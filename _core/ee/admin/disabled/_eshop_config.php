<?
	$modul = basename(__FILE__, '.php');
	$modul_type = '_config';
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!isset($op)) $op='0';
	include('url_if_back.php');
	if (!defined('ADMIN_MENU_ITEM_ESHOP_CONFIG')) define('ADMIN_MENU_ITEM_ESHOP_CONFIG', 'Administration/Configuration/Catalog');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_ESHOP_CONFIG . "/popup");

	$config_vars = array(
				array('field_name'=>'UniShopHost', 'field_title'=>'Catalog server site'),
				array('field_name'=>'UniShopSite', 'field_title'=>'Catalog server site prefix'),
				array('field_name'=>'SHOP_CODE', 'field_title'=>'Shop Code'),
				array('field_name'=>'ESHOP_CACHE_XML', 'field_title'=>'Use cache for catalog requests', 'type'=>'checkbox'),
				array('field_name'=>'is_can_buy', 'field_title'=>'Is buy interface enabled', 'type'=>'checkbox'));
	$error=array();

	//vdump(config_var('USE_CACHE'));

//********************************************************************
	function edit_config()
	{
		global $pageTitle, $modul, $modul_type, $config_vars, $error;
		$pageTitle = 'Catalog configuration';

		/*foreach ($config_vars as $k=>$v)
		{
			if (empty($config_vars[$k]['type'])) $config_vars[$k]['type'] = 'text';
			if (empty($config_vars[$k]['size'])) $config_vars[$k]['size'] = '50';
			if (empty($config_vars[$k]['field_title'])) $config_vars[$k]['field_title'] = str_to_title($config_vars[$k]['field_name']);
			$config_vars[$k]['readonly'] = '';
		}
		if (post('refresh'))
		{
			if (count($error)==0)
			{
				vdump($_POST);
				foreach ($config_vars as $k=>$v)
				{
					save_config_var($config_vars[$k]['field_name'], $_POST[$config_vars[$k]['field_name']]);
				}
				//header('Location: '.EE_ADMIN_URL.$modul.'.php');
				exit;
			}
		} else {
			foreach ($config_vars as $k=>$v)
			{
				global $$config_vars[$k]['field_name'];
				$$config_vars[$k]['field_name'] = config_var($config_vars[$k]['field_name']);
			}
		}
		return parse_array_to_html($config_vars,'templates/'.$modul_type.'/edit_modul_config_row'); */
		return include('print_edit_config.php');
	}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array ('call_remote'),
			'php_ini' => array (),
			'constants' => array (),
			'db_tables' => array (),
			'db_funcs'  => array (),

			'dir_exists' => array(
				EE_XML_PATH
			),

			'dir_attributes' => array(
				EE_XML_PATH => EE_DEFAULT_DIR_MODE
			)
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