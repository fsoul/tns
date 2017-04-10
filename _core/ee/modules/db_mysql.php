<?php

function db_sql_query_cache_create($query, $link_identifier = null)
{
//	db_connect();

//	mysql_query('SET NAMES utf8');

	if ($link_identifier == null)
	{
		$rs = mysql_query($query);
	}
	else
	{
		$rs = mysql_query($query, $link_identifier);
	}

	if (is_resource($rs))
	{
		
		$ar = array
		(
			'query' => $query,
			'data' => array(),
			'fields' => array()
		);

		$ar['num_fields'] = mysql_num_fields($rs);

		$i = 0;

		while ($i < ($ar['num_fields']))
		{
			$meta = mysql_fetch_field($rs, $i);
			$ar['fields'][] = $meta->name;

			$i++;
		}

		$i = 0;

		while ($array = mysql_fetch_array($rs))
		{
			$row = $assoc = array();

			$j = 0;

			foreach ($array as $k=>$v)
			{
				if (($j%2)==0)
				{
					$row[$k] = $v;
				}
				else
				{
					$assoc[$k] = $v;
				}

				$j++;
			}

			$ar['data'][$i]['array'] = $array;
			$ar['data'][$i]['row'] = $row;
			$ar['data'][$i++]['assoc'] = $assoc;
		}
	}
	else
	{
		$ar = null;
	}
//vdump($ar, '$ar\'return\'');

	return $ar;
}

function get_db_sql_query_cache_id($query)
{
	$query_id = md5(trim($query));

	return $query_id;
}

function db_sql_query_cache_array_save_to_file($ar_query_data, $dir_name, $query_id)
{
	if (file_exists($f = trim($dir_name, '/')) && !is_dir($f) && !unlink($f))
	{
		trigger_error('Can\'t create SQL-cache directory "'.$f.'" because of file with the same name is present and can\'t be deleted automaticaly. Please delete file via FTP.', E_USER_ERROR);

		$result = false;
	}

	if (!file_exists($dir_name = EE_PATH.EE_SQL_CACHE_DIR))
	{
		if (!(mkdir($dir_name, 0777)))
		{
			trigger_error('Can\'t create SQL-cache directory "'.$dir_name.'". Please make it via FTP with mask 0777.', E_USER_ERROR);

			$result = false;
		}
		elseif (!chmod($dir_name, 0777))
		{
			trigger_error('Can\'t set 0777-mask to SQL-cache directory "'.$dir_name.'". Please set it via FTP.', E_USER_ERROR);

			// result is not false here yet
			// it can be false on the next step - if dir is not writeable
		}
	}

	if (!is_writeable($dir_name))
	{
		trigger_error('SQL-cache directory "'.$dir_name.'" is not writeable. Please set mask 0777 it via FTP.', E_USER_ERROR);

		$result = false;
	}
	else
	{
		$file_name = $dir_name.$query_id;

		$serialized_query_data = serialize($ar_query_data);

		$handler = fopen($file_name, "w");

		if (fwrite($handler, $serialized_query_data))
		{
			$result = true;
		}
		else
		{
			trigger_error('Can\'t write to SQL-cache file "'.$file_name.'".', E_USER_ERROR);

			$result = false;
		}

		fclose($handler);

		if (!chmod($file_name, 0777))
		{
			trigger_error('Can\'t set attributes 0777 to SQL-cache file "'.$file_name.'".', E_USER_ERROR);
		}
	}

	return $result;
}


function db_sql_query_cache_init($query, $link_identifier = null)
{
	$query_id = get_db_sql_query_cache_id($query);

	global $ar_db_sql_query_cache;

	if (!is_array($ar_db_sql_query_cache))
	{
		$ar_db_sql_query_cache = array();
	}

	if (array_key_exists($query_id, $ar_db_sql_query_cache))
	{
		reset($ar_db_sql_query_cache[$query_id]['data']);
	}
	else
	{
		$rewrite_cache = false;

		if (file_exists($file_name = ($dir_name = EE_PATH.EE_SQL_CACHE_DIR).$query_id) && is_file($file_name))
		{
//msg($query, 'Read from file');
			$cache_data = file_get_contents($file_name);
			$ar_cache_data = unserialize($cache_data);

			if (!is_array($ar_cache_data))
			{
				trigger_error('Data stored in SQL-cache file "'.$file_name.'" is incorrect (not unserialazable) - will be replaced.');

				$rewrite_cache = true;
			}
		}
		else
		{
			$rewrite_cache = true;
		}

		if ($rewrite_cache)
		{
			$ar_cache_data = db_sql_query_cache_create($query, $link_identifier);
//vdump($ar_cache_data, '$ar_cache_data');

			// save to file only queries wich returns data
			// i.e. don't save to file queries like SET NAMES UTF-8
			//  - thay should be executed every time
			if (is_array($ar_cache_data))
			{
				db_sql_query_cache_array_save_to_file($ar_cache_data, $dir_name, $query_id);
			}
		}
//vdump($ar_cache_data['query'], 'query');
		// cache only queries wich returns data
		// i.e. don't cache queries like SET NAMES UTF-8
		//  - thay should be executed every time
		if (is_array($ar_cache_data))
		{
			$ar_db_sql_query_cache[$query_id] = $ar_cache_data;
		}
//vdump($ar_db_sql_query_cache[$query_id], $ar_db_sql_query_cache[$query_id]['query']);
	}

	return $query_id;
}




