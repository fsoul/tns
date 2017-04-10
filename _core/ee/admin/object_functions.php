<?

if ( !function_exists('htmlspecialchars_decode') )
{
    function htmlspecialchars_decode($text)
    {
        return strtr($text, array_flip(get_html_translation_table(HTML_SPECIALCHARS)));
    }
}

function import_object_from_csv()
{
	global $modul, $error, $fields;
	global $type;

	$__object_id = getField('SELECT id FROM object WHERE name = ' . sqlValue(substr($modul, 1)));

	// с массива полей забираем поля типа image, потому как они будут импортировать неверно. Єто в свою очередь приведет к "поломке дизайна"...
	// см. аттач к 9207

	$fields_old = $fields;
	$fields = array();
	foreach($fields_old as $val)
	{
		if($type[$val] != 'image')
		{
			$fields[] = $val;
		}
	}

	if (post('refresh') && count($_FILES['csv_file']))
	{
		$csv_file_name = ($_FILES['csv_file']['tmp_name']);
		$csv_file_ext = strtolower(substr($_FILES['csv_file']['name'], -4));

		if (	$csv_file_ext == '.csv' &&
			check_file($csv_file_name)
		)
		{
			ini_set('auto_detect_line_endings', true);

			$ar_rows = $ar_row = array();

			$ar_spaces = array('&nbsp;', ' ');

			// parse csv-fle row by row and return it as array
			$ar_rows = parse_csv_file($csv_file_name, ";");

			$ar_csv_field_names = $ar_rows[0];

			foreach($ar_csv_field_names as $k=>$v)
			{
				$ar_csv_field_names[$k] = strtolower($ar_csv_field_names[$k]);

				// change all possible variants of space in csv-file fields names to underscore
				// the same will be done with captions (see code below)
				// so we will have the same fields names format in both cases
				$ar_csv_field_names[$k] = str_replace($ar_spaces, '_', $ar_csv_field_names[$k]);
			}

			$ar_langs = SQLField2Array(viewsql('SELECT language_code FROM v_language', 0));

			if (count($error)==0)
			{
				// updated rows counter
				$upd = 0;

				for ($i=1; $i<count($ar_rows); $i++)
				{
					$ar_csv_field_values = $ar_rows[$i];

					if (count($ar_csv_field_values) != count($ar_csv_field_names))
					{
						$error['csv_file'] = 'Incorrect data structure in row '.$i;

						if (defined('DEBUG_MODE') && DEBUG_MODE)
						{
							$error['csv_file'].= '<br>';
							$error['csv_file'].= '<pre>';
							$error['csv_file'].= print_r($ar_rows[$i], 1);
							$error['csv_file'].= 'Last correct data in row '.($i-1).': <br>';
							$error['csv_file'].= print_r($ar_rows[$i-1], 1);
							$error['csv_file'].= '</pre>';
						}

						break;
					}

					global $caption;

					foreach ($fields as $field_name)
					{
						// now id-fileds can be updated via appropriate record values (see new code below)
						/*
						// Id-fields will not be updated anyway
						if (ereg('^.+_id$', $field_name))
						{
							continue;
						}
						*/

						if (array_key_exists($field_name, $caption))
						{
							$field_caption = strtolower($caption[$field_name]);

							// change all possible variants of space
							// in fields names (taked from caption-array) to underscore
							// the same was done with csv-file fields names (see code above)
							// so we will have the same fields names format in both cases
							$field_caption = str_replace($ar_spaces, '_', $field_caption);
						}
						else
						{
							$field_caption = $field_name;
						}

						foreach ($ar_langs as $lang_code)
						{
							$field_name_lng = strtolower($field_name.'_'.$lang_code);					

							if (in_array($field_name_lng, $ar_csv_field_names))
							{
								$field_name_csv = $field_name_lng;
							}
							elseif (in_array($field_caption, $ar_csv_field_names))
							{
								$field_name_csv = $field_caption;
							}
							else
							{
								continue;
							}

							if (in_array($field_name_csv, $ar_csv_field_names))
							{
								$_value = $ar_csv_field_values[array_search($field_name_csv, $ar_csv_field_names)];
								//
								if (preg_match('/^.+_id$/', $field_name))
								{
									$m_object = str_replace('_id', '', $field_name);

									if($_object_id = get_object_id_by_name(str_replace('_id', '', $field_name)))
									{
										if (!is_integer(intval($_value)))
										{
											$_sql = 'SELECT object_record_id 
													FROM object_content 
													WHERE object_field_id=(
														SELECT id 
														FROM object_field 
														WHERE 	object_field_name=\'value\'
															AND
															object_id=\''.$_object_id.'\'
														) 
													AND value="'.htmlspecialchars_decode($_value).'"';

											$new_value = getField($_sql);
		
											if ($new_value)
											{
												$_value = $new_value;
											}
											elseif ($_value !== ' ' && $_value !== '')
											{
												$error['csv_file'] = 'Classifier "'.$_value.'" not find in "'.(str_replace('_id', '', $field_name)).'" object. Please check that imported data correctly. [\''.$_sql.'\']';
												break;
											}
										}
									}
								}

								$sql = '
									object_content
								    SET
									value = '.sqlValue($_value);

								$where = '

								  WHERE
									'.($object_record_id = 'object_record_id = '.sqlValue($ar_csv_field_values[array_search('id', $ar_csv_field_names)])).'
								    AND '.($object_field_id = 'object_field_id = (

									 SELECT id
									   FROM object_field
									  WHERE object_field_name = '.sqlValue($field_name).'
									    AND object_id = ' . sqlValue($__object_id) . ')');

								if ($field_name == 'object_unique_name')
								{
									$sql_check = 'SELECT 
												count(*) 
											FROM 
												object_content 
											WHERE
												object_record_id <> ' . sqlValue($ar_csv_field_values[array_search('id', $ar_csv_field_names)]) .'
												AND 
												'.$object_field_id.'
												AND
												value=' . sqlValue($_value) . '
											';

									if (getField($sql_check) > 0)
									{
										$error['csv_file'] = 'Such object unique name already exists. [dublicate object unique name : ' . $_value . '] ';
									}
								}

								if ($field_name_csv == $field_name_lng)
								{
									//$ar_sql_update[$i][count($ar_sql_update[$i])-1] = $ar_sql_update[$i][count($ar_sql_update[$i])-1].' AND language = '.sqlValue(strtoupper($lang_code));
									$where.= ' AND '.($object_language = ' language = '.sqlValue(strtoupper($lang_code)));
								}
								else
								{
									global $language;
									$object_language = ' language = '.sqlValue($language);
								}

								if ((getField('SELECT count(*) FROM object_content '.$where)) > 0)
								{
									$sql = 'UPDATE '.$sql. ' '.$where;
								}
								else
								{
									$sql = '
									    INSERT INTO '.$sql.',
											'.$object_record_id.',
											'.$object_field_id.',
											'.$object_language;
								}

								$ar_sql_update[$i][] = $sql;

								if ($field_name_csv != $field_name_lng)
								{
									break;
								}
							}
						}
					}
				}
				if (count($error)==0)
				{
					runsql('START TRANSACTION', 0);

					for($i = 1; $i<=count($ar_sql_update); $i++)
					{
						$record_updated = false;

						foreach($ar_sql_update[$i] as $sql_update)
						{
							runsql($sql_update, 0);

							if (db_sql_affected_rows())
							{
								$record_updated = true;
							}
						}

						if ($record_updated)
						{
							$upd++;
						}
					}

					runsql('COMMIT', 0);

					clean_all_obj_cache();

					$s = array();
					$s[] = 'import success';
					$s[] = $upd.' rows updated';
					$error['csv_file'] = '<span style="color:green">'.implode('<br>', $s).'</span>';
				}
			}
		}
	}
	return parse_popup($modul.'/csv_import');
}

