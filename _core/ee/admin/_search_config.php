<?
	$modul=basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!isset($op)) $op='0';

	if (!defined('ADMIN_MENU_ITEM_SEARCH_CONFIG')) define('ADMIN_MENU_ITEM_SEARCH_CONFIG', 'Administration/Configuration/Search');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_SEARCH_CONFIG .'/popup');

	include('url_if_back.php');

	if(!isset($mc)) $mc=$MAX_CHARS;
	if(!isset($mr)) $mr=$MAX_ROWS_IN_ADMIN;
	if(!isset($clive)) $clive=$live;
	if(!isset($dl)) $dl=$default_language;
	$error=array();

	$config_fields = array("search_enable_search_for_website","search_exclude_html_tags","search_page_name","search_rate_page_name","search_page_title","search_rate_page_title","search_page_keywords","search_rate_page_keywords","search_user_content","search_rate_user_content","search_page_content","search_rate_page_content","search_media_library","search_rate_media_library","search_show_page_name","search_max_chars_page_name","search_show_page_url","search_max_chars_page_url","search_show_page_keywords","search_max_chars_page_keywords","search_show_page_content","search_max_chars_page_content","search_minimal_characters_to_search");
	$pageTitle = str_to_title($modul.' configuration');
	if(!empty($save))
	{
		foreach($config_fields as $key=>$value)
		{
			if (!isset($_POST[$value]))
			{
				$_POST[$value] = 0;
			}
		}
//	print_r($_POST);

		foreach ($_POST as $key=>$val)
		{
			if (strpos($key,"search_")===0)	//если начинается с search_
			{
				save_config_var($key, $val);
			}
		}
	    header('Location: '.$modul.'.php');
	    exit;
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

//********************************************************************
	switch ($op)
	{
		default:
		case '0': echo parse($modul.'/list');break;
		case 'self_test': echo print_self_test(); break;
	}
?>