function db_sql_free_result($resource)
{
	if (is_resource($resource))
	{
		$res = mysql_free_result($resource);
	}
	else
	{
		$res = false;
	}

	return $res;
}

function db_sql_connect($servername, $username, $password)
{
	return mysql_connect($servername, $username, $password);
}

function db_sql_data_seek($result_identifier, $row_number)
{
	global $ar_db_sql_query_cache;

	if (EE_USE_SQL_CACHE && array_key_exists($result_identifier, $ar_db_sql_query_cache))
	{
		$res = (bool)(reset($ar_db_sql_query_cache[$result_identifier]['data']));

		for ($i = 0; $i<$row_number; $i++)
		{
			$res = (bool)(next($ar_db_sql_query_cache[$result_identifier]['data']));
		}
	}
	elseif (is_resource($result_identifier))
	{
		$res = mysql_data_seek($result_identifier, $row_number);
	}
	else
	{
		trigger_error('No resource is provided to db_sql_data_seek()-function: '.$result);

		$res = false;
	}

	return $res;
}

function db_sql_execute($stmt, $skip_results = null)
{
	return db_sql_query($stmt);
}




function db_sql_fetch_next($result, $type, $result_type = null)
{
	global $ar_db_sql_query_cache;

	if (EE_USE_SQL_CACHE && array_key_exists($result, $ar_db_sql_query_cache))
	{
		$current = current($ar_db_sql_query_cache[$result]['data']);
		$res = $current[$type];
		next($ar_db_sql_query_cache[$result]['data']);
	}
	elseif (is_resource($result))
	{
		$fetch_function_name = 'mysql_fetch_'.$type;

		if ($result_type == null)
		{
			$res = $fetch_function_name($result);
		}
		else
		{
			$res = $fetch_function_name($result, $result_type);
		}
	}
	else
	{
		trigger_error('No resource is provided to db_sql_fetch_'.$type.'()-function: ['.$resource . '], MySQL Error: [' . db_sql_error() . ']');

		$res = false;
	}

	return $res;
}


function db_sql_fetch_array($result, $result_type = null)
{
	return db_sql_fetch_next($result, 'array', $result_type);
}

function db_sql_fetch_assoc($result)
{
	return db_sql_fetch_next($result, 'assoc');
}

function db_sql_fetch_row($result)
{
	return db_sql_fetch_next($result, 'row');
}




function db_sql_num_fields($resource)
{
	global $ar_db_sql_query_cache;

	if (EE_USE_SQL_CACHE && array_key_exists($resource, $ar_db_sql_query_cache))
	{
		$res = $ar_db_sql_query_cache[$resource]['num_fields'];
	}
	elseif (is_resource($resource))
	{
		$res = mysql_num_fields($resource);
	}
	else
	{
		trigger_error('No resource is provided to db_sql_num_fields()-function: ['.$resource . '], MySQL Error: [' . db_sql_error() . ']');

		$res = false;
	}

	return $res;
}

function db_sql_num_rows($resource)
{
	global $ar_db_sql_query_cache;

	if (	EE_USE_SQL_CACHE &&
		array_key_exists($resource, $ar_db_sql_query_cache) &&
		array_key_exists('data', $ar_db_sql_query_cache[$resource])
	)
	{
		$num_rows = count($ar_db_sql_query_cache[$resource]['data']);
	}
	elseif (is_resource($resource))
	{
		$num_rows = mysql_num_rows($resource);
	}
	else
	{
		$num_rows = false;
	}

	return $num_rows;
}

