<?php                                                                               
//mail('sergep@2kgroup.com', 'opros debug SESSION', print_r($_SESSION, true));
//mail('sergep@2kgroup.com', 'opros debug SERVER', print_r($_SERVER, true));
//mail('sergep@2kgroup.com', 'opros debug GET', print_r($_GET, true));
//mail('sergep@2kgroup.com', 'opros debug POST', print_r($_POST, true));
$thisfile = "index";



require_once('define_constants.php');
require_once('modules/cache_min_function.php');
// Next module was included just becouse of function "set_content_type"
// If we need to use cache-version, we should have posibility to define type of cached content


session_name(str_replace('.', '_', EE_HTTP_PREFIX));
session_start();

global $content_type;

$request_page 	= substr($_SERVER['REQUEST_URI'], strlen(EE_HTTP_PREFIX));
$extension 	= pathinfo($request_page, PATHINFO_EXTENSION);

if (!isset($_GET['admin_template']) &&  $html = cache_get_page($request_page))
{
	$p_1		= strpos($html, "\r\n");
	$additional_info = unserialize(str_replace(array('<!--', '-->'), array('', ''), (substr($html, 0, $p_1))));

	$status 	= $additional_info['status'];
	$content_type 	= $additional_info['content_type'];
	$charset	= $additional_info['charset'];

	$html = trim(substr($html, $p_1+1));

	header('HTTP/1.1 '.$status);
	header('Status: '.$status);

	$header 	= 'Content-type: '.$content_type.($charset ? '; charset='.$charset : '');

	header($header);
	if (isset($additional_info['for_search']))
	{
		header('X-Robots-Tag: noindex, noarchive');
	}
}
else
{
	list($usec, $sec) = explode(' ', microtime());
	$begin_logging_time = ((float)$usec + (float)$sec); // remember start time of page generating

	require_once('lib.php');

	if (!isset($_GET['t']))
	{
		$_GET['t'] = $GLOBALS['t'];
		$_GET['t_view'] = isset_globals('t_view');
	}
	else
	{
		$GLOBALS['t'] = $t = (is($t) ? $t : isset_get($_GET['t']));
		$GLOBALS['t_view'] = (is($t_view) ? $t_view : isset_get('t_view'));

		// this $_GET-variables needs for working object-fields with type "HTML"
		$GLOBALS['record_id'] = isset_get('record_id');
		$GLOBALS['field_name'] = isset_get('field_name');
	}

	if(!check_frontend_folder_access_by_group($page_folder) && $admin_template != 'yes')
	{
		if (se_index() === false)
		{
			header('X-Robots-Tag: noindex, noarchive');
		}

		parse_error_code('401');
		exit;
	}

	$html = parse($t);
	

//	if ( $admin_template != 'yes'
//		&&
//	     !EE_ALLOW_URL_PARAMS
//		&&
//	     ($uri_query_str = check_url_allowed_query($request_page, $tpl_allowed_uri_params_list, true)) !== false
//    )
//	{
//		header('Location:'. EE_HTTP.$redir.$uri_query_str);
//		exit;
//	}

	// Check lock status of page
	if (getField('SELECT is_locked FROM tpl_pages WHERE id='.sqlValue($t)) == 1 &&
		(!CheckAdmin() || $admin_template != 'yes')
	)
	{
		parse_error_code('403');
	}

	if ($admin_template == 'yes')
	{
		$html = str_replace('?t=', '?admin_template=yes&t=', $html);
		$html = str_replace('&t=', '&admin_template=yes&t=', $html);
		$html = str_replace('&page_id=', '&admin_template=yes&page_id=', $html);

		if ($dns_draft_status)
		{
			header('Location: '.EE_HTTP);
		}

		if (strtolower(EE_REDIRECT_HTTPS) == 'on')
		{
			$html = str_replace('"'.EE_HTTP.'"', EE_HTTP_FRONT, $html);
		}
		else
		{
			$html = str_replace('https://', 'http://', $html);
		}
	}
	elseif (strtolower(EE_REDIRECT_HTTPS) == 'on')
	{
  		$html = str_replace('https://', 'http://', $html);
	}

	// If config_var('antispam_security')
	// then coding e-mails && adding JS code to decode emails (Task: 7282)
	$html = hide_emails($html);

	$html = reduce_html_links($html);
	                    
	if (!empty($redir_status_out) && $redir_status_in != '200')
	{
		header('HTTP/1.1 '.$redir_status_out);
		header('Status: '.$redir_status_out);
	}

	$additional_info = false;

	if (!empty($content_type))
	{
		$additional_info = array();

		$charset = (($content_type == 'text/html') ? getCharset() : false);

		if (!headers_sent())
		{
			$header = 'Content-type: '.$content_type.($charset ? '; charset='.$charset : '');
			header($header);
		}

		if (	!$page_is_index &&
			$content_type == 'text/html')
		{
			header('X-Robots-Tag: noindex, noarchive');
			$additional_info['for_search']	= '0';
		}

		$additional_info['status'] 		= $redir_status_out;
		$additional_info['content_type'] 	= $content_type;
		$additional_info['charset']		= $charset;
	}

	if (	$admin_template != 'yes' &&
		check_cache_enabled() &&
		(
		$page_is_alias == true
		||
		$page_is_system_alias == true
		||
		$page_is_system_views_alias == true
		||
		$page_is_system_object_alias == true
		) &&
		touch_dir_writable(EE_PATH.EE_CACHE_DIR) &&
		$page_access_type != AM_GROUPS	&&
		!cache_check_authorize($request_page) &&
		is_cachable($t)
	)
	{
		save_cache_for_current_page($html, $request_page, false, $additional_info);
	}

	expanded_logging_page($begin_logging_time);
}

echo trim($html);

