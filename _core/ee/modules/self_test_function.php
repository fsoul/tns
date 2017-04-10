<?
/**
 * ќбработка результата проверки зависимостей модулей.
 *
 * ≈сли тестируетс€ один конкретный модуль - возвращаем готовый html;
 * если модуль тестируетс€ из другого скрипта обращением через socket,
 * (о чем свидетельствет наличие параметра $_GET['test_all'])
 * - возвращаем сериализированный массив
 * дл€ дальнейшей его обработки уже в вызывающем скрипте
 *
 */
function parse_self_test($ar_self_check)
{
	$res = global_check($ar_self_check);

	if (isset($_GET['test_all']))
	{
		$res = serialize($res);
	}
	else
	{
		$res = parse_array_to_html($res, 'self_test');
	}

	return $res;
}

/**
 * ѕроверка зависимостей модулей
 *
 * @param array $modules ћассив зависимостей: (название модул€ => ('constants' => 'массив констант', 'db_funcs' => 'массив storage functions', 'db_tables' => 'массив таблиц и вьюшек'))
 * @return array ћассив зависимостей: (название модул€ => ('constants' => 'недостающие константы', 'db_funcs' => 'недостающие storage functions', 'db_tables' => 'недостающие таблицы и вьюшки'))
 */
function global_check($modules)
{
	global $err_message;

	$i = 0;

	foreach ($modules as $modul_name=>$ar_check)
	{
		$res_check = array();
		$j=0;
		$res[$i]['modul_check_result'] = true;
		foreach ($ar_check as $check_type=>$ar_check_params)
		{
			$test_func_name='_self_test_'.$check_type;
			if (function_exists($test_func_name) && is_array($check_result = $test_func_name($ar_check_params)))
			{
				if (isset_array_var($check_result,'result') == 'FAIL')
				{
					$res_check[$j]['check_type_desc'] = $err_message;
					$res_check[$j++]['check_result'] = $check_result['message'];
					$res[$i]['modul_check_result'] = false;
				}
				elseif (isset_array_var($check_result,'result') == 'PASS' && isset_array_var($check_result,'message') != '' && $res[$i]['modul_check_result'])
				{
					$res_check[$j]['check_type_desc'] = 'Successful check '.$check_type;
					$res_check[$j++]['check_result'] = $check_result[message];
					$res[$i]['modul_check_result'] = true;
				}
			}
		}
		$res[$i]['modul_name'] = $modul_name;
		$res[$i++]['modul_check_message'] = parse_array_to_html($res_check, 'self_test_row_record');
	}

	return $res;
}
/**
 * ¬озвращает масив с результатом тестировани€
 * @param array $res результат тестировани€
 * @param string $pass_message сообщение при положительном результате тестировани€
 * return array('result' => PASS или FAIL, 'message' => $pass_message при успешном результате тестировани€ или возникшие ошибки)
 */
function get_test_result_row($res = array(), $pass_message = '')
{
	if (count($res) == 0)
	{
		$test_result['result'] = 'PASS';
		$test_result['message'] = $pass_message != '' 
							? 
							parse_array_to_html(array('object_name'=>$pass_message), 'self_test_row_record_row')
							:
							"";
	}
	else
	{
		$test_result['result'] = 'FAIL';
		$test_result['message'] = parse_array_to_html($res, 'self_test_row_record_row');
	}
	return $test_result;
}

function _self_test_constants($constants = array())
{
	global $err_message;
	$err_message = 'Constants undefined';

	$res = array();

	foreach ($constants as $key)
	{
		if (!defined($key))
			$res[]['object_name'] = $key;
	}

	return get_test_result_row($res);
}

function _self_test_config_vars($vars = array())
{
	global $err_message, $CONFIG;
	$err_message = 'Configuration variables undefined';

	$res = array();

	foreach ($vars as $key)
	{
		if (!isset($CONFIG[$key['field_name']]))
			$res[]['object_name'] = $key['field_name'];
	}

	return get_test_result_row($res);
}

function _self_test_custom_query($queries = array())
{
	global $err_message;
	$err_message = 'Test database queries failed';

	$res = array();

	if (count($queries) > 0)
	foreach ($queries as $key)
	{
		if (getField($key['query']) != $key['result'])
			$res[]['object_name'] = $key['message'].(DEBUG_MODE==1?' ('.$key['query'].')':'');
	}

	return get_test_result_row($res);
}

