<?
	$modul = basename(__FILE__, '.php');
	$modul_title = 'Subscribers';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 450; 

	if (!defined('ADMIN_MENU_ITEM_NL_SUBSCRIBERS')) define('ADMIN_MENU_ITEM_NL_SUBSCRIBERS', 'Mailing/Subscribers');

	//провер€ем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_NL_SUBSCRIBERS);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихс€ от установленных по-умолчанию
	if ($click==-1) { $srt = $click = 8; }
	// только список (grid)
	//скрыть столбец
//	$hidden = array('id');
 	// размер пол€ фильтра в списке
	$size_filter['id'] = 3;
	$size_filter['language'] = 10;
	$size_filter['ip_address'] = 10;
	$size_filter['reg_date'] = 20;
	// тип фильтра
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
	$mandatory = array('email');
	// тип пол€ ввода
	$type['id'] = 'string';
	$type['ip_address'] = 'string';
	$type['reg_date'] = 'string';
	$type['last_send'] = 'string';
	$type['status'] = 'select_status';
	$type['group_name'] = 'select_group';
	$type['language'] = 'select_language';
	
	$caption['reg_date'] = 'Date of registration';
	$caption['last_send'] = 'Date of last send';

	$type_filter['language'] = 'select_distinct';

//	$caption['id'] = 'јйƒи';
//	$caption['login'] = 'Ћогин';
//	$caption['change_password'] = 'Change password:';



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


	function print_fields()
	{
		return include('print_fields.php');
	}


        function edit() {
                global $b_color, $modul, $edit, $ftpServer, $httpServer, $httpPrefix, $imgPath;
                global $pageTitle, $error;
                global $modul;

                $pageTitle='Edit Subscriber';
                $error=array();
                $sql='select * from nl_subscriber where id='.$edit;
                $info=db_sql_fetch_assoc(viewsql($sql, 0));
                if(post('refresh')) {
			foreach ($info as $var=>$val) {
				global $$var;
		                $$var = $_POST[$var];
				$info[$var]=$$var;
			}
			reset($info);
			if($nl_group_id=='') $error['group_name']='Group must be not empty<br>';
			if($status === '') $error['status']='Status must be not empty<br>';
			if($email=='') $error['email']='Email must be not empty<br>';
			if($language=='') $error['language']='Language must be not empty<br>';
			if(count($error)==0) {
				if (($error['id'] = nl_subscriber_edit ($id, $email, $nl_group_id, $status, $first_name, $sur_name, $ip_address)) > 0)
//	                                header('Location: '.$modul.'.php?load_cookie=true');
					close_popup('yes');
                        }
                } else {
			foreach ($info as $var=>$val) {
				global $$var;
		                $$var = $val;
			}
			reset($info);
                }
                return parse($modul.'/edit');
        }
        function add() {
                global $_POST, $b_color, $modul, $ftpServer, $httpPrefix, $imgPath;
                global $pageTitle, $error;
                global $modul;
                $pageTitle='Add Subscriber';
                $error=array();
                $sql = 'select * from nl_subscriber where 1=0';

		$rs = viewsql($sql, 0);
		for ($i=0; $i<db_sql_num_fields($rs); $i++) {
			$ff = mysql_fetch_field($rs, $i);
			$field_name = $ff->name;
			global $$field_name;
			//echo $field_name."=".$$field_name." <br>";
			if(post('refresh'))
			$$field_name=post($field_name);
			else
			if (strpos($field_name, '_id')) $$field_name = 0;
			else $$field_name = '';
		} 
		if(post('refresh')) {

			if($nl_group_id=='') $error['group_name']='Group must be not empty<br>';
			if($email=='') $error['email']='Email must be not empty<br>';
			if($status === '') $error['status']='Status must be not empty<br>';			
			if(count($error)==0) 
			{
				$res = nl_subscriber_add($email, $nl_group_id, $status, $first_name, $sur_name, '');
				if ($res < 0)
				{
					$error['email'] = 'Such email already exists';
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
		return parse($modul.'/edit');
        }

	function del() 
	{
		global $del;
		global $modul;
		nl_subscriber_delete($del);
		header('Location: '.$modul.'.php?load_cookie=true');
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
					'email',
					'first&nbsp;name',
					'sur&nbsp;name'
				);
				ini_set('auto_detect_line_endings', true);
				$ar_rows = file($csv_file_name);
				
				foreach($ar_rows as $k=>$v) $ar_rows[$k] = strtolower(trim(html_entity_decode($v)));
				$ar_field_names = explode(EE_DEFAULT_CSV_SEPARATOR, $ar_rows[0]);
				foreach($ar_field_names as $k=>$v) $ar_field_names[$k] = trim($v,'"');
				for ($i=0; $i<count($ar_model); $i++)
				{
					if (!in_array(html_entity_decode($ar_model[$i]), $ar_field_names))
					{
						$error['csv_file'] = 'Required field "'.$ar_model[$i].'" is absent';
						break;
					}
				}
				$nl_group_id = $_POST['nl_group_id'];
				if (empty($nl_group_id)) $error['csv_file'] = 'Please select group';
				if (count($error)==0)
				{
					$upd = 0;
					for ($i=1; $i<count($ar_rows); $i++)
					{
						$ar_field_values = explode(EE_DEFAULT_CSV_SEPARATOR, $ar_rows[$i]);
						vdump($ar_field_values);
						foreach($ar_field_values as $k=>$v) $ar_field_values[$k] = trim($v,'"');
						$res = nl_subscriber_add(
							$ar_field_values[array_search('email',$ar_field_names)], 
							$nl_group_id, 
							SUBSCRIBE_CONFIRM, 
							$ar_field_values[array_search(html_entity_decode('first&nbsp;name'),$ar_field_names)], 
							$ar_field_values[array_search(html_entity_decode('sur&nbsp;name'),$ar_field_names)],
							''
						);
						if ($res > 0) $upd+=1;
					}
					$s = array();
					$s[] = 'import success';
					$s[] = $upd.' subscribers added';
					if (count($ar_rows)-$upd > 1) $s[] = (count($ar_rows)-$upd-1).' subscribers not added (already exists)';
					$error['csv_file'] = implode('<br>', $s);
				}
			}
		}

		return parse_popup($modul.'/csv_import');
	}
	
	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'nl_subscriber_add'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'nl_group',
				'nl_subscriber',
				'nl_subscriber_status'),
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
		case '1': echo edit();break;
		case '2': del();break;
		case '3': echo add();break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'import_from_csv': echo import_from_csv(); break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel'); break;
		case 'export_to_csv': header( 'Content-Type: application/csv' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.csv"' );
					echo parse('export_csv'); break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>