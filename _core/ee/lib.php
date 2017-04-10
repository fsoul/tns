<?php
	/**
	 * Set up error repoting level
	 */
	error_reporting(E_ALL & ~E_NOTICE);


    require_once('lib/Mobile_Detect.php');

    /**
	 * global variable $page from GET
	 * possibly is not used more and could be deleted
	 */
	if (array_key_exists('page', $_GET))
	{
		$page = $_GET['page'];
	}

	/**
	 * last error message will always be present
	 * in the variable $php_errormsg
	 */
	ini_set('track_errors', 'on');
	ini_set('display_errors', 'on');

	/**
	 * Define all EE constants
	 */
	require_once('define_constants.php');

	/**
	 * timestamp markup initial setup
	 */
	set_mark();


	/**
	 * Redirect first phase
	 */

	/**
	 * use debug-functions library 
	 */
	require_once(EE_PATH.EE_HTTP_PREFIX_CORE.'modules/debug_function.php');

	/**
	 * Separate script name and GET-params into $redir and $prev_keys accordingly
	 */
	if (substr(EE_REQUEST_URI, 0, strpos(EE_REQUEST_URI, '?')) == '')
	{
		$redir = EE_REQUEST_URI;
	}
	else
	{
		$redir = substr(EE_REQUEST_URI, 0, strpos(EE_REQUEST_URI, '?'));
		$prev_keys = str_replace('?', '&', substr(EE_REQUEST_URI, strpos(EE_REQUEST_URI, '?'), (strlen(EE_REQUEST_URI) - strpos(EE_REQUEST_URI, '?'))));

		if ($prev_keys != '' && $redir == '/')
		{
			$redir.= 'index.php';
		}
	}
	$l = strlen(EE_HTTP_PREFIX);
	$redir = substr($redir, $l);

	/**
	 * Change redirection status to 200 for 4* & 5* current one
	 */
	$redir_status_in = (isset($_SERVER["REDIRECT_STATUS"]))?$_SERVER["REDIRECT_STATUS"]:'200';

	if (	substr($redir_status_in,0,1)=="4"
		||
		substr($redir_status_in,0,1)=="5"
	)
	{
		$redir_status_out = '200';
	}
	else
	{
		$redir_status_out = $redir_status_in;
	}

	/**
	 * Load current DBMS-related functions
	 */
	require('modules/db_'.EE_DBMS.'.php');

	/**
	 * Connect with DataBase
	 * if connection can't be seted - redirect to special url|static file if specified or show message and die
	 */
	function db_connect()
	{
		//task_id = 9604
		$catching_database_redirect_url = CATCHING_DATABASE_INAVAILABILITY_REDIRECT_URL;

		if ($catching_database_redirect_url != '')
		{
			if (strpos($catching_database_redirect_url, 'http://')!==0)
			{
				$catching_database_redirect_url = EE_HTTP.$catching_database_redirect_url;
			}
		}

		if (!($db = @db_sql_connect(EE_HOST, EE_USER, EE_PASS)))
		{
			if ($catching_database_redirect_url=='')
			{
				die('Database Server Connection Error: '.db_sql_error());
			}
			else
			{
//var_dump(1); exit;
				header('Location: '.$catching_database_redirect_url);
				exit;
			}
		}

		if (!(db_sql_select_db(EE_DATABASE, $db)))
		{
			if ($catching_database_redirect_url=='')
			{
				die('Database Connection Error: '.db_sql_error());
			}
			else
			{
//var_dump(2); exit;
				header('Location: '.$catching_database_redirect_url);
				exit;
			}
		}

		$res = mysql_query('SET NAMES utf8');
	}

	db_connect();
	/**
	 * Set global variables from GET, POST etc.
	 */
	if (array_key_exists('admin_template', $_GET))
	{
		$admin_template = $_GET['admin_template'];
	}
	else
	{
		$admin_template = '';
	}

	/**
	 * Let start session with the name of current site subfolder
	 * if this is backoffice & we are not exporting some grid
	 */
	if ((is_in_admin() || EE_START_SESSION_ALWAYS == 1)
		&& (!isset($export_run) || $export_run != 1)
	)
	{
		set_session_name(EE_HTTP_PREFIX);
		session_start();
	}

	/**
	 * Set utf-8 character-set if it is admin section or if charset is still not seted
	 */
	if (	strpos($_SERVER['PHP_SELF'], EE_HTTP_PREFIX.EE_ADMIN_SECTION_IN_HTACCESS) !== false
		||
		!detect_sent_charset()
	)
	{
		header('Content-type: text/html; charset=utf-8');
	}

	/**
	 * clear slashes in POST & GET if were added by Apache
	 */
	stripslashes_in_post();
	stripslashes_in_get();

	/**
	 * if init order is not defined in cfg.php
	 * - take it from php.ini
	 */
	if (!defined('EE_VARIABLES_ORDER'))
	{
		define('EE_VARIABLES_ORDER', (get_cfg_var('variables_order'))?(get_cfg_var('variables_order')):"EGPCSs");
	}

	// clear %00 in possible file name
	foreach($_GET as $var=>$val)
	{
		$_GET[$var] = str_replace(chr(0), '', $_GET[$var]);
	}

	foreach($_POST as $var=>$val)
	{
		$_POST[$var] = str_replace(chr(0), '', $_POST[$var]);
	}

	/**
	 * unset global variables and set them using GET, POST etc in correct order
	 */
	if (1 or get_cfg_var('register_globals'))
	{
		$order = EE_VARIABLES_ORDER;

		$ar_globals = array (
			'G'=>$_GET,
			'P'=>$_POST,
			'C'=>$_COOKIE,
			'S'=>$_SERVER,
			's'=>(isset($_SESSION)?$_SESSION:array()),
			'E'=>$_ENV
			);

		for($i=0;$i<strlen($order);$i++)
		{
			$index = substr($order,$i,1);

			if (is_array($ar_globals[$index]))
			foreach ($ar_globals[$index] as $var=>$val)
			{
				/**
				 * remove some hack-related attemtions from GET, POST, COOKIE
				 * 10188, 10242
				 */
				if ($index == 'G' || $index == 'P' || $index == 'C')
				{
					$val = preg_replace("/^(.*,)*(:+(EE_[A-Z]+))/i", "\${3}", $val);
				}

				// 9882
				if (!is_array($$var))
				{
					unset ($$var);
					// if not _SESSION - set global var
					if ($index != 's')
					{
						$$var = $val;
					}
				}
			}
		}
	}

	$order = '';


	/**
	 * Load all EE-variables from config-table
	 * cache them to $CONFIG-array
	 */
	$sql_config_vars = 'select var, val, lang_code from config ORDER BY var, lang_code';
	$vars = db_sql_query($sql_config_vars);

	$CONFIG = array();
	while ($vr = db_sql_fetch_array($vars))
	{
		if ($vr['lang_code'] == '')
		{
			$CONFIG[$vr['var']] = $vr['val'];
		}
		else
		{
			if (!is_array($CONFIG[$vr['var']]))
			{
				unset($CONFIG[$vr['var']]);
			}

			$CONFIG[$vr['var']][$vr['lang_code']] = $vr['val'];
		}
	}

	/**
	 * DNS Draft mode
	 */
	$sql_lang_draft_status = sprintf(get_sql_for_current_dns(), 'draft_mode');
	list($dns_draft_status) = db_sql_fetch_row(db_sql_query($sql_lang_draft_status));


	/**
	 * Language forwarding
	 */
	$rs = db_sql_query('SELECT
				    language_code
			      FROM
				    v_language
			      JOIN
  				    dns
			        ON
				    v_language.language_code = dns.language_forwarding
			     WHERE
				    (dns = "'.EE_HTTP_HOST.'" OR dns = "www.'.EE_HTTP_HOST.'") AND v_language.status = 1 AND dns.status = 1
        	          ORDER BY
				    v_language.default_language DESC LIMIT 0, 1
	');

	list($default_language) = db_sql_fetch_row(db_sql_query('SELECT language_code FROM v_language ORDER BY default_language DESC'));

	$language_forwarding = $default_language;	

	if ($ar_language_forwarding = db_sql_fetch_row($rs))
	{
		$language_forwarding = $ar_language_forwarding[0];
	}

	if (!isset($language))
	{
		$language = $language_forwarding;
	}


	/**
	 * Load lenguage dependent constants if defined
	 */
	$UserLanguage = strtolower($language);
	$lang_fn = EE_PATH.'lang/lang_'.$UserLanguage.'.php';
	if ($UserLanguage != 'en' and file_exists($lang_fn))
	{
		include($lang_fn);
	}

	$lr = db_sql_query('SELECT language_code FROM v_language WHERE language_url=\''.$redir.'\'');
	/**
	 * For redirect from "/<%language%>" to "/<%language%>/" [teamtrack:11451]
	 * "/folder" and "/folder/" equal. So, header() function no place here.
	 */
	if (db_sql_num_rows($lr) > 0)
	{
		$redir .= '/';
	}

	/**
	 * Load all modules
	 */
/**
* Load modules specific for the current project from dir 'modules'
*/
$custom_modules_path = EE_PATH.'modules';

if (	($redir !== false || $admin_template == 'yes') &&
	file_exists($custom_modules_path)
)
{
	$handle = opendir($custom_modules_path);
	$custom_modules_path.= '/';

	while (false!==($file = readdir($handle)))
	{
		if (	$file != "." &&
			$file != ".." &&
			is_file($custom_modules_path.$file)
		)
		{
			if (	preg_match("/function.php$/i", $file)
				||
                preg_match("/class.php$/i", $file)
			)
			{
				require_once($custom_modules_path.$file);
			}
		}
	}

	closedir($handle);
}


/**
* And after that need to load core-modules from dir 'modules',
* and if module with such name exist in a specific modules then show error and stop execution.
*/
$core_modules_path = EE_PATH.EE_HTTP_PREFIX_CORE.'modules/';

if ($redir === false && $admin_template != 'yes' && !isset($_GET['t_view']))
{
	/* minimum functions loading */
	require_once($core_modules_path.'_base_function.php');
	require_once($core_modules_path.'config_function.php');
	require_once($core_modules_path.'convert_function.php');
	require_once($core_modules_path.'sql_function.php');
	require_once($core_modules_path.'tag_function.php');
	require_once($core_modules_path.'expanded_logging_function.php');
	require_once($core_modules_path.'f_db_url_mapping_function.php');

}
else
{
	$handle = opendir(substr($core_modules_path, 0, -1));

	while (false!==($file = readdir($handle)))
	{
		if (	$file != "." &&
			$file != ".." &&
			is_file($core_modules_path.$file)
		)
		{
			if (	preg_match("/function.php$/i", $file)
				||
                preg_match("/class.php$/i",$file)
			)
			{
				/**
				 * if the same file (exactly file, not directory!) was already loaded from custom-dir - stop!
				 */
			        if (	file_exists($custom_modules_path.$file) &&
					is_file($custom_modules_path.$file)
				)
				{
					die('Redeclaring of core modules is prohibited: Attempt of redeclaring of core module ['.EE_PATH.EE_HTTP_PREFIX_CORE.'modules/'.$file.'] was detected at ['.EE_PATH.'modules/'.$file.']');
				}
				else
				{
					require_once($core_modules_path.$file);
				}

			}
		}
	}

	closedir($handle);
}

/**
 * write to log select-queries or not
 */
$log_viewsql = get_config_var('log_viewsql');


if (EXPANDED_LOGGING_ON)
{
	// switch-on global logging
	turn_on_log_viewsql($log_viewsql);
}

/**
 * Error-reporting
 * report all bugs/warnings/noties in DEBUG_MODE
 * or use pre-defined error handler otherwise
 */
if (DEBUG_MODE)
{
//	error_reporting(E_ALL);
}
else
{
	error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING);
	//set_error_handler("userErrorHandler", E_ALL);
	set_error_handler("userErrorHandler", E_ALL & ~E_NOTICE);
}

