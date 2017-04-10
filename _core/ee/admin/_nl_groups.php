<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');
	$popup_height = 175; 

	if (!defined('ADMIN_MENU_ITEM_NL_GROUPS')) define('ADMIN_MENU_ITEM_NL_GROUPS', 'Mailing/Groups');

	//провер€ем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_NL_GROUPS);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихс€ от установленных по-умолчанию
	//
	// только список (grid)
	//скрыть столбец
//	$hidden = array('id');
 	// размер пол€ фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
	$type_filter['show_on_front'] = 'select_YN';
//	$type_filter['status'] = 'select_status';
//	$type_filter['role'] = 'select_role';
	// выравнивание
	$align['id']='right';
//	$valign['id']='bottom';
	// стиль столбца
//	$grid_col_style['id'] = 'display:none';
	// оформление самого значени€ в гриде
//	$ar_grid_links['login'] = '<a id="%1$s" href="'.EE_HTTP.'?t=tpl_preview&tpl_name=%2$s" target="_blank">open file</a>';
	//
	// стиль строки пол€ формы
//	if ($op==3) $form_row_style['new_password']=$form_row_style['confirm_new_password']=$form_row_style['change_password']=$form_row_style['old_password']='display:none';
//		else $form_row_style['change_password']='font-weight:bold; font-size:150%;';
	// размер пол€
//	$size['login'] = '100';
	// доступно только дл€ чтени€
//	$readonly = array('name');
	// об€зательны дл€ заполнени€
//	$mandatory = array('name', 'login', 'email', 'status', 'role');
	// тип пол€ ввода
//	$type['id'] = 'string';
//	$type['status'] = 'select_status';
//	$type['role'] = 'select_role';
//	$type['change_password'] = 'string';
//	$type['old_password'] = 'password';
//	$type['new_password'] = 'password';
//	$type['confirm_new_password'] = 'password';
//	$type['password'] = $type['password_confirm'] = 'password';

//	$caption['id'] = 'јйƒи';
//	$caption['login'] = 'Ћогин';
//	$caption['change_password'] = 'Change password:';

//	$check_pattern['icq'] = array('^[0-9]*$', 'Must be integer');
//	$check_pattern['email'] = array(EMAIL_PATTERN, ERROR_EMAIL_PATTERN);


///////////////////
	// восстанавливаем значени€ фильтра, сортировки, страницы
	load_stored_values($modul);

///////////////////
	if (empty($srt)) $srt='';
///////////////////
	$ar_usl[] = 'srt='.$srt;

///////////////////
	// дл€ сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// пол€ фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}

	// список (grid)
	function print_list($export='')
	{
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

			$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
			$rows[$j]['id'] = $r[0];
			$rows[$j++]['name'] = SaveQuotes($r[1]);
		}
		$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);

		global $navigation;
		$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');

		return $s;
	}



	// список полей в окне редактировани€
	function print_fields()
	{
		$res = include('print_fields.php');
		return $res;
	}

	// добавление/сохранение записи
	function save()
	{
		global $modul;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit, $edit_styles;
		global $elem_title, $class_title, $style_text;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		include ('save_init.php');

		if (post('refresh'))
		{
			if($group_name=='') $error['group_name']='Group name must be not empty<br>';
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
				$field_values["show_on_front"] = (isset($_POST["show_on_front"])==1) ? 1:0;

				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					$error['group_name'] = 'Group already exists';
				}
				else
				{
					if (post('save_add_more')) 
					{
						header ('Location: '.$modul.'.php?op=3&added='.$res);
						exit;
					} else if (post('save_continue')) {
						header ('Location: '.$modul.'.php?op=1&edit='.$res);
						exit;
					} else
						close_popup('yes');
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

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'nl_email_add',
				'ms_recipient_add',
				'send_letter',
				'mail'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v_nl_email',
				'nl_subscriber',
				'ms_status',
				'ms_mail'),
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

	switch($op) {
		default:
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
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