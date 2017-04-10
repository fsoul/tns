<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
	$modul_title = 'Website Object views metatags';

//********************************************************************
	include_once('../lib.php');
	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_OBJECT_SEO')) define('ADMIN_MENU_ITEM_OBJECT_SEO', 'Content/SEO/SEO Object');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_OBJECT_SEO);

	// list of meta tags that cannot be deleted
	$ar_meta_fixed = array('id', 'object_name', 'object_unique_name', 'file_name', 'language', 'title', 'keywords', 'description', 'commentary');

	// list of main meta tags
	$ar_meta_main_fields = array('id', 'object_name', 'object_unique_name', 'file_name', 'language');

	// list of existing meta tags to check default values
	$ar_meta_default = array();

	$rs = ViewSQL('
			SELECT meta_tags FROM
			(
                                SELECT \'commentary\'  as meta_tags
                                UNION
                                SELECT \'title\'
                                UNION
                                SELECT \'keywords\'
                                UNION
                                SELECT \'description\'

                                UNION

                                SELECT DISTINCT REPLACE(var,\'obj_meta_\',\'\')
                                  FROM content
                                 WHERE var REGEXP \'^obj_meta_\'
                                   AND var <> \'obj_meta_\'
			) mt
			ORDER BY meta_tags ASC

        	', 0);
	while ($row = db_sql_fetch_row($rs))
	{
		$ar_meta_default[] = $row[0];
	}

	// проверка наличия информации в контенте
	foreach ($ar_meta_default as $key=>$value)
	{
		$sql = "SELECT language_code FROM v_language";
		$res = ViewSQL($sql,0);
		while (list($r_lang) = db_sql_fetch_row($res))
		{
			if (!db_sql_num_rows(ViewSQL("SELECT * FROM content WHERE var='default_obj_meta_".$value."' AND language='".$r_lang."'",0)))
			{
				RunSQL("INSERT INTO content(var,val,page_id,language) VALUES ('default_obj_meta_".$value."','',0,'".$r_lang."')",0);
			}
			if (!db_sql_num_rows(ViewSQL("SELECT * FROM content WHERE var='obj_meta_".$value."' AND language='".$r_lang."'",0)))
			{
				RunSQL("INSERT INTO content(var,val,page_id,language) VALUES ('obj_meta_".$value."','',0,'".$r_lang."')",0);
			}
		}
	}

	$sql = sql_get_all_obj_meta();

	$ar_meta = SQLField2Array(viewsql($sql, 0));
	// apply sorting for grid
	$ar_meta = sort_seo_grid_fields_by_users_wish($ar_meta, 'obj_meta_');

	$meta_sql = '
			CASE ( SELECT count(c.'.val_field_name().')
				 FROM content c
				WHERE page_id = m.id
				  AND var=\'%s\'
				  AND (
					var_id=m.template_id
					OR
					var_id=\'0\'
					)
				  AND language = v_language.language_code
				  AND '.val_field_name().' <>\'\'
				  AND '.val_field_name().' IS NOT NULL
				  LIMIT 0, 1
			)
			WHEN 0 THEN (	SELECT '.val_field_name().'
					  FROM content c
					 WHERE c.page_id=0
					   AND c.var = \'default_%s\'
				   AND language=v_language.language_code
				)
			ELSE (	SELECT '.val_field_name().'
				  FROM content c
				 WHERE page_id = m.id
				   AND var = \'%s\'
				   AND (
						var_id=m.template_id
						OR
						var_id=\'0\'
					)
				   AND language = v_language.language_code
				ORDER BY var_id DESC
				LIMIT 0, 1
			)
			END
				 AS \'%s\'
			';

	for ($i=0; $i<count($ar_meta); $i++)
	{
		$ar_sql[] = sprintf($meta_sql, $ar_meta[$i], $ar_meta[$i], $ar_meta[$i], str_replace('obj_meta_', '', $ar_meta[$i]));
	}

	$sql_general = implode (','."\n", $ar_sql);
	// url mapping fields start
	$tpl_views_sql = 'SELECT id, view_name FROM tpl_views';

	$tpl_views_res = viewSQL($tpl_views_sql);

	if (db_sql_num_rows($tpl_views_res) > 0)
	{
		while ($row = db_sql_fetch_assoc($tpl_views_res))
		{
			$ar_tpl_views[] = array('id' 		=> $row['id'],
						'view_name' 	=> $row['view_name']);
		}
	}
	if (!is_array($ar_tpl_views) || count($ar_tpl_views) == 0)
	{
		$ar_tpl_views[] = array('id' => 'NULL', 'view_name' => 'default');
	}
	                                       
	$map_url_sql = '(	SELECT 
					target_url
				FROM 
					url_mapping_object um_obj 
				WHERE 
					um_obj.language = v_language.language_code 
					AND
					um_obj.tpl_view %s
					AND
					um_obj.object_record_id = m.id
					AND
					um_obj.object_view = m.template_id
			) AS map_url_%s';

	for ($i=0; $i < count($ar_tpl_views); $i++)
	{
		$ar_url_map_sql[] = sprintf($map_url_sql, ($ar_tpl_views[$i]['id'] == 'NULL' ? 'IS NULL' : '= '.$ar_tpl_views[$i]['id']), $ar_tpl_views[$i]['view_name']);
		$url_map_fields[] = 'map_url_'.$ar_tpl_views[$i]['view_name'];
	}

	$url_map_sql = implode(','."\r\n", $ar_url_map_sql);
	// url mapping fields end

	$sql_general = 'SELECT *
			FROM (
				SELECT	m.id AS id,
					v_object.name AS object_name,
					(
						SELECT value
						  FROM object_content oc
						  JOIN object_record orr
						    ON oc.object_record_id = orr.id
						  JOIN object_field of
						    ON of.id = oc.object_field_id
						 WHERE of.object_field_name = \'object_unique_name\'
						   AND	orr.object_id = (
									 	SELECT id
										  FROM object
										 WHERE name = v_object.name
									)
						   AND language = v_language.language_code
						   AND oc.object_record_id = m.id
					) as object_unique_name,
					tpl_files.file_name,
					v_language.language_code as language,
					'.$sql_general.','.$url_map_sql.'
				 FROM (
					(
						SELECT 	v_object_template.object_id,
							v_object_template.template_id,
                	        			v_object_record.id
	  					  FROM v_object_template
					     LEFT JOIN v_object_record
						    ON v_object_record.object_id = v_object_template.object_id
					      ORDER BY v_object_template.object_id) AS m, v_language
					)
			   INNER JOIN v_object
				   ON v_object.id = m.object_id
			   INNER JOIN tpl_files
		        	   ON tpl_files.id = m.template_id
			    ) AS main';

	$sql = sprintf($sql_general);

	//For export need to use not "language_name" but "language_code"
	$sql_for_export = sprintf($sql_general);

	//Popup window settings
	$popup_scroll = 1;
	$popup_height = 700;
	// apply sorting for caption
	$ar_meta_default = sort_seo_grid_fields_by_users_wish($ar_meta_default);
	// Главный список полей по нему работают все функции
	$fields = array_merge($ar_meta_main_fields, $ar_meta_default, $url_map_fields);	

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	if ($op == 'export_excel')
	{
		$page_name_grid_link = $custom_fields_type = '%s';
	}
	else
	{
		$custom_fields_type = '
			<input	style="color:#000;"
				<%%iif:<%%is_seo_draft:%4$s,%3$s,%2$s,true%%>,1,class="seoInDraft",%%>
				type="text"
				value="%6$s"
				onFocus="editSEO(this, \'%2$s\', \'%3$s\', \'%4$s\', \'%5$s\');"
				<%%iif:1,0,%6$s%%>
				<%%iif:<%%config_var:max_chars_%2$s%%>,,,maxlength="<%%config_var:max_chars_%2$s%%>"%%>
			>';
		$page_name_grid_link = '<a href="'.EE_HTTP.'index.php?language=%3$s&t=%4$s&admin_template=yes">%6$s</a>';
	}


	foreach ($ar_grid_links as $k=>$v)
	{
		$ar_grid_links[$k] = $custom_fields_type;
	}

 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	$size_filter['language'] = 7;
	$hidden = array('language_code');
	

	// выравнивание
	$align['id']='right';

	// оформление самого значения в гриде
	$ar_grid_links['object_unique_name'] = $ar_grid_links['id'] =$ar_grid_links['language'] = $ar_grid_links['object_name'] = $ar_grid_links['file_name'] = $ar_grid_links['language_code'] = '%s';
	$ar_grid_links['page_name'] = $page_name_grid_link;

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if (!isset($op))
	{
		$srt = 2;
	}

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions($export = '')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list($export = '')
	{
		global $sql, $meta_sql, $page_name_alias;

		include('print_list_init_vars.php');

		// проходимся по всем полям грида
		$fields_count = count($fields);

		for($i = 0; $i < $fields_count; $i++)
		{
			$filter_field = 'filter_'.$fields[$i];
			global $$filter_field;
			// если соотве-я глоб-я пер-я фильтра не пуста
			if (($val = trim($$filter_field)) != '')
			{
				// куки
				$ar_usl[] = $filter_field.'='.$val;
				// условие where для запроса
				if (strpos($fields[$i], 'date')!==false)
				{
					$next_field_name = 'DATE_FORMAT('.$fields[$i].', \'%d/%m/%y %h:%i\')';
				}
				else
				{
					$next_field_name = $fields[$i];
				}

				if ($next_field_name == 'id')
				{
					$ar_where[] = 'id='.sqlValue($val);
				}
				else
				{
					$ar_where[] = $next_field_name.' like '.sqlValue('%'.$val.'%');
				}
			}
		}

		$where = implode(' and ', $ar_where);

		$usl = implode('&', $ar_usl);
		// сохраняем в куки
		store_values($usl, $modul);

		// добавляем условие where до запроса
		$sql.= $where.$order;

		$tot = db_sql_num_rows(viewsql($sql, 0));

		include('print_list_limit_sql.php');

		$rs = ViewSQL($sql, 0);


        	$s = '';
		$j=0;
		$rows = array();
		while($r = db_sql_fetch_row($rs))
		{
			$obj_view = $r[3];
			list($lang_code) = db_sql_fetch_row(ViewSQL("SELECT language_code FROM v_language WHERE language_code='".$r[4]."'",0));
			$row_field = array();
			$row_count = count($r);

			for($i = 0; $i<$row_count; $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$ret = htmlspecialchars($r[$i],ENT_QUOTES);
				$ret = str_replace("&amp;","&",$ret);
				
				$array = array(
				        'value'		=> $ret,
					'fieldname' 	=> $fields[$i],
					'lang_code'	=> $lang_code,
					'record_id'	=> $r[0],
					'tpl'		=> $r[3],
					'ent_value'	=> htmlentities($r[$i], ENT_QUOTES, 'UTF-8'),
				);

				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $array));
				unset($array);
			}
			$row_field = remove_by_keys($row_field, $hidden);
			
			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field' . $export);
			$rows[$j]['id'] = $r[0];
			$rows[$j]['row_language'] = $lang_code;
			$rows[$j]['view'] = SaveQuotes($r[3]);
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row');

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}


	include ('rows_on_page.php');

	function export_to_csv()
	{
		global $sql_for_export, $modul;

		if(get('close_popup') == '')
		{
			$s = '<script type="text/javascript">
					// reload
					window.parent.location.href = window.location.href + "&close_popup=1";
					// suicide
					window.parent.closePopup();
				</script>
				';
		}
		else
		{
			header( 'Content-Type: application/csv' );
			header( 'Content-Disposition: attachment; filename="meta_tags.csv"' );

			// write names of fields
			$r = db_sql_fetch_assoc($rs = viewsql($sql_for_export, 0));

			$r = remove_by_keys($r,  $hidden, 0);

			$_r = array_keys($r);

			for ($i = 0; $i < count($_r); $i++)
			{
				$_r[$i] = '"'.$_r[$i].'"';
			}

			$s = implode(EE_DEFAULT_CSV_SEPARATOR, $_r)."\r\n";

			do	// write values of fields
			{
				$r = remove_by_keys($r,  $hidden, 0);
				foreach ($r as $k=>$v)
				{
					$r[$k] = (!empty($v) ? '"'.str_replace('"', '&#34;', trim($v)).'"' : '');
				}

				$s.= implode(EE_DEFAULT_CSV_SEPARATOR, $r)."\r\n";

			} while ($r = db_sql_fetch_assoc($rs));
		}
		return $s;
	}

	function import_from_csv()
	{
		global $modul, $error, $fields;
		ini_set('max_execution_time','900');

		if (post('refresh') && count($_FILES['csv_file']))
		{
			$csv_file_name = ($_FILES['csv_file']['tmp_name']);
			$csv_file_ext = strtolower(substr($_FILES['csv_file']['name'], -4));
			if (	$csv_file_ext == '.csv' &&
				is_file($csv_file_name) &&
				file_exists($csv_file_name)	)
			{
				setlocale(LC_ALL, 'ru_RU');
				$fp = fopen($csv_file_name, 'r');

				while(($data = fgetcsv($fp, 4024, EE_DEFAULT_CSV_SEPARATOR)) !==  false)
				{
					if($ar_field_names == '')
					{
						$ar_field_names = $data;
					}
					else
					{
						$ar_rows[] = $data;
					}
				}
				fclose($fp);

				if (!is_array($hidden))
				{
					$hidden = array();
				}

				$ar_model = array_values(array_unique(array_diff($fields, $hidden)));

				for ($i=0; $i<count($ar_model); $i++)
				{
					if (strtolower($ar_field_names[$i]) != strtolower($ar_model[$i]))
					{
						$error['csv_file'] = 'Required field \''.$ar_model[$i].'\' is absent or wrong fields order';
						break;
					}
				}
				if (count($error)==0)
				{

					$upd = 0;
					$not_upd_map_url = 0;
					$not_upd_map_url_array = array();

					for ($i=0; $i<count($ar_rows); $i++)
					{
						$ar_field_values = $ar_rows[$i];
						$_fields_count = count($ar_field_values);

						for ($j = 5; $j<$_fields_count; $j++)
						{
							$id 		= $ar_field_values[0];
							$field_name	= $ar_field_names[$j];
							$object_view	= $ar_field_values[3];
							$object_tpl_id 	= getField('SELECT id FROM tpl_files WHERE file_name='.sqlValue($object_view));
							$language 	= $ar_field_values[4];
							$value		= trim($ar_field_values[$j],' "');

							if($ar_field_values[$j] == EE_DEFAULT_CSV_SEPARATOR)
							{
								$ar_field_values[$j] = '';
							}

							if ($f_details = get_url_map_field_details($field_name))
							{
								$t_view 	= $f_details['tpl_view'];
								$url_map_result = f_save_map_url($value, $language, $t_view, $id, $object_view);
								
								if ($url_map_result === -2)
								{
									$not_upd_map_url++;
									$not_upd_map_url_array[] = ($i+1).' row: '.$value;
								}	
								$upd++;
							}
							else if (trim($field_name) != '')
							{
								$upd += save_cms('obj_meta_'.$field_name.$object_tpl_id, str_replace('&#34;', '"', trim($value)), $id, $language);
								
								if (post('publish_seo'))
								{
									publish_cms_on_page($id, 'obj_meta_'.$field_name, $object_tpl_id);
								}
							}
						}
					}
					$s = array();
					$s[] = 'Import success';
					$s[] = '<strong>&#171;' . intval( $upd / ($_fields_count - 5) ) . '&#187;</strong> - rows updated';
					
					$not_imported_html = '&nbsp;<a 	href="#"
									onclick="document.getElementById(\'not_imported_urls\').style.display=\'block\'; onWindowResize();">See report &#187;</a>'.									
								'<br /><div id="not_imported_urls">'.implode('<br />', $not_upd_map_url_array).'</div>';								
								
					$s[] = '<strong>&#171;'.$not_upd_map_url.'&#187;</strong> - URLs not imported.'.$not_imported_html;
					
					$s = implode('<br />', $s);					
					$error['csv_file'] = $s;
				}
			}
		}

		return parse_popup($modul.'/meta_import');
	}

	// удаление meta-tag'a
	function meta_del()
	{
		global $modul, $url;
		global $ar_meta_fixed;
		if (	$_GET['meta_del'] &&
			$_GET['meta_del'] != '' &&
			!in_array($_GET['meta_del'], $ar_meta_fixed) )
		{
			del_cms('obj_meta_'.$_GET['meta_del'], null, null, false);
			del_cms('default_obj_meta_'.$_GET['meta_del'], null, null, false);
		}

		header($url);
	}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'mysql_query',
				'is_array',
				'iconv'
			),

			'php_ini' => array (
				'max_execution_time'
			),

			'constants' => array (
				'EE_HTTP',
			),

			'db_tables' => array (

				'language',
				'content',
				'tpl_pages',
				'v_tpl_folder',
			),

			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}

	function get_modul_list($modul)
	{
		return include('get_yui_list.php');
	}
	function print_yui_captions($full='no')
	{
		return include('print_yui_captions.php');
	}

//********************************************************************
	switch($op)
	{
		default:
		case '0': header('Content-type: text/html; charset=utf-8'); $characterSet="utf-8"; echo parse_tpl($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'publish': publish_seo(true);
				header($url);
				break;
		case 'revert': 	revert_seo(true);
				header($url);
				break;
		case 'rows_on_page': rows_on_page(); break;
		case 'export_to_csv': echo export_to_csv(); break;
		case 'import_from_csv': echo import_from_csv(); break;
		case 'meta_del': meta_del(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel':
					header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
	}
?>