/*
	foreach($_GET as $var=>$val)
	{
		if (!isset($_GET[md5(EE_FCK_EDITOR_ID)]) && !checkAdmin()) {
			$_GET = clean_tags($_GET);
		}
	}

	foreach($_POST as $var=>$val)
	{
		if (!isset($_POST[md5(EE_FCK_EDITOR_ID)]) && !checkAdmin()) {
			$_POST = clean_tags($_POST);
		}
	}
*/
	/**
	 * Language autoforwarding
	 */

	/**
	 * define language by browser options
	 * phpMyAdmin code is used
	 */
	include('lib/language_detector/select_lang.lib.php');

	/**
	 * define country by user ip
	 */
	include('lib/geoip/geoip.php');

	$getting_browser_language = strtoupper(PMA_langCheck());

	$geo_country_code = ee_get_country_by_ip();


	if (	//if language autoforwarding is enabled for site
		(config_var('language_autoforwarding') == 1) &&
		//if user first time come to current page of this site
		(parse_url(EE_HTTP_REFERER, PHP_URL_HOST) != EE_HTTP_HOST)
	)
	{
		$sql_part_query_lang_get = ' WHERE status=1 AND '.sqlValue($getting_browser_language).' LIKE language_of_browser ';

		//Check if this language is in DB. In else way leave default language (do nothing).
		$sql = 'SELECT language_code FROM language '.$sql_part_query_lang_get.' LIMIT 0,1';
		$language_in_db = getField($sql);

		if (array_key_exists($geo_country_code, $geo_ip_redirect_rate) && !check_admin_template()) // redirect by IP
		{
			$language = $geo_ip_redirect_rate[$geo_country_code];
		}
		else if ($language_in_db && !check_admin_template())
		{
			$language = $language_in_db;
		}
		elseif (	config_var('absent_browser_language_autoforwarding') == 1 &&
				config_var('abesent_browser_lang_aforward_target_url') &&
				!check_admin_template() &&
				EE_REQUEST_URI == '/'
		) // anee a nenoaia iaa iaoee oaeiai ycuea e aee??ai "default autoforwarding" oi....
		{
			$af_link_arr = unserialize(config_var('abesent_browser_lang_aforward_target_url'));

			$af_lang_link_type = $af_link_arr['link_type'];

			if ($af_lang_link_type == 'url')
			{
				$af_lang_link = EE_HTTP_PREFIX.ltrim($af_link_arr['link'], '/');
			}
			else
			{
				$af_lang_link = get_href($af_link_arr['link']);//always return full URL
			}

//var_dump(3); exit;
			header('Location: '.$af_lang_link, true, 302);
			exit;
		}
	}

	/**
	 *  REDIRECT - continuation.
	 *  Redirect from URL type of ?t=100&language=EN&t_view=1 	-> /EN/path/page.tpl_view.html
	 *                            ?t=100&language=EN	  	-> /EN/path/page.html
         *                            ?t=100				-> <%:default_language%>/path/page.html
	 *  Default language defined into lib.php
	 *  Redirect from URL type of EN/<%:unique_name%>.html to EN/<%:page_name_on_en%>.html. For details see TT #11511
	 */
	$page_id = getField('SELECT id FROM tpl_pages WHERE page_name='.sqlValue(is($t)) . ' OR id='.sqlValue(is($t)));

	if (	$page_id &&
		(!array_key_exists('admin_template', $_GET) || $_GET['admin_template'] != 'yes' || !checkAdmin()) &&
		$t !== 'tpl_preview'
	) {
		$t = $_GET['t'];
		$t_view = (array_key_exists('t_view', $_GET) && $_GET['t_view']) ? $_GET['t_view'] : null;

		$language_sql = 'SELECT language_code FROM v_language WHERE language_code = '.sqlValue($_GET['language']);

		if ($_GET['language'] && ($language_in_db = getField($language_sql)))
		{
			$language = $language_in_db;
		}
		else
		{
			$language = $default_language;
		}

		if (isset($object_name) && isset($object_id))
		{
//var_dump(111);
			$url = get_default_alias_for_object($object_id, $page_id, '', '', $language);
		}
		else
		{
//var_dump(222);
			$url = get_href($page_id, $language);
		}

		if (	strpos($url, '?t=') 	=== false &&
			strpos($url, '&t=') 	=== false &&
			strpos($url, EE_URI) 	=== false &&
			strpos(EE_HTTP.ltrim_str(EE_URI, EE_HTTP_PREFIX), $url)	=== false
		)
		{
//var_dump(EE_HTTP.ltrim_str(EE_URI, EE_HTTP_PREFIX));
//var_dump(EE_URI);
//var_dump($url);
//var_dump(4); exit;
			header('Location: '.$url, true, 301);
			exit;
		}
	}
