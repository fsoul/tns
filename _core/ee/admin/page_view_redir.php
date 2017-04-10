<?php
	$page_name = $_GET['page_name'];
	$view = $_GET['view'];
	if(empty($view))
	{
		$url = get_href($page_name);
	}
	else
	{
		$url = get_view_href($page_name, $view);
	}
	header('location: '.$url);
	exit;
?>