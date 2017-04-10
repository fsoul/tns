<?
	function nl_email_add($s_from_name, $s_from_email, $s_subject, $s_tpl, $s_body, $s_header, $finish_date, $ip_address, $add_date)
	{
		$finish_date = (is_null($finish_date))?'null':sqlValue($finish_date);
		$res_id = RunSQL('INSERT INTO nl_email (from_name, from_email, subject, tpl, body, header, finish_date, ip_address, create_date)
			VALUES ("'.mysql_real_escape_string($s_from_name).'", "'.mysql_real_escape_string($s_from_email).'",
			"'.mysql_real_escape_string($s_subject).'", "'.mysql_real_escape_string($s_tpl).'", "'.mysql_real_escape_string($s_body).'",
			"'.mysql_real_escape_string($s_header).'", '.$finish_date.', "'.mysql_real_escape_string($ip_address).'", '.sqlValue($add_date).');
		');

		return $res_id;
	}

	function nl_email_edit($i_id, $s_from_name, $s_from_email, $s_subject, $s_tpl, $s_body, $s_header, $finish_date)
	{
		$finish_date = (is_null($finish_date))?'null':sqlValue($finish_date);
		$res_id = 1;
		
		if (getField('SELECT count(*) FROM nl_email WHERE id = '.$i_id) == 0) // nl_check_email_id
			$res_id = -1;
		else
		{
				RunSQL('UPDATE nl_email SET
					from_name = "'.mysql_real_escape_string($s_from_name).'", from_email = "'.mysql_real_escape_string($s_from_email).'",
					subject = "'.mysql_real_escape_string($s_subject).'", tpl = "'.mysql_real_escape_string($s_tpl).'",
					body = "'.mysql_real_escape_string($s_body).'", header = "'.mysql_real_escape_string($s_header).'",
					finish_date = '.$finish_date.'
				WHERE
					id = "'.$i_id.'";');
		}
		return $res_id;
	}

	function nl_email_delete($i_id) {
		$res_id = 1;

		if (getField('SELECT count(*) FROM nl_email WHERE id = '.$i_id) == 0) // nl_check_email_id
			$res_id = -1;
		else
			RunSQL('DELETE FROM nl_email WHERE id = "'.$i_id.'";');

		return $res_id;
	}

	/*
	** Deletes selected items on grid
	** $i_id - array of [selected] items ids
	*/
	function nl_emails_delete($i_id) {
		$res_id = 1;

		if (getField('SELECT count(*) FROM nl_email WHERE id in('.sqlValuesList($i_id).')') == 0) // nl_check_email_id
			$res_id = -1;
		else
			RunSQL('DELETE FROM nl_email WHERE id in('.sqlValuesList($i_id).')');

		return $res_id;
	}

	/**
	* Check what email letter and group is exists, and we hasn't already added current group to current letter
	* @param $i_email_id - id of mail in table `nl_email`
	* @param $i_group_id - id of group in table `nl_group`
	* @return 1 if everything is ok, or negative value in other case
	*/
	function nl_check_email_id_group_id($i_email_id, $i_group_id)
	{
		$res_id = 1;
		
		//Check what such email letter is exists
		if (getField('SELECT COUNT(*) FROM `nl_email` WHERE `id`='.$i_email_id) == 0)
			$res_id = -1;
		//Check what such group is exists
		if (getField('SELECT COUNT(*) FROM `nl_group` WHERE `id`='.$i_group_id) == 0)
			$res_id = -2;
		//Check what such group wasn't already added to current mail letter
		if ($res_id > 0)
			$res_id = getField('SELECT COUNT(*) FROM `nl_email_group` WHERE `nl_email_id`='.sqlValue($i_id).' AND nl_group_id='.sqlValue($i_group_id));
		
		return $res_id;
	}

	/**
	* Add information about current group to current mail letter
	* @param $i_email_id - id of mail in table `nl_email`
	* @param $i_group_id - id of group in table `nl_group`
	* @used nl_check_email_id_group_id()
	*/
	function nl_email_group_add($i_email_id, $i_group_id) {
		$res_id = 1;
		//if this group was already added to current letter, then skip later steps
		if (nl_check_email_id_group_id($i_email_id, $i_group_id) > 0)
			$res_id = -1;
		//if current group wasn't added to this email, then add it
		if ($res_id > 0)
			RunSQL('INSERT INTO `nl_email_group` (`nl_email_id`, `nl_group_id`)
			VALUES ('.sqlValue($i_email_id).', '.sqlValue($i_group_id).')');
	}

	function f_add_nl_groups($s_group_name,$show_on_front) {
		$res_id = 1;

		if (getField('SELECT count(*) FROM nl_group WHERE group_name = "'.mysql_real_escape_string($s_group_name).'" AND id<>0') > 0) // nl_check_group_name
			$res_id = -1;
		else
			$res_id = RunSQL('INSERT INTO nl_group (group_name,show_on_front) VALUES ("'.mysql_real_escape_string($s_group_name).'","'.mysql_real_escape_string($show_on_front).'");');
		return $res_id;
	}

	function f_upd_nl_groups($i_id, $s_group_name,$i_show_on_front) {
	  $res_id = 1;

		if (getField('SELECT count(*) FROM nl_group WHERE id = '.$i_id) == 0) // nl_check_group_id
			$res_id = -1;
		if (getField('SELECT count(*) FROM nl_group WHERE group_name = "'.mysql_real_escape_string($s_group_name).'" AND id<>"'.$i_id.'"') > 0) // nl_check_group_name
			$res_id = -2;
		if ($res_id > 0)
	    RunSQL('UPDATE nl_group SET
	    	group_name = "'.mysql_real_escape_string($s_group_name).'", show_on_front = "'.$i_show_on_front.'"
	    WHERE id = "'.$i_id.'";');

		return $res_id;
	}

	function f_del_nl_groups($i_id) {
	  $res_id = 1;

		if (getField('SELECT count(*) FROM nl_group WHERE id = '.$i_id) == 0) // nl_check_group_id
			$res_id = -1;
		else
			RunSQL('DELETE FROM nl_group WHERE id = "'.$i_id.'";');
	  return $res_id;
	}

	/*
	** Deletes selected items on grid
	** $i_id - array of [selected] items ids
	*/
	function f_del_nl_groupss($i_id) {
	  $res_id = 1;

		if (getField('SELECT count(*) FROM nl_group WHERE id in('.sqlValuesList($i_id).')') == 0) // nl_check_group_id
			$res_id = -1;
		else
			RunSQL('DELETE FROM nl_group WHERE id in('.sqlValuesList($i_id).')');
	  return $res_id;
	}

	/**
	* Check what email letter is exists, and return its id from table `ms_mail`
	* @param $i_email_id - id of mail in table `nl_email`
	* @return id of email letter from table `ms_mail`
	*/
	//NOT IN USE
	/*function nl_check_email_transaction_id($i_email_id)
	{
		$res_id = 1;
		
		if (getField('SELECT COUNT(*) FROM `nl_email` WHERE `id`='.$i_email_id, 0, 1) == 0)
			$res_id = -1;
		else
			$res_id = getField('SELECT `transaction_id` FROM `nl_email` WHERE `id`='.$i_email_id, 0, 1);
		
		return $res_id;
	}*/

	/**
	* Check what email letter is exists, and add it to table `ms_mail`
	* @param $i_email_id - id of mail in table `nl_email`
	* @used nl_check_email_transaction_id()
	* @used get_email_param()
	* @return id of email letter from table `ms_mail`
	*/
	function nl_email_send($i_email_id)
	{
		global $language;
		
		$res_id = 1;
		
		//Check what email letter is exists
		if (getField('SELECT COUNT(*) FROM `nl_email` WHERE `id`='.sqlValue($i_email_id)) == 0)
			$res_id = -1;
		else
		{
			//add mail letter into table `ms_mail`
			$ms_mail_id = getField('SELECT `transaction_id` FROM `nl_email` WHERE `id`='.$i_email_id);//before used function nl_check_email_transaction_id($i_email_id);
			if ($ms_mail_id > 0)
				$res_id = $ms_mail_id;
			else
			{
				//mail could be sended in several languages
				$subject = serialize(get_email_param('subject', $i_email_id, $_POST['language_ids']));
				$body = serialize(get_email_param('body', $i_email_id, $_POST['language_ids']));
				$langs = serialize($_POST['language_ids']);
				
				$res_id = RunSQL('INSERT INTO `ms_mail`
					(`original_name`, `original_id`, `subject`, `body`, `from_name`, `from_email`, `header`, `date_reg`, `language`)
					SELECT "news_letters", `id`, '.sqlValue($subject).', '.sqlValue($body).', `from_name`, `from_email`, `header`, NOW(), '.sqlValue($langs).' FROM `nl_email` WHERE `id`='.sqlValue($i_email_id));
				RunSQL('UPDATE `nl_email` SET `transaction_id`='.sqlValue($res_id).' WHERE `id`='.sqlValue($i_email_id));
			}
		}
  	return $res_id;
	}

	/**
	* Return mail letter subject depend of language(s)
	* @param string $param - whatever to return, may be 'subject' or 'body'
	* @param string $i_email_id - id of mail in table `nl_email`
	* @param string $langs - on which language return mail subject, might be array
	* @return mail letter subject depend of language
	* used parse_email_body()
	*/
	function get_email_param($param, $i_email_id, $langs)
	{
		$return = '';
		//$lang might be array with languages
		if(is_array($langs))
		{
			foreach($langs as $lang)
			{
				if($param == 'body')
					$return[$lang] = parse_email_body($i_email_id, $lang);
				else if($param == 'subject')
					$return[$lang] = cms('news_letter_subject_'.$i_email_id, 0, $lang);
			}
		}
		else
		{
			if($param == 'body')
				$return[$langs] = parse_email_body($i_email_id, $langs);
			else if($param == 'subject')
				$return = cms('news_letter_subject_'.$i_email_id, 0, $langs);
		}
		return $return;
	}
	
	/**
	* Parse email body
	* @param string $i_email_id - id of mail in table `nl_email`
	* @return parsed html code of mail letter
	*/
	function parse_email_body($i_email_id, $lang) {
		global $ignore_admin, $show_email_link, $edit, $email_tpl, $language;
		$email_tpl = getField('SELECT `tpl` FROM `nl_email` WHERE `id`='.sqlValue($i_email_id));
		$ignore_admin = $show_email_link = 1;
		$edit = $i_email_id;
		$original_language = $language;
		$language = $lang;
		$res = parse_tpl($email_tpl);
		$language = $original_language;
		$ignore_admin = $show_email_link = 0;
		return $res;
	}
	
	/**
	* Check if subscriber is subscribed
	* @param string $s_email - id of mail in table `nl_subscriber `
	* @param string $i_group_id - id of subscribers group
	* @return integer 1 if subscriber is subscribe, or -1 in other case
	*/
	//NOT IN USE
	/*function nl_check_subscriber_status($s_email, $i_group_id)
	{
		global $language;
		$res_id = -1;

		if (getField('SELECT COUNT(*) FROM `nl_subscriber` WHERE `email`='.sqlValue($s_email).' AND `nl_group_id`='.sqlValue($i_group_id).' AND language='.sqlValue($language)) > 0)
		{
		  $tStatus = getField('SELECT `status` FROM `nl_subscriber` WHERE `email` = '.sqlValue($s_email).' AND `nl_group_id` = '.sqlValue($i_group_id).' AND language='.sqlValue($language));
			if ($tStatus == 1 || $tStatus == 3)
				$res_id = 1;
		}

		return $res_id;
	}*/

	function check_email_finish_date($email_id)
	{
		$finish_date = (int) convert_objecttime_to_unixtimelabel(getField('SELECT finish_date FROM nl_email WHERE id = '.$email_id));
		$current_date = (int) convert_objecttime_to_unixtimelabel(date('Y-m-d'));
		if(!empty($finish_date) && $finish_date < $current_date)
		{
			$res = true;
		}
		else
		{
			$res = false;
		}
		return $res;
	}

	/**
	* Send letter to current group
	* @param integer $i_email_id - id of mail in table `nl_email`
	* @param string $i_group_id - id of subscribers group
	* @used nl_email_send()
	* @used nl_email_group_add()
	* @used ms_recipient_add()
	* @used ms_mail_set_status()
	*/
	function nl_email_group_send($i_email_id, $i_group_id)
	{
		global $language, $recipient_id;

		$res_id = 1;
		//get all subscribers from current group on current language
		$sql = ViewSQL('SELECT DISTINCT `id`, `email`, `status` FROM `nl_subscriber` WHERE `nl_group_id`='.sqlValue($i_group_id).' AND `language`='.sqlValue($language));
		//add info about mail letter into table `ms_mail`
		$ms_mail_id = nl_email_send($i_email_id);
		
		//add info about mail letter into table `nl_email_group`
		nl_email_group_add($i_email_id, $i_group_id);

		while ($r = db_sql_fetch_assoc($sql))
		{
			if ($r['status'] == 1 || $r['status'] == 3)//before used function nl_check_subscriber_status()
			{
				$recipient_id = $r[1];
				//ставим текущим подписчикам статус outbox, т.к. отныне рассылка будет производитс€ с помощью senddaemon
				$ins_id_rcp = ms_recipient_add($r['email'], $ms_mail_id, MS_STATUS_OUTBOX, $r['id']);
			}
		}
		ms_mail_set_status($ms_mail_id, MS_STATUS_OUTBOX);
	}

	function nl_subscriber_group_add($s_email, $s_group_name)
	{
	  $res_id = 1;

		if (getField('SELECT count(*) FROM nl_group WHERE group_name = "'.mysql_real_escape_string($s_group_name).'" AND id<>0') == 0) // nl_check_group_name
			nl_group_add(pGroupName,0);

		$group_id = getField('SELECT id FROM nl_group WHERE group_name = "'.mysql_real_escape_string($s_group_name).'"');

		if (getField('SELECT count(*) FROM nl_subscriber WHERE email = pEmail AND nl_group_id = '.$group_id) > 0)
			$res_id = -2;

		if ($res_id > 0)
			$res_id = RunSQL('INSERT INTO nl_subscriber (email, nl_group_id) VALUES ("'.mysql_real_escape_string($s_email).'", "'.mysql_real_escape_string($s_group_name).'");');

		return $res_id;
	}

	function nl_subscriber_add($s_email, $i_nl_group_id, $i_status, $s_first_name, $s_sur_name, $ip_address)
	{
		$res_id = 1;
		
		//deviant add
		if(empty($ip_address))
			$ip_address = (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR'];
			
		if (getField('SELECT count(*) FROM nl_group WHERE id = '.$i_nl_group_id) == 0) // nl_check_group_id
			$res_id = -1;
			
		$operation = 'INSERT INTO';
		$where = '';
		$rs = viewSql('SELECT * FROM nl_subscriber WHERE email = "'.mysql_real_escape_string($s_email).'" AND nl_group_id = '.$i_nl_group_id.' AND language='.sqlValue($_POST['language']).' LIMIT 1');
		if(db_sql_num_rows($rs) > 0)
			$res_id = -2;
		$res = db_sql_fetch_assoc($rs);
		//ѕровер€ем не желает ли пользователь после отписки заново подписатс€
		if($res['status'] == 4)
		{
			$operation = 'UPDATE';
			$where = ' WHERE id='.$res['id'];
			$res_id = 1;
		}
		if ($res_id > 0)
		{
			$company = $city = '';
			//is used fields company & city
			if(!empty($_POST['company']))
				$company = ', company='.sqlValue($_POST['company']);
			if(!empty($_POST['city']))
				$city = ', city='.sqlValue($_POST['city']);
			$res_id = RunSQL($operation.' '.TABLE_PREFIX.'nl_subscriber SET email='.sqlValue($s_email).', nl_group_id="'.$i_nl_group_id.'", status="'.$i_status.'", reg_date=NOW(), first_name='.sqlValue($s_first_name).', sur_name='.sqlValue($s_sur_name).$company.$city.', ip_address='.sqlValue($ip_address).', language='.sqlValue($_POST['language']).$where,0);
		}

		return $res_id;
	}
	
	function nl_subscriber_set_status($id, $new_status)
	{
		//“акой пользователь есть в Ѕƒ
		//”знаем его статус
		$status = getField('SELECT status FROM '.TABLE_PREFIX.'nl_subscriber WHERE id='.$id);
		if ($status == 1)
			$status++;//—татуса с номером 2 не существует
		if ($status == 4)
			$status = -1;//Ќачинаем отсчет заново
		if(checkAdmin() || (++$status == $new_status))
		{
			$r = RunSQL("UPDATE ".TABLE_PREFIX."nl_subscriber SET Status=".$new_status." WHERE id=".$id);
		}
	}
	
	function nl_subscriber_edit($i_id, $s_email, $i_nl_group_id, $i_status, $s_first_name, $s_sur_name, $ip_address)
	{
		$res_id = 1;

		if (getField('SELECT count(*) FROM nl_group WHERE id = '.$i_nl_group_id) == 0) // nl_check_group_id
			$res_id = -1;
	  if (getField('SELECT count(*) FROM nl_subscriber WHERE email = "'.mysql_real_escape_string($s_email).'" AND nl_group_id = "'.$i_nl_group_id.'" AND language='.sqlValue($_POST['language']).' AND id<>"'.$i_id.'";') > 0)
			$res_id = -2;
		if ($res_id > 0)
	    RunSQL('UPDATE nl_subscriber SET 
			email = '.sqlValue($s_email).', 
			nl_group_id = "'.$i_nl_group_id.'",
			Status = "'.$i_status.'", 
			first_name = '.sqlValue($s_first_name).', 
			sur_name = '.sqlValue($s_sur_name).',
			language = '.sqlValue($_POST['language']).'
			WHERE id = "'.$i_id.'";');

		return $res_id;
	}

	function nl_subscriber_delete($i_id)
	{
		RunSQL('DELETE FROM nl_subscriber WHERE id = '.sqlValue($i_id));
		return true;
	}

	/*
	** Deletes selected items on grid
	** $i_id - array of [selected] items ids
	*/
	function nl_subscribers_delete($i_id)
	{
		RunSQL('DELETE FROM nl_subscriber WHERE id in('.sqlValuesList($i_id).')');
		return true;
	}

	
	function nl_add_attachment($nl_id, $orig_file_name, $file)
	{
		if (!check_file($file)) return (-1);
		
		$file_contents = file_get_contents($file);
		$res_id = RunSQL('INSERT INTO nl_attachments SET nl_id='.sqlValue($nl_id).', file_name='.sqlValue($orig_file_name).', file_content='.sqlValue($file_contents),0);
		return $res_id;
	}

	function nl_del_attachment($id)
	{
		$res_id = RunSQL('DELETE FROM nl_attachments WHERE id='.sqlValue($id),0);
		return true;
	}
	
	function check_email_send()
	{
		global $email_status, $email_id, $lang;
		$return = '';
		if($email_status == 'draft')//еще только формируем письмо, дл€ удобства ставим все €зыки выбраными
		{
			$return = ' checked';
		}
		else
		{
			$sql = 'SELECT `mail`.`language` FROM `'.TABLE_PREFIX.'nl_email_group` AS `email_group`, `'.TABLE_PREFIX.'ms_mail` AS `mail` WHERE `email_group`.`nl_email_id` = `mail`.`original_id` AND `email_group`.`nl_email_id` = '.$email_id.' LIMIT 0,1';
			$rs = viewSql($sql);
			if(db_Sql_num_rows($rs)>0)
			{
				$res = db_sql_fetch_assoc($rs);
				//сохран€ем обратную совместимость, раньше в поле €зыка был код €зыка, € теперь сериализированый массив €зыков
				if(strlen($res['language'])<3)
				{
					$langs = array($res['language']);
				}
				else
				{
					$langs = unserialize($res['language']);
				}
				if(in_array($lang, $langs))
				{
					$return = ' checked';
				}
			}
		}
		return $return;
	}
?>
