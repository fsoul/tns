<?
	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!isset($op)) $op='0';

	if (!defined('ADMIN_MENU_ITEM_ERROR_HANDLE')) define('ADMIN_MENU_ITEM_ERROR_HANDLE','Administration/Configuration/Error Handling/popup');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_ERROR_HANDLE);

	$config_vars = array(
				array('field_name'=>'err_title', 'field_title'=>'Error type \\ Handling type', 'type' => 'string3')
				);
	$error=array();

//********************************************************************
	function edit_config()
	{
		global $pageTitle, $modul, $config_vars, $error, $errortype, $errorcodes;
		$pageTitle = 'Error handling';
		$error_handle = unserialize(config_var('error_handle'));
               

		foreach ($errortype as $k=>$v)
		{
			$config_vars[$k]['type'] = 'checkbox3';
			$config_vars[$k]['field_name'] = 'error_'.$k;
			$config_vars[$k]['size'] = '50';
			$config_vars[$k]['field_title'] = $v.' ('.$errorcodes[$k].')';
			$config_vars[$k]['readonly'] = '';
		}
		if (post('refresh'))
		{
			if (count($error)==0)
			{
				foreach ($errortype as $k=>$v)
				{
						for($i=1; $i<4; $i++)
						{
							$var_name = 'error_'.$k.'_'.$i;
							$error_handle[$i][$k] = ($_POST[$var_name]?'1':'0');
						}
				}

				save_config_var('error_handle', serialize($error_handle));
//				header('Location: '.EE_ADMIN_URL.$modul.'.php');
				echo '<script type="text/javascript">window.parent.closePopup();</script>';
				exit;
			}
		} else {
			foreach($errortype as $k=>$v)
			{
				for($i=1; $i<4; $i++)
				{
					$var_name = 'error_'.$k.'_'.$i;
					global $$var_name;
					$$var_name = $error_handle[$i][$k];
				}
			}
		}
//		print_r($config_vars);
		$config_vars = renumber_array($config_vars);
		return parse_array_to_html($config_vars,'templates/'.$modul.'/edit_modul_config_row');		
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