//var_dump(44); exit;

	/**
	 * If this is alias - define real URL from permanent_redirect-table
	 */
	$page_is_alias = $page_is_system_alias = false;
	$is_redir = false;
	$count_redir_url = 0;

	if (	$redir !== false &&
		!check_admin_template() &&
		(strtolower(get_file_extension($redir)) != 'php' || (isset($thisfile) && $thisfile == "index"))
	)
	{

		$redir_request = substr(EE_REQUEST_URI, $l);
		$redir_alternative_url = EE_HTTP.prepare_source_url($redir_request);
		$sql_redir = 'SELECT * FROM permanent_redirect WHERE source_url="'.$redir_request.'" OR source_url="'.$redir_alternative_url.'" LIMIT 0,1';

		$page_test = viewSQL($sql_redir, 0);

		$count_redir_url = db_sql_num_rows($page_test);

		$is_um_object_redirect = false;

		if ($count_redir_url == 0)
		{
			$url_mapping_object_redirect_sql = '	SELECT * FROM 
									permanent_redirect_object
								WHERE 
									source_url='.sqlValue($redir).' 
									OR
									source_url='.sqlValue($redir_alternative_url);

			$page_test = viewSQL($url_mapping_object_redirect_sql, 0);

			$count_redir_url = db_sql_num_rows($page_test);

			$is_um_object_redirect = true;
		}

	}


	if ($count_redir_url > 0)
	{
		$page_is_alias = true;
		$p = db_sql_fetch_array($page_test);
		$t 		= ($is_um_object_redirect ? $p['object_record_id'] : $p['page_id']);
		$language 	= ($is_um_object_redirect ? $p['language'] : $p['lang_code']);

		if ($t === null)
		{
			$url = EE_HTTP.$p['target_url'];
		}
		else
		{
			if (	$p['t_view'] == null
				||
				$p['t_view'] == getField('SELECT id FROM tpl_views WHERE view_folder="'.EE_DEFAULT_TPL_VIEW_FOLDER.'"')
			)
			{
				$url = EE_HTTP.get_default_aliase_for_page($p['page_id']);
			}
			else
			{
				$url = get_view_href($p['page_id'], $p['t_view'], $p['lang_code']);
			}
		}

//var_dump(5); exit;
		header('Location: '.$url, true, 301);
		exit;
	}
	elseif (check_the_need_to_parse_url($redir) && is_map_url($redir)) // URL Mapping Redirect
	{
		set_map_url_params($redir, $language, $t_view, $object_id, $object_view);

		$t = getField('SELECT file_name FROM tpl_files WHERE id='.sqlValue($object_view));

		$page_type 	= 'html';
		$object_folder 	= config_var('object_folder');
		$object_name	= Get_object_name_by_record_id($object_id);

		set_content_type($page_type);

//var_dump(6); exit;
		header ('Status: 200 OK');
	}
	elseif (check_the_need_to_parse_url($redir))
	{
		if (getField('select count(*) from content where var = "folder_path_"') == 0)
		{
			update_folder_hierarhi(false);
		}

		// Alias Parsing
		if ($page_is_system_alias = parse_system_alias($redir, config_var('alias_rule'), array('page_folder' => '([\/0-9a-zA-Z_%&\.-]+)')))
		{
			check_default_alias_mask(config_var('alias_rule'),'page');
			// For the satelite-page alias
			if (isset($page_name))
			{
				$t = $page_name;
			}

			if (isset($page_folder))
			{
				$t = $page_folder.'/'.$t;
			}

			set_content_type(is($page_type));
		}
		elseif ($page_is_system_object_alias = parse_system_alias($redir, config_var('object_alias_rule')))
		{
			// If in .htaccess is next line
			// RewriteRule ^([A-z][A-z])/([A-z0-9\/]{1,})\.html$ /_core/ee/index.php?language=$1&t=$2&__replaced_not_for_8815_task [QSA]
			// Then for "object-url" we must to unset $_GET['t'], because with halp it $_GET['t'] we define the page (template)
			// but if it is objects then we define object_template with halp URL (get it from URL).
			unset($_GET['t']);
                        check_default_alias_mask(config_var('object_alias_rule'),'object');
			// For object-page alias
			$t = $object_view;
			$object_id = get_object_record_id_by_unique_name($object_id);
			set_content_type($page_type);

			// It is needs to get from variable $prev_keys variables :), and insert them into array $_GET, and make global.
			if (isset($prev_keys))
			{
				$added_get_vars = explode('&', $prev_keys);
			}

			if (	isset($added_get_vars) &&
				is_array($added_get_vars)
			)
			{
				foreach($added_get_vars as $v)
				{
					$cur_var_name_value = explode('=', $v);

					if (	array_key_exists(0, $cur_var_name_value) &&
						array_key_exists(1, $cur_var_name_value) &&
						$cur_var_name_value[0] != ''
					)
					{
						$cur_var_name = $cur_var_name_value[0];
						//Add to $_GET-array
						$_GET[$cur_var_name] = $cur_var_name_value[1];
						//Make it global
						global $$cur_var_name;
						$$cur_var_name = $cur_var_name_value[1];
					}
				}
			}
		}
		elseif($page_is_system_views_alias = parse_system_alias($redir, config_var('views_rule'), array('page_folder' => '([\/0-9a-zA-Z_%\.-]+)')))
		{
			// For the satellite-page view alias. Example: http://somehost/EN/page_name:t_view.html
			$t = $page_name;

			if (isset($page_folder))
			{
				$t = $page_folder . '/' . $t;
			}

			set_content_type($page_type);
		}
		elseif($page_is_system_views_alias = parse_system_alias($redir, config_var('object_views_rule'), array('page_folder' => '([\/0-9a-zA-Z_%\.-]+)')))
		{
			unset($_GET['t']);

			// For object-page alias
			$t = $object_view;
			$object_id = get_object_record_id_by_unique_name($object_id);
			set_content_type($page_type);
			
		}
		else
		{
			//we need to know a charset for error code page, but $langEncode will be declared later
			//so - declare it now
			$langEncode = get_Array_Language_Encode();

			// if $redir_status_in == 200 (.htaccess:rw_club) that we forced set error not found - 404
			if ($redir_status_in == '200')
			{
				header("HTTP/1.0 404 Not Found"); // without header visually we can see "404 page", but 200 code by response.
				parse_error_code('404');
			}
			else
			{
				parse_error_code($redir_status_in);
			}
		}
	}


/**
 * Find default page if current page is not defined still
 */

