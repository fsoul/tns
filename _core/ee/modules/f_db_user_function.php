<?

function f_add_user($pName, $pLogin, $pEmail, $pStatus, $pComment, $pIcq, $pCity, $ug, $pRole, $ca, $pPwd)
{
	if($pRole == ADMINISTRATOR)
	{
		$ca = 4;
		del_cms('folder_access_mode_'.$userId);
	}
	elseif($pRole == USER)
	{
		$ca = 1;
	}
	$ret = 0;
	if (!$pIcq) $pIcq='NULL';
	if (mysql_num_rows(ViewSQL('SELECT id FROM users WHERE login = "'.$pLogin.'";')) > 0)
		$ret = -1;
	if (mysql_num_rows(ViewSQL('SELECT id FROM users WHERE email = "'.$pEmail.'"')) > 0)
		$ret = -2;

	if ($ret == 0)
	{
		$ret = RunSQL('INSERT INTO users SET name = "'.$pName.'", login = "'.$pLogin.'", passw = "'.md5($pPwd).'",
			email = "'.$pEmail.'", status = "'.$pStatus.'", role = "'.$pRole.'", comment = "'.$pComment.'",
			icq = '.$pIcq.', city = "'.$pCity.'", resetpassw = 1, content_access="'.$ca.'";');
		if(is_array($ug))
		{
			foreach($ug as $k=>$v)
			{
				runSQL('INSERT INTO user_group VALUES("'.$ret.'", "'.$v.'")');
			}
		}
	}

	return $ret;
}

function f_del_user($pId)
{
	// 8829 start
	$user_name = getField('SELECT name FROM users WHERE id="'.$pId.'"');
	$ar_res = unserialize(config_var('allowed_moduls'));
	unset($ar_res[$user_name]);
	save_config_var('allowed_moduls', serialize($ar_res));
	// 8829 end
	RunSQL('DELETE FROM users WHERE id = "'.$pId.'";');

	return 1;
}

/*
** Deletes selected items on grid
** $pId - array of [selected] items ids
*/

function f_del_users($pId)
{
	// 8829 start
	$ar_res = unserialize(config_var('allowed_moduls'));
	if(is_array($pId))
	{
		foreach($pId as $val)
		{
			$user_name = getField('SELECT name FROM users WHERE id="'.$val.'"');	
			unset($ar_res[$user_name]);			
		}
	}
	save_config_var('allowed_moduls', serialize($ar_res));
	// 8829 end
	RunSQL('DELETE FROM users WHERE id in('.sqlValuesList($pId).')');
	return 1;
}


function f_upd_user($pId, $pName, $pLogin, $pEmail, $pStatus, $pComment, $pIcq, $pCity, $old_pass, $new_pass, $conf_new_pass, $cur, $ip, $browser, $login, $mv, $ug, $pRole, $ca)
{
	global $error;
	// Если пользователь Админ принудительно выставляем полный доступ к контенту
	if($pRole == ADMINISTRATOR)
	{
		$ca = 4;
		del_cms('folder_access_mode_'.$userId);
	}
	elseif($pRole == USER)
	{
		$ca = 1;
	}
	$tmp = 1;
	if (!$pIcq) $pIcq='NULL';

	if (mysql_num_rows(ViewSQL('SELECT id FROM users WHERE login = "'.$pLogin.'" AND id <> "'.$pId.'"', 0)) > 0)
		$tmp = -3;
	if (mysql_num_rows(ViewSQL('SELECT id FROM users WHERE email = "'.$pEmail.'" AND id <> "'.$pId.'"', 0)) > 0)
		$tmp = -4;
	if ($tmp == 1 && !empty($old_pass) && mysql_num_rows(ViewSQL('SELECT id FROM users WHERE passw = "'.md5($old_pass).'" AND id = "'.$pId.'"', 0)) == 0)
	{
		$tmp = -5;
	}
	//
	if($tmp == 1 && !empty($old_pass) && ($new_pass != $conf_new_pass || empty($new_pass) || empty($new_pass)))
	{
		$tmp = -6;
	}
	//
	if($tmp == 1 && !empty($old_pass) && strlen($new_pass) < MIN_PASSWORD_LENGTH && get_config_var('pass_min_8_symbol'))
	{
		$tmp = -7;
	}
	//
	if($tmp == 1 && !empty($old_pass) && strlen($new_pass) < MIN_PASSWORD_LENGTH_FRONTEND && !get_config_var('pass_min_8_symbol'))
	{
		$tmp = -8;
	}
	//
	if($tmp == 1 && check_password($pLogin, $new_pass) != 1 && !empty($old_pass) && $new_pass == $conf_new_pass)
	{
		$tmp = -9;
		$error['new_password'] = check_password($pLogin, $new_pass);
	}

	if ($tmp > 0)
	{
		if (!empty($new_pass))
		{
			$pass = ', passw="'.md5($new_pass).'"';

			// bug_id=11464
			if (!empty($old_pass) && $old_pass<>$new_pass)
			{
				$pass.= ', passw_update_datetime=NOW() ';
			}
		}

		RunSQL('UPDATE users SET name = "'.$pName.'", login = "'.$pLogin.'",
			email = "'.$pEmail.'", status = "'.$pStatus.'", role = "'.$pRole.'", content_access="'.$ca.'", comment = "'.$pComment.'",
			icq = '.$pIcq.', city = "'.$pCity.'" '.$pass.' WHERE id = "'.$pId.'";');
		runSQL('DELETE FROM user_group WHERE user_id="'.$pId.'"');

		if (is_array($ug))
		{
			foreach($ug as $k=>$v)
			{
				runSQL('INSERT INTO user_group(user_id, group_id) VALUES("'.$pId.'", "'.$v.'")');
			}
		}
		else
		{
			runSQL('INSERT INTO user_group(user_id, group_id) VALUES("'.$pId.'", "'.$ug.'")');
		}

		$tmp = $pId;
	}

	return $tmp;
}



