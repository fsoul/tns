<?
	$admin=true;

	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');

	$modul_title = str_replace(' ','',str_to_title($modul));

	include('url_if_back.php');

	$popup_height = 395; 

	if (!defined('ADMIN_MENU_ITEM_NEWS_MAPPING')) define('ADMIN_MENU_ITEM_NEWS_MAPPING', 'News/'.str_to_title($modul));

	//��������� ����� � ������������ op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_NEWS_MAPPING);
	// ������� ������ �����
	// �� ���� �������� ��� �������

	// ��������� ������� ��-���������

	include('object_inits.php');

	// ��������� �������, ������������ �� ������������� ��-���������

	// ������ ������ (grid)
	//������ �������
	$hidden = array('record_id', 'language', 'channel_link', 'channel_generator' , 'channel_docs', 'channel_managingEditor', 'channel_webMaster', 'channel_lastBuildDate', ''
);
	// ������ ���� ������� � ������
	$size_filter['channel_language'] = 10;
	
	

	// ��� �������



      	$type_filter['channel'] = 'select_channel_id';
      	$type_filter['type_of_export'] = 'select_export_id';
//	$type_filter['channel'] = 'select_channel_id';
	//$type_filter['default_page' = 'select_Y';

	// ������������
	//$align['id']='right';
	// ����� �������
	//$grid_col_style['default_page'] = 'width:5px';
	// ���������� ������ �������� � �����
	//$ar_grid_links['clients_id'] = '<a id="%1$s" href="'.EE_HTTP.'?t=tpl_preview&tpl_name=%2$s" target="_blank">open file</a>';
	
	//Next 2 lines changed ID to NAME on print-list

        $ar_grid_links_getfield["channel"] = 'SELECT concat("(", v.record_id, ") ", v.channel_title) FROM ( '.create_sql_view((int)GetField('SELECT id FROM object WHERE name="news_channels"')).' ) v  WHERE v.record_id=\'%'.(array_search('channel',$fields)+1).'$s\'';
	$ar_grid_links_getfield["type_of_export"] = 'SELECT concat("(", v.record_id, ") ", v.name) FROM ( '.create_sql_view((int)GetField('SELECT id FROM object WHERE name="news_export"')).' ) v  WHERE v.record_id=\'%'.(array_search('type_of_export',$fields)+1).'$s\'';
	// ������ ���� ��������������
	// ����� ������ ���� �����
	// ������ ����
	// �������� ������ ��� ������
	$readonly=array();
	// ����������� ��� ����������
	$mandatory=array('title', 'channel', 'type_of_export');
	// ��� ���� �����
	$type['record_id'] = "string";
	$type['id'] = "string";



        $type['type_of_export'] = "select_from_object_channel_id";
	$type['channel'] = 'select_from_object_export_id';
	$check_pattern['name'] = array('^[a-zA-Z_ 0-9]*$', 'Illegal characters in name');

	// ��������������� �������� �������, ����������, ��������
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// ��� ���������� � sql-�������
	if ($op == 0) $order = getSortOrder();

	// ���� ��
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// ���� ������� � grid-�
	function print_filters()
	{
		return include('print_filters.php');
	}

	// ������ (grid)
	function print_list($export='')
	{
		return object_print_list($export);
	}


	// ������ ����� � ���� ��������������
	function print_fields()
	{
		return include('print_fields.php');
	}

	// ����������/���������� ������
	function save($obj_id)
	{
		return object_save($obj_id);
	}

	// ��������
	function del()
	{
		return object_del();
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (
				'f_add_object_modul',
				'f_upd_object_modul',
				'f_del_object_modul',
				'mysql_query'),
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
		case '0': echo parse($modul.'/list');break;
		case '1': echo save($object_id);break;
		case '2': del();break;
		case '3': echo save($object_id);break;
		case 'del_sel_items': del_selected_items('object');echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': object_del_rows(); echo get_modul_list($modul); break;
	}
?>