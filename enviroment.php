<?php

//  DB section
define('EE_USER', 'root');
define('EE_PASS', '');
define('EE_HOST', 'localhost');

define('EE_DATABASE', 'devopros');

//Oracle
define('AP_OCI_USERNAME', 'ap_user');
define('AP_OCI_PASSWORD', '1');
define('AP_OCI_SERVERNAME', '//192.168.4.24:1521/devgrp');

//for real site: http://serv5.erp-director.com/b36panel/Entry/
//  https://mmi.bemobile.ua/plcountry/mobile/app_update/tns_browser https://mmi.bemobile.ua/plcountry/mobile/app_update/tns_top
//if (!defined('TNS_BROWSER_DOWNLOAD'))	define('TNS_BROWSER_DOWNLOAD', 'https://194.247.174.9/plcountry/mobile/app_update/tns_browser');

if (!defined('TNS_BROWSER_DOWNLOAD'))	define('TNS_BROWSER_DOWNLOAD', 'https://play.google.com/store/apps/details?id=com.tnsua.browser&referrer=');
if (!defined('TNS_BROWSER_DOWNLOAD_REFERRER'))	define('TNS_BROWSER_DOWNLOAD_REFERRER', 'utm_source=opros.tns-ua.com&utm_content=respondent_id=%resp_id%&utm_campaign=tns-browser');

if (!defined('TNS_TOP_DOWNLOAD'))	define('TNS_TOP_DOWNLOAD', 'https://play.google.com/store/apps/details?id=com.tnsua.top&referrer=');
if (!defined('TNS_TOP_DOWNLOAD_REFERRER'))	define('TNS_TOP_DOWNLOAD_REFERRER', 'utm_source=%urlid%');

if (!defined('ORACLE_API_LINK'))	define('ORACLE_API_LINK', 'http://192.168.4.25:8080/b36panel/Entry/');