<?php 
/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2006 Frederico Caldeira Knabben
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
 * 	Configuration file for the PHP File Uploader.
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
 */

global $t, $admin_template;
$t=0;
$admin_template='yes';

require('../../../lib.php');

global $Config ;

// SECURITY: You must explicitelly enable this "uploader". 
$Config['Enabled'] = true ;

// Set if the file type must be considere in the target path. 
// Ex: /UserFiles/Image/ or /UserFiles/File/
$Config['UseFileType'] = true ;

// Path to uploaded files relative to the document root.
if(EE_FCK_EDITOR_USE_ABSOLUTE_PATH)
{
	$Config['UserFilesPath'] = EE_HTTP.EE_IMG_PATH;
}
else
{
	$Config['UserFilesPath'] = EE_HTTP_PREFIX.EE_IMG_PATH;
}

// Fill the following value it you prefer to specify the absolute path for the
// user files directory. Usefull if you are using a virtual directory, symbolic
// link or alias. Examples: 'C:\\MySite\\UserFiles\\' or '/root/mysite/UserFiles/'.
// Attention: The above 'UserFilesPath' must point to the same directory.
$Config['UserFilesAbsolutePath'] = $_SERVER['DOCUMENT_ROOT'].EE_HTTP_PREFIX.EE_IMG_PATH ;

// Due to security issues with Apache modules, it is reccomended to leave the
// following setting enabled.
$Config['ForceSingleExtension'] = true ;

$Config['AllowedExtensions']['File']	= array() ;

// bug_id=11626
$Config['DeniedExtensions']['File']	= array('htaccess','shtml','php','php2','php3','php4','php5','phtml','pwml','inc','asp','aspx','ascx','jsp','cfm','cfc','pl','bat','exe','com','dll','vbs','js','reg','cgi') ;

$Config['AllowedExtensions']['Image']	= array('jpg','gif','jpeg','png') ;
$Config['DeniedExtensions']['Image']	= array() ;

$Config['AllowedExtensions']['Flash']	= array('swf','fla') ;
$Config['DeniedExtensions']['Flash']	= array() ;

?>