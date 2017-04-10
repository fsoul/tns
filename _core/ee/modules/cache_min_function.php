<?php

function cache_check_authorize($request_page)
{
	global $page_extensions;

	$is_authorize = false;

	if (	isset($_SESSION['already_checked']) &&
		$_SESSION['already_checked'] == true &&
		array_search(pathinfo(parse_url(EE_HTTP.$request_page, PHP_URL_PATH), PATHINFO_EXTENSION), $page_extensions) !== false
	)
	{
		$is_authorize = true;
	}

	return $is_authorize;
}

/*
 * Checks if cache enabled or disabled
 * creates "cache is enabled"-indication file in cache-directory
 *
 */
function check_cache_enabled()
{
	$sql = '
		SELECT val
		  FROM config
		 WHERE var = \'ee_cache_html\'
	';

	if (getField($sql) == 1)
	{
		if (	!check_file(EE_CACHE_FILE_INDICATION_PATH) &&
			touch_dir_writable(EE_PATH.EE_CACHE_DIR)
		)
		{
			if ($fp = fopen(EE_CACHE_FILE_INDICATION_PATH, "w"))
			{
				fclose($fp);
			}
			else
			{
				trigger_error('Can\'t write to file "'.EE_CACHE_FILE_INDICATION_PATH.'"');
			}
		}

		$res = true;
	}
	else
	{
		if (	check_file(EE_CACHE_FILE_INDICATION_PATH) &&
			touch_dir_writable(EE_PATH.EE_CACHE_DIR)
		)
		{
			if (!delete_file(EE_CACHE_FILE_INDICATION_PATH))
			{
				trigger_error('Can\'t delete file "'.EE_CACHE_FILE_INDICATION_PATH.'"');
			}
		}

		$res = false;
	}

	return $res;
}

/*
*  1) if AUTHORIZE && EXTENSION [ html|htm ] 				- $create_cache_enabled = false;
*  2) if AUTHORIZE && EXTENSION NOT [ html|htm ] && cache_enabled 	- $create_cache_enabled = true;
*  3) if !AUTHORIZE && cache_enabled 					- $create_cache_enabled = true;
*/
function cache_get_page($request_page, $cache_dir = false)
{
	$cache_content = false;

	if (	!cache_check_authorize($request_page) &&
		//checking file "cache.enabled'
		file_exists(EE_CACHE_FILE_INDICATION_PATH) &&
		is_file(EE_CACHE_FILE_INDICATION_PATH)
	)
	{
		$allow_cache_fname = get_full_name_cache_from_aliase($request_page, '', $cache_dir);

		$cache_content = get_content_of_current_cache($allow_cache_fname);
	}

	return $cache_content;
}


/*
** Gets content of cache
** $file_name - cache file name
** returns content of cache page
*/
function get_content_of_current_cache($file_name)
{
	$res =  false;

	if (	file_exists($file_name) &&
		is_file($file_name)
	)
	{
		if ($h = fopen($file_name, "r"))	// открываем файл для чтения
		{
			//while (!flock($h, LOCK_EX)); - на тестах ведет себя так же как нижеиспользованный if ()
			if (flock($h, LOCK_EX)) // ждем пока сможем заблокировать его в личное пользование
			{
				if (($fsize = filesize($file_name)) > 0)
				{
					$res = fread($h, $fsize); // пользуясь полученной блокировкой считываем его
					// никаких file_get_contents() !!!
					// только fread()|fgets() и т.д.
					// потому что иначе блокировка не даст читать файл
				}
				else
				{
					trigger_error('Cache file '.$file_name.' is empty');
				}

				flock($h, LOCK_UN);		// отпускаем
			}
			else
			{
				trigger_error('Can\'t lock cache file '.$file_name.' in EX-mode');
			}

			fclose($h);		// закрываем
		}
		else
		{
			trigger_error('Can\'t open cache file '.$file_name.' for reading');
		}
	}

	return $res;
}


/*
** Input:  $aliase - name of page
** 	   $dns - dns
** Output: Returns full path of cache page
**
*/
function get_full_name_cache_from_aliase($aliase, $dns = '', $cache_dir = false, $extension = true)
{                 
	$path_string = parse_url(EE_HTTP.$aliase, PHP_URL_PATH);

	parse_str(parse_url(EE_HTTP.$aliase, PHP_URL_QUERY), $arr_query);

	ksort($arr_query);

	$query_string = http_build_query($arr_query);

	$dot_pos = strrpos($path_string, '.');

	$extension = ($extension)?substr($path_string, $dot_pos):'';

	$alias_name = substr($path_string, 0, $dot_pos);

	$result_alias_string = md5(strtolower($alias_name)).( ( $query_string ) ? '_'.md5(strtolower($query_string)): '' ).$extension;

	$result = EE_PATH.($cache_dir ? $cache_dir : EE_CACHE_DIR).get_dns_as_file_name($dns).$result_alias_string;

	return $result;
}


/*
** Input:  $dns - some site DNS
** Output: Returns $dns with some changes for use it as part of any file name
**
*/
function get_dns_as_file_name($dns = '')
{
	if ($dns == '')
	{
		$dns = EE_HTTP_HOST;
	}

	$dns = strtolower($dns);

	// если начинается с www. - убираем www.
	if (strpos($dns, 'www.') === 0)
	{
		$dns = substr($dns, 4);
	}

	$dns = str_replace('.', '_dot_', $dns);

	return $dns;
}



//function check if page is avilable via current protocol, if no make redirect to page native protocol
function check_page_protocol($protocol_id, $protocol_type)
{
	if($protocol_id == 0//should be used http
	&& $protocol_type != 'http')//but used https
	{
		header('Location: http://'.EE_HTTP_HOST.$_SERVER['REQUEST_URI'], true, 301);
		exit;
	}
	else if($protocol_id == 1//should be used http
	&& $protocol_type != 'https')//but used https
	{
		header('Location: https://'.EE_HTTP_HOST.$_SERVER['REQUEST_URI'], true, 301);
		exit;
	}
	//if $protocol_id == 2 do nothing
}

