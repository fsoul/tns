<?
	$admin=true;

	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');


       	$modul_title = $modul;
	include('url_if_back.php');

	$popup_height = 395; 

	$popup_scroll = 1; 

	if (!defined('ADMIN_MENU_ITEM_NEWS_CHANNELS')) define('ADMIN_MENU_ITEM_NEWS_CHANNELS', 'News|50/'.str_to_title($modul));

	//��������� ����� � ������������ op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_NEWS_CHANNELS);

	// ������� ������ �����
	// �� ���� �������� ��� �������

	// ��������� ������� ��-���������

	include('object_inits.php');

	// ��������� �������, ������������ �� ������������� ��-���������

	// ������ ������ (grid)
	//������ �������
	$caption['record_id'] = 'Channel id';
	$hidden = array('channel_description', 'language', 'channel_generator' , 'channel_docs', 'channel_managingEditor', 'channel_webMaster', 'channel_lastBuildDate', ''
);
	// ������ ���� ������� � ������
	$size_filter['channel_language'] = 10;
	
	

	// ��� �������




	//$type_filter['default_page' = 'select_Y';
	$type_filter['channel_pubDate'] = "by_date";
	// ������������
	//$align['id']='right';
	// ����� �������
	//$grid_col_style['default_page'] = 'width:5px';
	// ���������� ������ �������� � �����
	//$ar_grid_links['clients_id'] = '<a id="%1$s" href="'.EE_HTTP.'?t=tpl_preview&tpl_name=%2$s" target="_blank">open file</a>';
	
	//Next 2 lines changed ID to NAME on print-list

//	$ar_grid_links_getfield["works_id"]  = 'SELECT v.name        FROM ( '.create_sql_view((int)GetField('SELECT id FROM object WHERE name="Works"    ')).' ) v  WHERE v.record_id=\'%'.(array_search('works_id',$fields)+1).'$s\'';

	// ������ ���� ��������������
	// ����� ������ ���� �����
	// ������ ����
	// �������� ������ ��� ������
	$readonly=array();
	// ����������� ��� ����������
	$mandatory=array('channel_title');
	// ��� ���� �����
	$type['record_id'] = "string";
	$type['id'] = "string";
	    $type['channel_language'] = "select_language";
	$type['status_id'] = "select_channel_status";



          

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

	function del_sel_items($object)
	{
		if(!empty($_POST['selected_items']))
		{
			//non deletable items
			$non_deletable = check_if_in_mapping('channel','',0);
			$_POST['selected_items'] = array_diff($_POST['selected_items'], $non_deletable);
		}
		return del_selected_items($object);
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
		case 'del_sel_items': del_sel_items('object');echo parse($modul.'/list');break;			
		case 'rows_on_page': rows_on_page(); break;
		case 'self_test': echo print_self_test(); break;                                                
		case 'export_excel': header( 'Content-Type: application/vnd.ms-excel' );
					header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
					echo parse('export_excel');
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': object_del_rows(); echo get_modul_list($modul); break;
	}
?>