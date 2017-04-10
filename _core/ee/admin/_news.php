<?
	$modul = basename(__FILE__, '.php');
//	$modul_title = $modul;
	$modul_title = 'News & Events';
//********************************************************************
	include_once('../lib.php');

	$url = 'Location: '.$modul.'.php?load_cookie=true&channel_id='.$channel_id;

	include('url_if_back.php');
	$popup_height = 640; 

	if (!defined('ADMIN_MENU_ITEM_NEWS')) define('ADMIN_MENU_ITEM_NEWS', 'News|50');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_NEWS);

	// главный список полей
	// по нему работают все функции
//	echo 'v'.$modul.($op!=0?'_edit':'_grid');

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихся от установленных по-умолчанию

	// только список (grid)
	//скрыть столбец
	//$hidden[1] = 0;
	$readonly = array("PublishedDate", "ExpiryDate", "SystemDate");
 	// размер поля фильтра в списке
	$size_filter['news_id'] = 4;
	$size_filter['status'] = 10;
	$size_filter['channel_id'] = 14;
	$size_filter['SystemDate'] = 17;
	$size_filter['ExpiryDate'] = 17;
	$size_filter['PublishedDate'] = 17;

	// тип фильтра
	// выравнивание
	$align['news_id']='right';
	$align['status']='center';
	$align['channel_id']='center';
	$align['SystemDate']='center';
	$align['ExpiryDate']='center';
	$align['PublishedDate']='center';

	// стиль столбца
	// оформление самого значения в гриде
//	$ar_grid_links['title'] = '<a href="'.EE_HTTP.'admin/'.$modul.'.php?op=1&admin_template=yes&edit=
//		%'.(array_search('news_id',$fields)+1).'$s">%'.(array_search('title',$fields)+1).'$s</a>';

	// только окно редактирования

	// стиль строки поля формы
	// размер поля
	$size['SystemDate'] = 12;
	$size['ExpiryDate'] = 12;
	$size['PublishedDate'] = 12;
	// доступно только для чтения

	// не обязательно для заполнения
	$mandatory=array('title','description','status','category','channel_id','SystemDate', 'ExpiryDate', 'PublishedDate');

	// тип поля ввода
	$type['news_id'] = "string";
	$type['description'] = "textarea";
	$type['status'] = "select_news_status";
	$type['show_on_home'] = "select_yes_no";
	$type['channel_id'] = "string";
	$type['SystemDate'] = "date";
	$type['ExpiryDate'] = "date";
	$type['PublishedDate'] = "date";	

	// восстанавливаем значения фильтра, сортировки, страницы
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// для сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// подписи к колонкам списка (grid-а)

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
		global $sql;
		global $modul;
		$filtered_news_view = '(SELECT * FROM v'.$modul.'_grid '.($GLOBALS["channel_id"]?'WHERE CHANNEL_ID = "'.$GLOBALS["channel_id"].'"':'').') as q';


		$sql = 'SELECT * from '.$filtered_news_view;
//		global $filter_channel_id;
//		$filter_channel_id = 1;
//		$filter_field[] =
//		global $where;
//		$where.=" AND channel_id='".$GLOBALS["channel_id"]."'";
		include('print_list_init_vars_apply_filter.php');
//		if ($GLOBALS["channel_id"])
//		{
//			$where.=" AND channel_id='".$GLOBALS["channel_id"]."'";
//		}

		$tot = getsql('count(*) from '.$filtered_news_view.$where, 0);

		if (ceil($tot/$MAX_ROWS_IN_ADMIN)<$page)
			$page=1;

//		if ($GLOBALS["channel_id"])
//		{
//			$sql.=" AND channel_id='".$GLOBALS["channel_id"]."'";
//		}

		if ($MAX_ROWS_IN_ADMIN > 0)
			$sql.= ' limit '.(($page-1)*$MAX_ROWS_IN_ADMIN).','.$MAX_ROWS_IN_ADMIN;
		else
			$MAX_ROWS_IN_ADMIN = $tot;

		$rs = viewsql($sql, 0 );

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
				$row_field[$i]['field_value'] = vsprintf($ar_grid_links[$fields[$i]], $r);
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

		$_POST["SystemDate"] = GetSQLDate($_POST["SystemDate"]);
		$_POST["ExpiryDate"] = GetSQLDate($_POST["ExpiryDate"]);
		$_POST["PublishedDate"] = GetSQLDate($_POST["PublishedDate"]);
				
		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);

		$error = array();

		// начальная инициализация при редактировании
		$info = array();
		if (!empty($edit))
		{
			GetNews($edit);
		}
		for ($i=0; $i<count($fields); $i++)
		{
			$field_name = $fields[$i];
			global $$field_name;

			// если это сохранение/добавление
			if (post('refresh'))
			{
				

				// инициализируем новыми значениями гл.пер-е
				$field_values[$field_name] = $$field_name = $_POST[$field_name];
				// проверяем обязательные поля
				if (in_array($fields[$i], $mandatory) &&
					trim($$field_name)=='')
				{
					$error[$field_name]=EMPTY_ERROR;
				}
			}
		}
		if (post('refresh'))
		{
			
			
				
			if (count($error)==0)
			{


				if (empty($edit)) // New object
				{
					$res = AddNews();
				}
				else
				{
					EditNews($edit);
				}
			
				if ($_POST["save_add_more"]){

				$s = 'Location: '.$modul.'.php?op=3&admin_template=yes&added='.$res;

				if ($_POST["channel_id"])
					$s.="&channel_id=".$_POST["channel_id"];
					header ($s);
					exit;
				}
				
				
				
				close_popup('yes');
			}
		}
		return parse($modul.'/edit');
	}

	// удаление
	function del()
	{
		global $del, $modul, $url;
		GetNews($del);
		global $channel_id;
		DeleteNews($del);
		header($url."&channel_id=".$channel_id);
	}
	function print_channel_info($channel_id)
	{
		global $modul;
		$channel_info = db_sql_fetch_assoc(ViewSQL("SELECT * FROM v_channel_edit WHERE channel_id='".$channel_id."'", 0));
		return parse_array_to_html(array(0=>$channel_info),"templates/".$modul."/channel_info");
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'AddNews',
				'GetNews',
				'mysql_query'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (
				'v_events_db'),
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
		case '0': echo parse($modul.'/list');break;
		case '1': echo save();break;
		case '2': del();break;
		case '3': echo save();break;
		case 'del_sel_items': del_selected_items($modul);echo parse($modul.'/list');break;			
		case 'rows_on_page':
			$url = 'Location: channel.php?load_cookie=true';
			rows_on_page();
		break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;
	}
?>