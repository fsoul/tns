<?
// возвращает значение поля $field
// первой записи результата запроса $sql
function getField($sql, $field = 0, $debug = 0)
{
	$rs = viewsql($sql, $debug);

	if (is_int($field))
	{
		$r = db_sql_fetch_row($rs);
	}
	else
	{
		$r = db_sql_fetch_assoc($rs);
	}

	return $r[$field];
}

function spValue($var)
{
	if (is_null($var) or !isset($var) or $var==='')
	{
		$s = 'NULL';
	}
	else
	{
		$s = '\''.db_escape_string($var).'\'';
	}

	return $s;
}

/*
* Use it in WHERE clause of SQL-queries
*/
function sqlValueWhere($var)
{
	if (is_null($var))
	{
		$s = ' IS NULL ';
	}
	else
	{
		$s = ' = '.sqlValue($var);
	}

	return $s;
}

/*
* Use it in SET clause of SQL-queries
*/
function sqlValueSet($var)
{
	if (is_null($var))
	{
		$s = 'NULL';
	}
	else
	{
		$s = sqlValue($var);
	}

	return $s;
}

function sqlValue($var)
{
	if (!isset($var) or is_null($var) or $var==='')
	{
		$s = '\'\'';
	}
	else
	{
		$s = '\''.db_escape_string($var).'\'';
	}

	return $s;
}

/*
** Input: raw array of ids.
** Output: formated array with sqllike string value.
** Warning!!!
** If you input array like ("2abcyz", "13dffgdf") and use Output of this function in SQL function like DELETE
** be careful, because SQL will get ("2", "13") not ("2abcyz", "13dffgdf").
**
*/
function sqlValuesList($array_of_id, $check_access_mode = false) 
{
        if(is_array($array_of_id))
	{   		
		foreach($array_of_id as $key=>$value)
		{
			if($check_access_mode && check_content_access(CA_READ_ONLY,null,null,$value))
			{}
			else
			{
		   	 	$array_of_id_2[$key] = sqlValue($value);
			}
		}
		$array_del_items = implode(',' , $array_of_id_2);
		return $array_del_items;
	}
	else
	{
		return 	0;
	}
}


// предназначена для вызова процедур из базы
// возвращает значение, возвращаемое БД-шной процедурой
function CallSql($sql, $debug_mode=1) {
	return RunSQL('call '.$sql, $debug_mode);
}

// предназначена для вызова хр.процедур из базы MSSQL или функций из базы MySQL
// возвращает значение, возвращаемое БД-шной хр.п./функцией
function GetSql($sql, $debug_mode=1) {
	$sql_tpl = array (
		'mssql' => 'dbo.%s %s',
		'mysql' => '%s (%s)'
	);
	if (is_array($sql)) {
		$sql_name = $sql[0];
		unset($sql[0]);
		$sql = sprintf($sql_tpl[EE_DBMS], $sql_name, implode(', ',$sql));
	}
	$rs=ViewSQL((EE_DBMS=='mssql'?'execute ':'select ').$sql, $debug_mode);
	$r=db_sql_fetch_array($rs);
	return $r[0];
}

