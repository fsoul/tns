<?
/**
 * This file provides administration of object content in admin panel. 
 * It works with table `object_content` in DB, that contains 4 fields (object_record_id, object_field_id, value, language). 
 * This file contains functions for add/edit record, delete record, print all data on page or export it to MS Excel document, testing itself. 
 * Functions are called depending on variable $op.
 */
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'Object Content';
//********************************************************************
/**
 * Main lib-file
 */
	include_once('../lib.php');

/**
 * This file is used to tell what to do if button "BACK" is pressed. Also it contains function close_popup(), that is used in all modules. 
 */
	include('url_if_back.php');

	$popup_height = 295; 

	if (!defined('ADMIN_MENU_ITEM_OBJECT_CONTENT')) define('ADMIN_MENU_ITEM_OBJECT_CONTENT', 'Objects/Object Content');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR), ADMIN_MENU_ITEM_OBJECT_CONTENT);
	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
/**
 * Sets default properties for grid on page in admin panel.
 */
	require ('set_default_grid_properties.php');
	
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)

	//скрыть столбец
	//$hidden = array('is_default');
 	// размер поля фильтра в списке
	$size_filter['object_field_id'] = 3;
	$size_filter['record_id'] = 3;
	// тип фильтра
	//$type_filter['default_page'] = 'select_Y';
	// выравнивание
	//$align['id']='right';
	// стиль столбца
	//$grid_col_style['default_page'] = 'width:5px';
	// оформление самого значения в гриде

	//$row_field[$i]['field_value'] = cut(strip_tags($row_field[$i]['field_value']),100);
	//$ar_grid_links['value'] = '<span onmouseover="ddrivetip(\'<img src=%'.(array_search($v,$fields)+1).'$s>\')" onMouseout="hideddrivetip()"><img src='.EE_HTTP.'img/camera.gif></span>';	
	// только окно редактирования
	// стиль строки поля формы

	// размер поля


	// доступно только для чтения

	// обязательно для заполнения
	$mandatory=array('object_field_id','object_record_id','value','language');
	// тип поля ввода
	$type['object_field_id'] = "select_object_field";
	$type['object_record_id'] = "select_object_record";
	$type['language'] = "select_language";
	if (!empty($edit))
	{
	$type['object_record_id'] = "string";
	$type['object_field_id'] = "string";
	$type['language'] = "string";
	}
	$type['value'] = "textarea";
	
	$type_filter['language'] = 'select_distinct';
	$type_filter['object_name'] = 'select_distinct';
	$type_filter['object_field_name'] = 'select_distinct';
	//$type['template'] = "select_tpl_file";
	//$type['folder'] = "select_tpl_folder";
	//$type['search'] = "checkbox_search";

	//$check_pattern['object_field_id'] = array('^[0-9]*$', 'Illegal characters in page name');
	$check_pattern['object_record_id'] = array('^[0-9]*$', 'Illegal characters in page name');
	$check_pattern['language'] = array('^[A-Z][A-Z]$', 'Must be 2 upper case letters');

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
/**
 * Returns string include file print_captions.php
 * @param string $export tells in what format data is  exporting. If it is empty - data shows on page.
 */
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// поля фильтра в grid-е
/**
 * Returns string include file print_filters.php
 */
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
/**
 * Prints all data on page or exports it to file (depends on variable $export)
 * Works with SQL-view v_object_content_grid
 * @param string $export tells in what format data is  exporting. If it is empty - data shows on page.
 * @return string parse array to html table format
 */
	function print_list($export='')
	{
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);

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
				if ($fields[$i]=="value") $row_field[$i]['field_value'] = cut(strip_tags($row_field[$i]['field_value']),100);
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r[0];
			$rows[$j]['record_id'] = $r[1];
			$rows[$j]['lang'] = $r[3];
			$rows[$j++]['name'] = SaveQuotes('(field_id='.$r[0].', record_id='.$r[1].', language='.$r[3].')');
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}


	// список полей в окне редактирования
/**
 * Returns string include file print_fields.php
 */
	function print_fields()
	{
		return include('print_fields.php');
	}

	// добавление/сохранение записи
/**
 * Provides adding or editing record. Depends on variable $op.
 * Works with SQL-view v_object_content_edit.
 * @return string parse template edit, where user can enter data to save it in DB
 */
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit, $edit2, $lang;

		$where_object_id = '';
		if (!empty($edit)) $where_object_id = 'WHERE object_id='.GetField('Select object_id FROM object_field WHERE id='.$edit);

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);
		$sql='select * from v'.$modul.'_edit where object_field_id ='.sqlValue($edit).' AND object_record_id='.sqlValue($edit2).' AND language='.sqlValue($lang);

		include ('save_init.php');

		if (post('refresh'))
		{
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

				if ((int)$res == -1)
				{
					$error['object_field_id'] = 'No such object_field';
				}
				else if ((int)$res == -2)
				{
					$error['record_id'] = 'No such record';
				}
				else if ((int)$res == -3)
				{
					$error['language'] = 'No such language';
				}
				else if ((int)$res == -4)
				{
					$error['object_field_id'] = 'Value with such id\'s already exists';
				}
				else if (post('save_add_more')) 
				{
					header ('Location: '.$modul.'.php?op=3&added='.$res[0].'&edit2='.$res[1].'&lang='.$res[2]);
					exit;
				}
				else
				{
					close_popup('yes');
				}
			}
		}
		return parse_tpl($modul.'/edit');
	}

	// удаление
/**
 * Calls to function RunNonSQLFunction().
 */
	function del()
	{
		global $del, $del2, $modul, $url, $lang;

		RunNonSQLFunction('f_del'.$modul, array($del, $del2, $lang));

		header($url);
	}

/**
 * It contains function rows_on_page(). Used to divide data on pages.
 */
	include ('rows_on_page.php');

/**
 * Initiates array with parameters for self testing of modul.
 * Array contains of php functions, php.ini, constatnts, DB tables, DB functions.
 * @return string calling another function parse_self_test().
 */
	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'f_add'.$modul,
				'f_upd'.$modul,
				'f_del'.$modul,
				'mysql_query'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit',
				'v_tpl_file',
				'v_tpl_folder'
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
		case '0': echo parse_tpl($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'del_sel_items': del_selected_items('object_content');echo parse_tpl($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>