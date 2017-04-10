<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL. 
* http://www.2k-group.com
*/
?>
<?
function test_checked($test) {
	global $r_type;
	return $r_type[val_field_name()]==$test?'checked':'';
}

$admin=true;
$UserRole=0;
$modul='cms_by_type';
if(!isset($op)) $op=0;
//********************************************************************
include_once('../lib.php');
//********************************************************************
if(!CheckAdmin() or ($UserRole!=ADMINISTRATOR and $UserRole!=POWERUSER)) {echo parse('norights');exit;}

if(empty($close) and !empty($lang) and !empty($cms_name)) {
	if($save) {
		$aFieldName=trim($_POST['aFieldName']);
		$lang=trim($_POST['lang']);
		$i_name = $_FILES['nfile']['name'];
		$n_size = $_FILES['nfile']['size'];
		$nfile = $_FILES['nfile']['tmp_name'];
		$src='';
		if ($i_name!='' && $n_size!=0) {
			deleteFile($i_name);
			if (ftpUpload($nfile,$i_name)) $src=EE_FILE_HTTP.$i_name;
		} else 	$src=$fImageSrc;

		runsql('update content set '.val_field_name().'="'.$op.'", short_desc="'.$aFieldName.'" where language="'.$lang.'" and var="'.$cms_name.'_type"',0);
		runsql('update content set '.val_field_name().'="<img src=\"'.$src.'\" '.($fImageWidth?'width=\"'.$fImageWidth.'\"':'').' '.($fImageHeight?'height=\"'.$fImageHeight.'\"':'').' alt=\"'.$fImageAlt.'\" border=\"0\">", short_desc="'.$aFieldName.' img" where language="'.$lang.'" and var="'.$cms_name.'_img"',0);

		header('Location: cms_by_type.php?close=true');
		exit;
	}
	$rs_type=viewsql('select * from content where var="'.$cms_name.'_type" and language="'.$lang.'"',0);
	if(db_sql_num_rows($rs_type)<1) {
		runsql('insert into content(var,'.val_field_name().',short_desc,language) values("'.$cms_name.'_type","txt","'.$cms_name.'","'.$lang.'")',0);
		$rs_type=viewsql('select * from content where var="'.$cms_name.'_type" and language="'.$lang.'"',0);
	}

	$rs_img=viewsql('select * from content where var="'.$cms_name.'_img" and language="'.$lang.'"',0);
	if(db_sql_num_rows($rs_img)<1) {
		runsql('insert into content(var,'.val_field_name().',short_desc,language) values("'.$cms_name.'_img","","'.$cms_name.'_img","'.$lang.'")',0);
		$rs_img=viewsql('select * from content where var="'.$cms_name.'_img" and language="'.$lang.'"',0);
	}

	$r_type=db_sql_fetch_array($rs_type);
	$fType=$r_type[val_field_name()];
	$aFieldName=$r_type['short_desc'];

	$fText=cms($cms_name.'_txt');

	$tmp=$admin_template;
	$admin_template='yes';

	$edit_cms_fText=str_replace('<br><br>', '', edit_cms($cms_name.'_txt'));
	$admin_template=$tmp;


	$r_img=db_sql_fetch_array($rs_img);
	$fImage=$r_img[val_field_name()];

	$ImgAttr=array('src', 'width', 'height', 'alt');
	foreach ($ImgAttr as $ImAt)
		$$ImAt=strpos($fImage, $ImAt.'="') ? substr($fImage,strpos($fImage, $ImAt.'="')+strlen($ImAt)+2, strpos(substr($fImage,strpos($fImage, $ImAt.'="')+strlen($ImAt)+2),'"')) : '';
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
<?
}

?>