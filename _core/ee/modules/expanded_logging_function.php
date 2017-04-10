<?php
//Function return time with precision to microseconds
function microtime_float()
{
    list($usec, $sec) = explode(' ', microtime());
    return ((float)$usec + (float)$sec);
}

//Function turn on globall logging view sql queries if we use expanded logging
function turn_on_log_viewsql(&$log_viewsql)
{
	if (!$log_viewsql && EXPANDED_LOGGING_ON)
	{
		$log_viewsql = 1;
	}
}

//Function turn on globall logging run sql queries if we use expanded logging
function turn_on_log_runsql(&$log_runsql)
{
	if (!$log_runsql && EXPANDED_LOGGING_ON)
	{
		$log_runsql = 1;
	}
}

$expanded_logging_queries = array(array(), array());// Записываем все неповторяющиеся запросы в массив чтобы утверждать уникальные они или нет
$expanded_logging_queries_num = 0;//Полное количество запросов
$expanded_logging_problems = array();// Запросы у которых превышено время выполнения
//Function return query log
function expanded_logging_query($sql, $begin_logging_time, $end_logging_time, $type = 1)
{
	global $expanded_logging_queries, $expanded_logging_queries_num, $expanded_logging_problems;

	if (EXPANDED_LOGGING_ON || ERROR_SENDER_ON)
	{
		$query_execution_time = ($end_logging_time - $begin_logging_time);

		if ($query_execution_time > MAX_QUERY_EXECUTION_TIME)//если превышено допустимое время выполнения запроса
		{
			$expanded_logging_problems[sizeof($expanded_logging_problems)]['sql'] = $sql;
			$expanded_logging_problems[sizeof($expanded_logging_problems)-1]['time'] = sprintf("%.7f", $query_execution_time).' sec';
		}

		$expanded_logging_queries_num++;

		//Проверяем уникальный ли запрос
		if (!in_array($sql, $expanded_logging_queries[0]))
		{
			$expanded_logging_queries[0][] = $sql;
			$expanded_logging_queries[1][] = 1;

			if (LOGGER_OUTPUT_CSV)
			{
				$unique = '#yes#+';
			}
			else
			{
				$unique = "\n".'Query unique: yes';
			}
		}
		else
		{
			$key = array_search($sql, $expanded_logging_queries[0]);

			if ($key !== false)
			{
				$expanded_logging_queries[1][$key]++;

				if (LOGGER_OUTPUT_CSV)
				{
					$unique = '#no, repeated '.$expanded_logging_queries[1][$key].' times#+';
				}
				else
				{
					$unique = "\n".'Query unique: no, repeated '.$expanded_logging_queries[1][$key].' times';
				}
			}
		}

		//Проверяем использует ли запрос индексы
		if ($type)//Select запрос
		{
			$rs = @db_sql_query('EXPLAIN '.$sql);

			if ($rs && db_sql_num_rows($rs)>0)
			{
				$res=db_sql_fetch_assoc($rs);
				$extra = '';//как mysql выполняет запрос
				//if ($res['Extra'] == 'Using filesort' || $res['Extra'] == 'Using temporary')
				if (	strpos($res['Extra'], 'Using filesort')!== false
					||
					strpos($res['Extra'], 'Using temporary')!== false
				)
				{
					$extra = ' ('.$res['Extra'].')';
				}

				if (LOGGER_OUTPUT_CSV)
				{
					$key = '#yes#+';//использует ли mysql индексы
				}
				else
				{
					$key = "\n".'Query use index: yes';//использует ли mysql индексы
				}				

				if (is_null($res['key']))
				{
					if (LOGGER_OUTPUT_CSV)
					{
						$key = '#no#+';
					}
					else
					{
						$key = "\n".'Query use index: no';
					}
				}
			}
		}
	}
	else
	{
		$unique = $key = $extra = '';
	}

	if (EXPANDED_LOGGING_ON)
	{
		if (LOGGER_OUTPUT_CSV)
		{
			$prefix = '#';
			$separator = '#+';
		}
		else
		{
			$prefix = "\n".'Query execution time: ';
			$separator = '';
		}

		$str_format = $prefix."%.7f sec".$separator.$unique.$key.$extra;

		return sprintf($str_format, $query_execution_time);
	}
}

//Fuction return page log and send email if time execution more than must be
function expanded_logging_page($begin_logging_time)
{
	global $t, $expanded_logging_queries, $expanded_logging_queries_num, $expanded_logging_problems, $CONFIG;
	$end_logging_time = microtime_float();
	$page_problems = 0;//превышено ли время выполнения скрипта
	
	$page_execution_time = ($end_logging_time - $begin_logging_time);

	if ($page_execution_time > MAX_PAGE_EXECUTION_TIME)//если превышено допустимое время выполнения запроса
	{
		$page_problems = 1;
	}
	
	if (ERROR_SENDER_ON)
	{
		if ($page_problems || sizeof($expanded_logging_problems)>0)
		{
			//send email
			$msg = array();
			$eol = "\r\n";
			$headers='From: noreply@'.EE_HTTP_HOST.$eol;
			$headers.='MIME-Version: 1.0'.$eol;
			$headers.='Content-Type: text/plain; charset='.$CONFIG['mail_character_set'].$eol;
			$headers.='X-Mailer: PHP/'.phpversion();
			if (sizeof($expanded_logging_problems) > 0)
				for($i = 0; $i < sizeof($expanded_logging_problems); $i++)
				{
					$msg[] = 'Max query execution time exceeded'."\n".'Query:'.$expanded_logging_problems[$i]['sql']."\n".'Execution time: '.$expanded_logging_problems[$i]['time'].' sec';
				}
			if ($page_problems)
			{
				$msg[] = 'Max page execution time exceeded'."\n".'Page url: '.EE_HTTP_SERVER.EE_REQUEST_URI."\n".'Execution time: '.sprintf("%.7f", $page_execution_time).' sec';
			}
			$message = implode("\n\n", $msg)."\n\n".'Date: '.date("Y-m-d G:i:s");
			@mail(ERROR_SENDER_EMAIL, 'Site '.EE_SITE_NAME.' execution time exceeded', $message, $headers);
		}
	}

	if (EXPANDED_LOGGING_ON)//Если включена отсылка и-мейлов при превышении допустимого времени выполнения
	{
		$logger = get_global_logger();

		$logger->debug("\n".'Page url='.EE_HTTP_SERVER.EE_REQUEST_URI."\n".'Execution time: '.sprintf("%.7f", $page_execution_time).' sec'."\n".'Total unique queries: '.sizeof($expanded_logging_queries[0])."\n".'Total executed queries: '.$expanded_logging_queries_num."\r\n\r\n");
	}
	// тут еще может вызыватся скрипт dynamic_style.php из файла common.css что приведет к тому, что после информации о странице появится дополнительные 4 запроса
	
	// обратите внимание, что если вы укажите в файле modules/log4php.properties не абсолютный путь, а относительный то для этих 4 запросов будет создан отдельный файл request.log
	// расположеный уровнем выше, поскольку у них на 1 папку больше в REQUEST_URI
}