//	РµСЃР»Рё РЅР° Рґ-Р№ РјРѕРјРµРЅС‚ РІСЃРµ-РµС‰Рµ РЅРµ СѓСЃС‚Р°РЅРѕРІР»РµРЅР° $t (РЅРµ РѕРїСЂРµРґРµР»РµРЅР° СЃС‚СЂР°РЅРёС†Р°)
//	- Р·РЅР°С‡РёС‚ РїРѕСЃР»Рµ РёРјРµРЅРё РґРѕРјРµРЅР° С‚Р°Рє РЅРёС‡РµРіРѕ Рё РЅРµ РІРІРµР»Рё
//	РїРѕСЌС‚РѕРјСѓ, РµСЃР»Рё РёРјРµРµРј РґРµР»Рѕ РЅРµ СЃ РєР°РєРёРј-С‚Рѕ РјРѕРґСѓР»РµРј С‚РёРїР° _users.php РёР»Рё fck_custom/fckstyles.php -
//	РёС‰РµРј СЃС‚СЂР°РЅРёС†Сѓ, СѓСЃС‚Р°РЅРѕРІР»РµРЅРЅСѓСЋ РєР°Рє СЃС‚СЂР°РЅРёС†Р° РїРѕ СѓРјРѕР»С‡Р°РЅРёСЋ
//	get_dynamic_style - 8911 - (dynamic_style.php)

	if (isset($thisfile) && $thisfile == "index" && !(isset($admin) && $admin == true) && !isset($get_dynamic_style))
	{
		// РµСЃР»Рё Р·Р°Р»РѕРіРёРЅРёР»РёСЃСЊ Рё СЃРјРѕС‚СЂРёРј РЅР° СЃР°Р№С‚ РІ СЂРµР¶РёРјРµ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂР°
		if (check_admin_template())
		{          
			set_content_type('html');
		}

		if (!isset($t))
		{
			$sql = 'SELECT id FROM v_tpl_page WHERE folder_id IS NULL ORDER BY default_page DESC, id ASC LIMIT 0,1';
//var_dump($sql);
			$r = db_sql_fetch_array(viewsql($sql, 1));
//vdump($r, 'r');
			$t = $r['id'];
//vdump($t, 't');
//exit;
			// РµСЃР»Рё РЅРµ Р·Р°Р»РѕРіРёРЅРёР»РёСЃСЊ, Р»РёР±Рѕ Р·Р°Р»РѕРіРёРЅРёР»РёСЃСЊ РЅРѕ СЃРјРѕС‚СЂРёРј СЃС‚СЂР°РЅРёС‡РєСѓ Р±РµР· РјРµРЅСЋ Р°РґРјРёРЅРєРё,
			// РЅР°РїСЂРёРјРµСЂ РєР»РёРєРЅСѓРІ РїРѕ Р»РѕРіРѕС‚РёРїСѓ РІ РјРµРЅСЋ Р°РґРјРёРЅРєРё РёР»Рё СЂСѓРєР°РјРё СѓР±СЂР°РІ РІ URL'Рµ '&admin_template=yes'
			if (!check_admin_template())
			{
				// С‚Рѕ РЅСѓР¶РЅРѕ РІСЃРµ РІРёРґРµС‚СЊ РєР°Рє РїРѕР»СЊР·РѕРІР°С‚РµР»СЊ,
				// РїРѕСЌС‚РѕРјСѓ РµСЃР»Рё РЅРµ РЅР°С€Р»Р°СЃСЊ СЃС‚СЂР°РЅРёС‡РєР° - РіРѕРІРѕСЂРёРј РѕР± СЌС‚РѕРј Рё РІСЃРµ
				if (empty($t))
				{
					echo 'No default page';
					exit;
				}
				// РµСЃР»Рё Р¶Рµ РЅР°С€Р»Р°СЃСЊ - РїРµСЂРµС…РѕРґРёРј РЅР° РµРµ РєСЂР°СЃРёРІС‹Р№ URL
				else
				{
					$r_url  = get_href($t);
//var_dump(7); exit;
					header('Location: '.$r_url, true, 302);
					exit;
				}
			}
		}
	}


/**
 * Unset global variable $sql
 * it is necessary for not using incorrect query in object-based modules
 * where global $sql-variable is used when it is defined
 */
unset($sql);

/**
 * Process file version.info
 * load appropriate information from the file if it is present
 * die otherwise
 */
version_info();

/**
 * Global array of language encoding with keys of language code
 * langEncode['language_code'] = language_encode
 * $langEncode could be declared while parsing error code
 */
if (!isset($langEncode))
{
	$langEncode = get_Array_Language_Encode();
}

//set_mark('lib m');

//********************************************************************

/**
 * numeric equivalent of language code
 * used, for example, for create menu id if it's structure should be language depended
 * (concatenate to get_menu_level() first argument
 */
$lang_num_code = '';
for ($i=0;$i<strlen($language);$i++)
{
	$lang_num_code .= ord(substr($language,$i,1));
}

/**
 * try to autorize automaticaly if there are login/password in session
 */
CheckAdmin();

/**
 * if backoffice - generate dynamic top menu based on "admin/_*.php" modules
 * @see modules/dynamic_menu_function.php
 */
generate_dyn_menu(is($ar_admin_modules_black_list));

/**
 * Allowed URI params list, by default should be empty 
 */
$tpl_allowed_uri_params_list = array();	

/**
 * Check if DNS is enabled
 */
if ( 	$admin_template != 'yes' and
	$UserRole != ADMINISTRATOR and
	$UserRole != POWERUSER and
	$modul=="" and
	dns_disabled() and
	strpos(EE_PHP_SELF, EE_HTTP_PREFIX.EE_HTTP_PREFIX_CORE.EE_ADMIN_SECTION_IN_HTACCESS.'includer.php') === false and
	post('action') != 'admin_section_login'
   )
{
	parse_error_code(600);
}


//********************************************************************
function dns_disabled ()
{
	// Check if current DNS is enabled
	$sql = 	sprintf(get_sql_for_current_dns(),'*');
	return !db_sql_num_rows(viewsql($sql, 0));
}

//********************************************************************
function check_template_db($file)
{
	global $language;
	global $page_type;

	$rs = query_alias_info($file, '', ($page_type ? $page_type : false));

	if (db_sql_num_rows($rs) == 1)
	{
		$r = db_sql_fetch_assoc($rs);

		$file = $_GET['t_name'] = $GLOBALS['t_name'] = $r["file_name"];
		// ia oio neo?ae, anee $t auei ?aaii ia id, a iacaaie? no?aieou
		// - ianeeuii noaaei $t = id,
		// a eiy no?aieou caiiieiaai a t_name
		if (!is_numeric($GLOBALS['t']))
		{
			$GLOBALS['t_name'] = $GLOBALS['t'];
			$GLOBALS['t'] = $r["id"];
		}
		else
		{
			$GLOBALS['t_name'] = $r["page_name"];
		}

		if ($r["type"]==0) // only for pages, not for media etc!
		{
			$GLOBALS['page_file'] = $r["file_name"];
			$GLOBALS['page_id'] = $r["id"];
			$GLOBALS['page_name'] = $r["page_name"];
			$GLOBALS['page_name_for_current_language']  = cms('page_name_'.$r['id'], '', $language);
			$GLOBALS['page_description'] = $r["page_description"];
			$GLOBALS['page_folder'] = $r["folder"];
			$GLOBALS['page_is_index'] = $r["for_search"];
			//page access type: everyone has an access or some user's groups
			$GLOBALS['page_access_type'] = $r["group_access"];
			$GLOBALS['extension'] = $r["extension"];
		}

		$GLOBALS['page_type'] = $r["type"];
	}

	return $file;
}

