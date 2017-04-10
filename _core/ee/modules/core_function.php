<?

function get_custom_or_core_file_name($file_name)
{
	$result = $file_name;

	if (!check_file($file_name))
	{
		if (strpos($file_name, EE_ADMIN_PATH)===0)
		{
			$result = EE_CORE_ADMIN_PATH.substr($file_name, strlen(EE_ADMIN_PATH));

			if (get_file_extension($file_name)=='tpl')
			{
				$result = get_core_admin_template($result);
			}
		}
		elseif (strpos($file_name, EE_PATH)===0)
		{
			$result = EE_CORE_PATH.substr($file_name, strlen(EE_PATH));
		}

		if (!check_file($result))
		{
			$result = $file_name;
		}
	}
//vdump($file_name, '$file_name');
//vdump($result, '$result');
	return $result;
}

function get_custom_or_core_file_contents($file_name)
{
	return file_get_contents(get_custom_or_core_file_name($file_name));
}


