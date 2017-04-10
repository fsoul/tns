<?
/**
 * This file provides administration of objects in admin panel. 
 * It works with table `object` in DB, that contains 2 fields (id, name). 
 * This file contains functions for add/edit record, delete record, print all data on page or export it to MS Excel document, testing itself. 
 * Functions are called depending on variable $op.
 */

	$modul = basename(__FILE__, '.php');
	$modul_title = 'Objects';
//********************************************************************
/**
 * Main lib-file
 */
	include_once('../lib.php');
/**
 * This file is used to tell what to do if button "BACK" is pressed. Also it contains function close_popup(), that is used in all modules. 
 */
	include('url_if_back.php');

	$popup_height = 150;
	$edit_config_width = 700;
	$config_vars = array (
				array (
				'field_name' => 'object_folder',
				'size' => '70',
				'field_title' => 'Default object folder',
				'for_all_languages' => true
				),

				array (
				'field_name' => 'object_alias_rule',
				'size' => '70',
				'field_title' => 'Default object alias rule'
				)
			);

	if (!defined('ADMIN_MENU_ITEM_OBJECT')) define('ADMIN_MENU_ITEM_OBJECT', 'Objects/Object management');

	//��������� ����� � ������������ op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR), ADMIN_MENU_ITEM_OBJECT);
	// ������� ������ �����
	// �� ���� �������� ��� �������

	// ��������� ������� ��-���������
/**
 * Sets default properties for grid on page in admin panel.
 */
	require ('set_default_grid_properties.php');
	
	// ��������� �������, ������������ �� ������������� ��-���������
	// ������ ������ (grid)
	//������ �������
	$hidden = array('is_default');
 	// ������ ���� ������� � ������
	$size_filter['id'] = 3;
	// ��� �������
	$type_filter['default_page'] = 'select_Y';
	// ������������
	$align['id']='left';
	// ����� �������
	$grid_col_style['default_page'] = 'width:5px';
	// ���������� ������ �������� � �����
	// ������ ���� ��������������
	// ����� ������ ���� �����
	// ������ ����
	// �������� ������ ��� ������
	// ����������� ��� ����������
	$mandatory=array('name');
	// ��� ���� �����
	$type['id'] = "string";

	$check_pattern['page_name'] = array('^[a-zA-Z_][a-zA-Z0-9_-]*$', 'Illegal characters in page name');

	// ��������������� �������� �������, ����������, ��������
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// ��� ���������� � sql-�������
	if ($op == 0) $order = getSortOrder();

	// ���� ��
/**
 * Returns string include file print_captions.php
 * @param string $export tells in what format data is  exporting. If it is empty - data shows on page.
 */
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// ���� ������� � grid-�
/**
 * Returns string include file print_filters.php
 */
	function print_filters()
	{
		return include('print_filters.php');
	}

	// ������ (grid)
/**
 * Prints all data on page or exports it to file (depends on variable $export)
 * Works with SQL-view v_object_grid
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


	// ������ ����� � ���� ��������������
/**
 * Returns string include file print_fields.php
 */
	function print_fields()
	{
		return include('print_fields.php');
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


	// ����������/���������� ������
/**
 * Provides adding or editing record. Depends on variable $op.
 * Works with SQL-view v_object_edit.
 * @return string parse template edit, where user can enter data to save it in DB
 */

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

				if ($res == -1)
				{
					$error['name'] = 'Such object already exists';
				}
				else if ($res == -2)
				{
					$error['name'] = 'Object name must be !empty';
				}
				else if (post('save_add_more')) 
				{
					header ('Location: '.$modul.'.php?op=3&added='.$res);
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

	// ��������
/**
 * Calls to function RunNonSQLFunction().
 */
	function del()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

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
		case 'del_sel_items': del_selected_items($modul);echo parse_tpl($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'config': echo edit_config(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>