function is_mobile(){
	$useragent=$_SERVER['HTTP_USER_AGENT'];
	if(preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4))
	)
		return 1;
	else return 0;
}
$detect = new Mobile_Detect();

$isMobile = $detect->isMobile();

function check_template($file, $check_db = true)
{
	global $admin, $ignore_admin, $t_view, $isMobile;
	global $view_template_not_find, $first_view_template_find;

	$view_template_not_find = false;

	// if it is not just <%include:...%> in some template
	if ($check_db){
		// full path may be used only in <%include:...%>
		// so, in this case - remove full path (hack-fix)
		$file = str_replace(EE_PATH, '', $file);
		// find tpl in db, if no - the same
		$file = check_template_db($file);
	}

	// removes "../" from the path
	$file = reduce_path_to_canonical($file);

	if (strpos($file, EE_PATH)===false)
	{
		$origin_file = $file;//need fot t_views

		if($isMobile && file_exists(EE_PATH.'templates/mobile/'.$file.'.tpl'))
			$file = 'templates/mobile/'.$file;
		else
			$file = 'templates/'.$file;
	}
//res($file);
	$file = $file.'.tpl';

	$file_for_fopen = $file;
	if (	$admin && $ignore_admin!=1){
		if (strpos($file, EE_PATH)===false)
		{
			if (!file_exists($file_for_fopen = EE_ADMIN_PATH.$file))
			{
				$file_for_fopen = get_core_admin_template($file);
			}
		}
	}
	else {
		// if 't_view' determinate - try get tpl from /VIEWS folder
        	if (isset($t_view) && strpos($file, EE_PATH)===false)
		{
			$view_folder = getField('SELECT view_folder FROM v_tpl_views WHERE view_name='.sqlValue($t_view));

			if (!empty($view_folder))
			{
				$t_view = $view_folder;
			}

			$t_view = reduce_path_to_canonical($t_view);

			$filet = 'templates/VIEWS/'.$t_view.'/'.$origin_file.'.tpl';
		}
		else {
			$filet = $file;
		}
		
		if (strpos($filet, EE_PATH)===false) {
			$file_for_fopen = EE_PATH.$filet;
		}

		// if tpl absent in VIEWS - try find it in /templates/
		if (!file_exists($file_for_fopen)) {
			if (!$first_view_template_find){
				$view_template_not_find = true;
			}

			if (strpos($file, EE_PATH)===false){
				$file_for_fopen = EE_PATH.$file;
			}
		}
		else {
			$first_view_template_find = true;
		}

		// if tpl absent in /templates/ - try find it in /_core/ee/templates
		if (!file_exists($file_for_fopen))
		{
			$file_for_fopen = EE_CORE_PATH.$file;
		}
	}


	if (file_exists($file_for_fopen) and filesize($file_for_fopen)>0)
	{
		$fd = fopen($file_for_fopen, "r");
		$ret = fread($fd, filesize($file_for_fopen));
		fclose($fd);

		return $ret;
	}
	else
	{
		msg($file_for_fopen, 'no template file');
//vdump(DEBUG_MODE);
//exit;
		if (DEBUG_MODE==0)
		{
			parse_error_code('404');
		}
	}
}


/*
* Use for real template (file) parsing, not for satellite-pages
*/
function parse_tpl($tpl_name, $ar_visited=array())
{
	// don't look in DB because of it's about real template
	return parse($tpl_name, $ar_visited, false);
}


/*
* Use for satellite-pages parsing as well as for real template (file) parsing
*/
function parse($t_id, $ar_visited='', $check_db=true)
{
//var_dump($t_id);
	if ($t_id != '')
	{
		global $t_cache, $t, $page_type;

		if(!empty($t_id) && (is_array($ar_visited) && in_array($t_id, $ar_visited)))
		{
			echo '***Error: recursion in branch '."\r\n";
			print_r($ar_visited);
			echo ' node '.$t_id.'. Aborting template.';
			return;
		}
		else
		{
			$ar_visited[] = $t_id;
		}

		if (empty($t_cache[$t_id]))
		{
			$t_cache[$t_id] = check_template($t_id, $check_db);
		}

		$t_text = $t_cache[$t_id];
		$tmp_page_type = $page_type;
		$result = parse2($t_text, 0, $ar_visited);
		$page_type =  $tmp_page_type;
		// if this is just a page - not a media or something like that
		if ($GLOBALS['page_type']==0){
//			$result = replace_amps($result);
		}
	}
	else {
		$result = '';
	}

	return $result;
}


/*
* Use for text (code) parsing
*/
function parse2($t_text, $recursion_level = 0, $ar_visited = '')
{
	global $admin_template, $top_menu_active;

	$t_len = strlen($t_text);
	$s = '';

	for ($i=0; $i < $t_len; $i++)
	{
		// euai aee?aeoee ioe?uaa?uee oaa
		$tagOpen = $tagOpenNext = strpos($t_text, "<%", $i);
		// anee oaeeo aieuoa iao - cia?eo inoaeny iau?iue html,
		if ($tagOpen === false)
		{
			// ... aai e aica?auaai
			$s.= substr($t_text, $i);
			break;
		}
		else
		{
			// au?eneyai iiceoe? cae?uaa?uaai oaaa
			$tagClose = strpos($t_text, "%>", $tagOpen);

			// au?eneyai iiceoe? aicii?iiai neaao?uaai ioe?uoey
			while (	($tagOpenNext = strpos($t_text, "<%", $tagOpenNext + 1)) !== false &&
				$tagOpenNext < $tagClose
			)
			{
				// anee naaao?uee oaa ioe?ueny ?aiuoa,
				// ?ai cae?ueny i?aauaouee,
				// cia?eo eiaai aaei n aei?aieai oaaia
				// iioiio iaoiaei neaao?uee cae?uaa?uee oaa
				// e naaeaaai oeacaoaeu cae?. oaaa ia iaai
				$tagClose = strpos($t_text, "%>", $tagClose + 1);

			}

			if ($tagClose === false)
			{
				$ar_debug_backtrace = debug_backtrace();

				foreach ($ar_debug_backtrace as $i => $ar)
				{
					if ($ar['function']=='parse')
					{
						$template_name = $ar['args'][0];
						break;
					}
				}

				trigger_error('Unclosed EE-tag in template'.(isset($template_name) ? ' "'.$template_name.'.tpl' : '-code "'.htmlentities($t_text)).'"');

				break;
			}

			$tag = substr($t_text, $tagOpen + 2, $tagClose - $tagOpen - 2);

			// anee a iieo?eaoainy oaaa anou aei?aiuie oaa -
			if (strpos($tag, "<%") !== false and strpos($tag, "%>") !== false)
			{
				// i?aaaa?eoaeuii ia?nei iieo?eaoeeny oaa (?aeo?ney)
				$tag = parse2($tag, $recursion_level+1);
			}

			$s.= substr($t_text, $i, $tagOpen - $i);

			if (($col_pos = strpos($tag, ":")) !== false)
			{
				$vtag_name = substr($tag, 0, $col_pos);
				$vtag_value = substr($tag, $col_pos + 1);

				switch ($vtag_name)
				{
					case "include":
						$s.= parse_tpl($vtag_value, $ar_visited);
						break;

					default:
						$s.= tag_func($vtag_name, $vtag_value, $recursion_level);
						break;
				}
			}
			elseif (function_exists($tag))
			{
				$s.= $tag();
			}
			else
			{
				$s.= $tag;
			}

			$i = max($tagClose + 1, $i);
		}
	}

	return $s;
}
//if(!$check_admin) { add_statistic(); }

