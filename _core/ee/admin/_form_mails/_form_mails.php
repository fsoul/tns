<?
	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');

	//$modul_title = str_replace(' ','',str_to_title($modul));
	$modul_title = 'Form mails';

	include('url_if_back.php');

	$popup_height = 385;

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), 'Administration/'.str_to_title($modul));
	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	include('object_inits.php');//еще используется require ('set_default_grid_properties.php');
	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	$hidden = array('record_id', 'language');
	// размер поля фильтра в списке
	$size_filter['record_id'] = 5;
	//$size_filter['summary'] = 18;
	
	$caption['serialized'] = 'Form content';
	$caption['user_name'] = 'User info';
	$caption['form_id'] = 'Form name';
	
	// тип фильтра
	//$type_filter['id'] = "select_client";
	/////$type_filter['types_id'] = "select_type";
	/////$type_filter['work_date'] = "by_date";
	// выравнивание
	//$align['summary']='center';
	$align['serialized']='center';
	// стиль столбца
	
	// оформление самого значения в гриде
	$form_name_sql = 'SELECT `form_name` FROM ('.create_sql_view_by_name('formbuilder').') AS `v` WHERE `record_id`=\'%'.(array_search('form_id',$fields)+1).'$s\' LIMIT 1';
	$ar_grid_links_getfield['form_id'] = $form_name_sql;
	
	$ar_grid_links['serialized'] = '<a href="javascript:openPopup(\'_form_mails/form_mails_summary.php?op=1&show=%'.(array_search('record_id',$fields)+1).'$s%\&admin_template=yes\',400,385,1)"><img src="'.EE_HTTP.'img/menu/mailing.gif" alt="Show" align="top" border="0" height="16" width="16"></a>';
	$size_filter['serialized'] = 15;
	
	$ar_grid_links['user_name'] = '<a href="javascript:openPopup(\'_form_mails/form_mails_summary.php?op=2&show=<%%getfield:SELECT id FROM users WHERE id=\'%'.(array_search('user_name',$fields)+1).'$s\' LIMIT 0\,1%%>&admin_template=yes\',400,160,0)"><%%getfield:SELECT login FROM users WHERE id=\'%'.(array_search('user_name',$fields)+1).'$s\' LIMIT 0\,1%%></a>';
	
	// только окно редактирования
	// стиль строки поля формы
	// размер поля
	// доступно только для чтения
	$readonly=array('form_id', 'user_name', 'serialized');
	// обязательно для заполнения
	$mandatory=array('form_id', 'date', 'ip', 'email');
	// тип поля ввода
	//без этого не будут находится шаблоны для обработки типов полей формы
	//т.к. шаблон edit_fields_default уже не существует в природе
	$type['record_id'] = "string";
	$type['form_name'] = "form_name";
	$type['ip'] = "text";
	$type['date'] = "text";
	$type['email'] = "text";
	$type['serialized'] = "serialized";//html
	$type['user_name'] = "user_name";

	$type_filter['form_id'] = "select_form_name";
	$type_filter['serialized'] = "empty";

	$sort_disabled = array('serialized');

	$filter_function['user_name'] = "(SELECT login FROM users WHERE id = %s)";

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	$srt = -3;//По какому полю сортируем
	
	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	//unset($sort);
	//$sort[1] = 'form_name';
	
	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();
	
//	msg($order); exit;

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
		global $serialized;
		$serialized = get_form_attr(0, 0);

		return include('print_fields.php');
	}
	
	// добавление/сохранение записи
	function save()
	{
		global $object_id;
		return object_save($object_id);
	}

	// удаление
	function del()
	{
		return object_del();
	}
	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (),
			'db_funcs'  => array ()
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
		case '0': echo parse($modul.'/list'); break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'del_sel_items': del_selected_items('object'); echo parse($modul.'/list'); break;
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;

		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows('object'); echo get_modul_list($modul); break;
	}
?>