function _self_test_db_funcs($db_funcs = array())
{
	global $err_message;
	$err_message = 'DB-functions not exists';

	$res = array();

	if (is_array($db_funcs) && count($db_funcs) > 0)
	foreach ($db_funcs as $key)
	{
		db_sql_query('show create function '.$key);

		if (db_sql_error() != '')
		{
			$res[]['object_name'] = $key;
		}
	}

	return get_test_result_row($res);
}

function _self_test_db_tables($db_tables = array())
{
	global $err_message;

	$err_message = 'Tables not exists';

	$res = array();

	foreach ($db_tables as $key)
	{
		db_sql_query('show create table '.$key);

		if (db_sql_error() != '')
		{
			$res[]['object_name'] = $key;
		}
	}

	return get_test_result_row($res);
}

function _self_test_php_ini($ar_params = array())
{
	global $err_message;

	$err_message = 'PHP INI undefined';

	$res = array();

	foreach ($ar_params as $key)
	{
		if (!get_cfg_var($key))
			$res[]['object_name'] = $key;
	}

	return get_test_result_row($res);
}

function _self_test_php_functions($ar_params = array())
{
	global $err_message;

	$err_message = 'PHP-functions undefined';

	$res = array();

	foreach ($ar_params as $key)
	{
		if (!function_exists($key))
		{
			$res[]['object_name'] = $key;
		}
	}

	return get_test_result_row($res);
}

function _self_test_ftp_file_exists($ar_params = array())
{
	return _self_test_file_exists($ar_params, true);
}

function _self_test_file_exists($ar_params = array(), $ftp = false)
{
	$touch_file_function_name = ( $ftp ? 'ftp_' : '' ).'touch_file';

	global $err_message;  

	$res = array();

	foreach ($ar_params as $file)
	{
		if (!$touch_file_function_name(EE_PATH.$file))
		{
			$err_message = 'File not exists';

			$res[]['object_name'] = $file;
		}
	}      

	return get_test_result_row($res);
}

function _self_test_ftp_dir_exists($ar_params = array())
{
	return _self_test_dir_exists($ar_params, true);
}

function _self_test_dir_exists($ar_params = array(), $ftp = false)
{
	$touch_dir_function_name = ( $ftp ? 'ftp_' : '' ).'touch_dir';

	global $err_message;  

	$res = array();

	foreach ($ar_params as $dir)
	{
		if (!$touch_dir_function_name(EE_PATH.$dir))
		{
			$err_message = 'Directory not exists';

			$res[]['object_name'] = $dir;
		}
	}      

	return get_test_result_row($res);
}

function _self_test_ftp_dir_attributes($ar_params = array())
{
	return _self_test_dir_attributes($ar_params, true);
}

function _self_test_dir_attributes($ar_params = array(), $ftp = false)
{
	$touch_dir_function_name = ( $ftp ? 'ftp_' : '' ).'touch_dir';

	global $err_message;  

	$res = array();

	foreach ($ar_params as $dir=>$dir_mode)
	{
		$dir_mode = octal_string_to_integer($dir_mode);

		$path_dir = EE_PATH.$dir;

		if ($touch_dir_function_name($path_dir, $dir_mode))
		{
			// it is unconditionally necessary here!
			// fileperms() will not work correctly without this!
			// see also function touch_dir()
			clearstatcache();

			if (($current_mode = substr(sprintf('%o', fileperms($path_dir)), -3)) != ($expected_mode = sprintf('%o', $dir_mode)))
			{
				$err_message = 'No proper rights for directories';

				$res[]['object_name'] = $dir.' ('.$expected_mode.' is expected but '.$current_mode.' is assigned)';
			}
		}
		else
		{
			$err_message = 'Failed to check rights for directories';

			$res[]['object_name'] = $dir;
		}
	}      

	return get_test_result_row($res);
}

function _self_test_ftp_upload($ar_params = array())
{
	global $err_message;
	$err_message = 'Error in';

	$res = array();

	$index = EE_CORE_PATH.'version.info';
	$fp = fopen($index, 'r');
	$file_tmp = 'ftp_test.tmp';

	$conn_id=ftp_connect(EE_FTP_SERVER,0,10);
	if (!$conn_id)  $res[]['object_name'] = 'FTP connection';
	else {
		$login_result=@ftp_login($conn_id, EE_FTP_USER, EE_FTP_PASS);
		if (!$login_result) $res[]['object_name'] = 'FTP authorisation';
	
		else {
			$ftp_res = ftp_fput($conn_id, EE_FTP_PREFIX.$file_tmp, $fp, FTP_BINARY);
			if (!$ftp_res) $res[]['object_name'] = 'FTP upload';
			if (file_exists(EE_PATH.$file_tmp))
				$f_del = ftp_delete($conn_id, EE_FTP_PREFIX.$file_tmp);
			}

		ftp_close($conn_id);
		}

	return get_test_result_row($res);
}