function set_global_vars ($order)
{
	// anee ia aee??aia iioey PHP
	// onoaiiaee aeiaaeuiuo ia?aiaiiuo ec aeiaaeuiuo ianneaia
	// - onoaiaaeeaaai eo naie a oeacaiiii $order ii?yaea
	if (!get_cfg_var('register_globals'))
	{
		$ar_globals = array (
			'G'=>$_GET,
			'P'=>$_POST,
			'C'=>$_COOKIE,
			'S'=>$_SERVER,
			'E'=>$_ENVIRONMENT,
			'F'=>$_FILES
			);
		for($i=0;$i<strlen($order);$i++)
		{
			$index=substr($order,$i,1);
			if (is_array($ar_globals[$index]))
			foreach($ar_globals[$index] as $var=>$val)
			{
				if ($index=='F') $val = $val['name'];
				global $$var;
				$$var = $val;
			}
		}
		return true;
	}
	else
	{
		return false;
	}
}

function stripslashes_in_get()
{
	// anee onoaiiaeaii ae?aie?iaaiea ia o?iaia na?aa?a
	// - oae?aai ec $_GET eeoiea neyoe
	if(get_magic_quotes_gpc()) stripslashes_in($_GET);
}

function stripslashes_in_post()
{
	// anee onoaiiaeaii ae?aie?iaaiea ia o?iaia na?aa?a
	// - oae?aai ec $_POST eeoiea neyoe
	if(get_magic_quotes_gpc()) stripslashes_in($_POST);
}

function stripslashes_in(&$arr)
{
	// - oae?aai ec $arr eeoiea neyoe
	foreach ($arr as $k=>$v)
	{
		if (is_array($v))
			stripslashes_in($arr[$k]);
		else if (is_string($v))
			$arr[$k] = stripslashes($v);
	}
}

function prepare_cookie_session_name($p_session_name)
{
	return str_replace('.', '_', $p_session_name);
}

function set_session_name($p_session_name)
{
	// session name must not contain dot-symbols
	return session_name(prepare_cookie_session_name($p_session_name));
}

function userErrorHandler($errno, $errmsg, $filename, $linenum, $vars)
{
//var_dump(EE_ERROR_LOG_PATH);
	global $global_reply_mail_box, $global_reply_mail_box_name, $errortype;
	$global_reply_mail_box = EE_SUPPORT_EMAIL;
	$global_reply_mail_box_name = 'EngineExpress error handling';
//var_dump($global_reply_mail_box);
//var_dump($errortype);
//var_dump($error_handle[1][$errno]);
//exit;
// 	list($error_handle) = db_sql_fetch_row(db_sql_query('SELECT val FROM config WHERE var = "error_handle"'));
//	$error_handle = unserialize($error_handle);
	$error_handle = unserialize(get_config_var('error_handle'));
    // timestamp for the error entry
	$dt = date("Y-m-d H:i:s (T)");

	if (	$error_handle[1][$errno] == 1
		||
		$error_handle[2][$errno] == 1
		||
		$error_handle[3][$errno] == 1
	)
	{
		$backtrace = parse_backtrace(debug_backtrace());
	}
	
	// save to the error log,
	if ($error_handle[1][$errno] == 1)
	{
		$err = "<errorentry>\n";
		$err .= "\t<datetime>" . $dt . "</datetime>\n";
		$err .= "\t<host>" . EE_HTTP_SERVER . "</host>\n";
		$err .= "\t<uri>" . EE_REQUEST_URI . "</uri>\n";
		$err .= "\t<url>" . EE_HTTP_SERVER . EE_REQUEST_URI . "</url>\n";
		$err .= "\t<errornum>" . $errno . "</errornum>\n";
		$err .= "\t<errortype>" . $errortype[$errno] . "</errortype>\n";
		$err .= "\t<errormsg>" . $errmsg . "</errormsg>\n";
		$err .= "\t<scriptname>" . $filename . "</scriptname>\n";
		$err .= "\t<scriptlinenum>" . $linenum . "</scriptlinenum>\n";

		if ($backtrace != '')
		{
			$err .= "\t<backtrace>" . $backtrace . "</backtrace>\n";
		}

		$err .= "</errorentry>\n\n";

		// 10213
		if (check_file(EE_ERROR_LOG_PATH))
		{
			$logfile_size = filesize(EE_ERROR_LOG_PATH);
		}
		else
		{
			$logfile_size = 0;
		}

		$result_logfile_size = $logfile_size + strlen($err);

		$run_error_log = true;

		if ($result_logfile_size > ($logfile_maxsize = get_config_var('logfile_maxsize')))
		{
			if (!defined('EE_LOG_STOP_RESET_MAIL_TO'))	define('EE_LOG_STOP_RESET_MAIL_TO', 'ee_priority_support@2kgroup.com');

			$headers = 'X-Priority: 1'."\n";
			$headers.= 'From: "'.$global_reply_mail_box_name.'" <'.$global_reply_mail_box.'>'."\n";

			if (EE_LOG_RESET == ($logfile_stop_reset = get_config_var('logfile_stop_reset')))
			{
				$can_not_reset = false;

				// try to lock and then trancate log file
				if (is_writeable(EE_ERROR_LOG_PATH))
				{
					$lock_start_time = time();

					// trancate file
					$handle = fopen(EE_ERROR_LOG_PATH, "w");

					do
					{
						$locked = flock($handle, LOCK_EX);

						// If lock not obtained sleep for 0 - 100 milliseconds, to avoid collision and CPU load
						if (!$locked)
						{
							usleep(round(rand(0, 100)*1000));
						}

					} while ((!$locked) && (($delta = time() - $lock_start_time) < 2));

					// release the lock
					flock($handle, LOCK_UN);

					fclose($handle);

					// Since of the results of filesize() function are cached...
					clearstatcache();

					if (filesize(EE_ERROR_LOG_PATH)==0)
					{
						mail(EE_LOG_STOP_RESET_MAIL_TO, 'Error-log file was reseted.', EE_HTTP."\r\n\r\n".'Log file size ('.$result_logfile_size.' bytes) has reached max size ('.$logfile_maxsize.' bytes).'."\r\n".'According to current configuration file "'.EE_ERROR_LOG_PATH.'" was reseted.', $headers);
					}
					else
					{
						$can_not_reset = true;
					}
				}
				else
				{
					$can_not_reset = true;
				}

				if (!defined('EE_CAN_NOT_RESET_LOG_FILE_NAME'))	define('EE_CAN_NOT_RESET_LOG_FILE_NAME', 'can_not_reset_log.txt');

				if ($can_not_reset && !file_exists($can_not_reset_log_file_name = EE_PATH.EE_CAN_NOT_RESET_LOG_FILE_NAME))
				{
					mail(EE_LOG_STOP_RESET_MAIL_TO, 'Can\'t reset error-log file.', EE_HTTP.': can\'t reset log file "'.EE_ERROR_LOG_PATH.'". Check if file is writeable. Loging is stoped.', $headers);

					if ($handler_can_not_reset = fopen($can_not_reset_log_file_name, "w"))
					{
						fwrite($handler_can_not_reset, date(DATETIME_FORMAT_PHP)."\r\n".'Delete this file for further mail notification about log-file reseting errors.'."\r\n");

						fclose($handler_can_not_reset);
					}

					// if can't reset log file - don't log into it
					$run_error_log = false;
				}
			}
			elseif (EE_LOG_STOP == $logfile_stop_reset &&
				// $logfile_size is verified
				// instead of $result_logfile_size
				// because we need mail about stoping only once
				$logfile_size <= $logfile_maxsize
			)
			{
				mail(EE_LOG_STOP_RESET_MAIL_TO, 'Error loging to file was stoped.', EE_HTTP."\r\n\r\n".'Log file size ('.$result_logfile_size.' bytes) has reached max size ('.$logfile_maxsize.' bytes).'."\r\n".'According to current configuration loging to file "'.EE_ERROR_LOG_PATH.'" was stoped.', $headers);

				// so we will add error-info into file this last time
				// and in future file size verification above 
				// will help us to not mail again

				//in real this assigning is one too many here
				$run_error_log = true;
			}
		}

		if ($logfile_size > $logfile_maxsize)
		{
			// if current size of log-file is greater then max available size
			//  - don't log in any case
			$run_error_log = false;
		}

		if ($run_error_log)
		{
			error_log($err, 3, EE_ERROR_LOG_PATH);
		}
	}


	// and e-mail me if there is a critical user error
	// and not too many mails were already sent

	if (!defined('EE_WARNINGS_STOP_FILE_NAME'))	define('EE_WARNINGS_STOP_FILE_NAME', 'warnings_stop.txt');

	if (	$error_handle[2][$errno] == 1 &&
		!(file_exists(EE_PATH.EE_WARNINGS_STOP_FILE_NAME))
	)
	{
		$err_text = "<html><head><style>.bold{font-weight:bold;} .cell{vertical-align:top;min-width:117px;width:120px;text-align:right;padding-right:5px;}</style></head>\n<body>\n<table style=\"table-layout:fixed;width:1200px;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n";
		$err_text .= "\t<tr><td class=\"cell\" width=\"120px\">Host: </td><td class=\"bold\">". EE_HTTP_SERVER . " (".gethostbyname(EE_HTTP_HOST).")</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">URI: </td><td>" . EE_REQUEST_URI . "</td></tr>\n";
		if (isset($_SERVER['HTTP_REFERER']))
		{
			$err_text .= "\t<tr><td class=\"cell\">Referer: </td><td>" . $_SERVER['HTTP_REFERER'] . "</td></tr>\n";		
		}
		$err_text .= "\t<tr><td class=\"cell bold\">".$errortype[$errno].": </td><td class=\"bold\">". $errmsg . "</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">File (line $linenum): </td><td>" . $filename . "</td></tr>\n";
		if ($backtrace != '')
		{
			$err_text .= "\t<tr><td class=\"cell\" valign=\"top\">Backtrace: </td><td>" . $backtrace . "</td></tr>\n";
		}                                             		                                              
		$err_text .= "\t<tr><td class=\"cell bold\">Method: </td><td>" . $_SERVER['REQUEST_METHOD'] . "</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">GET: </td><td>" . print_array($_GET) . "</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">POST: </td><td>" . print_array($_POST) . "</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">Remote address: </td><td>" . $_SERVER['REMOTE_ADDR'] . "</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">User agent: </td><td>" . $_SERVER["HTTP_USER_AGENT"] . "</td></tr>\n";
		$err_text .= "\t<tr><td class=\"cell\">EE Version: </td><td>" . get_version_info() . "</td></tr>\n";
		$err_text .= "</table></body></html>\n\n";
		send_error_report(EE_HTTP_SERVER.' '.$errortype[$errno].' ('.$filename.')', $err_text);
		update_warnings_log();
	}

	// show error on screen if need
	if ($error_handle[3][$errno] == 1)
	{
//		$err_text = "<div><b>". $errortype[$errno] .'</b><br />'. $errmsg . "<br />";
//		$err_text .= "at file - " . $filename . "<br />\n";
//		$err_text .= "on line -  " . $linenum . "\n";
//		$err_text .= "</div>";
		echo parse('error_php'); exit;
	}
}


