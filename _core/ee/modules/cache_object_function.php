<?php
	/* 
	* function that provide object caching
	* $obj_id - (integer) object id
	* $type - (string) cache type (object_sql_view or field attributes) as cache type might be used any string  
	* $cached_data - (string) data that will be cached
	*
	*/
	function cache_obj($obj_id, $type, $cached_data)
	{
		if (	EE_CACHE_OBJECT_ENABLE && 
			touch_dir_writable(EE_PATH.EE_CACHE_DIR, EE_DEFAULT_DIR_MODE) &&
			touch_dir_writable(EE_PATH.EE_OBJ_CACHE_DIR, EE_DEFAULT_DIR_MODE)
		)
		{
			// get full pathname to cache file
			$file_name = get_cache_obj_file_name($obj_id, $type, '');
			// save cache
			save_obj_cache($file_name, $cached_data);
			$result = true;
		}
		else 
		{
			$result = false;
		}
		return $result;
	}
	/*
	* save object cache
	* $file_name - full pathname to cache file
	* $cached_data - (string) data that will be cached
	*/
	function save_obj_cache($file_name, $cached_data)
	{
		// clean cache
		if (file_exists($file_name))
		{
			unlink($file_name);
		}

		// write data to cache file
		if ($fp = fopen($file_name, 'w'))
		{
			fwrite($fp, $cached_data);
			fclose($fp);
			return true;
		}
		return false;
	}
	/*
	* get full pathname to cached file
	* $obj_id - (integer) object id
	* $cache_type - (string) cache type (object_sql_view or field attributes) as cache type might be used any string. 
	* By default $cache_type equal 'sql_view'
	*
	*/
	function get_cache_obj_file_name($obj_id, $cache_type = 'sql_view', $dns = '')
	{
		$file_name = EE_PATH.EE_OBJ_CACHE_DIR.get_dns_as_file_name($dns).'_'.md5($obj_id.'_'.$cache_type);
		return $file_name;
	}
	/*
	* check is object cache present for one object
	* $obj_id - (integer) object id
	* $type - (string) cache type (object_sql_view or field attributes) as cache type might be used any string.
	*/
	function check_obj_cache($obj_id, $type)
	{
		$file_name = get_cache_obj_file_name($obj_id, $type, '');

		if(file_exists($file_name))
		{
			return true;
		}

		return false;
	}
	/*
	* get object cache by object id
	* $obj_id - (integer) object id
	* $type - (string) cache type (object_sql_view or field attributes) as cache type might be used any string.
	*
	*/
	function get_obj_cache($obj_id, $type)
	{
		$file_name = get_cache_obj_file_name($obj_id, $type, '');
		$cache = file_get_contents($file_name);
		return $cache;
	}
	/*
	*
	*
	function is_object_cache()
	{
		 check_chache_exists($cache_path)
	}
	*/
	function clean_all_obj_cache()
	{
		delete_cache_by_path(EE_PATH.EE_OBJ_CACHE_DIR);
	}

?>