//‘ункци€ тестирует на месте ли шаблоны страниц
function _self_test_templates_exists($vars = array())//если массив $vars пустой, провер€ем все шаблоны в Ѕƒ
{
	global $err_message;
	$err_message = 'Missing templates';

	$res = array();
	//если нам передали шаблоны
	if(sizeof($vars) > 0)
	{
		foreach ($vars as $key)
		{
			$f_cust_path = EE_PATH.'templates/'.$key.'.tpl';
			$f_core_path = EE_CORE_PATH.'templates/'.$key.'.tpl';
			//ѕровер€ем если шаблон те только в кастомной части но и в €дре
			if (!check_file($f_cust_path) && !check_file($f_core_path))
				$res[]['object_name'] = $key;
		}
	}
	else//провер€ем все шаблоны
	{
		$db_rs = ViewSql('SELECT file_name FROM tpl_files');
		if(db_sql_num_rows($db_rs) > 0)
		{
			while($db_res = db_sql_fetch_assoc($db_rs))
			{
				$f_name = stripslashes($db_res['file_name']);
				$f_cust_path = EE_PATH.'templates/'.$f_name.'.tpl';
				$f_core_path = EE_CORE_PATH.'templates/'.$f_name.'.tpl';
				//ѕровер€ем если шаблон те только в кастомной части но и в €дре
				if (!check_file($f_cust_path) && !check_file($f_core_path))
					$res[]['object_name'] = $f_name;
			}
		}
	}
	
	return get_test_result_row($res);
}

//‘ункци€ тестирует есть ли страницы на несуществующих шаблонах
function _self_test_pages_on_nonexisting_templates($vars = array())//если массив $vars пустой, провер€ем все шаблоны в Ѕƒ
{
	global $err_message;
	$err_message = 'Pages on non existing templates';
	
	//select all pages on existing templates
	$sql = 'SELECT `tp`.`id` FROM `tpl_pages` AS `tp` INNER JOIN `tpl_files` AS `tf` ON `tp`.`tpl_id`=`tf`.`id`';
	$rs = viewSQL($sql);
	if(db_sql_num_rows($rs)>0)
	{
		$ids = array();
		while($res = db_sql_fetch_assoc($rs))
		{
			$ids[] = $res['id'];
		}
		$sql = 'SELECT `tp`.`id`, `tp`.`page_name` FROM `tpl_pages` AS `tp` LEFT JOIN `tpl_files` AS `tf` ON `tp`.`tpl_id`=`tf`.`id` WHERE `tp`.`id` NOT IN('.implode(', ', $ids).') AND `tp`.`tpl_id` IS NOT NULL';
		$rs = viewSQL($sql);
		if(db_sql_num_rows($rs)>0)
		{
			while($res = db_sql_fetch_assoc($rs))
			{
				$result[]['object_name'] = $res['page_name'].' (id='.$res['id'].')';
			}
			return get_test_result_row($result);
		}
	}
		return;
}

// проверка на выполнение функций
function _self_test_run_function($ar_params = array())
{
	global $err_message;
	$err_message = 'PHP-functions not exists or returned false result';

	$res = array();

	foreach ($ar_params as $key)
	{
		if (!function_exists($key) || !$key())
		{
			$res[]['object_name'] = $key;			
		}
	}

	return get_test_result_row($res);

}

function _self_test_send_mail($ar_params = array())
{
	global $err_message, $global_reply_mail_box_name, $global_reply_mail_box;
	$err_message = 'Error while send test e-mail';
	
	$res = array();
	$global_reply_mail_box = EE_SELF_TEST_EMAIL_FROM;
	$global_reply_mail_box_name = "EngineExpress self testing";	
	$send = phpmailer_send_mail(EE_SUPPORT_EMAIL, '', EE_HTTP." Test letter", "This is a test letter from ".EE_HTTP.".");
	if ($send !== true)
	{
		$res[]['object_name'] = $send;
	}
	return get_test_result_row($res,'Successfuly sent test letter to '.EE_SUPPORT_EMAIL);
}

