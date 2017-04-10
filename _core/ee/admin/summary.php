<?
	$modul='summary';
//********************************************************************
	require_once('../lib.php');
	require_once('statistic_function.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
//********************************************************************
if(empty($aReportDate) ) $aReportDate = date('Y-m-d');
///********************************************************************
	echo parse($modul.'/list');
?>