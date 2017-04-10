<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_ERROR_LOG')) define('ADMIN_MENU_ITEM_ERROR_LOG','Administration/Logs/Errors Log');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR),ADMIN_MENU_ITEM_ERROR_LOG);
	
	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array ();

		return parse_self_test($ar_self_check);
	}

	if($op == 'self_test')
	{
		echo print_self_test();
	}

	header("HTTP/1.1 200 OK");
	header("Status: 200 OK");
	header ('content-type: text/xml');

	echo '<error_log>'.@file_get_contents(EE_ERROR_LOG_PATH).'</error_log>';
?>