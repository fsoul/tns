<?php
/*
 * Created on 13/9/2006 by YuriK
 */
function get_version_info()
{
	return EE_VERSION_FULL.' (build date '.EE_BUILD_DATE.')';
}

function version_info()
{
	$version_info_file = EE_PATH.EE_HTTP_PREFIX_CORE.'version.info';

	if ( !file_exists($version_info_file) )
	{
		print '<h1> VERSION INFO IS ABSENT! </h1>';
		return;
	}

	$arr = array();
	$arr_file_strings = file($version_info_file);

	for ($i = 0; $i < count($arr_file_strings); $i++)
	{
		$tmp = explode('=', $arr_file_strings[$i]);

		if (array_key_exists(1, $tmp))
		{
			$arr[trim($tmp[0])] = trim($tmp[1]);
		}
	}

	if (!defined('EE_BUILD_NUMBER'))	define('EE_BUILD_NUMBER', array_key_exists('build.number',$arr)?$arr['build.number']:'');
	if (!defined('EE_BUILD_DATE'))	define('EE_BUILD_DATE', preg_replace('/[\\]/', "", array_key_exists('build.date',$arr)?$arr['build.date']:''));
	if (!defined('EE_VERSION_FULL'))	define('EE_VERSION_FULL', array_key_exists('version.full',$arr)?$arr['version.full']:'');
	if (!defined('EE_BUILD_CODE'))	define('EE_BUILD_CODE', array_key_exists('build.code',$arr)?$arr['build.code']:'');
	if (!defined('EE_VERSION_SHORT'))	define('EE_VERSION_SHORT', array_key_exists('version.short',$arr)?$arr['version.short']:'');
	if (!defined('VERSION_EE'))	define('VERSION_EE', array_key_exists('version.ee',$arr)?$arr['version.ee']:'');
}




