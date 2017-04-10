<?php
//var_dump($_SERVER['PATH_INFO']);
//var_dump($_SERVER['REQUEST_URI']);
	$haystack = $_SERVER['REQUEST_URI'];
	// считаем, сколько слешей - столько и уровней вверх будем проверять
	$slashes_count = substr_count(substr($haystack, 0, strpos($haystack.'?', '?')), '/');
	// ищем cfg.php начиная с текущего каталога и далее вверх по иерархии
	for ($i = 0; $i < ($slashes_count+3); $i++)
	{
		if ($cfg_php_exists = file_exists($cfg_php_path = str_repeat('../', $i).'cfg.php'))
		{
			// если нашли cfg.php - прекращаем искать
			require($cfg_php_path);
			break;
		}
	}
	// если не нашли cfg.php - прекращаем работу
	if (!$cfg_php_exists)
	{
		die('"cfg.php" is not accessable from define_constants.php (REQUEST_URI = "'.$haystack.'")');
	}
	if (!defined('EE_LINK_XITI_ENABLE'))	define('EE_LINK_XITI_ENABLE', false);

/*
	{
		if (!defined('EE_'.$key))	define('EE_'.$key, $val);
	}
*/

	//fix problem with php 5.2.3
	//http://pear.php.net/bugs/bug.php?id=11418
	if(!array_key_exists('REDIRECT_URL', $_SERVER)){
		if (!defined('EE_REDIRECT_URL')) define('EE_REDIRECT_URL', $_SERVER['REQUEST_URI']);
	}

	

	if (!defined('EE_REDIRECT_URL'))		define('EE_REDIRECT_URL', $_SERVER['REDIRECT_URL']);

	if (!defined('EE_REQUEST_URI'))			define('EE_REQUEST_URI', $_SERVER['REQUEST_URI']);

	if (!defined('EE_URI'))				define('EE_URI', EE_REQUEST_URI);

	if (isset($_SERVER['QUERY_STRING']))
	{
		if (!defined('EE_URL_QUERY_STRING'))		define('EE_URL_QUERY_STRING', $_SERVER['QUERY_STRING']);
	}

	if (!defined('EE_SCRIPT_NAME'))			define('EE_SCRIPT_NAME', ( strpos(EE_REQUEST_URI, '?')!==false ? substr(EE_REQUEST_URI, 0, strpos(EE_REQUEST_URI, '?')) : EE_REQUEST_URI));


	if (!defined('EE_LANGUAGE_AUTOFORWARDING'))	define('EE_LANGUAGE_AUTOFORWARDING', '1');

	//  global variables init order
	if (!defined('EE_VARIABLES_ORDER'))	define('EE_VARIABLES_ORDER', 'EGPCSs');

	if (!defined('EE_HOST'))	define('EE_HOST', 'localhost');
	
	if (!defined('EE_ALLOW_URL_PARAMS'))	define('EE_ALLOW_URL_PARAMS', 0);	

	if (!defined('EE_PHP_SELF'))	define('EE_PHP_SELF', $_SERVER["PHP_SELF"]);

	if (!defined('AUTHORIZE_SOAP'))	define('AUTHORIZE_SOAP',0);

	if (isset($_SERVER['PHP_AUTH_USER']))
	{
		if (!defined('EE_PHP_AUTH_USER'))	define('EE_PHP_AUTH_USER', $_SERVER['PHP_AUTH_USER']);

		if (!defined('EE_PHP_AUTH_PW'))		define('EE_PHP_AUTH_PW', $_SERVER['PHP_AUTH_PW']);
	}

	if (!defined('EE_DBMS'))	define('EE_DBMS', 'mysql');
	if (!defined('TABLE_PREFIX'))	define('TABLE_PREFIX', '');

	if (!defined('EE_HTTP_HOST'))	define('EE_HTTP_HOST', $_SERVER["HTTP_HOST"]);

	if (!defined('EE_SITE_NAME'))	define('EE_SITE_NAME', EE_HTTP_HOST);

	if (!defined('EE_EXPORT_DIR'))	define('EE_EXPORT_DIR', 'templates/export/');

	if (!defined('EE_FSOCKOPEN_HOST'))	define('EE_FSOCKOPEN_HOST', EE_HTTP_HOST);

	if (!defined('EE_HTTP_SERVER'))	define('EE_HTTP_SERVER','http://'.EE_HTTP_HOST);

	if (!defined('EE_HTTP_PREFIX'))	define('EE_HTTP_PREFIX','/');

	if (!defined('EE_ADMIN_SECTION'))	define('EE_ADMIN_SECTION',	'admin/');

	if (!defined('EE_ADMIN_SECTION_IN_HTACCESS'))	define('EE_ADMIN_SECTION_IN_HTACCESS', 'admin/');

		//------------------------------HTTPS----------------------------------------------------------//
	if (!defined('EE_HTTPS_ONLY'))	define('EE_HTTPS_ONLY',	false);

	if (!defined('EE_REDIRECT_HTTPS'))
	{
		if (isset($_SERVER['REDIRECT_HTTPS']))
		{
			define('EE_REDIRECT_HTTPS', $_SERVER['REDIRECT_HTTPS']);
		}
		else
		{
			define('EE_REDIRECT_HTTPS', '');
		}
	}

	if (EE_REDIRECT_HTTPS == 'on')
	{
		define('EE_HTTPS_SERVER','https://'.EE_HTTP_HOST);

		define('EE_HTTPS', EE_HTTPS_SERVER.EE_HTTP_PREFIX);

		define('EE_HTTP_FRONT', EE_HTTP_SERVER.EE_HTTP_PREFIX);

		define('EE_HTTP', EE_HTTPS);
	}
	else
	{
		define('EE_HTTP', EE_HTTP_SERVER.EE_HTTP_PREFIX);
	}

	define('EE_URL', EE_HTTP_SERVER.EE_URI);


      	//--------------------------------------------------------------------------------------------//
	if (!defined('EE_FTP_SERVER'))	define('EE_FTP_SERVER',	EE_HTTP_HOST);
	if (!defined('EE_FTP_PREFIX'))	define('EE_FTP_PREFIX',	EE_HTTP_PREFIX);
	if (!defined('EE_FTP_USER'))	define('EE_FTP_USER',	EE_USER);
	if (!defined('EE_FTP_PASS'))	define('EE_FTP_PASS',	EE_PASS);

	if (!defined('EE_IMG_PATH'))	define('EE_IMG_PATH',	'usersimage/');
	if (!defined('EE_MEDIA_PATH'))	define('EE_MEDIA_PATH',	'media/');
	if (!defined('EE_XML_PATH'))	define('EE_XML_PATH', 'xml/');

	// Start SESSION always ( "0" - no; "1" - yes)
	if (!defined('EE_START_SESSION_ALWAYS'))	define('EE_START_SESSION_ALWAYS', 0);

	if (!defined('EE_GALLERY_DIR'))	define('EE_GALLERY_DIR','gallery/');
	if (!defined('EE_GALLERY_C'))	define('EE_GALLERY_C',	3); // gallery image columns number
	if (!defined('EE_GALLERY_R'))	define('EE_GALLERY_R',	4); // gallery image rows number
	define('EE_GALLERY_CxR',	EE_GALLERY_C*EE_GALLERY_R);

	if (!defined('EE_GALLERY_THUMBNAIL_W'))	define('EE_GALLERY_THUMBNAIL_W',150); // Thumbnail image width
	if (!defined('EE_GALLERY_MAX_W'))	define('EE_GALLERY_MAX_W',	300); // Maximum width of not resized uploaded image
	if (!defined('EE_GALLERY_MAX_H'))	define('EE_GALLERY_MAX_H',	200); // Maximum height of not resized uploaded image

	if (!defined('EE_DOCUMENT_ROOT'))	define('EE_DOCUMENT_ROOT',	$_SERVER['DOCUMENT_ROOT']);

	if (!defined('EE_PATH'))		define('EE_PATH',	EE_DOCUMENT_ROOT.EE_HTTP_PREFIX);

	if (	isset($_GET['vcore'])
			&&
        preg_match('/([a-b0-9_]+)?/i',$_GET['vcore'])
			&&
		is_dir(EE_PATH.'_core/ee'.$_GET['vcore']))
	{
		setcookie('core_ver_dir_path', $_GET['vcore'], time()+3600, EE_HTTP_PREFIX);
		define('EE_HTTP_VERSION_CORE_DIR','ee'.$_GET['vcore'].'/');
	}

	if (isset($_COOKIE['core_ver_dir_path']))
	{
		if (preg_match('/([a-b0-9_]+)?/i', $_COOKIE['core_ver_dir_path']) && is_dir(EE_PATH.'_core/ee'.$_COOKIE['core_ver_dir_path']))
		{
			define('EE_HTTP_VERSION_CORE_DIR','ee'.(isset($_COOKIE['core_ver_dir_path']) ? $_COOKIE['core_ver_dir_path'] : '' ).'/');
		}
		else
		{
			setcookie('core_ver_dir_path', $_GET['vcore'], time()-3600, EE_HTTP_PREFIX);
			header('Location: '.EE_HTTP);
			exit;
		}
	}

	if (!defined('EE_HTTP_VERSION_CORE_DIR'))	define('EE_HTTP_VERSION_CORE_DIR','ee/');

	if (!defined('EE_HTTP_PREFIX_CORE'))	define('EE_HTTP_PREFIX_CORE','_core/'.EE_HTTP_VERSION_CORE_DIR);


	// task 9604
	if (!defined('CATCHING_DATABASE_INAVAILABILITY_REDIRECT_URL'))		define('CATCHING_DATABASE_INAVAILABILITY_REDIRECT_URL', '');


