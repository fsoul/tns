<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
	$modul_title = 'Website pages metatags';

//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$config_vars = array (
		array (

		'field_name' => 'max_chars_title',
		'field_title' => 'Maximum size for title field',
		'size' => '11'

		),
		array (

		'field_name' => 'max_chars_description',
		'field_title' => 'Maximum size for description field',
		'size' => '11'

		),
		array (

		'field_name' => 'max_chars_keywords',
		'field_title' => 'Maximum size for keywords field',
		'size' => '11'

		)
	);

	if (!defined('ADMIN_MENU_ITEM_SEO')) define('ADMIN_MENU_ITEM_SEO', 'Content/SEO/SEO Pages');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_SEO);

	// list of meta tags that cannot be deleted or renamed
	$ar_meta_fixed = array('title', 'keywords', 'description', 'commentary');
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

                                SELECT DISTINCT REPLACE(var,\'meta_\',\'\')
                                  FROM content
                                 WHERE var REGEXP \'^meta_\'
                                   AND var <> \'meta_\'
			) mt
			ORDER BY meta_tags ASC

        	', 0);

	while ($row = db_sql_fetch_row($rs))
	{
		$ar_meta_default[]=$row[0];
	}
	db_sql_free_result($rs);

	// проверка наличия информации в контенте
	$sql_language = '

        SELECT
               language_code
          FROM
               v_language
        ';

	$res = ViewSQL($sql_language, 0);

	$langs_count = db_sql_num_rows($res);

	$sql_meta_count = '

        SELECT
               count(*)
          FROM
               content
    INNER JOIN v_language
            ON content.language=v_language.language_code
         WHERE
               var regexp \'^default_meta_\'
           AND var <> \'default_meta_\'
        ';

	$meta_count = GetField($sql_meta_count);

	if ((int)$meta_count <> ($langs_count)*(count($ar_meta_default)-1)) //in content there is no tag change_frequency, but no need to add it
	{
		$ar_langs = SQLField2Array($res);

		foreach ($ar_meta_default as $key=>$value)
		{
			foreach ($ar_langs as $r_lang)
			{
				if (!db_sql_num_rows(ViewSQL("SELECT * FROM content WHERE var='default_meta_".$value."' AND language='".$r_lang."'",0)))
				{
					RunSQL("INSERT INTO content(var,val,page_id,language) VALUES ('default_meta_".$value."','',0,'".$r_lang."')",0);
				}

				if (!db_sql_num_rows(ViewSQL("SELECT * FROM content WHERE var='meta_".$value."' AND language='".$r_lang."'",0)))
				{
					RunSQL("INSERT INTO content(var,val,page_id,language) VALUES ('meta_".$value."','',0,'".$r_lang."')",0);
				}
			}
		}
	}
	db_sql_free_result($res);

	$sql = sql_get_all_meta();

	$sql_model = "SELECT
		    DISTINCT replace(var,'meta_','')
		        FROM content
		       WHERE var
		      NOT IN ('meta_title', 'meta_keywords', 'meta_description', 'meta_commentary', '')
		         AND var like 'meta_%'";

	$ar_model_ext_res = ViewSQL($sql_model);
	$ar_model_ext_tags = SQLField2Array($ar_model_ext_res);

	$ar_meta = SQLField2Array(viewsql($sql, 0));
	// for grid
	$ar_meta = sort_seo_grid_fields_by_users_wish($ar_meta, 'meta_');
	// for caption
	$ar_meta_default = sort_seo_grid_fields_by_users_wish($ar_meta_default);

	$meta_sql = '

        IFNULL(( SELECT IF('.val_field_name().'=\'\',NULL,'.val_field_name().')
                   FROM content
                  WHERE page_id=p.id
                    AND var=\'%s\'
                    AND language=p.language
               )
        ,
               ( SELECT '.val_field_name().'
                   FROM content
                  WHERE page_id=0
                    AND var=\'default_%s\'
                    AND language=p.language
               )
        )   AS \'%s\'
        ';

	for($i=0; $i<count($ar_meta); $i++)
	{
		$ar_meta[$i] = addslashes($ar_meta[$i]);
		$ar_sql[] = sprintf($meta_sql, $ar_meta[$i], $ar_meta[$i], str_replace('meta_', '', $ar_meta[$i]));
	}


	$sql_general = implode (','."\n", $ar_sql);
	$page_name_alias = 'IF(p.folder_id != 0 && p.folder_id IS NOT NULL ,CONCAT(f.folder,"/",p.page_name),p.page_name)';

	$sql_general = '

        SELECT *
          FROM
        (
        SELECT
               p.id,
               '.$page_name_alias.' AS page_name,
               p.language as language_name,
       '.$sql_general.'
          FROM v_tpl_non_folder_content p
     LEFT JOIN v_tpl_path_content f
            ON f.id=p.folder_id
           AND p.language = f.language
	 WHERE p.type = 0

        ) AS main_query
        ';

	$sql = sprintf($sql_general);

	//For export need to use not "language_name" but "language_code"
	$sql_for_export = sprintf($sql_general);

	// главный список полей
	// по нему работают все функции

	$ar_meta_default = sort_seo_grid_fields_by_users_wish($ar_meta_default);
	$fields = array_merge(array('id', 'page_name', 'language_name'), $ar_meta_default);

//set_mark('$fields');

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	if ($op == 'export_excel')
	{
		$page_name_link = $custom_fields_type = '%s';		
	}
	else
	{
		$custom_fields_type = '
			<input
				style="color:#000;"
				<%%iif:<%%is_seo_draft:%4$s,%3$s,%2$s%%>,1,class="seoInDraft",%%>
				type="text"
				value="%6$s"
				onFocus="editSEO(this, \'%2$s\', \'%3$s\', \'%4$s\');"
				<%%iif:1,0,%1$s%%>
				<%%iif:<%%config_var:max_chars_%2$s%%>,,,maxlength="<%%config_var:max_chars_%2$s%%>"%%>>';

		$page_name_link = '<a href="'.EE_HTTP.'index.php?language=%3$s&t=%4$s&admin_template=yes">%6$s</a>';
	}

	foreach ($ar_grid_links as $k=>$v) 
	{
		$ar_grid_links[$k] = $custom_fields_type;
	}

	// оформление самого значения в гриде
	$ar_grid_links['id'] = '%s';
	$ar_grid_links['language_name'] = '%s';
	$ar_grid_links['page_name'] = $page_name_link;

	//set_mark('$ar_grid_links');

 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	$size_filter['language_name'] = 7;

	// выравнивание
	$align['id']='right';

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	$caption['language_name'] = 'Lang';

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

		for($i=0; $i<count($fields); $i++)
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

		$rs = viewsql($sql, 0);

		$s = '';
		$j = 0;


		$rows = array();
		while ($r = db_sql_fetch_row($rs))
		{
			list($lang_code) = db_sql_fetch_row(ViewSQL("SELECT language_code FROM v_language WHERE language_code='".$r[2]."'",0));
			$row_field = array();
			for($i=0; $i<count($r); $i++)
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
					'ent_value'	=> htmlentities($r[$i], ENT_QUOTES, 'UTF-8')
				);

				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $array));
				unset($array);
			}

			$row_field = remove_by_keys($row_field, $hidden);

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field' . $export);
			$rows[$j]['id'] = $r[0];
			$rows[$j]['row_language'] = $lang_code;
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

				$ar_model = array_values(array_unique($fields));
				for ($i=0; $i<count($ar_model); $i++)
				{
					if (strtolower($ar_field_names[$i])!=strtolower($ar_model[$i]))
					{
						$error['csv_file'] = 'Required field \''.$ar_model[$i].'\' is absent or wrong fields order';
						break;
					}
				}
				if (count($error)==0)
				{

					$upd = 0;
					for ($i=0; $i<count($ar_rows); $i++)
					{
						$ar_field_values = $ar_rows[$i];
						$_fields_count = count($ar_field_values);
						for ($j=3; $j<$_fields_count; $j++)
						{
							if($ar_field_values[$j] == EE_DEFAULT_CSV_SEPARATOR)
							{
								$ar_field_values[$j] = '';
							}

							if (trim($ar_field_names[$j]) != '') 
							{
								$upd += save_cms('meta_'.$ar_field_names[$j], str_replace('&#34;', '"', trim($ar_field_values[$j],' "')), $ar_field_values[0], $ar_field_values[2], null, 0);
								
								if (post('publish_seo'))
								{
									publish_cms_on_page($ar_field_values[0], 'meta_'.$ar_field_names[$j]);
								}
							}
						}
					}
					
					$s = array();
					$s[] = 'Import success';
					$s[] = '<strong>&#171;' . intval( $upd / ($_fields_count - 3) ) . '&#187;</strong> rows updated';
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
			del_cms('meta_'.$_GET['meta_del']);
			del_cms('default_meta_'.$_GET['meta_del']);
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

	function edit_config()
	{
		return include('print_edit_config.php');
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
//set_mark('switch($op)');

	switch($op)
	{
		default:

		case '0':
			$characterSet = 'utf-8';
			header('Content-type: text/html; charset='.$characterSet);
			echo parse($modul.'/list');
			break;

		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'publish': publish_seo();
				header($url);
				break;
				
		case 'revert': 	revert_seo();
				header($url);
				break;
		case 'rows_on_page': rows_on_page(); break;
		case 'export_to_csv': echo export_to_csv(); break;
		case 'import_from_csv': echo import_from_csv(); break;
		case 'meta_del': meta_del(); break;
		case 'self_test': echo print_self_test(); break;
		case 'config': echo edit_config(); break;
		case 'export_excel':
				header( 'Content-Type: application/vnd.ms-excel' );
				header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
				echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
	}

//set_mark('END');

?>