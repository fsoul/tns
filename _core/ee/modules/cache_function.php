<?php

/*
** Delete cache function, deletes cache for mentioned page and language for all DNS.
** param $id - id of page to delete
** param $lng - language of cache to delete
*/
function delete_cache_by_id($id, $lng)
{
//vdump($id, '$id');
//vdump($lng, '$lng');
	$ar_dns = SQLField2Array(viewsql('SELECT dns FROM dns'));
//vdump($ar_dns, '$ar_dns');
	if (count($ar_dns) > 0)
	{
		foreach($ar_dns as $dns)
		{
			//msg($dns, '$dns');
			if (is_array($cache_file_mask = glob(create_cache_file_mask_from_aliase($id, $lng, $dns))))			
			{               
				foreach ($cache_file_mask as $filename)
				{
					delete_file($filename);
				}
			}

			//msg($cache_name, '$cache_name');
			delete_file($cache_name);

			// delete VIEWS cached pages
			// views cache file name array
			$views_cache_files_name_array = get_views_full_name_cache_from_id($id);
			if(is_array($views_cache_files_name_array))
			{
				foreach($views_cache_files_name_array as $val)
				{
					delete_file($val);
				}
			}
		}
	}

}

/*
** Delete cache function, deletes (all or for page) cache.
** $aliase - id or name of page
** EE_PATH.EE_CACHE_DIR - path of CACHE
*/
function delete_cache($id = null, $delete_language = null)
{
	if(($id !== null) && ($delete_language !== null))
	{
		delete_cache_by_id($id, $delete_language);
	}
	elseif(($id == null) && ($delete_language !== null))
	{
		$result = db_sql_query('select id from tpl_pages');
		while ($row = mysql_fetch_array($result, MYSQL_ASSOC))
		{
			delete_cache_by_id($row['id'], $delete_language);
		}
	}
	elseif($id !== null)
	{
		$result = viewsql('select language_code from v_language');

		while ($row = db_sql_fetch_array($result))
		{
			delete_cache_by_id($id, $row['language_code']);
		}
	}
        else
	{
		delete_cache_by_path(EE_PATH.EE_CACHE_DIR);
		delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
		delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	}
}

function delete_cache_by_path($cahe_path)
{
	clear_dir($cahe_path);
}

/*
** Gets id cache from aliase
** $aliase - name of page
** returns full path of cache page
*/
function get_full_name_cache_from_id($id, $lang = null, $dns = '', $extension = true)
{
//msg($id, 'get_full_name_cache_from_id   $id');
//msg($lang, 'get_full_name_cache_from_id   $lang');
//msg($dns, 'get_full_name_cache_from_id   $dns');
	return get_full_name_cache_from_aliase(get_default_aliase_for_page($id, '', $lang), $dns, false, $extension);
}

/**
* Get cache views file name from page_id
**/

function get_views_full_name_cache_from_id($id, $lang = null, $dns = '')
{
	$r = viewSQL('SELECT view_name FROM tpl_views');
	while($views = db_sql_fetch_array($r))
	{
		$views_cache_name[] = get_full_name_cache_from_aliase(get_default_alias_for_view($id, $views[0]), $dns);
	}
	return $views_cache_name;
}

/*
** Save cache for page
** $html - content of page
**
*/

function save_cache_for_current_page($html, $pname, $cache_dir = false, $addition_info = false)
{

	global  $page_is_alias, $page_is_system_alias, $t, $ar;

	$cache_dir 	= ($cache_dir ? $cache_dir : EE_CACHE_DIR);
	$dir_size 	= dir_size(EE_PATH.$cache_dir);

	$additional_header = '';

	if (	is_array($addition_info) && 
		count($addition_info) > 0
	)
	{
		$additional_header = '<!--'.serialize($addition_info).'-->'."\r\n";

		$html = $additional_header.$html;
	}

	if (($dir_size['totalsize'] + strlen($html)) > EE_CACHE_DIR_SIZE_LIMIT_BYTES)
	{
		delete_cache_by_path(EE_PATH.$cache_dir);
	}

	//if not media or else
	if ($page_is_alias == true)
	{
		$fname = get_full_name_cache_from_id($t, null, '');
	}
	else
	{
		$fname = get_full_name_cache_from_aliase($pname, '', $cache_dir);
	}

	/** 
	 *  To prevent reading|writing cache while it's creating
	 */
	if ($fp = fopen($fname, "a"))
	{
		if (flock($fp, LOCK_EX))
		{
			ftruncate($fp, 0);
			fwrite($fp, $html);
			flock($fp, LOCK_UN);
		}
		else
		{
			trigger_error('Can\'t lock cache file '.$fname.' in EX-mode');
		}

		fclose($fp);
	}
	else
	{
		trigger_error('Can\'t open cache file '.$fname.' for writing');
	}
}

/*
** This function generates image in admin _tpl_pages
** delete_all_cache_enabled or delete_all_cache_disabled
**
*/
function check_if_cache_exists()
{
	$cache_path 	= EE_PATH.EE_CACHE_DIR;
	$cache_path_xml	= EE_PATH.EE_XML_CACHE_DIR;
	$cache_path_obj	= EE_PATH.EE_OBJ_CACHE_DIR;

	if(	check_chache_exists($cache_path) ||
		check_chache_exists($cache_path_xml) ||
		check_chache_exists($cache_path_obj)
	)
	{
		return true;
	}
	else
	{
		return false;
	}
}

/*
** this function check cache folder exists by $cache_path.
*/
function check_chache_exists($cache_path)
{
	if (check_folder_exist($cache_path) && is_writable($cache_path) && $dh=opendir($cache_path))
	{
		while ($file = readdir($dh))
		{
			if (	is_file($cache_path.$file) &&
				!is_dir($cache_path.$file) &&
				$file != EE_CACHE_FILE_INDICATION
			)
			{
				return true;
			}
		}
	}

	return false;
}

/*
** This function generates image in admin _tpl_pages
** delete_cache_page_for_all and delete_cache_page
**
*/
function check_if_exists_other_lng_cache($aliase)
{
        $result = db_sql_query('select language_code from v_language');
	while ($row = db_sql_fetch_assoc($result))
	{
		if (glob(create_cache_file_mask_from_aliase($aliase, $row['language_code'])))
		{
			return true;
		}
	}
	return false;
}

function create_cache_file_mask_from_aliase($aliase, $lng = null, $dns = '')
{
	$cache_file = get_full_name_cache_from_id($aliase, $lng, $dns);
	$ar_cache_file = pathinfo($cache_file);
	$cache_file_mask = $ar_cache_file['dirname'].'/'.$ar_cache_file['filename'].'*.'.$ar_cache_file['extension'];
	return $cache_file_mask;
}

/*
** Checks if folder $path exists
** if exists return 1
**
*/
function check_folder_exist($path)
{          
	if (file_exists($path))
	{
		$res = 1;
	}
	else
	{
		$res = 0;
	}

	return $res;
}

function is_cachable($t)
{
	global $page_is_system_object_alias;

	if ($page_is_system_object_alias && !($t != (int)$t))
	{

		$internal_t = (int)getField('SELECT id FROM tpl_files WHERE file_name = ' . sqlValue($t));
		if (is_tpl_cachable($internal_t))
		{
			return true;
		}
	}
	else
	{
		if (	is_tpl_cachable_by_page($t) &&
			is_page_cachable_by_page($t)
			)
		{
			return true;
		}
	}

	return false;
}

