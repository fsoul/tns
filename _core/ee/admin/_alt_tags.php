<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
	$modul_title = 'media alt tags';

//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_ALT_TAGS')) define('ADMIN_MENU_ITEM_ALT_TAGS','Resources/Media/Image Alt Tags');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_ALT_TAGS);
	
	$sql = 'SELECT language_code FROM v_language';
	$arr_langs = SQLField2Array(viewsql($sql, 0));

	$sql = '
	 SELECT
		m.id,
		CONCAT("/", IF(m.folder_id != 0 && m.folder_id IS NOT NULL ,CONCAT(f.folder,"/",m.page_name),m.page_name)) AS page_name
	FROM
		v_media_content m
	LEFT JOIN v_tpl_path_content f ON f.id = m.folder_id AND m.language = f.language
	WHERE m.file_name="media_image"
		  AND m.language = '.sqlValue($language).
	'ORDER BY f.folder ASC, m.page_name';
	$res=ViewSQL($sql,0);
	if (db_sql_num_rows($res))
	{
		$ar_sql = array();
		while ($r=db_sql_fetch_assoc($res))
		{
			$picture_vars = media_manage_vars('media_'.$r['id']);
			$alts = array();
			foreach ($arr_langs as $v)
			$alts[] = ' "'.$picture_vars['alts'][$v].'" '.$v.
				', "'.(empty($picture_vars['images'][$v])?'noimage':$picture_vars['images'][$v]).'" img_'.$v;
			$ar_sql[]=$r['id'].' id, "'.$r['page_name'].'" page_name, '.implode(', ',$alts);
		}

	}
	else
	{
		$ar_sql[]='\'\' id, \'\' page_name, \''.implode('\', \'', $arr_langs).'\' from content where 1=0';
	}
	$sql = 'SELECT * FROM (SELECT '.implode(' UNION SELECT ',$ar_sql).') as alt_tags ';
	// главный список полей
	// по нему работают все функции
	$fields = db_sql_query_fields($sql);
	// установка свойств по-умолчанию
	require ('init_grid_properties.php');

	if (is_array($ar_grid_links) && $op != 'export_excel')
	{
		foreach ($ar_grid_links as $k=>$v) 
		{
			if (in_array($k,$arr_langs)) 
			{
				$ar_grid_links[$k] = '<input style="color:#000;" type="text" value="'.'%'.(array_search($k,$fields)+1).'$s'.'"';
				$ar_grid_links[$k] .= ' onClick="if (this.style.color==\'#000\') this.style.color=\'#f00\'"';
				$ar_grid_links[$k] .= ' onBlur="if (this.style.color==\'#f00\') this.style.color=\'#000\';"';
				$ar_grid_links[$k] .= ' onChange="alt_tag_onChange(this, \'%1$s\', \''.$k.'\')">';
				$ar_grid_links[$k] .= '<img src="<%%:EE_HTTP%%>img/camera<%%iif:<%%file_exists:<%%:EE_MEDIA_FILE_PATH%%>%'.(array_search($k,$fields)+2).'$s%%>,1,,_p%%>.gif"';
				$ar_grid_links[$k] .= '	onmouseover="ddrivetip(\'<%%iif:<%%file_exists:<%%:EE_MEDIA_FILE_PATH%%>%'.(array_search($k,$fields)+2).'$s%%>,,';
				$ar_grid_links[$k] .= '<img src=\\\'<%%:EE_HTTP%%>img/inv.gif\\\'/>,<%%print_assets_preview_source:%'.(array_search('id',$fields)+1).'$s,'.$k.'%%>%%>\')" onmouseout="hideddrivetip()"/>';
			}
		}
	}
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	$hidden = array();
	foreach ($arr_langs as $k=>$v) 
	{
		$hidden[] = 'img_'.$v;
	}
 	// размер поля фильтра в списке
	$size_filter['id'] = 3;

	// выравнивание
	$align['id']='right';

	// оформление самого значения в гриде
	$ar_grid_links['id'] = '%1$s';	

	if ($op != 'export_excel')
	{
		$ar_grid_links['page_name'] = '<a href="'.EE_HTTP.'index.php?t=%1$s&admin_template=yes">%2$s</a>';
	}

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)
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
		global $sql, $meta_sql, $arr_langs;

		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from ('.$sql.') grid '.$where, 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 0);

		$s = '';
		$j=0;
		$rows = array();
		while($r=db_sql_fetch_row($rs))
		{
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'. $export);
			$rows[$j]['id'] = $r[0];
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
		global $sql, $hidden, $fields, $arr_langs;
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
			header( 'Content-Disposition: attachment; filename="alt_tags.csv"' );
	        
			$r = db_sql_fetch_assoc($rs = viewsql($sql, 0));
			foreach ($r as $k=>$v) if (strpos($k,'img_') !== false) unset($r[$k]);
//	//		$r = remove_by_keys($r, array_keys(array_intersect($fields, $hidden)));
			$s = implode(EE_DEFAULT_CSV_SEPARATOR, array_keys($r))."\r\n";
	        
			do
			{	// меняем ";" на хтмл-код
				foreach ($r as $k=>$v) {
//	//				vdump($r);
//	//				$lang = getField("SELECT language_code FROM language WHERE language_name='".$r['language_name']."'",0,0);
					$res = convert_from_utf($v,$k);
					if (empty($res)) $res = $v;
					if (in_array($k,$arr_langs)) $r[$k] = htmlentities($res,ENT_QUOTES);
					if (strpos($r[$k], EE_DEFAULT_CSV_SEPARATOR) !== false) $r[$k] = '"'.$r[$k].'"';
					if (strpos($k,'img_') !== false) unset($r[$k]);
				}
				$s.= implode(EE_DEFAULT_CSV_SEPARATOR, $r)."\r\n";
	        
			} while ($r = db_sql_fetch_assoc($rs));
		}

		return $s;
	}

	function import_from_csv()
	{
		global $modul, $error;

		if (post('refresh') && count($_FILES['csv_file']))
		{
			$csv_file_name = ($_FILES['csv_file']['tmp_name']);
			$csv_file_ext = strtolower(substr($_FILES['csv_file']['name'], -4));
			if (	$csv_file_ext == '.csv' &&
				is_file($csv_file_name) &&
				file_exists($csv_file_name)	)
			{
				$ar_model = array (
					'id',
					'page_name'
				);
				ini_set('auto_detect_line_endings', true);
				$ar_rows = file($csv_file_name);

				foreach($ar_rows as $k=>$v) $ar_rows[$k] = trim(html_entity_decode($v));
				$ar_field_names = explode(EE_DEFAULT_CSV_SEPARATOR, $ar_rows[0]);

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
					for ($i=1; $i<count($ar_rows); $i++)
					{
						$ar_field_values = explode(EE_DEFAULT_CSV_SEPARATOR, $ar_rows[$i]);
						$picture_vars = media_manage_vars('media_'.$ar_field_values[0]);
						for ($j=2; $j<count($ar_field_values); $j++)
						{
							$picture_vars['alts'][$ar_field_names[$j]] = convert_to_utf(trim($ar_field_values[$j],'"'),$ar_field_names[$j]);
//							save_cms('meta_'.$ar_field_names[$j], convert_to_utf(trim($ar_field_values[$j],'"'),$ar_field_values[2]), $ar_field_values[0], $ar_field_values[2]);
//							$upd+=db_sql_affected_rows();
						}
						$picture_vars1 = media_manage_vars('media_'.$ar_field_values[0],$picture_vars);
						if ($picture_vars == $picture_vars1) $upd+=1;
					}
					$s = array();
					$s[] = 'import success';
					$s[] = $upd.' rows updated';
					$error['csv_file'] = implode('<br>', $s);
				}
			}
		}

		return parse_popup($modul.'/meta_import');
	}
	// удаление meta-tag'a

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
		case '0': $characterSet="utf-8"; echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;
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
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>