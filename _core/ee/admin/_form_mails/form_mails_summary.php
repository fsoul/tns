<?
	$modul = basename(__FILE__, '.php');
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!isset($op)) $op='0';
	include('url_if_back.php');
	
	switch ($op)
	{
		default:
		case '1':
		case '0': echo parse_popup($modul); 
		break;
		case '2': echo parse_popup('_formbuilder/user_info'); 
		break;
	}

?>