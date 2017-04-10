<?
	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!isset($op)) $op='0';
	include('url_if_back.php');
	if (!defined('ADMIN_MENU_ITEM_CONFIG')) define('ADMIN_MENU_ITEM_CONFIG','Administration/Configuration/General');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER),ADMIN_MENU_ITEM_CONFIG . '/popup');

	$config_vars = array(

		array('field_name'=>'s_copyright', 'field_title'=>'Site Copyright'),
		array('field_name'=>'live', 'field_title'=>'Timeout for login users (in sec.)'),
		array('field_name'=>'MAX_CHARS', 'field_title'=>'Max chars in short description'),
		array('field_name'=>'MAX_ROWS_IN_ADMIN', 'field_title'=>'Max rows in lists'),
		array('field_name'=>'log_runsql', 'field_title'=>'Log UPDATE-queries', 'type'=>'checkbox'),
		array('field_name'=>'log_viewsql', 'field_title'=>'Log SELECT-queries', 'type'=>'checkbox'),

		array('field_name'=>'warnings_notices_max_count',	'field_title'=>'Limit of warnings to be sent'),
		array('field_name'=>'warnings_notices_max_period',	'field_title'=>'Number of time periods'),
		array('field_name'=>'warnings_notices_max_period_type',	'field_title'=>'Type of time period', 'type'=>'select_period_type'),

		array('field_name'=>'logfile_maxsize',		'field_title'=>'Maximal size of log file in bytes'),
		array('field_name'=>'logfile_stop_reset',	'field_title'=>'What to do if log file size reache logfile_maxsize', 'type'=>'select_logfile_stop_reset'),
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

		// trim possible 'www.'
		$www = 'www.';
		$domain_name = substr(EE_HTTP_HOST, (strpos(EE_HTTP_HOST, $www)===0 ? strlen($www) : 0));

		$nut_file_name1 = 'file_'.(md5($domain_name)).'_nut.html';
		$nut_file_name2 = 'file_'.(md5('www.'.$domain_name)).'_nut.html';

		$ar_self_check[$modul] = array (

			'php_functions' => array (),
			'php_ini' => array (),
			'constants' => array (),

			'file_exists' => array(
				$nut_file_name1,
				$nut_file_name2,
			),

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