<?
/*
* Copyright 2004 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL.
* http://www.2k-group.com
*/
//	Определяется IP адрес и версия браузера пользователя
	if (preg_match('/Opera(\/| )([0-9].[0-9]{1,2})/', $HTTP_USER_AGENT, $log_version))
	{
		define('PMA_USR_BROWSER_VER', $log_version[2]);
		define('PMA_USR_BROWSER_AGENT', 'OPERA');
	}
	elseif (preg_match('/MSIE ([0-9].[0-9]{1,2})/', $HTTP_USER_AGENT, $log_version))
	{
		define('PMA_USR_BROWSER_VER', $log_version[1]);
		define('PMA_USR_BROWSER_AGENT', 'IE');
	}
	elseif (preg_match('/OmniWeb\/([0-9].[0-9]{1,2})/', $HTTP_USER_AGENT, $log_version))
	{
		define('PMA_USR_BROWSER_VER', $log_version[1]);
		define('PMA_USR_BROWSER_AGENT', 'OMNIWEB');
	}
	elseif (preg_match('/(Konqueror\/)(.*)(;)/', $HTTP_USER_AGENT, $log_version))
	{
		define('PMA_USR_BROWSER_VER', $log_version[2]);
		define('PMA_USR_BROWSER_AGENT', 'KONQUEROR');
	}
	elseif (preg_match('/Mozilla\/([0-9].[0-9]{1,2})/', $HTTP_USER_AGENT, $log_version))
	{
		define('PMA_USR_BROWSER_VER', $log_version[1]);
		define('PMA_USR_BROWSER_AGENT', 'MOZILLA');
	}
	else
	{
		define('PMA_USR_BROWSER_VER', 0);
		define('PMA_USR_BROWSER_AGENT', 'OTHER');
	}

	if (getenv('REMOTE_HOST')!='' and getenv('REMOTE_HOST')!='unknown')
	{
		$ip = getenv('REMOTE_HOST');
	}
	else
	{
		$ip = getenv("REMOTE_ADDR");
	}

	if (getenv('HTTP_X_FORWARDED_FOR'))
	{
		$ip.= ' ('.getenv('HTTP_X_FORWARDED_FOR').')';
		define('USER_IP', $ip);
		unset($ip);
	}
//********************************************************************
//	Сохранить строку логов в БД
//function add_log($operation,$section,$str)
//{
//	$s = str_replace("'", "\'", $str);
//	$s = str_replace('"', '\"', $str);
//	db_sql_query('insert into u_logs(operation,section,str) values('.sqlValue($operation).', '.sqlValue($section).', '.sqlValue($s).')');
//}

function LogTo($str, $file_name='log.log')
{
	if (is_array($str))
	{
		$str = print_r($str, true);
	}

	$h = fopen(EE_PATH.'logs/'.$file_name, "a");
	fwrite($h, $str."\r\n\r\n");
	fclose($h);
}

function LogSql($sql, $file_name='sql.log')
{
	LogTo($sql, $file_name);
/*
	global $UserLogin, $UserIp, $modul;
	$arr = preg_split("/[\(\s,]+/", $sql, 4);
	if ($arr[0]=='update') $i=1;
	else $i=2;
	$operation = $arr[0];
	$section = $arr[$i];
	$module = $modul;

	$log_sql = 'insert into sql_logs
			(dates, login, ip, operation, section, sql, module)
		values	('.sqlValue(date("Y-m-d H:i:s")).', '.sqlValue($UserLogin).', '.sqlValue($UserIp).', '.sqlValue($operation).', '.sqlValue($section).', '.sqlValue($sql).', '.sqlValue($module).')';

	db_sql_query($log_sql)
	or
	die('<b>Can\'t write log</b><br>'.db_sql_error().'<hr>'.$log_sql.'<hr>');
	sleep(1);
*/
}

function parse_backtrace($raw)
{
	$output = '';

	if (is_array($raw))
	{
		foreach ($raw as $entry)
		{
			if (array_key_exists('file', $entry))
			{
				$output.= "\n<br />File: ".$entry['file'];

				if (array_key_exists('line', $entry))
				{
					$output.= "\n(Line: ".$entry['line'].")";
				}
			}

			if (array_key_exists('function', $entry))
			{				
				$output.= "\n<br />Function: ".$entry['function'];
			}

			if (array_key_exists('args', $entry))
			{
				if (array_key_exists('function', $entry) && $entry['function'] == 'userErrorHandler' && array_key_exists(4,$entry['args']))
				{
					unset($entry['args'][4]);					
				}
				$output.= "\n<br />Args: (".parse_backtrace_func_arg($entry['args']).")";
			}

			$output.= "\n<br />";
		}
	}
	return $output;
}

function parse_backtrace_func_arg($func_arg)
{
	$s ='';
	$func_arg_count = count($func_arg);

	foreach($func_arg as $k=>$v)
	{
		if (is_array($v))
		{
			$s .= "\n<br /><span style=\"display:block;margin-left:40px;\">Array\n<br />(\n<br /><span style=\"display:block;margin-left:40px;\">".print_array($v)."</span>)".(($k == ($func_arg_count - 1))?"":", ")."</span>";
		}
		else
		{
			if (is_object($v))
			{
				$v = print_r($v, 1);
			}

			$s .= ((strlen($v) >= 100)?"\n<br /><span style=\"margin-left:40px;\">":"")."\"".htmlentities($v,ENT_QUOTES)."\"".(($k == ($func_arg_count - 1))?"":", ")."</span>\n";
		}
	}
	return $s;
}
?>