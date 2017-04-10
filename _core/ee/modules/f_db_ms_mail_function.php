<?
	//NOT IN USE
	/*
	function ms_mail_add($s_orig_name, $i_orig_id, $s_subject, $s_body,	$s_from_name, $s_from_email, $s_header, $i_status_id)
	{
		global $language;
		if (getField('SELECT count(*) FROM ms_status WHERE id = '.sqlValue($i_status_id)) == 0)
			$res_id = -1;

	  $test = getField('SELECT id FROM ms_mail WHERE original_name = "'.mysql_real_escape_string($i_orig_name).'" AND original_id = "'.mysql_real_escape_string($i_orig_id).'";');
		if (!($test > 0))
		{
			$res_id = RunSQL('INSERT INTO ms_mail
					(original_name, original_id, subject, body, from_name, from_email, header,
					ms_status_id, date_reg, language)
				VALUES
					("'.mysql_real_escape_string($s_orig_name).'", "'.mysql_real_escape_string($i_orig_id).'", "'.mysql_real_escape_string($s_subject).'",
					"'.mysql_real_escape_string($s_body).'", "'.mysql_real_escape_string($s_from_name).'", "'.mysql_real_escape_string($s_from_email).'",
					"'.mysql_real_escape_string($s_header).'", "'.$i_status_id.'", NOW(), '.Sqlvalue($language).');');
 		}

		return $res_id;
	}
	*/

	/**
	* Check what email letter and email status is exists, and update it's status
	* @param $i_id - email id from table `ms_mail`
	* @param $i_status_id - new status of mail
	* @return 1 if status were updated succesfully or negative number if occur error 
	*/
	function ms_mail_set_status($i_id, $i_status_id)
	{
		$res_id = 1;
		//проверяем что такое письмо существует
		if (getField('SELECT COUNT(*) FROM `ms_mail` WHERE `id`='.sqlValue($i_id)) == 0)
			$res_id = -1;
		//проверяем что такой статус существует
		if (getField('SELECT COUNT(*) FROM `ms_status` WHERE `id`='.sqlValue($i_status_id)) == 0)
			$res_id = -2;
		//если небыло ошибок
		if ($res_id > 0)
		{
			if(getField('SELECT COUNT(*) FROM `ms_mail` WHERE `id`='.sqlValue($i_id).' AND `ms_status_id`='.sqlValue($i_status_id)) == 0)
			{
				RunSQL('UPDATE `ms_mail` SET `ms_status_id`='.sqlValue($i_status_id).' WHERE `id`='.sqlValue($i_id));
				$res_id = 1;
			}
			else
				$res_id = -3;
		}

  	return $res_id;
	}

	/**
	* Check what email letter and status is exists, we hasn't already added current recipoient and add it
	* @param $s_recipient - email address of recipient
	* @param $i_mail_id - id of email letter from table `ms_mail`
	* @param $i_status_id - status of subscriber
	* @param $nl_subscriber_id - id of recipient from table `nl_subscriber`
	* @return id of recipient from table `ms_recipient`
	*/
	function ms_recipient_add($s_recipient, $i_mail_id, $i_status_id, $nl_subscriber_id) {
		global $language;
		
		$res_id = 1;
		//проверяем что такое письмо существует
		if (getField('SELECT COUNT(*) FROM `ms_mail` WHERE `id`='.sqlValue($i_mail_id)) == 0)
			$res_id = -1;
		//проверяем что такой статус существует
		if (getField('SELECT COUNT(*) FROM `ms_status` WHERE `id`='.sqlValue($i_status_id)) == 0)
			$res_id = -2;
		//проверяем что такой подписчик еще не присутствует в таблице `ms_recipient` с учетом текущей группы и языка
		if (getField('SELECT COUNT(*) FROM `ms_recipient` WHERE `recipient`='.sqlValue($s_recipient).' AND `ms_mail_id`='.sqlValue($i_mail_id).' AND `language`='.sqlValue($language)) > 0)
			$res_id = -3;
		//добавляем подписчика в таблице `ms_recipient` с учетом текущей группы и языка
		if ($res_id > 0)
		{
			$res_id = RunSQL('INSERT INTO `ms_recipient`
					(`recipient`, `ms_mail_id`, `ms_status_id`, `date_update`, `language`, `recipient_id`)
				VALUES
					('.sqlValue($s_recipient).', '.sqlValue($i_mail_id).', '.sqlValue($i_status_id).', NOW(), '.sqlValue($language).', '.sqlValue($nl_subscriber_id).')');
		}
		
		return $res_id;
	}

	/**
	* Change status of recipient
	* @param $i_recipient_id - id of recipient from table `ms_recipient`
	* @param $i_status_id - new status
	* @return 1 if ststus was succesfully changes or negative value in other case
	*/
	function ms_recipient_set_status($i_recipient_id, $i_status_id) {
		global $language;
		
		$res_id = 1;
		//Проверяем что такой получатель не был добавлен ранее
		if (getField('SELECT COUNT(*) FROM `ms_recipient` WHERE `id`='.sqlValue($i_recipient_id)) == 0)
			$res_id = -1;
		//Проверяем что такой статус существует
		if (getField('SELECT COUNT(*) FROM `ms_status` WHERE `id`='.sqlValue($i_status_id)) == 0)
			$res_id = -2;
		//если все ОК
		if ($res_id > 0)
		{
			if (getField('SELECT COUNT(*) FROM `ms_recipient` WHERE `id`='.sqlValue($i_recipient_id).' AND `ms_status_id`='.sqlValue($i_status_id)) == 0)
			{
				RunSQL('UPDATE `ms_recipient` SET `ms_status_id`='.sqlValue($i_status_id).', `date_update`=NOW() WHERE `id`='.sqlValue($i_recipient_id));
				$res_id = 1;
			}
			else
				$res_id = -3;
		}

		return $res_id;
	}

	/**
	* Check what test email letter is exists, and add it to table `ms_mail`
	* @param $i_email_id - id of mail in table `nl_email`
	* @used get_email_param()
	* @return id of test email letter from table `ms_mail`
	*/
	function ms_test_mail_add($i_email_id) {
		
		global $language;
		
		$res_id = 1;
		
		//Check what email letter is exists
		if (getField('SELECT COUNT(*) FROM `ms_status` WHERE `id`='.sqlValue(MS_STATUS_DRAFT)) == 0)
			$res_id = -1;

		if ($res_id > 0)
		{
			$subject = serialize(get_email_param('subject', $i_email_id, array($language)));
			$body = serialize(get_email_param('body', $i_email_id, array($language)));
			$langs = serialize($language);
			
			//insert info about email into `ms_mail` table
			$res_id = RunSQL('INSERT INTO `ms_mail`
					(`original_name`, `original_id`, `subject`, `body`, `from_name`, `from_email`, `header`, `ms_status_id`, `date_reg`, `language`)
				SELECT
					"test newsletter", `id`, '.sqlValue($subject).', '.sqlValue($body).', `from_name`, `from_email`, `header`, "'.MS_STATUS_DRAFT.'", NOW(), '.sqlValue($langs).' FROM `nl_email` WHERE `id`='.sqlValue($i_email_id));
		}

		return $res_id;
	}
	
	/**
	* Check what email letter and status is exists, we hasn't already added current recipoient and add it
	* @param $s_recipient - email address of recipient
	* @param $i_mail_id - id of email letter from table `ms_mail`
	* @param $i_status_id - status of subscriber
	* @return id of recipient from table `ms_recipient`
	*/
	function ms_test_recipient_add($s_recipient, $i_mail_id, $i_status_id) {
		global $language;
	
		$res_id = 1;
		//проверяем что такое письмо существует
		if (getField('SELECT COUNT(*) FROM `ms_mail` WHERE `id`='.sqlValue($i_mail_id)) == 0)
			$res_id = -1;
		//проверяем что такой статус существует
		if (getField('SELECT COUNT(*) FROM `ms_status` WHERE `id`='.sqlValue($i_status_id)) == 0)
			$res_id = -2;
		//проверяем что мы еще не добавили такого получателя
		if (getField('SELECT COUNT(*) FROM `ms_recipient` WHERE `recipient`='.sqlValue($s_recipient).' AND `ms_mail_id`='.sqlValue($i_mail_id)) > 0)
			$res_id = -3;
		//если такой получатель не существует, добавляем его
		if ($res_id > 0)
		{
			$res_id = RunSQL('INSERT INTO `ms_recipient` (`recipient`, `ms_mail_id`, `ms_status_id`, `date_update`, `language`, `recipient_id`)
				VALUES ('.sqlValue($s_recipient).', '.sqlValue($i_mail_id).', '.sqlValue($i_status_id).', NOW(), '.sqlValue($language).', 0)');
		}
		return $res_id;
	}

	function check_count_unsent_mails($mail_id)
	{
		$sql = 'SELECT count(*) FROM ms_recipient JOIN ms_mail ON ms_mail.id=ms_recipient.ms_mail_id WHERE ms_recipient.ms_status_id=2 and ms_recipient.id = '.$mail_id;
		return getField($sql);
	}
?>