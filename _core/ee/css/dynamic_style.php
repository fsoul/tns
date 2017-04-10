<?php
	$admin = true;
	// get_dynamic_style 8911
	$_POST['get_dynamic_style'] = '';


	require_once('../define_constants.php');
	require_once('../modules/cache_min_function.php');

	$request_page 	= substr($_SERVER['REQUEST_URI'], strlen(EE_HTTP_PREFIX));

	// is dynamic style chached
	if ($cssContent = cache_get_page($request_page))
	{
		echo '/* DYNAMIC STYLES :: CACHE */';
	}
	else
	{
		include ('../lib.php');
		$cssContent = get_dynamic_css();
		save_cache_for_current_page($cssContent, $request_page);
	}

	header('Content-type: text/css');

	echo $cssContent;
?>