/**
 * Contains functions that are used in administration of objects (like Products [products.php], Software [software.php])
 */


/**
 * Prints data or export it to file (depends on param $export)
 * @param int $export - tells where to export data (if empty - data shows in browser)
 * @return - string parse tamplate list_row (if not empty $export - another template is used)
 */

function object_print_list($export='')
{
	global $sql, $num_records, $object_id;
	global $html_fields, $ar_grid_links_getfield, $gallery_id;
	global $type, $field_preoutput_functions;

	include('print_list_init_vars_apply_filter.php');

	reset($fields);

	// get to know how many records we will have in query result after filtering
	$sql_tot = 'SELECT COUNT(*) FROM ('.$sql.') AS main_query';
	$tot = getField($sql_tot);

	include('print_list_limit_sql.php');

	if ($export === '_csv')
	{
		// если у нас поле типа image, то его експортировать или импортировать нельзя...
		// см. аттач к 9207
		foreach ($fields as $val)
		{
			if ($type[$val] == 'image')
			{
				$hidden[] = $val;
			}
		}
	}

	$rs = viewsql($sql, 0);

	$s = '';
	$j = 0;
	$rows = array();

	while ($r = db_sql_fetch_row($rs))
	{
		$row_field = array();

		$count = count($r);

		for($i = 0; $i < $count; $i++)
		{
			$field_name 		= $fields[$i];
			$grid_link		= $ar_grid_links[$fields[$i]];

			if (is_array($ar_grid_links_getfield) && array_key_exists($fields[$i], $ar_grid_links_getfield))
			{
				$grid_link_getfield = $ar_grid_links_getfield[$fields[$i]];
			}
			else
			{
				$grid_link_getfield = null;
			}

			$row_field[$i]['col_style'] 	= $grid_col_style[$field_name];
			$row_field[$i]['field_align'] 	= $align[$field_name];

			$preoutput_function = $field_preoutput_functions[$field_name];
			// Apply indicated functions for fields if they exist
			if (isset($preoutput_function))
			{
				$field_preoutput_function_name = $preoutput_function;
				$r[$i] = $field_preoutput_function_name($r[$i]);
			}

			$row_field[$i]['field_value'] = parse2(vsprintf($grid_link, $r));
		
			if (!empty($grid_link_getfield))
			{
				$row_field[$i]['field_value'] = GetField(parse2(vsprintf($grid_link_getfield, $r)));
			}

			if (
				!empty($html_fields) &&
				in_array($field_name, $html_fields)
			)
			{ 
				$row_field[$i]['field_value'] = ($export ? strip_tags($row_field[$i]['field_value']) : cut(strip_tags($row_field[$i]['field_value']), 100));
			}

			unset($field_name, $grid_link, $grid_link_getfield);
		}

		$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

		$rows[$j]['id'] 	= $r[0];
		$rows[$j]['name'] 	= SaveQuotes($r[1]);
		$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/' . $modul . '/list_row_field' . $export);

		foreach ($fields as $field_name)
		{
			$rows[$j][$field_name] = $r[array_search($field_name, $fields)];
		}

		$j++;
	}
	$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

	global $navigation;
	$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

	return $s;
}

