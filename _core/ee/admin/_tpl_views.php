<?
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'views';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 250;
	$edit_config_width = 100;
	$config_vars = array (
      		array (

		'field_name' 	=> 'views_rule',
		'size' 		=> '70',
		'field_title' 	=> 'Default views rule'

		),

		array (

		'field_name' 	=> 'object_views_rule',
		'size' 		=> '70',
		'field_title' 	=> 'Default object views rule'

		)

	); 

	if (!defined('ADMIN_MENU_ITEM_TPL_VIEWS')) define('ADMIN_MENU_ITEM_TPL_VIEWS', 'Content/Satellite Views');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_TPL_VIEWS);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	$hidden = array('is_default');

 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	
	// тип фильтра
	$type_filter['default_view'] = 'select_Y';

	// выравнивание
	$align['id']='right';

	// стиль столбца
	
	// оформление самого значения в гриде
	$ar_grid_links['is_default'] = '<%%iif:%'.(array_search('is_default',$fields)+1).'$s,1,Yes%%>';
	

	// только окно редактирования

	// стиль строки поля формы

	// размер поля

	// доступно только для чтения
	if (isset($edit) && db_constant('DEFAULT_TPL_VIEW_ID')==$edit)
	{
		// нельзя изменить поле is_default с true на false, только наоборот
		$readonly[] = 'is_default';
	}

	// обязательно для заполнения

	$mandatory=array('view_folder');

	// тип поля ввода
	$type['id'] = "string";
	$type['icon'] = "image";
	$type['is_default'] = "checkbox";

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)
	
	// туда же
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list($export='')
	{
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);

		include('print_list_limit_sql.php');

		$rs = viewsql($sql, 0 );

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
				$row_field[$i]['field_value'] = vsprintf($ar_grid_links[$fields[$i]], $r);
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}

	// список полей в окне редактирования
	function print_fields()
	{
		return include('print_fields.php');
	}

	// добавление/сохранение записи
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');

		if (post('refresh'))
		{
			$image_field = 'icon';
			$view_folder = $field_values['view_folder'];
			
			if(	!empty($view_folder) &&
				!create_view_folder($view_folder))
			{
				$error['view_folder'] = "Cann't create catalogue in 'templates/VIEWS'";
			}

			if ($_FILES[$image_field]['name'] != '')
			{
				unset($error[$image_field]);
				$res = upload_image($image_field, '', null, 100, 1000000, 1000000, array('static_width' => 16, 'static_height' => 16));
				if(is_array($res))
				{
					$error[$image_field] = $res[0];
				}
				else
				{
					$field_values[$image_field] = $res;
				}
			}
			else if(post('delete_img'))
			{
				$field_values[$image_field] = '';
				deleteFile(post($image_field));
				deleteFile('_'.post($image_field));
			}
			if (count($error)==0)
			{
				if (empty($edit)) // New object
				{
					unset($field_values['id']);
					$db_function = 'f_add'.$modul;
				}
				else
				{
					$db_function = 'f_upd'.$modul;
				}

				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					$error['id'] = 'DataBase error';
				}
				else
				{
					if (post('save_add_more')) 
					{
						header ('Location: '.$modul.'.php?op=3&added='.$res);
						exit;
					} else close_popup('yes');
				}
			}
		}
		return parse($modul.'/edit');
	}

	// удаление
	function del()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

		header($url);
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'f_add'.$modul,
				'f_upd'.$modul,
				'f_del'.$modul,
				'mysql_query'
			),

			'php_ini' => array (),

			'constants' => array (),

			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit',
				'tpl_views'
			),

			'custom_query' => array (
				array (
					'query'=>'SELECT COUNT(id) FROM tpl_views WHERE is_default=1',
					'result'=>1,
					'message'=>'1 and only 1 default view must be defined'
				)
			),

			'db_funcs'  => array ()
		);

		$ar_self_check[$modul]['dir_exists'] = array_merge(
			array('templates/VIEWS'),
			SQLField2Array(viewsql('SELECT CONCAT(\'templates/VIEWS/\', view_folder) FROM tpl_views'))
		);

		foreach($ar_self_check[$modul]['dir_exists'] as $dir)
		{
			$ar_self_check[$modul]['dir_attributes'][$dir] = EE_DEFAULT_DIR_MODE;
		}

		return parse_self_test($ar_self_check);
	}
	
	function edit_config()
	{
		if (post('refresh'))
		{
			// delete sitemap.xml cache
			delete_cache_by_path(EE_PATH.EE_XML_CACHE_DIR);
		}
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
	switch($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'config':
			echo edit_config();
			break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>