<?
	$modul = basename(__FILE__, '.php');
	$modul_title = 'Captcha Words';

	include_once('../lib.php');

	include('url_if_back.php');
	$popup_height = 640; 
	$popup_scroll = true;

	if (!defined('ADMIN_MENU_CAPTCHA')) define('ADMIN_MENU_CAPTCHA', 'Captcha|100/Captcha_Words');

	global $characterSet;
	$characterSet = "utf-8";
	//��������� ����� � ������������ op='self_test', op='menu_array' 

	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_CAPTCHA);

	$object_name = 'captcha';
	$object_id = Get_object_id_by_name($object_name);

	// ������� ������ �����
	// �� ���� �������� ��� �������
	
	// if $sql is defined before (lib.php, language_autoforwarding)
	if (isset($sql))
	{
		// - let it be defined for current object automatically
		unset($sql);
	}

        include('object_inits.php');

	// ��������� ������� ��-���������

	//������ �������
	$hidden = array('language');

        // ��� ���� �����
	$type['record_id'] = "string";	//The type of field 'record_id' must be always!

	// ��������������� �������� �������, ����������, ��������
	load_stored_values($modul);

	if(empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// ��� ���������� � sql-�������
	if ($op == 0) $order = getSortOrder();

	// ������� � �������� ������ (grid-�)

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
          	
	function print_list_images()
	{
		global $edit, $modul;
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
			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (),
			'db_funcs'  => array (),
			'dir_attributes' => array()
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
		case 'export_to_csv':
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.csv"' );
			echo parse('export_csv');
			break;
		case 'import_from_csv': echo import_object_from_csv(); break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': object_del_rows(); echo get_modul_list($modul); break;
	}

?>