function get_sql_for_current_dns()
{
	return	'select %s from dns where (dns="'.EE_HTTP_HOST.'" or dns="www.'.EE_HTTP_HOST.'") and status="1"';
}


function is_in_admin()
{
	global $modul, $admin_template;

	return (	(strpos(strtolower(EE_PHP_SELF), strtolower(EE_HTTP_PREFIX.EE_ADMIN_SECTION)) !== false
			|| strpos(strtolower(EE_PHP_SELF), strtolower(EE_HTTP_PREFIX_CORE.EE_ADMIN_SECTION)) !== false
			|| $admin_template == 'yes'
			|| !empty($modul)
			)
	  	) ? true : false;
}


function detect_sent_charset()
{
	if (!function_exists('headers_list'))
	{
		//Abort function
		return true;
	}
	$header_list_array = headers_list();
	foreach($header_list_array as $val)
	{
		if(strpos(strtolower($val), 'charset') > 0 &&
		   strpos(strtolower($val), 'content-type:') === 0)
		{
			return true;
		}
	}
	return false;
}


function set_mark($mark = false, $addition_info = false, $print = true)
{
	global $time_benchmark, $total_time_benchmark;

	if (EE_SET_BENCHMARK_ON)
	{
		if ($time_benchmark === null || $mark === false)
		{
			$time_benchmark = microtime(true);
			$total_time_benchmark = 0;
		}
		else
		{
			$sub = bcsub(microtime(true), $time_benchmark, 6);
			$mark = '<!-- '.$mark.' : '.$sub.' sec. -->'."\r\n";
			if ($addition_info)
			{
				$mark .= '<!-- '.$addition_info.' -->'."\r\n";
			}                                        

			$total_time_benchmark += $sub;

			$time_benchmark = microtime(true);

			if ($print)
			{
//$mark = str_replace("\r\n", '<br>'."\r\n", htmlentities($mark));
				echo $mark;
			}
			else
			{
				return $mark;
			}
		}
	}
}


function get_total_benchmark_time($text_label)
{
	global $total_time_benchmark;
	$text_label = $text_label ? $text_label : 'TOTAL BENCHMARK TIME';
	return '<!-- '.$text_label.': '.$total_time_benchmark.'sec. -->';
}


function total_benchmark_time($text_label)
{
	echo htmlentities(get_total_benchmark_time($text_label)).'<br/>';
}


if ($dns_draft_status)
{
	authorize_for_draft_mode(EE_PHP_AUTH_USER, EE_PHP_AUTH_PW);
}

/**
 * 
 * If somebody wants to get file in core module related admin templates
 * (_core/ee/admin/templates/_dns)
 * and there is no such file -
 * try to get it from commom core admin templates
 * (_core/ee/admin/templates)
 *
 */
function get_core_admin_template($file)
{
	if (strpos($file, EE_CORE_ADMIN_PATH.'templates/')===0)
	{
		$result = $file;
	}
	else
	{
		if (strpos($file, EE_CORE_ADMIN_PATH)===0)
		{
			$result = EE_CORE_ADMIN_PATH.'templates/'.substr($file, strlen(EE_CORE_ADMIN_PATH));
		}
		else
		{
			if (strpos($file, 'templates/')===0)
			{
				$result = $file;
			}
			else
			{
				$result = 'templates/'.$file;
			}

			$result = EE_CORE_ADMIN_PATH.$result;
		}
	}

	if (!file_exists($result))
	{
		global $modul;

		if (strpos($result, ($path_to_be_removed = EE_CORE_ADMIN_PATH.'templates/'.$modul.'/')) === 0)
		{
			$result = EE_CORE_ADMIN_PATH.'templates/'.substr($result, strlen($path_to_be_removed));
		}
	}

	return $result;
}