function ViewSQL($sql, $debug_mode=0)
{
$debug_mode=0;
//msg($sql, 'ViewSQL');

	global $log_viewsql, $present_loger_csv_header;

	if ($log_viewsql && LOGGER_OUTPUT_CSV)
	{
		$debug_array = getRunFileAndLine($sql);
	}

	if (	$log_viewsql
		||
		EXPANDED_LOGGING_ON
		||
		ERROR_SENDER_ON
	)
	{
		require_once(EE_CORE_PATH.'modules/log4php_function.php');

		$logger = get_global_logger();
	}

	if ($debug_mode)
	{
		msg($sql, 'SQL');
	}
	
	$begin_logging_time = microtime_float();

	$res = @db_sql_query($sql);

//vdump($res, '$res');
//vdump(db_sql_num_rows($res), 'db_sql_num_rows($res)');

	$end_logging_time = microtime_float();
	
	if ($debug_mode)
	{
		grid($res, 0);
	}

	
	if (!$res)
	{
		if (!$debug_mode) msg($sql, 'SQL');
		msg (db_sql_error(), 'SQL error');
		
		// дебаг в файл
		if ($log_viewsql)
		{
			$logger->error("\n".'ViewSQL ERROR -- '.$sql." -- ".db_sql_error().expanded_logging_query($sql, $begin_logging_time, $end_logging_time, 1));
		}
		elseif (ERROR_SENDER_ON)
		{
			expanded_logging_query($sql, $begin_logging_time, $end_logging_time, null);
		}
	}
	else
	{
		// дебаг в файл
		if ($log_viewsql)
		{
			if (LOGGER_OUTPUT_CSV)
			{
				if ($present_loger_csv_header === null)
				{	
					$logger->debug($_SERVER['REQUEST_URI']."\r\n");
					$logger->debug("#Run time#+#SQL query#+#Row number#+#Query execution time#+#Query unique#+#Query use index#+#module#+#line#\n");
					$present_loger_csv_header = 1;
				}
				$logger->debug("#".date("d.M.Y H:i:s")."#+#".str_replace("\r\n", "", $sql)."#+#".@db_sql_num_rows($res).'#+'.expanded_logging_query($sql, $begin_logging_time, $end_logging_time, 1)."#".$debug_array['file']."#+#".$debug_array['line']."#\n");
			}
			else
			{
				$logger->debug("\n".$sql."\n".'Rows number: '.@db_sql_num_rows($res).expanded_logging_query($sql, $begin_logging_time, $end_logging_time, 1));
			}
		}
		elseif (ERROR_SENDER_ON)
		{
			expanded_logging_query($sql, $begin_logging_time, $end_logging_time, null);
		}
	}

	if ($debug_mode)
	{
		msg(@db_sql_num_rows($res), 'Rows number');
	}

	return $res;
}

// функция которая формирует масив (файл, строка). где выполнялся SQL запрос (8842)
function getRunFileAndLine($sql)
{
	$debug_array = debug_backtrace();
	
	foreach($debug_array as $val)
	{
		if(array_key_exists ('args', $val) &&
			in_array($sql, $val['args']) && 
			(strtolower($val['function']) == 'viewsql' ||
			strtolower($val['function']) == 'getfield' ||
			strtolower($val['function']) == 'runsql')
		)
		{
			$array['file'] = basename($val['file']);
			$array['line'] = $val['line'];

		}
	}
	return $array;
}

/**
 * Run sql procedure
 *
 * @param string $procedure_name - name of function
 * @param arrar $params - array of parameters
 * @return nothing
 */
function RunSQLProcedure($procedure_name, $params)
{
	$logger = get_global_logger();

	$sql = 'CALL '.$procedure_name.' ('.Array2SQLstring( $params ).')';
	@db_sql_query($sql);
	if (db_sql_error())
		$logger->error('RunSQLProcedure ERROR -- '.$sql." -- ".db_sql_error());
//	Log::SQLLog($sql);
//	Log::SQLLog(db_sql_error());
//	return $res['id'];
}


/**
 * Run sql function
 *
 * @param string $function_name - name of function
 * @param arrar $params - array of parameters
 * @return result
 */
function RunSQLFunction($function_name, $params)
{
	$logger = get_global_logger();

	$sql = 'SELECT '.$function_name.' ('.Array2SQLstring( $params ).') AS id';
	$res = @db_sql_fetch_assoc(RunSQL($sql, 0));
	if (db_sql_error())
		$logger->error('RunSQLFunction ERROR -- '.$sql." -- ".db_sql_error());
	return $res['id'];
}

function Array2SQLstring($arr)
{
	if (!is_array($arr))
	{
		print "Incorrect input parameter!!!";
		print var_dump(debug_backtrace());
	}
	$s = '';
	foreach ($arr as $k=>$v)
	{
		$s.=spValue($arr[$k]).",";
	}
	$s = substr($s,0,-1); // remove last comma
	return $s;
}

