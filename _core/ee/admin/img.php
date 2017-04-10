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
	if(!empty($save)) {
		deleteFile($i_name);
		ftpUpload($_FILES['nfile']['tmp_name'],$i_name);
		header('Location: img.php?close=true');
		exit;
	} else if(post('cms_selector')) $cms_name=$_POST['cms_selector'];
	global $size_x, $size_y;
	if(fileExists($i_name)) {
		$size=getimagesize(EE_FILE_PATH.$i_name);
		$size_x=$size[0];
		$size_y=$size[1];
	} else {
		$size_x='?';
		$size_y='?';
	}
//********************************************************************
echo parse_popup($modul.'/list');
} else {?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<script language="JavaScript">
	window.parent.closePopup('yes');
</script>
</body>
</html>
<?}?>