function update_warnings_log()
{
	if (!defined('EE_WARNINGS_STOP_FILE_NAME'))	define('EE_WARNINGS_STOP_FILE_NAME', 'warnings_stop.txt');

	$w_stop = EE_PATH.EE_WARNINGS_STOP_FILE_NAME;

	if (file_exists($w_stop))
	{
		$result = false;
	}
	else
	{
		$result = true;

		if (!defined('EE_WARNINGS_LOG_FILE_NAME'))	define('EE_WARNINGS_LOG_FILE_NAME', 'warnings_log.txt');

		$w_log = EE_PATH.EE_WARNINGS_LOG_FILE_NAME;

		if (!defined('EE_FIRST_UPDATE_TIME'))	define('EE_FIRST_UPDATE_TIME', 'First update time');
		if (!defined('EE_MAILS_ALREADY_SENT'))	define('EE_MAILS_ALREADY_SENT', 'Mails already sent');
		if (!defined('EE_LAST_UPDATE_TIME'))	define('EE_LAST_UPDATE_TIME', 'Last update time');

		if (!defined('EE_WARNINGS_STOP_MESSAGE'))	define('EE_WARNINGS_STOP_MESSAGE', "\r\n".'For last %s %s(s) more then %s warnings were sent.'."\r\n".'Warnings sending is stoped now.'."\r\n".'Delete %s file to start warnings sending again.');

		$ar_shablon = array(
			EE_FIRST_UPDATE_TIME => time(),
			EE_MAILS_ALREADY_SENT => 0,
			EE_LAST_UPDATE_TIME => time(),
		);

		$ar_shablon_keys = array_keys($ar_shablon);

		$ar_res = array();

		if (check_file($w_log))
		{
			$ar_w_log = file($w_log);

			foreach ($ar_w_log as $row)
			{
				if (strpos($row, '='))
				{
					list($key, $val) = explode('=', $row);

					$ar_res[$key] = trim($val);
				}
			}
		}

		for ($i=0; $i<count($ar_shablon_keys); $i++)
		{
			if (array_key_exists($ar_shablon_keys[$i], $ar_res))
			{
				$ar_shablon[$ar_shablon_keys[$i]] = $ar_res[$ar_shablon_keys[$i]];
			}
		}

		$warnings_notices_max_count = get_config_var('warnings_notices_max_count');
		$warnings_notices_max_period = get_config_var('warnings_notices_max_period');
		$warnings_notices_max_period_type = get_config_var('warnings_notices_max_period_type');

		$ar_seconds = array(
			'second' =>	1,
			'minute' =>	60,
			'quarter' =>	60*15,
			'hour' =>	60*60,
			'day' =>	60*60*24,
		);

		$time = time();
		$first_update_time = $ar_shablon[EE_FIRST_UPDATE_TIME];
		$delta = $time - strtotime($first_update_time);

		if ($delta < $ar_seconds[$warnings_notices_max_period_type]*$warnings_notices_max_period)
		{
			$ar_shablon[EE_MAILS_ALREADY_SENT]+= 1;

			if ($ar_shablon[EE_MAILS_ALREADY_SENT] > $warnings_notices_max_count)
			{
				if ($handle = fopen($w_stop, "w"))
				{
					fwrite($handle, implode(chr(13).chr(10), $ar_shablon));
					fclose($handle);

					if (!defined('EE_WARNINGS_STOP_MAIL_TO'))	define('EE_WARNINGS_STOP_MAIL_TO', 'ee_priority_support@2kgroup.com');

					if (!defined('EE_WARNINGS_STOP_MAIL_SUBJECT'))	define('EE_WARNINGS_STOP_MAIL_SUBJECT', 'For last %s %s(s) more then %s warnings were sent.');

					global $global_reply_mail_box_name, $global_reply_mail_box;

					$headers = 'X-Priority: 1'."\n";
					$headers.= 'From: "'.$global_reply_mail_box_name.'" <'.$global_reply_mail_box.'>'."\n";

					if (!mail(EE_WARNINGS_STOP_MAIL_TO, sprintf(EE_HTTP.': '.EE_WARNINGS_STOP_MAIL_SUBJECT, $warnings_notices_max_period, $warnings_notices_max_period_type, $warnings_notices_max_count), sprintf(EE_HTTP."\r\n".EE_WARNINGS_STOP_MESSAGE, $warnings_notices_max_period, $warnings_notices_max_period_type, $warnings_notices_max_count, EE_WARNINGS_STOP_FILE_NAME), $headers))
					{
						trigger_error('Can\'t send warnings-stop mail to '.EE_WARNINGS_STOP_MAIL_TO);
					}
				}
				else
				{
					trigger_error('Can\'t create file '.$w_stop.'. Check if folder '.EE_HTTP.' is writeable');
				}
			}
		}
		else
		{
			$ar_shablon[EE_FIRST_UPDATE_TIME] = date(DATETIME_FORMAT_PHP);
			$ar_shablon[EE_MAILS_ALREADY_SENT] = 1;
		}

		$ar_shablon[EE_LAST_UPDATE_TIME] = date(DATETIME_FORMAT_PHP, $time);

		$ar_w_log = array();

		foreach ($ar_shablon as $key=>$val)
		{
			$ar_w_log[] = $key.'='.$val;
		}

		if (file_exists($w_stop))
		{
			$ar_w_log[] = sprintf(EE_WARNINGS_STOP_MESSAGE, $warnings_notices_max_period, $warnings_notices_max_period_type, $warnings_notices_max_count, EE_WARNINGS_STOP_FILE_NAME);

			$result = false;
		}

		if ($handle = fopen($w_log, "w"))
		{
			fwrite($handle, implode(chr(13).chr(10), $ar_w_log));
			fclose($handle);
		}
		else
		{
			trigger_error('Can\'t write to file '.$w_log.'. Check if folder '.EE_HTTP.' and file '.$w_log.' are writeable');
		}
	}

	return $result;
}


/**
 *
 * replaces "\", "//" and "../" by "/", ".." - by "."
 * @param string $string - some path
 * @return path with
 *    "/" instead of "../" or "\" or "//"
 * and
 *    "." instead of ".."
 */
function reduce_path_to_canonical($string)
{
	$patterns = array(
		"/(\/|\\\)*((\\.+(\/|\\\)+)+)(\.*)(\\\)*(\/)*/i",
		"/(\\\|\/)+/",
		"/(\\.)+(\\.)*/i"
	);
	$replace = array('/', '/', '.');

	$string = preg_replace($patterns, $replace, $string);

	return $string;
}

function check_the_need_to_parse_url($redir)
{
	return ($redir !== false && !is_in_admin() 
		&& 
		array_key_exists('SCRIPT_NAME',$_SERVER) 
		&& 
		$_SERVER['SCRIPT_NAME'] == EE_HTTP_PREFIX.EE_HTTP_PREFIX_CORE.'index.php' 
		&& 
		array_key_exists('REQUEST_URI',$_SERVER) 
		&& 
		$_SERVER['REQUEST_URI'] != EE_HTTP_PREFIX.'sitemap.xml' //if we need sitemap, we do not need to parse url
	);
}

function reduce_html_links($html)
{
	$cdn_server = get_cdn_server();

	if (	$cdn_server &&
		(!CheckAdmin() || $admin_template != 'yes')
	)
	{
		$cdn_pattern 		= array(
							'/("|\'|url\()('.str_replace('/', '\/', EE_HTTP).'|\/)([^"\'\s]*)\.(jpg|jpeg|gif|png|swf|bmp|pdf|doc)("|\'|\))/i'
						);

		$cdn_replacement 	= array(
							'$1http://'.$cdn_server.EE_HTTP_PREFIX.'$3.$4$5'
						);

		$html = preg_replace($cdn_pattern, $cdn_replacement, $html);
	}

	// change absolute links to relative
	$links_pattern = array(
		'"'.EE_HTTP,
		'\''.EE_HTTP,
		'('.EE_HTTP
	);
	$links_replacement = array(
		'"'.EE_HTTP_PREFIX,
		'\''.EE_HTTP_PREFIX,
		'('.EE_HTTP_PREFIX
	);
	$html = str_replace($links_pattern, $links_replacement, $html);

	return $html;
}

function clean_tags($val)
{
	if (is_array($val))
	{
		foreach($val as $v => $k)
		{
			$val[$v] 	= clean_tags($val[$v]);
		}
		return $val;
	}
	else
	{
		return strip_tags(urldecode($val));
	}
}

