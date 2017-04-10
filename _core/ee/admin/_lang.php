<?


	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$config_vars = array(
				array('field_name'=>'language_autoforwarding', 'field_title'=>'Use language autoforwarding?', 'type'=>'checkbox'),

				array('field_name'=>'absent_browser_language_autoforwarding', 'field_title'=>'Use language autoforwarding if browser language absent in CMS?', 'type'=>'i_lang_checkbox')
			    );

	if (!defined('ADMIN_MENU_ITEM_LANG')) define('ADMIN_MENU_ITEM_LANG', 'Administration/Language');

	//провер€ем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_LANG);

	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихс€ от установленных по-умолчанию
	//
	// только список (grid)
	//скрыть столбец
	$hidden = array('paypal_lang');
 	// размер пол€ фильтра в списке
	$size_filter['language_code'] = 3;
	// тип фильтра
	$type_filter['default_language'] = 'select_Y';
	$type_filter['status'] = 'select_status';
	// выравнивание
//	$align['id']='right';
//	$valign['id']='bottom';
	// стиль столбца
//	$grid_col_style['id'] = 'display:none';
	$grid_col_style['default_language'] = 'width:5px';
	// оформление самого значени€ в гриде
//	$ar_grid_links['status'] = '%'.(array_search('status',$fields)+1).'$s';
	//
	// форма редактировани€ записи
	// стиль строки пол€ формы
//	$form_row_style['password']='display:none';
	// размер пол€
//	$size['login'] = '100';
	// доступно только дл€ чтени€
//	$readonly = array('name');
	// об€зательны дл€ заполнени€
	$mandatory = array('language_name', 'l_encode');
	// тип пол€ ввода
	$type['id'] = 'lang_code';

	$type['status'] = 'select_status';
	$type['is_default'] = "checkbox";
	$type['language_link_title'] = "html";

	// рег.выр-е дл€ проверки пол€ при сохр-нии и соотв-е сообщ-е об ошибке
	$check_pattern['id'] = array('^[A-Z][A-Z]$', 'Must be 2 upper case letters');
//	$check_pattern['language_name'] = array('^[0-9][0-9]$');
	$check_pattern['paypal_lang'] = $check_pattern['id'];

	
	$caption['l_encode']='Encoding';
	$caption['id']='Language Code';
	// восстанавливаем значени€ фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// дл€ сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();




	// подпись в списке (grid) и в поле формы
//	$caption['id'] = 'јйƒи';
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


	// список полей в окне редактировани€
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
		global $change_pass;
		global $email, $login, $newpassword;
		global $check_pattern;
		
		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);
		include ('save_init.php');

		if (post('refresh'))
		{
			if (empty($_POST['status']) && !empty($_POST['is_default'])) $error['status'] = 'Default language cannot be disabled.';
			if (empty($_POST['is_default']) && getField('SELECT default_language FROM v_language WHERE language_name = '.sqlValue($_POST['language_name'])))
				$error['status'] = 'You must choose another default language';
			if (count($error)==0)
			{
				if (isset($_POST['id_key']))
				{
					$field_values['key'] = $_POST['id_key'];
				}		

				if (empty($edit)) // New object
				{
//					unset($field_values['language_code']);
					$db_function = 'f_add'.$modul;
				}
				else
				{
					$db_function = 'f_upd'.$modul;
				}

				$res = RunNonSQLFunction($db_function, $field_values);

				if ($res < 0)
				{
					switch($res)
					{
						case -1:
						$error['id'] = 'Language with this Language Code already exists';
						break;

						case -2:
						$error['language_name'] = 'Language with this Language Name already exists';
						break;

						case -3:
						$error['language_url'] = 'Language with this Language URL already exists';
						break;

						case -4:
						$error['id'] = 'DataBase error '.db_sql_error();
						break;

						default:
						$error['id'] = 'DataBase error '.$res;
					}
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
				'f_del'.$modul),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v'.$modul.'_grid',
				'v'.$modul.'_edit'),
			'db_funcs'  => array (),
			'custom_query' => array(
				array('query'=>'SELECT COUNT(*) FROM v_language WHERE default_language="1"', 'result' => '1', 'message'=>'1 language must be set to default')
			)

		);

		return parse_self_test($ar_self_check);
	}
	
	function edit_config()
	{
		if (post('refresh'))			 
		{
			if (config_var('use_draft_content') != $_POST['use_draft_content'])
			{
				if ($_POST['use_draft_content'] == '1')
					revert_all_cms();
				else   	
					publish_all_cms();
			}

			if (post('open_url') && post('absent_browser_language_autoforwarding'))
			{
				$dredir_url['link'] = post('f_url_text');
				$dredir_url['link_type'] = 'url';
			}
			else if (post('open_sat_page') && post('absent_browser_language_autoforwarding'))
			{
				$dredir_url['link'] = post('satelit');
				$dredir_url['link_type'] = 'sat_page';
			}
			else
			{
				$dredir_url = false;
			}
			
			save_config_var('abesent_browser_lang_aforward_target_url', ($dredir_url ? serialize($dredir_url) : ''));
		}

		prepare_default_autoforwarding_url();

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

	function prepare_default_autoforwarding_url()
	{
		global $af_lang_link_type, $af_lang_link;

		$arr = unserialize(config_var('abesent_browser_lang_aforward_target_url'));

		$af_lang_link_type = $arr['link_type'];
		$af_lang_link = $arr['link'];
	}

//********************************************************************

	switch ($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'config': echo edit_config(); break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
	}
?>