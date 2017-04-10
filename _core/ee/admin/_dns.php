<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL. 
* http://www.2k-group.com
*/
?>
<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
	if (!defined('ADMIN_MENU_ITEM_DNS')) define('ADMIN_MENU_ITEM_DNS','Administration|500/DNS');
	include_once('../lib.php');
	
	include('url_if_back.php');



	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_DNS);
	
	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');
//	$ar_grid_links['status'] = '<%%iif:%4$s,0,disabled,1,enabled%%>';
	
/*	$ar_grid_links['status'] = '<table border="0"><tr><td><img src="'.EE_HTTP.'img/folder<%%iif:%'.
	(array_search('folder',$fields)+1).
*/	
	$size_filter['id'] = 3;
	$type_filter['status'] = 'select_status';
	$type_filter['draft_mode'] = 'select_draft_status';
	$type_filter['language_forwarding'] = 'select_distinct';
	$mandatory = array('dns');
	$type['id'] = 'string';
	$type['status'] = 'select_DE';
	$type['language_forwarding'] = 'radio';
	$type['draft_mode'] = 'select_YN';
	$ar_grid_links['draft_mode'] = '<%%iif:%'.(array_search('draft_mode',$fields)+1).'$s,0,Disabled,Enabled%%>';
	//$type['cdn_server'] = 'dns_cdn_server';

	$check_pattern['dns'] = array('^[0-9a-zA-Z_][\.a-zA-Z0-9_-]*$', 'Illegal characters in dns name');        

//	$sort_function['comment'] = 'CAST(%s AS UNSIGNED)';
	
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

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

	function print_list($export='')
	{
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);


		include('print_list_limit_sql.php');


		$rs = viewsql($sql, 0);
		$s = '';
		$j=0;
		$rows = array();
		while ($r=db_sql_fetch_row($rs))
		{
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
			}
			//checking status of language
			if($row_field[4]['field_value'] && check_status_of_language($row_field[4]['field_value']) == 0)
			{
				$row_field[4]['field_value']  .= '<span class="error"> Warning!!! language is disabled</span>';
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);

			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}

		//check_status_of_language
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}
	
	function print_fields()
	{
		return include('print_fields.php');
	}

	
	function del()
	{
		global $del, $modul, $url;

		RunNonSQLFunction('f_del'.$modul, array($del));

		header($url);
	}

	include ('rows_on_page.php');

	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;
		global $change_pass;
		global $email, $login, $newpassword;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');

		if (post('refresh'))
		{

			$field_values['language_forwarding'] = $_POST['language_forwarding'];
			$field_values['draft_mode'] = (int) $field_values['draft_mode'];
			
			if ($_POST['select_lang_forw'] == 'default_language')
			{
				$field_values['language_forwarding'] = getField('select language_code from v_language WHERE default_language = 1');
			}

			if (count($error)==0)
			{

//				//unset($field_values['password_confirm']);
				
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
					if ($res==-1 || $res==-3)
						$error['dns'] = 'Such DNS already exists';
					else
						$error['id'] = 'DataBase error '.$res;

//					$error['id'] = 'DataBase error '.$res;
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
		return parse($modul.'/edit_popup');
	}


	function edit_lang_forwarding()
	{                 
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;
		global $change_pass;
		global $email, $login, $newpassword;

		$pageTitle = ('Edit language forwarding');

		include ('save_init.php');

		if (post('refresh'))
		{        
			if (count($error)==0)
			{ 
				//unset($field_values['password_confirm']);
				
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
					if ($res==-1 || $res==-3)
						$error['dns'] = 'Such DNS already exists';
					else
						$error['id'] = 'DataBase error '.$res;

//					$error['id'] = 'DataBase error '.$res;
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
		return parse($modul.'/edit_popup_lang_forw');
	}

	function dns_list($selected)
	{         
		global $modul;

		$sql = 'SELECT 
				id,
				dns,
				'.(int)$selected.' AS selected_cdn
			  FROM 
				dns';

		$html = parse_sql_to_html($sql, $modul.'/dns_list_row');
		return $html;
	}

	function is_cdn_server($dns_id)
	{
		$sql = 'SELECT 
				dns 
			  FROM 
				dns 
			 WHERE 
				cdn_server='.sqlValue($dns_id);

		$res = viewSQL($sql);

		if (db_sql_num_rows($res) > 0)
		{
			return 1;
		}

		return 0;
	}

	function get_dns_for_cdn($cdn_id)
	{
		global $modul;

		$sql = 'SELECT 
				dns 
			  FROM 
				dns 
			 WHERE 
				cdn_server='.sqlValue($cdn_id);

		return parse_sql_to_html($sql, $modul.'/notice_dns_list_row');

	}

	function get_modul_list($modul)
	{
		return include('get_yui_list.php');
	}
	function print_yui_captions($full='no')
	{
		return include('print_yui_captions.php');
	}

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
				'dns'),
			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}
//********************************************************************

	switch ($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '3': echo save();break;
		case '2': del(); break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;
		case 'edit_lang_forw': echo edit_lang_forwarding();break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}

?>