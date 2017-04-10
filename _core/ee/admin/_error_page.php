<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
	unset($open_pass_edit);
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 265; 

	if (!defined('ADMIN_MENU_ITEM_ERROR_PAGE')) define('ADMIN_MENU_ITEM_ERROR_PAGE','Administration/Error Pages');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_ERROR_PAGE);

	$page_types = array('Satellite Page', 'URL', 'Plain Text');
	$test = getField("SELECT val FROM config WHERE var='error_pages'");
	if (count(unserialize($test)) != count($error_codes)) {
		$error_pages = array();
		foreach ($error_codes as $k => $v) {
			$error_pages[$k] = array('id' => $k, 'description' => $v['description'], 'page_type' => 2, 'value' => 'Error '.$k.' - '.$v['description']);
		}
		RunSQL("DELETE FROM config WHERE var='error_pages'");
		RunSQL("INSERT INTO config SET var='error_pages', val='".serialize($error_pages)."' ");
	}
	// главный список полей
	// по нему работают все функции
	$fields = array('id','description','page_type','satelit');
	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихся от установленных по-умолчанию
	//
	// только список (grid)
	//скрыть столбец
//	$hidden = array('id');
 	// размер поля фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
//	$type_filter['status'] = 'select_status';
//	$type_filter['role'] = 'select_role';
	// выравнивание
	$align['id']='right';
//	$valign['id']='bottom';
	// стиль столбца
//	$grid_col_style['id'] = 'display:none';
	// оформление самого значения в гриде
//	$ar_grid_links['login'] = '<a id="%1$s" href="'.EE_HTTP.'?t=tpl_preview&tpl_name=%2$s" target="_blank">open file</a>';
	//
	// стиль строки поля формы
//	$form_row_style['password']=$form_row_style['password_confirm']='display:none';
	// размер поля
//	$size['login'] = '100';
	// доступно только для чтения
//	$readonly = array('name');
	// обязательны для заполнения
	$mandatory = array('page_type', 'satelit');
	// тип поля ввода
	$type['id'] = 'string';
	$type['description'] = 'string';
	$type['page_type'] = 'select_page_type';
	$type['satelit'] = 'err_page_text';
//	$type['role'] = 'select_role';
//	$type['password'] = $type['password_confirm'] = 'password';

	$caption['id'] = 'Error';
	$caption['satelit'] = 'Value';
//	$caption['login'] = 'Логин';

//	$check_pattern['icq'] = array('^[0-9]*$', 'Must be integer');
//	$check_pattern['email'] = array(EMAIL_PATTERN, ERROR_EMAIL_PATTERN);


	// туда же
	function print_captions()
	{
		return include('print_captions.php');
	}
	function print_filters()
	{
		return '';
	}
	// список (grid)
	function print_list()
	{
		global $MAX_ROWS_IN_ADMIN, $click, $page, $srt, $b_color, $order, $UserRole, $UserId;
		global $modul;
		global $sort, $align;
		global $admin_template;
		global $ar_grid_links;
		global $fields;
		global $grid_col_style;
		global $ar_usl;
		global $hidden, $page_types, $default_language;

		include('print_list_init_vars_apply_filter.php');                                              	

		$rs = unserialize(getField("SELECT val FROM config WHERE var='error_pages'"));
		$s = '';
		$j=0;
		$rows = array();
		foreach($rs as $r)
		{
			//for compability in serialize array we use key 'value' and in object field 'satelit'
			if(is_array($r) && array_key_exists('value', $r))
			{
				$new_fields_values = $r;
				$new_fields_values['satelit'] = $r['value'];
				unset($new_fields_values['value']);
				$r = $new_fields_values;
			}
			if ($r['page_type'] == 0) {
				$page_name = getField("SELECT CONCAT_WS('/', IF(`folder` = '/', '', `folder`), `page_name`) AS page_name FROM v_tpl_page_grid WHERE id=".sqlValue($r['satelit'])." AND language=".sqlValue($default_language)." LIMIT 0,1");
				$r['satelit'] = '<a href="'.EE_HTTP.'index.php?admin_template=yes&t='.$r['satelit'].'">'.$r['satelit'].' ('.$page_name.')</a>';
			}
			if ($r['page_type'] == 1) {
				$r['satelit'] = '<a href="'.$r['satelit'].'">'.$r['satelit'].'</a>';
			}
			
			$r['page_type'] = $page_types[$r['page_type']];
			$row_field = array();
			for($i=0; $i<count($r); $i++)
			{
				$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
				$row_field[$i]['field_align'] = $align[$fields[$i]];
				$row_field[$i]['field_value'] = vsprintf($ar_grid_links[$fields[$i]], $r);
			}

			$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field');
			$rows[$j]['id'] = $r['id'];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}

		/*
		** As grid values on Error Pages parse from serialize array, 
		** navigation ['Rows on page' selector] didn't work correctly.	
		** Redeclaration: $rows = array_slice(array, from_item_position, how_many_items);
		*/
	  	$tot = count($rows);			
		include('print_list_limit_sql.php');
		$rows = array_slice($rows,($page-1) * $MAX_ROWS_IN_ADMIN,$MAX_ROWS_IN_ADMIN);	

		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row');		

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, '../templates/navigation/default');
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
		global $edit, $field_values;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);
		$error = array();

		// начальная инициализация при редактировании
		$info = array();
		$rs = unserialize(getField("SELECT val FROM config WHERE var='error_pages'"));
		$info = $rs[$edit];
		$info['satelit'] = $info['value'];
		include ('save_init_globals_from_post.php');

		if (post('refresh'))
		{
			if (count($error)==0)
			{
				//unset($field_values['password_confirm']);
				
				//for compability in serialize array we use key 'value' and in object field 'satelit'
				$new_fields_values = $field_values;
				$new_fields_values['value'] = $field_values['satelit'];
				unset($new_fields_values['satelit']);
				//$rs[$edit] = $field_values;
				$rs[$edit] = $new_fields_values;
				
				$val = serialize($rs);
				$res = RunSQL("UPDATE config SET val='".$val."' WHERE var = 'error_pages'");

				if ($res < 0)
				{
					$error['id'] = 'DataBase error '.$res;
				}
				else
				{
					close_popup('yes');
//					header ('Location: '.$modul.'.php?load_cookie=true');
//					exit;
				}
			}
		}
		return parse($modul.'/edit_popup');
	}
	function get_current_page($edit)
	{
		$rs = unserialize(getField("SELECT val FROM config WHERE var='error_pages'"));
		$nm = $rs[$edit]['value'];
		return (int)$nm;
	}
	// удаление
	function del()
	{
		global $del, $modul, $url;

		$rs = unserialize(getField("SELECT val FROM config WHERE var='error_pages'"));
		unset($rs[$del]);
		$val = serialize($rs);
		$res = RunSQL("UPDATE config SET val='".$val."' WHERE var = 'error_pages'");

		header($url);
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (

				'mysql_query',
				'is_array'
			),

			'php_ini' => array (

				'max_execution_time'
			),

			'constants' => array (

				'EE_PATH',
			),

			'db_tables' => array (

			),

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
		case '2': del();break;
		case '3': echo save();break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
	}
?>