<?
	include_once('../lib.php');

	//проверяем права и обрабатываем op='self_test', op='menu_array'
	check_modul_rights(array(ADMINISTRATOR, POWERUSER), '');

function get_modules_check_array($modules_path, &$ar_res)
{
	$handle = opendir($modules_path);

	while (false !== ($file = readdir($handle)))
	{
		if (preg_match('/^_.*\.php$/i', $file))
		{
			$url = EE_HTTP_PREFIX.EE_ADMIN_SECTION_IN_HTACCESS.$file.'?test_all=true';

			$post_result = post_url($url, array('op'=>'self_test', 'UserRole'=>$_SESSION['UserRole']));

			$ar_tmp = unserialize($post_result);

			if (is_array($ar_tmp[0]))
			{
				$ar_res[] = $ar_tmp[0];
			}
			else
			{
				$ar_res[] = array(
					'modul_name'=>basename($file,'.php'),
					'modul_check_result'=>'<br/>No self-test function'
				);
			}
		}
	}

	closedir($handle);
}

	$ar_res = array();

	get_modules_check_array(EE_CORE_ADMIN_PATH, $ar_res);
	get_modules_check_array(EE_ADMIN_PATH, $ar_res);

	echo parse_array_to_html($ar_res, 'self_test');

?>