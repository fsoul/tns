<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//	$modul_title = 'Contact requests';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_MAIL_INBOX')) define('ADMIN_MENU_ITEM_MAIL_INBOX', 'Mailing/Mail inbox');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_MAIL_INBOX);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');
	
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)

	//отключить сортировку
	$sort_disabled = array(); 

	//скрыть столбец
	$hidden = array('add_info');
//	$hidden_excel = array('message', 'name', 'viewed', 'id', 'add_info', 'email');
 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
	$type_filter['viewed'] = 'select_YN';
	// выравнивание
	$align['id']='right';
	// стиль столбца

	// оформление самого значения в гриде
/*	$ar_grid_links['id']='<a href="'.EE_ADMIN_URL.$modul.'?op=1&edit='.
	'%'.(array_search('id',$fields)+1).'$s'.
	'">'.
	'%'.(array_search('id',$fields)+1).'$s'.
	'</a>';

	$ar_grid_links['name']='<a href="'.EE_ADMIN_URL.$modul.'?op=1&edit='.
	'%'.(array_search('id',$fields)+1).'$s'.
	'">'.
	'%'.(array_search('name',$fields)+1).'$s'.
	'</a>';
*/
	$ar_grid_links['message'] = '<%%show_message_in_list:%'.(array_search('message',$fields)+1).'$s%%>';
	// только окно редактирования
	// стиль строки поля формы

	// размер поля


	// доступно только для чтения

	// обязательно для заполнения
	//$mandatory=array('page_name','is_default','template','search');
	// тип поля ввода
	$type['id'] = "string";
	$type['email'] = "string";
	$type['name'] = "string";
	$type['send_date'] = "string";
	$type['add_info'] = "message_body";

	//$caption['add_info'] = 'Message body';
	//$caption['message'] = 'Comments';
	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	//обрезает строку для нормального отображения
	function show_message_in_list($message)
	{
		return cut(html_entity_decode($message), 50);
	}


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

	// список (grid)
	function print_list($export='')
	{
		global $hidden_excel, $caption;
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
			$field_names = array();
			$field_names_add = array();
			$row_field_add = array();
			$r[4] = str_replace(',','\\,',$r[4]);
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
				$field_names[$i]['field_value']=$caption[$fields[$i]];
				if ($fields[$i] == 'add_info' && !empty($export))
				{
					$arr = unserialize($r[$i]);
					foreach ($arr as $k=>$v)
					{
						$field_names_add[] = array('field_value' => $k);
						$row_field_add[] = array('col_style' => $grid_col_style['message'], 
									'field_align' => $align['message'], 
									'field_value' => $v);
					}
				}
			}
			if ((!empty($export)) AND (!empty($hidden_excel)))
			{
				$field_names = remove_by_keys($field_names, array_keys(array_intersect($fields, $hidden_excel)));
				$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden_excel)));
			} else {
				$field_names = remove_by_keys($field_names, array_keys(array_intersect($fields, $hidden)));
				$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));				
			}
			$field_names = array_merge($field_names_add, $field_names);
			$row_field = array_merge($row_field_add, $row_field);
			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = '';
//		if (!empty($export)) $s .= parse_array_to_html($field_names,'templates/'.$modul.'/list_row_head'.$export);
		$s .= parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

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

		$pageTitle = (empty($edit)?'Add ':'View ').str_to_title($modul);

		include ('save_init.php');
		RunSQL("UPDATE mail_inbox SET viewed=1 WHERE id=".$id,0);
		$add_info = unserialize($add_info);
		$add_info = '<table style="border:1px solid #000; padding:5px;" border="0" cellpadding="0" cellspacing="0" width="669">'.
			get_message_body($add_info).'</table>';
		return parse($modul.'/edit');
	}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'mysql_query',
				'get_message_body'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit'
			),
			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}

	include ('rows_on_page.php');
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
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
	}
?>