function export_object_to_csv($export_sql = false, $csv_separator = false)
{
	global $object_id;
	global $html_fields, $ar_grid_links_getfield, $gallery_id;
	global $type;
	global $caption;
	global $modul;
	global $error;

	if (!$export_sql)
	{
		global $export_sql;
		//$export_sql = 'SELECT * FROM (' . create_sql_view($object_id, '', true) .') AS ou';
		$export_sql = create_sql_view($object_id, '', true);
	}

	if (!$csv_separator)
	{
		$csv_separator = EE_DEFAULT_CSV_SEPARATOR;
	}

	if ($_POST['refresh'])
	{
		if (isset($_POST['export_fields']))
		{
			setcookie($modul . '_export_fields', implode('+', $_POST['export_fields']), time()+366*24*60*60);
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.csv"' );

			$export_fields 	= $_POST['export_fields'];
		}
		else
		{
			$error['not_specified_export_field'] = 'Error : Please specified export field.';
			print parse_popup($modul . '/select_export_fields');
			return;
		}
       	
		$fields_name_cache_array = array();
		$ar_grid_links 	= array();
		$s 		= '';
		$geader 	= '';
		$except_array	= array();

		global $fields;

		include('print_list_init_vars_apply_filter.php');

		$export_sql = 'SELECT * FROM('.$export_sql.') AS v';

		$res = viewSQL($export_sql.$where.$order, 0);

		$j = 0;

		while($row = db_sql_fetch_row($res))
		{
			$row_field = array();
			                             	
			for ($i = 0; $i < count($row); $i++)
			{
				$field_name = (	isset($fields_name_cache_array[$field_name]) ? 
						$fields_name_cache_array[$field_name] : 
						$fields_name_cache_array[$field_name] = db_sql_field_name($res, $i));

				if (in_array($field_name, $export_fields))
				{
					if ($j == 0)
					{
						$header.= '"' . str_replace('&nbsp;', ' ', get_field_caption($field_name)) . '"' . $csv_separator;
					}

					if (!empty($ar_grid_links_getfield[$field_name]))
					{
						$field_value = GetField(parse2(vsprintf($ar_grid_links_getfield[$field_name], $row)));
					}
       					else
					{
						$field_value = parse2(vsprintf('%' . ($i+1) . '$s', $row));
					}
       	
					$field_value = str_replace('"', '""', ($field_value ? $field_value : ' '));

					$row_field[$i] = '"' . $field_value . '"';

				}
			}

			$s .= implode($csv_separator, $row_field) . $csv_separator . "\r\n";
			$j++;
       	
			if ($j%1000 == 0)
			{
				flush();
			}
		}

		print $header . "\r\n" . $s;
		return;
	}
	else
	{		
		print parse_popup($modul . '/select_export_fields');
		return;
	}
}      	

function get_object_export_field_list($export_sql)
{
	$s 	= '';
	$i	= 0;
	$array 	= array();

	$export_fields = db_sql_query_fields($export_sql);

	foreach($export_fields as $field_name)
	{
		$array[$i]['field_name'] 	= $field_name;
		$array[$i]['field_caption'] 	= get_field_caption($field_name);
		$i++;
	}

	$s .= parse_array_to_html($array, 'export_field_list_csv');

	return $s;
}

function get_field_caption($field_name)
{
	global $caption;

	return ($caption[$field_name] ? $caption[$field_name] : ucfirst(str_replace('_', ' ', $field_name)));
}

function create_sql_view_for_edit($object_id, $record_id = '')
{
	global $language, $stat_fields, $html_fields;

	if (!isset($stat_fields) || !is_array($stat_fields))
	{
		$stat_fields = array();
	}
	if (!isset($html_fields) || !is_array($html_fields))
	{
		$html_fields = array();
	}

	$obj_chache_file_name = md5($object_id).'_sql_view_for_edit';

	if(check_obj_cache($object_id, $obj_chache_file_name))
	{
		return get_obj_cache($object_id, $obj_chache_file_name).($record_id == '' ? '' : ' AND r.id = '.sqlValue($record_id));
	}
		$sql_langs = '

			SELECT language_code
			  FROM v_language
		      ORDER BY default_language DESC
		';

		$ar_languages = SQLField2Array(viewsql($sql_langs, 0));

	//инициализируем имена полей
	$sql_fields = '
         SELECT id, object_field_name, one_for_all_languages
           FROM object_field
          WHERE object_id='.sqlValue($object_id).'
        ';
	$sql_fields.= ' ORDER BY id';

	$rs = viewsql($sql_fields, 0);
	while($r = db_sql_fetch_assoc($rs))
	{
		$ar_field_names[$r["id"]] = array($r["object_field_name"], $r['one_for_all_languages']);
	}

	$ar_sql = array();
	$ar_sql[] = "\r\n".' SELECT '."\r\n".'        r.id AS \'record_id\'';

	//для каждого поля начиная выбираем из object_content то, что нам необходимо
	foreach($ar_field_names as $k=>$v)
	{
		foreach($ar_languages as $key_lang)
		{
			$field_name_for_sql = ($v[1]==0 && !in_array($v[0],$stat_fields) && !in_array($v[0],$html_fields) ? $key_lang.'__' : '' ).$v[0];
			$ar_sql[]= '        (SELECT value FROM object_content WHERE object_field_id = '.sqlValue($k).' AND language='.sqlValue($key_lang).' AND object_record_id=r.id) AS \''.$field_name_for_sql.'\'';

			// if field is one for all languages - default language is quite enough
			if ($v[1]==1 || in_array($v[0],$stat_fields) || in_array($v[0],$html_fields))
			{
				break;
			}
		}
	}
	
	$ar_sql[] = '        '.sqlValue($language).' AS language';

	$sql = (implode(','."\r\n", $ar_sql))."\r\n".
	'   FROM'."\r\n".
	'        object_record r'."\r\n".
	'   WHERE r.object_id='.sqlValue($object_id);

	cache_obj($object_id, $obj_chache_file_name, $sql);

	//возвращаем SQL запрос
	return $sql.($record_id == '' ? ' AND 1=0' : ' AND r.id = '.sqlValue($record_id));
}