function RunSQL($sql, $debug_mode=1)
{
	$logger = get_global_logger();

	$log_runsql = get_config_var('log_runsql'); // Записывать ли в лог insert/update/delete запросы
	turn_on_log_runsql($log_runsql);// Включаем глобальное логирование если включено EXPANDED_LOGGING_ON

	// (для разработчика)
	if ($debug_mode)
	{
		msg($sql, 'SQL');
	}

	$begin_logging_time = microtime_float();

	$res=@db_sql_query($sql);
	
	$end_logging_time = microtime_float();
	
	if (!$res)
	{
		// если вывод запроса был отменен аргументом $debug_mode=0
		// - все-таки покажем запрос, т.к. была ошибка
		// (для разработчика)
		// в противном случае он уже показан
		if (!$debug_mode)
		{
			msg($sql, 'SQL');
		}

		// независимо от параметра функции $debug_mode выведем ошибку
		// (для разработчика)
		msg (db_sql_error(), '<font color="red">SQL error</font>');

		// дебаг в файл
		if($log_runsql)
		{
			$logger->error("\n".'RunSQL ERROR -- '.$sql." -- ".db_sql_error().expanded_logging_query($sql, $begin_logging_time, $end_logging_time, 0));
		}
		else//на случай если включено ERROR_SENDER_ON
			expanded_logging_query($sql, $begin_logging_time, $end_logging_time, null);
	}
	else
	{
		// если это insert - возвращаем id добавленной строки
		if (preg_match("/^[\n\t ]*insert/i",trim($sql)))
		{
			$res = db_sql_insert_id();
			if ($debug_mode)
			{
				msg($res, 'Inserted ID');
			}
		}

		// дебаг в файл
		if($log_runsql)
		{
			$logger->debug("\n".$sql.expanded_logging_query($sql, $begin_logging_time, $end_logging_time, 0));
		}
		else//на случай если включено ERROR_SENDER_ON
			expanded_logging_query($sql, $begin_logging_time, $end_logging_time, null);
	}

	if ($debug_mode)
	{
		msg(db_sql_affected_rows().'</p><p>&nbsp;', 'Affected rows number');
	}

	return $res;
}

function table($table_name)
{
	return viewsql('select * from '.$table_name.' order by 1');
}

function grid($sql, $show_rows_num=1)
{
	$flag = false;
	$s = '';
	if (DEBUG_MODE)
	{
		global $ar_db_sql_query_cache;
		// если запрос уже выполнен и сюда передан sql-result
		if (	is_resource($sql)
			||
			(
			EE_USE_SQL_CACHE &&
			isset($ar_db_sql_query_cache) &&
			array_key_exists($sql, $ar_db_sql_query_cache)
			)
		)
		{
			$rs = $sql;
		}
		// иначе - передали строку SQL, выполним запрос
		else
		{
			$rs = db_sql_query($sql);
		}

		$rows_num = db_sql_num_rows($rs);

		if ($rows_num)
		{
			if ($show_rows_num) msg($rows_num, 'Rows number');
			$s.='<table border="1" cellspacing="1" cellpadding="1">';
			while($r=db_sql_fetch_array($rs))
			{
				if (!$flag)
				{
					$flag=true;
					$keys=array_keys($r);
					for($i=1;$i<count($keys);$i+=2)
					{
						$s.='<td><b><font color="gray">'.$keys[$i].'</font></b></td>';
					}
				}
				$s.='<tr>';
				for($i=0;$i<db_sql_num_fields($rs);$i++)
				{
					$s.='<td>'.($r[$i]!=NULL?$r[$i]:'<i>NULL</i>').'</td>';
				}
				$s.='</tr>';
			}
			$s.='</table>';
			echo $s;
			db_sql_data_seek($rs, 0);
		}
	}
	return $s;
}

/*
* проверка наличия таблици в БД
*/
function is_table($table_name)
{
	$sql = 'SHOW TABLES';

	if ($res = viewSQL($sql, 0))
	{
		while($row = db_sql_fetch_array($res))
		{
			if ($table_name == $row[0])
			{
				return true;
			}
		}
	}

	return false;
}

