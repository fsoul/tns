<?
	$modul='searches';
//********************************************************************
	require_once('../lib.php');
	require_once('statistic_function.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
//********************************************************************
if(empty($aStartDate) ) $aStartDate = date('Y-m-d');
if(empty($aEndDate) ) $aEndDate = date('Y-m-d');

prepareCompareDate();

if(empty($act)) $act = 'summary';


	
	echo parse($modul.'/list');
?>