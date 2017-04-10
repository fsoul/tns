<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL. 
* http://www.2k-group.com
*/
?>
<?
	$modul='img';
	if(!isset($op)) $op=0;
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
	if(empty($i_name)) $close=true;
if(empty($close)) {
	if($save) {
		db_sql_query('update content set val="'.$aLname.'" where var="'.$i_name.'"');
		if(is_uploaded_file($nfile)) {
			deleteFile($i_name);
			ftpUpload($nfile,$i_name);
		}
		header('Location: img2.php?close=true');
		exit;
	} else if($_POST['cms_selector']) $cms_name=$_POST['cms_selector'];
//********************************************************************
function aLname() {
	global $i_name;
	$rs=db_sql_query('select val from content where var="'.$i_name.'"');
	if(db_sql_num_rows($rs)>0) {
		$r=db_sql_fetch_array($rs);
		$me=$r['val'];
	} else {
		$me='';
		db_sql_query('insert into content(var,val,short_desc) values("'.$i_name.'","","Link to the '.$i_name.' image")');
	}
	return $me;
}
echo parse($modul.'/list2');
} else {?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<script language="JavaScript">
	window.opener.location.reload();
	window.close();
</script>
</body>
</html>
<?}?>
