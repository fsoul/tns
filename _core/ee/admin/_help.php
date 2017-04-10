<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');

	include('url_if_back.php');

	$popup_height = 500; 
	
	if ($op !== 'reset_password' && $op !== 'change_reset_pass')

	if (!defined('ADMIN_MENU_ITEM_HELP')) define('ADMIN_MENU_ITEM_HELP', 'Administration/Help');

	//проверяем права и обрабатываем op='self_test', op='menu_array' 
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_HELP);

	// главный список полей
	// по нему работают все функции


	function print_captions()
	{
		return '';
	}

	function print_filters()
	{
		return '';
	}

	function print_list()
	{
		global $path, $helpDir, $helpHttp;

		$ar_regs = $ar_help = $ar_help_files = array();
vdump(EE_PATH.EE_HELP_DIR, 'EE_PATH.EE_HELP_DIR');
		$ar_help_files = dir_to_array(EE_CORE_PATH.EE_HELP_DIR, ".html$");
vdump($ar_help_files, '$ar_help_files');

		for($i=0; $i<count($ar_help_files); $i++)
		{
			if (preg_match ('/([a-zA-Z_]+)[_-]([0-9]+)[_-](.+)\.html/', $ar_help_files[$i], $ar_regs))
			{
				$ar_help[$ar_regs[1]][count($ar_help[$ar_regs[1]])]['article_title'] = case_title(words($ar_regs[3]));
				$ar_help[$ar_regs[1]][count($ar_help[$ar_regs[1]])-1]['article_url'] = EE_HELP_HTTP.$ar_regs[0];
			}
		}

		$s='';

		global $modul_name;

		foreach($ar_help as $modul_name=>$articles)
		{
			$s.=parse_array_to_html($articles, $admin_path.'templates/help_row');
		}

		return '<div id="help" style="margin: 30px 0px 0px 30px">'.$s.'</div>';
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

	echo parse($modul.'/list');
?>