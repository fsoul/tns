<?

	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'Survey List';
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');
	$popup_height = 340; 
	$popup_scroll = true;

	global $characterSet;
	$characterSet="utf-8";

	if (!defined('ADMIN_MENU_SURVEY_RESULT')) define('ADMIN_MENU_SURVEY_RESULT', 'Resources/Surveys/Manage');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 

	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_SURVEY_RESULT);

	$object_id = Get_object_id_by_name('survey');

	// главный список полей
	// по нему работают все функции
	
        include('object_inits.php');

	// установка свойств по-умолчанию

	$ar_grid_links["question_id"] = '<%%get_field_text_by_id:question,question,%'.(array_search('question_id',$fields)+1).'$s%%>';
	$ar_grid_links["answer_id"] = '<%%get_field_text_by_id:answer,answer,%'.(array_search('answer_id',$fields)+1).'$s%%>';
	$ar_grid_links["user_id"] = '<a onmouseover="ddrivetip(\'<%%get_user_info:%'.(array_search('user_id',$fields)+1).'$s%%>\');" onmouseout="hideddrivetip();" href="#"><%%get_user_login_by_id:%'.(array_search('user_id',$fields)+1).'$s%%></a>';  //array_search('user_id',$fields);


	//скрыть столбец
	$hidden = array('language');

	$size['question_id']='30';
	$size['answer_id']='30';

        // тип поля ввода
	$type['record_id'] = "string";	//The type of field 'record_id' must be always!
	$type['answer_id'] = "select_from_object";
	$type['question_id'] = "select_from_object";
	$type['date'] = "string";
	$type['ip'] = "string";
	$type['answer_language'] = "string";
	$type['user_id'] = "user_login";

        $sort_disabled = array('question_id', 'answer_id');

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();


	function get_field_text_by_id($object_name, $field_name, $question_id)
	{
		$sql = 'SELECT t.'.$field_name.'
			FROM ('.create_sql_view_by_name($object_name).') t
			WHERE t.record_id='.sqlValue($question_id);

		return getField($sql);
	}

	// подписи к колонкам списка (grid-а)

	function get_user_info($id)
	{
		$res = '';
		$sql = 'SELECT * FROM users WHERE id ='.sqlValue($id);
		$sql_res = viewSQL($sql);
		$usr = db_sql_fetch_assoc($sql_res);
		$res  = 'id: <b>'.$usr['id'].'</b><br />';
		$res .= 'Login: <b>'.$usr['login'].'</b><br />';
		$res .= 'Name: <b>'.$usr['name'].'</b><br />';
		$res .= 'Role: <b>'.$usr['status'].'</b><br />';
		$res .= 'Last login IP: <b>'.$usr['ip'].'</b><br />';
		$res .= 'Last login Date: <b>'.date('Y-m-d H:i:s', $usr['last_datetime']).'</b>';

		return $res;
	}

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
		return object_print_list($export);
	}


	// список полей в окне редактирования
	function print_fields()
	{
		return include('print_fields.php');
	}
 

	function save($object_id)
	{       
		return object_save($object_id);
	}

	function del($del_gall_dir = null)
	{
		return object_del();		
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
						),
			'php_ini' => array (),
			'constants' => array (
				),
			'db_funcs'  => array (),
			'dir_attributes' => array(
						)
		);

		return parse_self_test($ar_self_check);
	}
	function get_modul_list($modul)
	{
		return get_object_yui_list($modul);
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
		case '1': echo save($object_id);break;
		case '2': del();break;
		case '3': echo save($object_id);break;
		case 'del_sel_items': del('registered_users');del_selected_items('object');echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
					break;
		case 'export_to_csv':
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.csv"' );
			echo parse('export_csv');
			break;
//		case 'import_from_csv': echo import_object_from_csv(); break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': object_del_rows(); echo get_modul_list($modul); break;
	}

?>