function db_sql_query_can_update_db($sql)
{
	$sql = trim($sql);

	if ($result = !preg_match('/^SELECT\b/i', strtoupper($sql)))
	{
		vdump($sql, 'query can update db');
	}

	return $result;
}

function db_sql_query_clear_cache()
{
	return clear_dir(EE_PATH.EE_SQL_CACHE_DIR);
}

function db_sql_query($query, $link_identifier = null)
{
// if (DEBUG_MODE) echo $query.'<br>';
	if (EE_USE_SQL_CACHE)
	{
		if (db_sql_query_can_update_db($query))
		{
			db_sql_query_clear_cache();
		}

		$resource = db_sql_query_cache_init($query, $link_identifier);
	}
	else
	{
		if ($link_identifier == null)
		{
			$resource = mysql_query($query);
		}
		else
		{
			$resource = mysql_query($query, $link_identifier);
		}
	}

	return $resource;
}

function db_sql_result($result, $row, $field)
{
	return mysql_result($result, $row, $field);
}

function db_sql_affected_rows($conn_id=null)
{
	if ($conn_id==null)
	{
		return mysql_affected_rows();
	}
	else
	{
		return mysql_affected_rows($conn_id);
	}
}

function db_sql_rows_affected($conn_id=null)
{
	if ($conn_id==null)
	{
		return db_sql_affected_rows();
	}
	else
	{
		return db_sql_affected_rows($conn_id);
	}
}

function db_sql_select_db($database_name, $link_identifier)
{
	return mysql_select_db($database_name, $link_identifier);
}

function db_escape_string($var)
{
	return db_sql_escape_string($var);
}

function db_sql_escape_string($var)
{
	return mysql_real_escape_string($var);
}

function db_sql_insert_id()
{
	return mysql_insert_id();
}

function db_sql_error()
{
	return mysql_error();
}

function db_sql_table_fields ($table_name)
{
	$field_names = array();

	//php manual: The function mysql_list_fields() is deprecated...
	$rs = mysql_query('SHOW COLUMNS FROM '.$table_name);

	while ($r = mysql_fetch_array($rs))
	{
		$field_names[] = $r['Field'];
	}

	return $field_names;
}

function db_sql_query_fields ($sql)
{
	$field_names = array();
	$r = mysql_fetch_assoc(viewsql($sql, 0));

	if (is_array($r))
	{
		foreach ($r as $key=>$val)
		{
			$field_names[] = $key;
		}
	}

	return $field_names;
}

function db_sql_query_fields_for_empty_request($sql)
{
	$fields = array();
	$result = viewSQL($sql, 0);
	$count 	= db_sql_num_fields($result);	

	for ($i = 0; $i < $count; $i++)
	{
		$field = mysql_field_name($result, $i);
		$fields[] = $field;
	}

	return $fields;
}

function db_sql_is_enum_field($table_name, $field)
{
	$result = mysql_query("SHOW COLUMNS FROM ".$table_name);

	while ($row = mysql_fetch_object($result))
	{
		if (($field != '') && (preg_match('/enum/', $row->Type)) && (preg_match('/'.$field.'/', $row->Field)))
		{
			return true;
		}
	}

	return false;
}

function db_sql_show_enum_params($table_name, $field)
{
	$result = mysql_query("SHOW COLUMNS FROM ".$table_name);

	while ($row = mysql_fetch_object($result))
	{
		if (($field != '') && (preg_match('/enum/', $row->Type)) && (preg_match('/'.$field.'/', $row->Field)))
		{
			$ret = $row->Type;
			$ret = preg_replace(array('[enum\(]','[\'\)]'), '', $ret);
			$ret = preg_replace('[\']', '', $ret);
			$ret = explode(',',$ret);
		}
	}

	return $ret;
}

function db_sql_field_name($result,$field_offset=-1) 
{
	if ($field_offset==-1)
	{
		$r = mysql_field_name($result);
	}
	else
	{
		$r = mysql_field_name($result, $field_offset);
	}

	return $r;
}


function db_datetime_field_format($date_field_name) 
{
	return db_dt_field_format($date_field_name, DATETIME_FORMAT_MYSQL);
}

function db_date_field_format($date_field_name) 
{
	return db_dt_field_format($date_field_name, DATE_FORMAT_MYSQL);
}

function db_time_field_format($date_field_name) 
{
	return db_dt_field_format($date_field_name, TIME_FORMAT_MYSQL);
}

function db_dt_field_format($date_field_name, $format)
{
	return 'DATE_FORMAT('.$date_field_name.', \''.$format.'\')';
}



