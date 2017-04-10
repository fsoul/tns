<?
	define('MS_STATUS_DRAFT', 1);
	define('MS_STATUS_OUTBOX', 2);
	define('MS_STATUS_SENT', 3);
	define('MS_STATUS_ERROR', 5);
	define('MS_STATUS_ARCHIVE', 6);

	if (!defined('SUPPORT_EMAIL')) define('SUPPORT_EMAIL', EE_SUPPORT_EMAIL);

	/**
	* Function send letter on current language
	* @param $id_recipient - id of recipient from table `ms_recipient`
	* @used phpmailer_send_mail()
	* @used ms_recipient_set_status()
	* @used ms_mail_set_status()
	* @return boolean result of sending email
	*/
	function send_letter($id_recipient)
	{
		global $language;
		
		$res = false;
		
		$letter_sql = 'SELECT `ms_recipient`.*, `ms_mail`.*, `ms_mail`.`id` AS `ms_mail_id`, `ms_mail`.`language` AS `languages`
				FROM `ms_recipient`
				JOIN `ms_mail` ON `ms_mail`.`id`=`ms_recipient`.`ms_mail_id`
				WHERE `ms_recipient`.`id`='.sqlValue($id_recipient);
		
		$letter_row = db_sql_fetch_assoc(viewSql($letter_sql));
		//если поле письма ОТ заполнено не верно, посылаем письмо с азаданого и-мейла
		if(!preg_match('|^[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]{2,6}$|i', $letter_row['from_email']) && defined('SUPPORT_EMAIL'))
		{
			$letter_row['from_email'] = SUPPORT_EMAIL;
		}
		//устанавливаем свойства php mailerа
		$php_mailer_properties = array(
			'From' => $letter_row['from_email'],
			'FromName' => $letter_row['from_name']
		);
		//добавляем вложения, если они есть
		$attachments = array();
		if (getField('SELECT COUNT(*) FROM `nl_attachments` WHERE `nl_id`='.sqlValue($letter_row['original_id']))>0)
		{
			
			$r = ViewSQL('SELECT * FROM `nl_attachments` WHERE `nl_id`='.sqlValue($letter_row['original_id']));
			while ($row = db_sql_fetch_assoc($r))
			{
				$attachments[] = array('content'=>$row['file_content'], 'attachment_file_name'=>$row['file_name']);
			}
		}
		//узнаем свойства письма
		$langs = unserialize($letter_row['languages']);
		$subjects = unserialize($letter_row['subject']);
		$bodys = unserialize($letter_row['body']);
		$subject = $subjects[$language];
		$body = $bodys[$language];
		//отсылаем письмо
		$res = phpmailer_send_mail($letter_row['recipient'], '', $subject, $body, $attachments, $php_mailer_properties);
		//in order to save correct status of sended email to user
		if ($res === true)
		{
			// if sended successfully - set status 'sent'
			ms_recipient_set_status($id_recipient, MS_STATUS_SENT);
		} else {
			// if not sended - set status 'error'
			ms_recipient_set_status($id_recipient, MS_STATUS_ERROR);
		}

		$sql = 'SELECT * FROM `ms_recipient` WHERE `ms_mail_id`='.sqlValue($letter_row['ms_mail_id']).' AND `ms_status_id`='.sqlValue(MS_STATUS_OUTBOX);
		if (db_sql_num_rows(db_sql_query($sql)) == 0)//set status in ms_mail to sent if where are no other email
		{
			ms_mail_set_status($letter_row['ms_mail_id'], MS_STATUS_SENT);
		}

		return $res;
	}

	/**
	* Function get all email with outbox status and try to send them
	* @used send_letter()
	*/
	function send_all_emails()
	{
		global $language;
		set_time_limit(1800);
		$total_mails_send = 0;//count how many mail does we send
		//check if log file exists
		if(!file_exists(EE_SEND_LOG_FILE))
		{
			//try to create file
			file_put_contents(EE_SEND_LOG_FILE, '', FILE_APPEND);
		}
	  	if(!$handle = fopen(EE_SEND_LOG_FILE, 'a'))
		{
			echo 'Cannot open file ('.EE_SEND_LOG_FILE.')';
	        exit;
	   	}
		//если кто-то пытается одновременно получить доступ к этому скрипту то мы должны отказать ему
		$would_be_blocked = true;
		if(!flock($handle, LOCK_EX, $would_be_blocked))
		{
			echo 'This application is already used by another user';
			exit;
		}
		//select all languages
		$sql = 'SELECT language_code FROM language WHERE status=1 AND language_code<>""';
		$langs_res = viewSql($sql);
		if(db_sql_num_rows($langs_res)>0)
		{
			while($langs = db_sql_fetch_assoc($langs_res))
			{
				$language = $langs['language_code'];//Парсим шаблон с письмом на языке на который подписан пользователь
				
				fwrite($handle, 'Start date '.date("j.n.Y H:i:s")."\r\n");
				//обычное объединение не покатит, у ms_mail language это сериализированный массив
				$sql = 'SELECT `ms_recipient`.*,
						`ms_mail`.`original_id`,
						`ms_mail`.`subject`,
						`ms_mail`.`language` AS `mail_langs`
					FROM `ms_recipient`
						JOIN (`ms_mail`,
						`nl_email`)
						ON (`ms_mail`.`id`=`ms_recipient`.`ms_mail_id` AND
						`ms_recipient`.`ms_mail_id`=`nl_email`.`transaction_id`)
					WHERE `ms_recipient`.`ms_status_id`='.sqlValue(MS_STATUS_OUTBOX).'
					AND `ms_recipient`.`language`='.sqlValue($language);
				
				$r = viewSql($sql);
				
				if(db_sql_num_rows($r) > 0)
				{
					while ($f = db_sql_fetch_assoc($r))
					{
						$mail_langs = unserialize($f['mail_langs']);
						
						//if not array send to all languages
						//сохраняем обратную совместимость
						if(is_array($mail_langs) && !in_array($language, $mail_langs)) continue;
						
						$nl_email_subject = unserialize($f['subject']);
						$nl_email_subject = $nl_email_subject[$language];
						
						fwrite($handle, 'Start, date '.date("j.n.Y").' at '.date("H:i:s")."\r\n");
						fwrite($handle,'++ id_recipient:'.$f['id'].', subject:'.$nl_email_subject."\r\n");
						//if during mail sending error will occur phpmailer class will output error
						//so wee need to ignore phpmailer outputting and use it's message in $res variable
						ob_start();
						$res = send_letter($f['id']);
						ob_end_clean();
						if($res !== true)
						{
							echo 'Cant send letter id='.$f['id'].', user e-mail: '.$f['recipient'].', reason: '.$res.'<br />';
						}
						$total_mails_send++;
					}
				}
			}
		}
		if ($total_mails_send == 0)
		{
			fwrite($handle, 'Start, date '.date("j.n.Y").' at '.date("H:i:s")."\r\n");
			fwrite($handle, "No mailing tasks.\r\n");
			fwrite($handle, 'Finished '.date("j.n.Y").' at '.date("H:i:s")."\r\n\r\n");
		}
		flock($handle, LOCK_UN);
		fclose($handle);
	}
	
	function SendMailSimple($To, $Subject, $Html, $From, $FromName, $headers="", $charset='iso-8859-1')
	{
		if(!$To)
		{
			return false;
		}

		$FromName = ($FromName ? '=?'.$charset.'?b?' . base64_encode($FromName) . '?=' : '');

		$eol = PHP_EOL;
		$t_headers = 'MIME-Version: 1.0'.$eol;
		$t_headers .= 'Content-type: text/html; charset='.$charset.$eol;
		$t_headers .= 'From: '.$FromName.' <' . $From . '>'.$eol;
		$t_headers .= 'Reply-To: '.$FromName.' <' . $From . '>'.$eol;

		if ($headers != '')
		{
			$t_headers .= $headers.$eol;
		}

		$Subject = "=?$charset?b?".base64_encode($Subject)."?=";//for regional characters, in other way mail wouldn't be delivered

		$Html = wordwrap($Html, 70);

		return @mail($To, $Subject, $Html, $t_headers);
	}
	
	function fix_img_ways_from_fck_to_mail($cms_name)
	{
		$text = cms($cms_name);

		global $t;

		if ($t != 'nl/include_images' && $GLOBALS['show_email_link'])
		{
			$text = str_replace('src="/',		'src="'.EE_DOCUMENT_ROOT.'/',	$text);
			$text = str_replace('src="'.EE_HTTP,	'src="'.EE_PATH,	$text);
	 	}

		return $text;			
	}

	function show_go_to_page_control()
	{
		$return = '';
		if(!$GLOBALS['show_email_link'])
		{
			$return .= print_admin_js();
			$return .= text_edit_cms('text_for_nl__go_to_page');
		}
		return $return;
	}
?>