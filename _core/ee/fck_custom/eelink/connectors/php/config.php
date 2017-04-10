<?php 
/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * "Support Open Source software. What about a donation today?"
 * 
 * File Name: config.php
 * 	Configuration file for the File Manager Connector for PHP.
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
 */


//require('../../../../cfg.php');
require('../../../../lib.php');

if (!check_admin_template())
{
	exit;
}

//require('../../../../modules/ftp_function.php');
//require('../../../../modules/file_system_function.php');


global $Config ;

// SECURITY: You must explicitelly enable this "connector". (Set it to "true").
$Config['Enabled'] = true;

// Path to user files relative to the document root.
if(EE_FCK_EDITOR_USE_ABSOLUTE_PATH)
{
	$Config['UserMediaPath'] = EE_HTTP.EE_IMG_PATH;
	$Config['UserFilesPath'] = EE_HTTP.EE_IMG_PATH;
}
else
{
	$Config['UserMediaPath'] = EE_HTTP_PREFIX.EE_IMG_PATH;
	$Config['UserFilesPath'] = EE_HTTP_PREFIX.EE_IMG_PATH;
}
         

// Fill the following value it you prefer to specify the absolute path for the
// user files directory. Usefull if you are using a virtual directory, symbolic
// link or alias. Examples: 'C:\\MySite\\UserFiles\\' or '/root/mysite/UserFiles/'.
// Attention: The above 'UserFilesPath' must point to the same directory.
$Config['UserFilesAbsolutePath'] = $_SERVER['DOCUMENT_ROOT'].EE_HTTP_PREFIX.EE_IMG_PATH;

//bug_id=11626
$Config['AllowedExtensions']['File']	= array() ;
$Config['DeniedExtensions']['File']	= array('shtml','htaccess','php','php3','php5','phtml','asp','aspx','ascx','jsp','cfm','cfc','pl','bat','exe','dll','reg','cgi') ;

$Config['AllowedExtensions']['Image']	= array('jpg','gif','jpeg','png') ;
$Config['DeniedExtensions']['Image']	= array() ;

$Config['AllowedExtensions']['Flash']	= array('swf','fla') ;
$Config['DeniedExtensions']['Flash']	= array() ;

$Config['AllowedExtensions']['Media']	= array('swf','fla','jpg','gif','jpeg','png','avi','mpg','mpeg') ;
$Config['DeniedExtensions']['Media']	= array() ;

?>