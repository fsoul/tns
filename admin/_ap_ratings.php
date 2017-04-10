<?
	$admin=true;

	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');

	$modul_title = 'Ratings';

	include('url_if_back.php');

	$popup_height = 600; 
       	$popup_scroll = 1; 

	if (!defined('ADMIN_MENU_ITEM_AP_RATINGS')) define('ADMIN_MENU_ITEM_AP_RATINGS', 'Access Panel Dictionaries/'.str_to_title($modul_title));

	//��������� ����� � ������������ op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_AP_RATINGS);
	// ������� ������ �����
	// �� ���� �������� ��� �������

	//Codding
	global $characterSet;
	$characterSet="utf-8";

	//��������� ���������� �� ��������� �� ���� �5 (��-���� 'date')
	global $click, $srt;
	if($click<0 && empty($srt))
	{
		$click = 5;
		$srt = 5;
	}

	// ��������� ������� ��-���������
	$from_unixtime = true;
	include('object_inits.php');

	// ��������� �������, ������������ �� ������������� ��-���������

	// ������ ������ (grid)
	//������ �������
//	$hidden = array('record_id', 'language');

//	$sort_disabled= Array('Image');
	// ������ ���� ������� � ������
 //	$size_filter['item_channel_id'] = 15;

//	$size['html_content'] = 3;
	// ������ ���� ������� � ������
	//$size_filter['id'] = 3;
	// ��� �������
//	$type_filter['status_of_news'] = 'select_news_status';
//	$type_filter['item_channel_id'] = 'select_channel_id';
//	$type_filter['item_pubDate'] = 'date';
//	$type_filter['Image'] = 'by_img';
//	$type_filter['status_of_news'] = 'select_news_status';
	// ������������
	//$align['id']='right';
	// ����� �������
	//$grid_col_style['default_page'] = 'width:5px';
	// ���������� ������ �������� � �����
	//$ar_grid_links['clients_id'] = '<a id="%1$s" href="'.EE_HTTP.'?t=tpl_preview&tpl_name=%2$s" target="_blank">open file</a>';
$sec_ind = array_search('ap_ratings_section',$fields)+1;
$ar_grid_links['ap_ratings_section'] = '<%%iif:%'.$sec_ind.'$s,0,Auto,<%%iif:%'.$sec_ind.'$s,1,News,<%%iif:%'.$sec_ind.'$s,2,Sports%%>%%>%%>';
	//Next 2 lines changed ID to NAME on print-list

//	$ar_grid_links_getfield["i_channel_id"]  = 'SELECT v.channel_id        FROM ( '.create_sql_view((int)GetField('SELECT channel_id FROM object WHERE name="Channels"    ')).' ) v  WHERE v.record_id=\'%'.(array_search('channel_id',$fields)+1).'$s\'';

//	$ar_grid_links_getfield["item_channel_id"] = 'SELECT v.channel_title FROM ( '.create_sql_view((int)GetField('SELECT id FROM object WHERE name="news_channels"')).' ) v  WHERE v.record_id=\'%'.(array_search('item_channel_id',$fields)+1).'$s\'';

//	$ar_grid_links["status_of_news"] = '<%%iif:0,%'.(array_search('status_of_news',$fields)+1).'$s,0 (Draft),<%%iif:1,%'.(array_search('status_of_news',$fields)+1).'$s,1 (Published),<%%iif:2,%'.(array_search('status_of_news',$fields)+1).'$s,2 (Archive)%%>%%>%%>'; // array_search('status_of_news',$fields)+1;
	
	// ������ ���� ��������������
	// ����� ������ ���� �����
	// ������ ����
//	$size['news_image'] = 40;
//	$size['gallery_id'] = 20;
	// �������� ������ ��� ������
	$readonly=array();
	// ����������� ��� ����������
//	$mandatory=array();
	// ��� ���� �����
//	$type['record_id'] = 'text';
//	$type['full_desc'] = 'textarea';
	
	// ��������������� �������� �������, ����������, ��������
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// ��� ���������� � sql-�������
	if ($op == 0) $order = getSortOrder();

	function get_gallery_select_list()
	{
		global $modul;

		// globalazing $option_value_test with needed ID of gallery for make some <option>-item with atribute "selected"
		global $gallery_id, $option_value_test;
		$option_value_test = $gallery_id;

		$sql = 'SELECT
				gallery.record_id	AS option_value,
				gallery.gallery_title	AS option_text
			FROM
				('.create_sql_view_by_name_for_fields('gallery_title, gallery_status', 'gallery').') gallery 
			WHERE
				gallery.gallery_status = "1"';

		
		$res = parse_sql_to_html($sql, 'templates/'.$modul.'/option');

		return $res;
	}

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
/*		global $sql, $object_id;

		$sql_temp = $sql;

		// SQL for GRID
		$sql = 'SELECT 
				record_id,
				item_title,
				item_link,
				item_description,
				item_pubDate,
				item_guid,
				item_channel_id,				
				IF(status_of_news=0,\'Draft\',IF(status_of_news=1,\'Published\',IF(status_of_news=2,\'Archive\',\'\')))	status_of_news,
				html_content,
				language
			 FROM
				('.create_sql_view($object_id).') v ';*/

		$output_grid = object_print_list($export);

//		$sql = $sql_temp;

		return $output_grid;
	}


	// ������ ����� � ���� ��������������
	function print_fields()
	{
		global $fields;

		//Sorting fields in edit-popup
		$edit_popup_order = array();

		$fields = sort_object_edit_fields_by_order_array($fields, $edit_popup_order);

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