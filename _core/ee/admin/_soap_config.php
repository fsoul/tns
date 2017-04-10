<?
	$modul = basename(__FILE__, '.php');
	$modul_type = '_config';
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!isset($op)) $op='0';
	include('url_if_back.php');

	if (!defined('ADMIN_MENU_ITEM_SOAP_CONFIG')) define('ADMIN_MENU_ITEM_SOAP_CONFIG', 'Administration/Configuration/SOAP');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_SOAP_CONFIG.'/popup');

	$config_vars = array(
				array('field_name'=>'soap_server', 'field_title'=>'SOAP server site'),
				array('field_name'=>'account_aliase_id', 'field_title'=>'Account aliase ID'),
				array('field_name'=>'FRONTSITE_CODE', 'field_title'=>'Client site code'));
	$error=array();

//********************************************************************
	function edit_config()
	{
		global $pageTitle, $modul, $modul_type, $config_vars, $error;
		$pageTitle = SOAP_PAGE_TITLE;

		/*foreach ($config_vars as $k=>$v)
		{
			if (empty($config_vars[$k]['type'])) $config_vars[$k]['type'] = 'text';
			if (empty($config_vars[$k]['size'])) $config_vars[$k]['size'] = '50';
			if (empty($config_vars[$k]['field_title'])) $config_vars[$k]['field_title'] = str_to_title($config_vars[$k]['field_name']);
			$config_vars[$k]['readonly'] = '';
		}
		if (post('refresh') && post('save'))
		{
			if (count($error)==0)
			{
				foreach ($config_vars as $k=>$v)
				{
					save_config_var($config_vars[$k]['field_name'], $_POST[$config_vars[$k]['field_name']]);
				}
				header('Location: '.EE_ADMIN_URL.$modul.'.php');
				exit;
			}
		}
		else
		{
			foreach ($config_vars as $k=>$v)
			{
				global $$config_vars[$k]['field_name'];
				$$config_vars[$k]['field_name'] = config_var($config_vars[$k]['field_name']);
			}
		}
		return parse_array_to_html($config_vars,'templates/'.$modul_type.'/edit_modul_config_row');		 */
		return include('print_edit_config.php');
	}

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			//'php_functions' => array ('soap_call'),
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