/**
 * Save data while adding or editing it
 * @param int $object_id id of object
 * @return - parse tamplate edit
 */

function object_save($object_id, $obj_file_dir = false)
{
	global $modul, $modul_title;
	global $pageTitle, $PageName, $error;
	global $modul;
	global $fields;
	global $mandatory;
	global $edit;
	global $field_name, $num_fields, $sql_view, $language, $lang;
	global $caption, $readonly, $size, $type, $form_row_style, $form_row_type, $check_pattern;
	global $op, $enum_table, $enum_field;
	global $html_fields, $stat_fields, $non_stat_fields, $img_fields, $file_fields;


	global $object_name;

	global $lang_depend_fields;

	//array of languages
	$ar_lang = SQLField2Array(viewsql('Select language_code FROM v_language WHERE status=1', 0));

	$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

	if (post('refresh'))
	{
		clean_all_obj_cache();
	}

	//инициализируем повторно массив fields, поскольку он будет отличаться от массива в гриде
	$fields = array();
	$fields[] = 'record_id';
	
	$rs = viewsql('	SELECT
				object_field_name,
				one_for_all_languages
			FROM
				object_field
		 	WHERE
				object_id = '.SQLValue($object_id).'
			ORDER BY id
	', 0);
	//отличаться он будет тем, что языкозависящие поля будут переименованы в имя__язык и их кол-во будет увеличено пропорционально кол-ву языков
	while($r = db_sql_fetch_row($rs))
	{
		//если стат.поле - добавляем
		if (is_array($stat_fields) && in_array($r[0], $stat_fields))
		{
			$fields[]=$r[0];
		}
		//если языкозависящее - размножаем, модифицируем и добавляем
		elseif (is_array($non_stat_fields) && in_array($r[0], $non_stat_fields))
		{
			if ($r[1] == '0')
			{
				for($i=0; $i<count($ar_lang); $i++)
				{
					$fields[]=$ar_lang[$i].'__'.$r[0];
				}
				$lang_depend_fields[] = $r[0];
			}
			else
			{
				$fields[] = $r[0];
			}
		}
		elseif (is_array($html_fields) && in_array($r[0], $html_fields))
		{
			$fields[]=$r[0];
		}

		//если хтмл.поле - добавляем
		/*elseif (is_array($img_fields) && in_array($r[0], $img_fields))
		{
			$fields[]=$r[0];
		} */
		//если рисунок - добавляем
	}
	$obj_field_prefix = 'obj_fl_';

	if(check_obj_cache($object_id, $obj_field_prefix.'check_pattern'))
	{		
		$check_pattern 	= unserialize(get_obj_cache($object_id, $obj_field_prefix.'check_pattern'));
		$caption 	= unserialize(get_obj_cache($object_id, $obj_field_prefix.'caption'));
		$mandatory 	= unserialize(get_obj_cache($object_id, $obj_field_prefix.'mandatory'));
		$size 		= unserialize(get_obj_cache($object_id, $obj_field_prefix.'size'));
		$type 		= unserialize(get_obj_cache($object_id, $obj_field_prefix.'type'));
	}
	else
	{
		//перезапишем массив проверки шаблона для всех полей
		for ($i=0; $i<count($fields); $i++)
		{
			if (empty($check_pattern[$fields[$i]]))
			{
				$check_pattern[$fields[$i]] = array('^[^<]*$', 'Illegal characters in '.$fields[$i]);
			}
			//ограничиваем вводимые символы для object_unique_name т.к. поле используется для формирования линка на объект
			if ($fields[$i] == 'object_unique_name')
			{
				$check_pattern['object_unique_name'] = array('^[^<>%\,\. ]*$', 'Illegal characters in object_unique_name');
			}
			//заодно убираем из наз. подчёркивания и т.д.
			if (!isset($caption[$fields[$i]]))
			{
				$caption[$fields[$i]] = case_title(str_replace('_', '&nbsp;', str_replace(ltrim($modul,'_').'_', '', $fields[$i])));
			}
			//перезаписуем массив проверки шаблона, проверки на обяз. заполн., тип и размер для языкозависящих полей
			if (!empty($non_stat_fields) && array_key_exists($i,$ar_lang))
			{
				foreach ($non_stat_fields as $k=>$v)
				{
					if (!empty($check_pattern[$v]))
					{
						$check_pattern[$ar_lang[$i].'__'.$v]=$check_pattern[$v];
					}

					if (in_array($v,$mandatory))
					{
						$mandatory[] = $ar_lang[$i].'__'.$v;
					}

					$size[$ar_lang[$i].'__'.$v]=$size[$v];
					$type[$ar_lang[$i].'__'.$v]=$type[$v];
				}
			}
			// save cache
			cache_obj($object_id, $obj_field_prefix.'check_pattern', serialize($check_pattern));
			cache_obj($object_id, $obj_field_prefix.'caption', serialize($caption));
			cache_obj($object_id, $obj_field_prefix.'mandatory', serialize($mandatory));
			cache_obj($object_id, $obj_field_prefix.'size', serialize($size));
			cache_obj($object_id, $obj_field_prefix.'type', serialize($type));
		}
	}

	$sql = create_sql_view_for_edit($object_id,$edit);

	include ('save_init.php');

	if (post('refresh') OR post('upload') OR post('delete_img') OR post('delete_file'))
	{
		//если удаление - удаляем файл и инфу из field_values
		if (post('delete_img') || post('delete_file'))
		{
			
			$file = $_POST['delete_img'] != '' ? $_POST['delete_img'] : $_POST['delete_file'];
			$field_values[$file]='';

			$__file_name 	= $$file;
			$__lang		= get_language_by_field_name($file);

			$__limit_file_name 	= build_object_file_dir($object_name, $edit, $__lang, true) . $__file_name;
			$__general_file_name	= build_object_file_dir($object_name, $edit, $__lang) . $__file_name;

			if (file_exists(EE_PATH . $__limit_file_name))
			{
				$__file_name = $__limit_file_name;
			}
			else if (file_exists(EE_PATH . $__general_file_name))
			{
				$__file_name = $__general_file_name;
			}

			deleteFile($__file_name);
		}

		//понадобится позже для того, чтобы record_id для разных языков были одинаковые
		$res = 0;
		//трансформируем массив field_values в другой, отличный по структуре (елементами массива будут массивы с ключами "язык")
		foreach ($field_values as $k=>$v)
		{
			if (!is_null($v))
			{
				foreach ($ar_lang as $kl=>$vl)
				{
					if (substr($k,0,2) == $vl)
					{
						$field_val[$vl][substr($k,4)] = $field_values[$k];
					}
					elseif (in_array($k,$stat_fields))
					{
						$field_val[$vl][$k] = $field_values[$k];
					}
				}
			}
		}

		//каждый массив с ключем "язык" преобразуем в массив field_values
		foreach ($field_val as $key=>$val)
		{
			$field_values=$val;
			$field_values['language']=$key;


			if (!isset($img_fields) || !is_array($img_fields))
			{
				$img_fields = array();
			}
			if (!isset($file_fields) || !is_array($file_fields))
			{
				$file_fields = array();
			}
			//если есть рисунки
			foreach ($img_fields as $k=>$v)
			{
				$image_field = (in_array($v, $lang_depend_fields) ? $key.'__' : '').$v;
				//если файл не загружен - одно поле для всех языков
				if ($_FILES[$image_field]['name'] != '') //если файл загружен
				{
					//убираем ошибку
					unset($error[$image_field]);
					//имя файла
					$name = $modul_title.'_'.$key.'_'.$field_values['record_id'].'_'.$v;
					//аплоад, при успехе возвращает имя файла, при ошибке - массив с еррорами
					$rez = upload_object_image($image_field,null,$name);
					//если массив - значит ошибка загрузки, её выводим
					if (is_array($rez))
					{
						$error[$image_field] = $rez[0];
					}
					//иначе - имя файла заносим в наш массив
					else
					{
						$field_values[$v] = $rez;
					}
				}
			}
			//если есть файлы
			foreach ($file_fields as $k=>$v)
			{
				$file_field = (in_array($v, $lang_depend_fields) ? $key.'__' : '').$v;
				//если файл не загружен - одно поле для всех языков
				if ($_FILES[$file_field]['name'] != '') //если файл загружен
				{
					//убираем ошибку
					unset($error[$file_field]);
					//имя файла
					$name = $modul_title.'_'.$key.'_'.$field_values['record_id'].'_'.$v;
					//аплоад, при успехе возвращает имя файла, при ошибке - массив с еррорами
					$rez = upload_object_file($file_field, null, $name);
					//если массив - значит ошибка загрузки, её выводим
					if (is_array($rez))
					{
						$error[$file_field] = $rez[0];
					}
					//иначе - имя файла заносим в наш массив
					else
					{
						$field_values[$v] = $rez;
					}
				}
			}

			//если ошибок нет
			if (count($error)==0)
			{
				//ДОБАВЛЕНИЕ НОВОЙ ЗАПИСИ
				if (empty($edit)) // New object
				{
					//присваиваем record_id (если первое добавление - 0, если посл. - значение записи)
					$field_values['record_id'] = $res;
					//хтмл поля обнуляем, т.к. данн?е заносятся в табл. напрямую при сохранении в FCKEditor'e
					if (!empty($html_fields))
					{
						foreach ($html_fields as $k=>$v)
						{
							$field_values[$v] = null;
						}
					}
					// При добавлении вылавнюем поля типа "DATE" в обьектах и приводим их в метку времени UNIX
					foreach($field_values as $f_name=>$f_val)
					{						
						$field_type = getfield('SELECT object_field_type
						FROM object_field
						WHERE
							object_field_name='.sqlvalue($f_name).'
							AND
							object_id='.sqlvalue($object_id));


						if ($field_type == 'DATE')
						{
							$field_values[$f_name] = convert_objecttime_to_unixtimelabel($field_values[$f_name]);
						}
					}

					//и запускаем функцию добавления
					$res = f_add_object_modul($field_values, $object_id, $field_val);

					if($res > 0) 
					{
						global $record_id, $op, $edit;
						$record_id = $edit = $res;
						$op = 1; 	
					}					
				}
				//РЕДАКТИРОВАНИЕ СУЩЕСТВУЮЩЕЦ ЗАПИСИ
				else
				{
					// При добавлении вылавнюем поля типа "DATE" в обьектах и приводим их в метку времени UNIX
					//хтмл поля обнуляем, т.к. данн?е заносятся в табл. напрямую при сохранении в FCKEditor'e
					if (!empty($html_fields))
					{
						foreach ($html_fields as $k=>$v)
						{
							unset($field_values[$v]);
						}
					}
					foreach($field_values as $f_name=>$f_val)
					{
						if(check_obj_cache($object_id, $obj_field_prefix.$f_name.'_edit_transform'))
						{
							$field_type = get_obj_cache($object_id, $obj_field_prefix.$f_name.'_edit_transform');
						}
						else
						{
							$field_type = getfield('SELECT
											object_field_type
										FROM
											object_field
										WHERE
											object_field_name='.sqlvalue($f_name).'
										AND
											object_id='.sqlvalue($object_id));

							cache_obj($object_id, $obj_field_prefix.$f_name.'_edit_transform', $field_type);
						}

						if ($field_type == 'DATE')
						{
							$field_values[$f_name] = convert_objecttime_to_unixtimelabel($field_values[$f_name]);
						}

					}
					$field_values['record_id'] = $edit;
					//если редактирование - запускаем функцию апдейта    
					$res = f_upd_object_modul($field_values, $object_id, $field_val);

				}
			}
			if(strstr(EE_HTTP_REFERER, 'op=3') !== false)
			{
				clean_all_obj_cache();
			}
		}


		if (count($error)==0)
		{
			//Событие возникает при добавлении еще одной записи
			if (post('save_add_more'))
			{
				header ('Location: '.$modul.'.php?op=3&added='.$res);
				exit;
			}
			//Событие возникает при сохранения и последующего редактирования записи или подгрузке
			else if (post('upload') || post('save_continue'))
			{
				$str = 'Location: '.$modul.'.php?op=1&admin_template=yes&edit='.(!empty($edit)?$edit:$res);

				//Если нажата кнопка "Save and Edit" нужно передать id добавленной записи для обновления списка в случае нажатия кнопки "Cancel" после этого
				if (post('save_continue'))
				{
					$str.= '&added='.$res;
				}

				header($str);
				exit;
			}

			else if (post('delete_img') || post('delete_file'))
			{
				header ('Location: '.$modul.'.php?op=1&admin_template=yes&edit='.$edit);
				exit;
			}
			else
			{
				close_popup('yes');
			}
		}
	}
	set_mark('OBJECT_PREPARING');
	return parse_popup($modul.'/edit_popup');
}

/**
*  This function save an object (gallery image).
*  Input: $obj_name - object name (example: gallery_image_new)
*  All field_values of this object.
**/
function gallery_image_object_save($obj_record_id, $obj_image_filename, $obj_image_title, $obj_image_description, $obj_is_gallery_image, $obj_gallery_id, $obj_load_image, $item_order)
{
	$field_values['record_id'] = $obj_record_id;
	$field_values['image_filename'] = $obj_image_filename;
	$field_values['image_title'] = $obj_image_title;
	$field_values['image_description'] = $obj_image_description;
	$field_values['is_gallery_image'] = $obj_is_gallery_image;
	$field_values['gallery_id'] = $obj_gallery_id;
	$field_values['load_image'] = $obj_load_image;
	$field_values['item_order'] = $item_order;

	$object_id = (int)GetField('SELECT id FROM object WHERE name=\'gallery_image\'');

	//Инициализируем массив полей, не зависящих от языка
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE (object_field_type in (\'id\', \'foreign_key\', \'date\') OR (one_for_all_languages = 1)) AND object_id='.sqlValue($object_id), 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$stat_fields[] = $r["object_field_name"];
	}
	$stat_fields[] = 'record_id';

	//Инициализируем массив HTML полей
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type=\'html\' AND object_id='.sqlValue($object_id), 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$html_fields[] = $r["object_field_name"];
	}

	//Инициализируем массив INMAGE полей
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type=\'image\' AND object_id='.sqlValue($object_id), 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$img_fields[] = $r["object_field_name"];
	}

	//Инициализируем массив полей, зависящих от языка, но не рисунок и не html
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_field_type not in (\'id\', \'foreign_key\', \'date\', \'html\') AND object_id='.sqlValue($object_id).' order by id', 0);
	while ($r = db_sql_fetch_assoc($rs))
	{
		$non_stat_fields[] = $r["object_field_name"];
	}

//инициализируем массив fields по вьюхе
	$sql = 'SELECT * FROM ('.create_sql_view($object_id).') v ';
	$fields = db_sql_query_fields($sql);
//если данных нет - инициализируем по табл. object_field
	if (empty($fields))
	{
		$fields = array();
		$fields[] = 'record_id';
		$rs = viewsql('SELECT id, object_field_name FROM object_field WHERE object_id='.sqlValue($object_id).' order by id', 0);
		while ($r = db_sql_fetch_assoc($rs))
		{
			$fields[$r["id"]]=$r["object_field_name"];
		}

		$fields = renumber_array($fields);
	}

	$sql_view = create_sql_view($object_id);
	//array of languages
	$ar_lang = SQLField2Array(viewsql('Select language_code FROM v_language WHERE status=1', 0));

	//инициализируем повторно массив fields, поскольку он будет отличаться от массива в гриде
	$fields = array();
	$fields[] = 'record_id';
	$rs = viewsql('SELECT object_field_name FROM object_field WHERE object_id='.SQLValue($object_id).' order by id', 0);
	//отличаться он будет тем, что языкозависящие поля будут переименованы в имя__язык и их кол-во будет увеличено пропорционально кол-ву языков

	while ($r = db_sql_fetch_row($rs))
	{
		//если стат.поле - добавляем
		if (in_array($r[0],$stat_fields))
		{
			$fields[]=$r[0];
		}
		//если языкозависящее - размножаем, модифицируем и добавляем
		else if (in_array($r[0],$non_stat_fields))
		{
			for($i=0; $i<count($ar_lang); $i++)
			{
				$fields[]=$ar_lang[$i].'__'.$r[0];
			}
		}
		else if (in_array($r[0],$html_fields))
		{
			$fields[]=$r[0];
		}
		//если хтмл.поле - добавляем
		else if (in_array($r[0],$image_fields))
		{
			$fields[]=$r[0];
		}
		//если рисунок - добавляем
	}

	//трансформируем массив field_values в другой, отличный по структуре (елементами массива будут массивы с ключами "язык")
	foreach ($field_values as $k=>$v)
	{
		foreach ($ar_lang as $kl=>$vl)
		{
			//if (substr($k,0,2) == $vl) $field_val[$vl][substr($k,4)] = $field_values[$k];
			//elseif (in_array($k,$stat_fields)) $field_val[$vl][$k] = $field_values[$k];
			$field_val[$vl][$k] = $field_values[$k];
		}
	}

	//каждый массив с ключем "язык" преобразуем в массив field_values
	foreach ($field_val as $key=>$val)
	{
		$field_values=$val;
		$field_values['language']=$key;
		$field_values['record_id'] = $res;

		// При добавлении вылавнюем поля типа "DATE" в обьектах и приводим их в метку времени UNIX
		foreach($field_values as $f_name=>$f_val)
		{
			$field_type = getfield('
                          SELECT object_field_type
                            FROM object_field
                           WHERE object_field_name='.sqlvalue($f_name).'
                             AND object_id='.sqlvalue($object_id)
			);

			if ($field_type == 'DATE')
			{
				$field_values[$f_name] = convert_objecttime_to_unixtimelabel($field_values[$f_name]);
			}
		}

		//и запускаем функцию добавления
		$new_fields_values = array('image_filename' 	=> $field_values['image_filename']);

		if (object_record_exists(0, $new_fields_values, $object_id, false, $field_values['language']))
		{
			global $error;
			unset($error['record_id']);

			$record_id = get_object_record_id($object_id, 'image_filename', $field_values['image_filename']);

			$field_values['record_id'] = $record_id;

			unset($field_values['image_filename']);
			unset($field_values['item_order']);

			$res = f_upd_object_modul($field_values, $object_id);

			$res = $record_id;
		}
		else
		{
			$res = f_add_object_modul($field_values, $object_id);
		}
	}

	return $res;
}

/**
* Call to function f_del_object_modul, whitch delete some record
*/
function object_del()
{
	global $del, $modul, $url;

	RunNonSQLFunction('f_del_object_modul', array($del));

	header($url);
}
/**
 * Creates input of type "select". Is used in admin panel (Add or Edit some object).
 * @param string $object name of object, for whitch select is making
 * @param string $filter used to make such select form in admin panel to filter records by some field.
 * @return string html code to create input of type select
 */
function create_object_selector($object, $filter='')
{
	global $object_name, $field_name;

	$filter_field_name = 'filter_'.$field_name;

	global $$filter_field_name;

	$s='<select name="'.$filter.$field_name.'">';
	$rs=viewsql($sql_select=create_sql_view((int)GetField('SELECT id FROM object WHERE name='.sqlValue($object))),0);
	if ($filter!='') $s.='<option value="">All</option>';
	while ($r = db_sql_fetch_row($rs))
	{
		if ($$filter_field_name==$r[0]) $s.='<option value="'.$r[0].'" selected>'.$r[1].'</option>';
		else $s.='<option value="'.$r[0].'">'.$r[1].'</option>';
	}
	$s.='</select>';
	return $s;
}

function sort_object_edit_fields_by_order_array($fields, $edit_popup_order)
{
	$fields_sorted = array();
	foreach($edit_popup_order as $v)
	{
		foreach($fields as $k2=>$v2)
		{
			if($v == $v2
				|| (strpos($v2, '__'.$v)==2 && strlen($v)+4==strlen($v2) )
			)
			{
				$fields_sorted[] = $v2;
				unset($fields[$k2]);
			}
		}
	}
        
	foreach($fields as $v)
	{
		$fields_sorted[] = $v;
	}

	$fields = $fields_sorted;
	unset($fields_sorted);				
	
	return $fields;
}

function get_object_file_dir($objectName, $recordId, $language = false, $isProtected = false)
{
	$dir = false;

	$base_dir = get_base_dir_for_object_file($isProtected);
	
	if (	ftp_touch_dir($base_dir) &&
		ftp_touch_dir($base_dir . $objectName . '/') &&			
		ftp_touch_dir($base_dir . $objectName . '/' . $recordId . '/')
		)
	{

		
		if ($language && ftp_touch_dir($base_dir . $objectName . '/' . $recordId . '/' . $language . '/'))
		{
			$dir = $base_dir . $objectName . '/' . $recordId . '/' . $language . '/';
		}
		else
		{
			$dir = $base_dir . $objectName . '/' . $recordId . '/';
		}
	}

	return $dir;
}

function build_object_file_dir($objectName, $recordId, $language = false, $isProtected = false)
{
	$base_dir = get_base_dir_for_object_file($isProtected);

	$dir = $base_dir . $objectName . '/' . $recordId . '/' . ($language ? $language . '/' : '');

	return $dir;
}

function get_base_dir_for_object_file($isProtected)
{
	if ($isProtected)
	{
		$base_dir = EE_OBJ_FILES_LIMIT_PATH;
	}
	else
	{
		$base_dir = EE_OBJ_FILES_PATH;
	}

	return $base_dir;
}

function get_language_by_field_name($field_name)
{
	global $langEncode;

	$lang = false;

	$__lang = substr($field_name, 0, 2);

	if (array_key_exists($__lang, $langEncode) && strpos($field_name, '__') == 2)
	{
		$lang = $__lang;
	}

	return $lang;
}

function get_object_yui_list($modul)
{
	global $sql, $num_records, $object_id, $image_preview_field;
	global $html_fields, $ar_grid_links_getfield, $gallery_id;
	global $type, $field_preoutput_functions, $ar_grid_links, $sort_function;

	include('print_list_init_vars_apply_filter.php');

	for($i=0; $i<count($fields); $i++)
	{
		$filter_field = 'filter_'.$fields[$i];
		if (array_key_exists($filter_field,$_GET))
		{
			$fields_for_sql[] = $fields[$i];
		}
	}
	$sortBy = (isset($_GET['sort']) ? $_GET['sort'] : 'record_id');
	$sortDir = (isset($_GET['dir']) ? $_GET['dir'] : 'ASC');
	$startIndex = (isset($_GET['startIndex']) ? $_GET['startIndex'] : 0);
	$rowsPerPage = (isset($_GET['results']) ? $_GET['results'] : 25);
	// get to know how many records we will have in query result after filtering
	$tot = getsql('count(*) from ('.$sql.') main');
	$sql .= ' ORDER BY '.sprintf($sort_function[$sortBy], '`'.$sortBy.'`').' '.$sortDir.' LIMIT '.$startIndex.','.$rowsPerPage;

	$rs = viewsql($sql, 0);
	$j=0;
	$cell = array();
	while ($rows = db_sql_fetch_assoc($rs))
	{
		$cells = array();
		for($i=0; $i<count($rows); $i++)
		{
			if (in_array($fields[$i],$hidden))
			{
				continue;
			}
			$field_name = $fields[$i];
			$preoutput_function = $field_preoutput_functions[$field_name];
			// Apply indicated functions for fields if they exist
			if (isset($preoutput_function))
			{
				$field_preoutput_function_name = $preoutput_function;
				$rows[$i] = $field_preoutput_function_name($rows[$i]);
			}
			$grid_link		= $ar_grid_links[$fields[$i]];
			$grid_link_getfield	= $ar_grid_links_getfield[$fields[$i]];
			if (!empty($grid_link_getfield))
			{
				$field_value = GetField(parse2(vsprintf($grid_link_getfield, $rows)));
			}
			else
			{
				$field_value = parse2(vsprintf($grid_link, $rows));
			}
			if (!empty($html_fields) && in_array($field_name, $html_fields))
			{
				$field_value = cut(strip_tags($field_value), 100);
			}
			$cell_array[$j][$field_name] = $field_value;
			unset($field_name, $grid_link, $grid_link_getfield, $field_value);
		}
		if ($modul == '_gallery_image' && !file_exists(EE_PATH.EE_IMG_PATH.'gallery/'.$rows['gallery_id'].'/'.$rows['image_filename']))
		{
			$cell_array[$j]['image_preview'] = 0;
		}
		if ($modul == '_formbuilder' && getField('SELECT COUNT(*) FROM('.create_sql_view_by_name_for_fields_filter_by_fields('form_id', array('form_id'=>$rows['record_id']), 'form_mails', 0, $GLOBALS['default_language']).') AS forms') == 0)
		{
			$cell_array[$j]['export_form'] = 0;
		}
		if (isset($image_preview_field) && $image_preview_field != '')
		{
			$image = EE_IMG_PATH.$rows[$image_preview_field];
			if (fileexists(EE_PATH.$image))
			{
				$cell_array[$j]['image_preview'] = EE_HTTP.$image;
			}
			else
			{
				$cell_array[$j]['image_preview'] = 0;
			}
		}
		// For Delete and Edit operations in Gallery Manager should be used 'record_id' but not 'gallery_id' (task 11686)
		//$cell_array[$j++]['hidden_id'] = ($modul == '_gallery' ? $rows['gallery_id'] : $rows['record_id']);
		$cell_array[$j++]['hidden_id'] =  $rows['record_id'];

	}
	$pages_return['recordsReturned'] = count($cell_array);
	$pages_return['totalRecords'] = (int)$tot;
	$pages_return['startIndex'] = (int)$startIndex;
	$pages_return['sort'] = $sortBy;
	$pages_return['dir'] = $sortDir;
	$pages_return['pageSize'] = (int)$rowsPerPage;
	$pages_return['records'] = $cell_array;
	return json_encode($pages_return);
}

function object_del_rows()
{
	global $modul;
	$del = $_GET['del'];
	$del_array = explode('|',$del);
	$del_items = ((is_array($del_array) && count($del_array) > 0) ? $del_array : array($del));
	f_del_object_records($del_items);
}

?>