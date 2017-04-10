<?
	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!isset($op)) $op='0';
	include('url_if_back.php');
	if (!defined('ADMIN_MENU_ITEM_SEARCH_ENGINE_LIST')) define('ADMIN_MENU_ITEM_SEARCH_ENGINE_LIST','Administration/Configuration/Search Engine List');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_SEARCH_ENGINE_LIST . '/popup');

	$config_vars = array(
				array('field_name'=>'search_engine_list', 'field_title'=>'Search Engine List', 'type'=>'textarea')
				);
	$error=array();

//********************************************************************
	function edit_config()
	{
		global $pageTitle, $modul, $config_vars, $error;
		$pageTitle = 'General configuration';

		return include('print_edit_config.php');
	}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (),
			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}

//*****************************************************************
	switch ($op)
	{
		default:
		case '0': echo edit_config(); break;
		case 'self_test': echo print_self_test(); break;
	}

?>