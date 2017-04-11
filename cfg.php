<?php

include_once('enviroment.php'); //DB settings, urls && any env settings here

//Site name
define('EE_SITE_NAME', 'TNS Opros');

define('MANAGED_BY_URL', 'http://www.2kgroup.com/');
define('MANAGED_BY_NAME', '2K-Group');
define('SUPPORT_CONTACTS_EMAIL', 'accesspanel.helpdesk@tns-ua.com'); // visible on site
define('SUPPORT_EMAIL', 'ee_support@2kgroup.com');		// for scripts only

define('NOREPLY_EMAIL', 'noreply@'.$_SERVER["HTTP_HOST"]);	// for authomatic emails FROM-field
define('SMTP_HOST', 'macc.com.ua');

//define('SUPPORT_CONTACTS_PHONE', '');
//define('SUPPORT_CONTACTS_HOURS', '10:00 - 19:00 (CET + 1)');


// If 0 then you can allow URL query params  only by <%set_allowed_uri_params_list:param1,param2, ... ,paramN% >,
// else - any url params are allowed.
define('EE_ALLOW_URL_PARAMS', 0);

//        FTP section
define('EE_FTP_USER', 't1pool');
define('EE_FTP_PASS', 'gjkmpjdfntkmn1');

define('EE_HTTP_PREFIX', '/');


$ar_admin_modules_black_list = array (

/*Mailing*/
'_nl_groups.php',
'_nl_notification.php',
'_mailing.php',
'_mail_inbox.php',
'_news_letters.php',
'_nl_subscribers.php',

/*objects*/
/*
'_object.php',
'_object_content.php',
'_object_field.php',
'_object_field_type.php',
'_object_record.php',
'_object_template.php',
*/

/*news*/
'_news_channels.php',
'_news_export.php',
'_news_mapping.php',
'_news_items.php',
'_news.php',

/*captcha*/
'_captcha.php',

/*survey*/
'_question.php',
'_survey.php',

'_manage_favorite.php ',

/*other*/
'_formbuilder.php',
'_form_mails.php'

);

define('AP_DATE_FORMAT_ORACLE', 'dd.mm.yyyy');

define('EE_START_SESSION_ALWAYS', 1);//need for form_builder module
define('AP_CONNECT_RESP', 0);
if ($_SERVER['REMOTE_ADDR']=='89.252.56.204')
{
//	define('POINTS_FOR_CONVERTION_DIVISIBLE_TO', 1);//100
//	define('MIN_POINTS_FOR_CONVERTION', 10);//1000
}

//echo '<!--'.$_SERVER['REMOTE_ADDR'].'-->';
if (($_SERVER['REMOTE_ADDR']=='82.144.201.69'
	||
	$_SERVER['REMOTE_ADDR']=='89.252.33.50'
	||
	$_SERVER['REMOTE_ADDR']=='89.252.56.204')
	&&
	array_key_exists('debug', $_GET) &&
	$_GET['debug']==1
)	
	define("DEBUG_MODE", 1);
else
	define("DEBUG_MODE", 0);