//cache section

	if (!defined('EE_CACHE_DIR'))			define('EE_CACHE_DIR', 'CACHE/');
	if (!defined('EE_CACHE_DIR_SIZE_LIMIT_BYTES'))	define('EE_CACHE_DIR_SIZE_LIMIT_BYTES', 1 * 1024 * 1024 * 1024);
	if (!defined('EE_OBJ_CACHE_DIR'))		define('EE_OBJ_CACHE_DIR', EE_CACHE_DIR.'OBJ_CACHE/');
	if (!defined('EE_XML_CACHE_DIR'))		define('EE_XML_CACHE_DIR', EE_CACHE_DIR.'xml/');

	if (!defined('EE_SQL_CACHE_DIR'))		define('EE_SQL_CACHE_DIR', EE_CACHE_DIR.'SQL/');
	if (!defined('EE_USE_SQL_CACHE'))		define('EE_USE_SQL_CACHE', false);

	if (!defined('EE_OBJ_FILE_SIZE_LIMIT'))		define('EE_OBJ_FILE_SIZE_LIMIT', 3*1024*1024);
	if (!defined('EE_OBJ_IMAGE_SIZE_LIMIT'))	define('EE_OBJ_IMAGE_SIZE_LIMIT', 3*1024*1024);


	if (!defined('EE_CACHE_FILE_INDICATION')) 	define('EE_CACHE_FILE_INDICATION', 'cache.enabled');
	if (!defined('EE_CACHE_FILE_INDICATION_PATH')) 	define('EE_CACHE_FILE_INDICATION_PATH', EE_PATH.EE_CACHE_DIR.EE_CACHE_FILE_INDICATION);
	if (!defined('EE_CACHE_OBJECT_ENABLE'))		define('EE_CACHE_OBJECT_ENABLE', true);
	if (!defined('EE_CACHE_ABSENT')) 		define('EE_CACHE_ABSENT', '0');
	if (!defined('EE_CACHE_PRESENT')) 		define('EE_CACHE_PRESENT', '1');

	if (!defined('EE_CORE_PATH'))		define('EE_CORE_PATH',	EE_PATH.EE_HTTP_PREFIX_CORE);

	if (!defined('EE_MIMETYPES_FILE'))	define('EE_MIMETYPES_FILE', EE_CORE_PATH.'lib/resources/mimetypes/mime.types');

	if (!defined('EE_ADMIN_PATH'))		define('EE_ADMIN_PATH',	EE_PATH.EE_ADMIN_SECTION);

	if (!defined('EE_CORE_ADMIN_PATH'))	define('EE_CORE_ADMIN_PATH',	EE_CORE_PATH.EE_ADMIN_SECTION);

	if (!defined('EE_ADMIN_URL'))		define('EE_ADMIN_URL',	EE_HTTP.EE_ADMIN_SECTION_IN_HTACCESS);

	if (!defined('EE_CORE_ADMIN_URL'))	define('EE_CORE_ADMIN_URL',	EE_HTTP.EE_HTTP_PREFIX_CORE.EE_ADMIN_SECTION);

	if (!defined('EE_FILE_PATH'))		define('EE_FILE_PATH',	EE_PATH.EE_IMG_PATH);
	if (!defined('EE_FILE_HTTP'))		define('EE_FILE_HTTP',	EE_HTTP.EE_IMG_PATH);
	if (!defined('EE_MEDIA_FILE_PATH'))	define('EE_MEDIA_FILE_PATH',	EE_PATH.EE_MEDIA_PATH);
	if (!defined('EE_IMG_HTTP'))		define('EE_IMG_HTTP',	EE_FILE_HTTP);
	if (!defined('EE_GALLERY_HTTP'))	define('EE_GALLERY_HTTP',	EE_IMG_HTTP.EE_GALLERY_DIR);
	if (!defined('EE_GALLERY_IMAGE_FILE_PATH'))	define('EE_GALLERY_IMAGE_FILE_PATH',	EE_PATH.EE_IMG_PATH.EE_GALLERY_DIR);		
	if (!defined('EE_SUPPORT_EMAIL'))	define('EE_SUPPORT_EMAIL', 'ee_support@2kgroup.com');
	if (!defined('EE_HELP_DIR'))		define('EE_HELP_DIR', 'help/ee/');
	if (!defined('EE_HELP_HTTP'))		define('EE_HELP_HTTP', EE_HTTP.EE_HELP_DIR);

	if (!defined('EE_HTTP_REFERER'))		define('EE_HTTP_REFERER', (isset($_SERVER['HTTP_REFERER'])) ? $_SERVER['HTTP_REFERER'] : '');
	if (!defined('EE_HTTP_ACCEPT_LANGUAGE'))	define('EE_HTTP_ACCEPT_LANGUAGE', (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : 'en');
	
	if (!defined('EE_ERROR_LOG_PATH'))		define('EE_ERROR_LOG_PATH', EE_PATH.'error.log');

	if (!defined('EE_LOG_STOP_RESET_MAIL_TO'))	define('EE_LOG_STOP_RESET_MAIL_TO', 'ee_priority_support@2kgroup.com');


	//https://admin.recaptcha.net/accounts/signup/
	if (!defined('CAPTCHA_INCORRECT')) define('CAPTCHA_INCORRECT', 'Captcha error');
	if (!defined('RE_CAPTCHA_PB_KEY')) define('RE_CAPTCHA_PB_KEY', '6LcMLgIAAAAAABtNSevTWwv-vtM0MHzLoi3nuODW');
	if (!defined('RE_CAPTCHA_PR_KEY')) define('RE_CAPTCHA_PR_KEY', '6LcMLgIAAAAAADqmVXaD5Y74P9m2oZZoVZTlkTVQ');
	
	if(!defined('EE_SITEMAP_LIMIT_URLS')) 		define('EE_SITEMAP_LIMIT_URLS', 45000);
	if(!defined('EE_SITEMAP_NUMBER'))	 	define('EE_SITEMAP_NUMBER', 900);
	if(!defined('EE_SITEMAPINDEX_DIR'))             define('EE_SITEMAPINDEX_DIR', 'sitemapindex/');
	if(!defined('EE_SITEMAPINDEX_PATH')) 		define('EE_SITEMAPINDEX_PATH', EE_PATH.EE_SITEMAPINDEX_DIR);
	
	// Expanded logging
	if (!defined('EXPANDED_LOGGING_ON')) define('EXPANDED_LOGGING_ON', 0);
	if (!defined('LOGGER_OUTPUT_CSV')) define('LOGGER_OUTPUT_CSV', 0);

	if (!defined('EE_SET_BENCHMARK_ON')) define('EE_SET_BENCHMARK_ON', 0);

	// Error sender
	if (!defined('ERROR_SENDER_ON')) define('ERROR_SENDER_ON', 0);
	if (!defined('ERROR_SENDER_EMAIL')) define('ERROR_SENDER_EMAIL', 'support@2kgroup.com');
	if (!defined('MAX_PAGE_EXECUTION_TIME')) define('MAX_PAGE_EXECUTION_TIME', 5);
	if (!defined('MAX_QUERY_EXECUTION_TIME')) define('MAX_QUERY_EXECUTION_TIME', 1);
	
	// Formbuilder
	if (!defined('FORMBUILDER_FOLDER')) define('FORMBUILDER_FOLDER', 'formbuilder/');

	//News letters subscribing
	if (!defined('SLAVE_SUBSCRIBE_PAGE')) define('SLAVE_SUBSCRIBE_PAGE', 'nl_subscribe');//ИМЯ (ПУТЬ) СТРАНИЦЫ ПОДПИСКИ НА MASTER САЙТЕ, определяется на Slave сайте
	if (!defined('SLAVE_UNSUBSCRIBE_PAGE')) define('SLAVE_UNSUBSCRIBE_PAGE', 'nl_unsubscribe');//ИМЯ (ПУТЬ) СТРАНИЦЫ ОТПИСКИ НА MASTER САЙТЕ, определяется на Slave сайте
	if (!defined('SLAVE_SITE_NAME')) define('SLAVE_SITE_NAME', '');//НАЗВАНИЕ SLAVE САЙТА (служит идентификатором и префиксом кастомных шаблонов), определяется на Slave сайте
	if (!defined('SLAVE_CONFIRM_PAGE')) define('SLAVE_CONFIRM_PAGE', '<%:EE_HTTP%><%:language%>/newsletter_form/slave_subscribe_confirm.html');//ПУТЬ К СТРАНИЦЕ ПОДТВЕРЖДЕНИЯ ПОДПИСКИ НА SLAVE САЙТЕ (куда попадает пользователь когда кликает по ссылке подтверждения подписки), определяется на Slave сайте
	if (!defined('SLAVE_MASTER_SITE')) define('SLAVE_MASTER_SITE', 'http://localhost/ee');//URL master сайта включая протокол и папку в которой лежит сайт, без слеша в конце
	
	if (!defined('MASTER_NL_TEMPLATES_FOLDER')) define('MASTER_NL_TEMPLATES_FOLDER', 'newsletter_form/');//ПАПКА ГДЕ НАХОДЯТСЯ ШАБЛОНЫ ПРОЕКТА

	if (!defined('EE_CAN_NOT_RESET_LOG_FILE_NAME'))	define('EE_CAN_NOT_RESET_LOG_FILE_NAME', 'can_not_reset_log.txt');

	if (!defined('EE_WARNINGS_LOG_FILE_NAME'))	define('EE_WARNINGS_LOG_FILE_NAME', 'warnings_log.txt');
	if (!defined('EE_WARNINGS_STOP_FILE_NAME'))	define('EE_WARNINGS_STOP_FILE_NAME', 'warnings_stop.txt');

	if (!defined('EE_WARNINGS_STOP_MAIL_TO'))	define('EE_WARNINGS_STOP_MAIL_TO', 'ee_priority_support@2kgroup.com');
	if (!defined('EE_WARNINGS_STOP_MAIL_SUBJECT'))	define('EE_WARNINGS_STOP_MAIL_SUBJECT', 'For last %s %s(s) more then %s warnings were sent.');
	if (!defined('EE_WARNINGS_STOP_MESSAGE'))	define('EE_WARNINGS_STOP_MESSAGE', "\r\n".EE_WARNINGS_STOP_MAIL_SUBJECT."\r\n".'Warnings sending is stoped now.'."\r\n".'Delete %s file to start warnings sending again.');


	if (!defined('EE_FCK_EDITOR_USE_ABSOLUTE_PATH')) define('EE_FCK_EDITOR_USE_ABSOLUTE_PATH', false);

	if (!defined('EE_USE_SENDDAEMON')) define('EE_USE_SENDDAEMON', false);

	// mail
	if (!defined('EE_SELF_TEST_EMAIL_FROM')) 	define('EE_SELF_TEST_EMAIL_FROM', 'ee_selftest@2kgroup.com');
	if (!defined('EE_SITE_INFO_EMAIL'))		define('EE_SITE_INFO_EMAIL', EE_SUPPORT_EMAIL);

	if (!defined('EE_LOG_STOP'))	define('EE_LOG_STOP', 0);
	if (!defined('EE_LOG_RESET'))	define('EE_LOG_RESET', 1);

	// export
	if (!defined('EE_DEFAULT_CSV_SEPARATOR'))	define('EE_DEFAULT_CSV_SEPARATOR', ';');

	if (!defined('EE_DEFAULT_DIR_MODE'))	define('EE_DEFAULT_DIR_MODE', 0775);

	if (!defined('EE_SEND_LOG_FILE'))	define('EE_SEND_LOG_FILE', EE_ADMIN_PATH.'send.log');

	if (!defined('EE_CHANGE_FREQUENCY_LIST_FOR_PAGE'))	define('EE_CHANGE_FREQUENCY_LIST_FOR_PAGE', 'always|hourly|daily|weekly|monthly|yearly|never');
	if (!defined('EE_CHANGE_FREQUENCY_TAG'))		define('EE_CHANGE_FREQUENCY_TAG', 'change_frequency');

	if (!defined('EE_FCK_EDITOR_ID'))			define('EE_FCK_EDITOR_ID', 'EE_FCK_Editor');
	
	if (($res = check_path_constants())!==true)
	{
		echo '<h1>Path definitions are not correct.<br>Please, check cfg file</h1>';
		echo '<h2>Error in '.$res.': '.constant($res).'</h2>';

		exit;
	}

	$page_extensions = array('html', 'htm');

	$ee_file_types_info = array( 'media' => array(	'jpg'	=> 'image/jpeg',
							'jpeg'	=> 'image/jpeg',
							'gif'	=> 'image/gif',
							'png'	=> 'image/png',
							'swf'	=> 'application/x-shockwave-flash',
							'pdf'	=> 'application/pdf',
							'doc'	=> 'application/msword'),

				'page'	=> array(	'html' 	=> 'text/html',
							'htm' 	=> 'text/html',
							'xml'	=> 'text/xml'));

	define('EE_FILE_TYPES', serialize($ee_file_types_info));

	if (!isset($geo_ip_redirect_rate))
	{
		$geo_ip_redirect_rate = array(	'US' => 'EN',
						'GB' => 'EN',
						'AU' => 'EN',
						'FR' => 'FR',
						'CH' => 'FR',
						'CN' => 'CN',
						'RU' => 'RU',
						'UA' => 'RU');
	}

function check_path_constants()
{
	$constants = array(
		'EE_HTTP_PREFIX',
		'EE_IMG_PATH',
		'EE_MEDIA_PATH',
		'EE_GALLERY_DIR',
//		'EE_FTP_SERVER',
		'EE_FTP_PREFIX',
		'EE_ADMIN_SECTION',
		'EE_ADMIN_SECTION_IN_HTACCESS',
		'EE_ADMIN_PATH',
		'EE_ADMIN_URL',
		'EE_FILE_PATH',
		'EE_FILE_HTTP',
		'EE_MEDIA_FILE_PATH',
		'EE_IMG_HTTP',
		'EE_GALLERY_HTTP',
		'EE_CACHE_DIR',
		'EE_EXPORT_DIR',
	);

	$res = true;

	foreach ($constants as $v)
	{
		if (defined($v) && substr(constant($v),-1) != '/')
		{
			$res = $v;
			break;
		}
	}

	if (substr(EE_HTTP_PREFIX, 0, 1) != '/')
	{
		$res = 'EE_HTTP_PREFIX';
	}

	return $res;
}

?>
