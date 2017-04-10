<?php

function get_config_var($var, $lang='')
{
	return config_var($var, $lang);
}


function config_var($var, $lang='', $for_backoffice=true)
{
	global $CONFIG;

	$res = '';

	if ($for_backoffice || !is_in_admin())
	{
		$config_var = get_array_var($CONFIG, $var);

		if ($lang != '')
		{
			$res = is_array($config_var) ? get_array_var($config_var, $lang) : false;
		}
		else
		{
			if (is_array($config_var))
			{
				global $language;
				$res = get_array_var($config_var, $language);
			}
			else
			{
				$res = $config_var;
			}
		}
	}

	return $res;
}


function save_config_var($var, $val, $lang='')
{
	global $CONFIG;
	$CONFIG[$var] = $val;

	// ищем в конфиге соотв. запись для текущего языка
	$rs=viewsql('SELECT val
			FROM config
			WHERE var='.sqlValue($var).'
			      AND lang_code='.sqlValue($lang)
		   ,0);

	if(mysql_num_rows($rs)<1) // если нет такой - создаем
	{
		runsql ('INSERT INTO config
				SET
					var='.sqlValue($var).',
					val='.sqlValue($val).',
					description=\'\',
					sortOrder=0,
					lang_code='.sqlValue($lang)
			,1);
	}
	else
	{        // если же есть - обновляем значение
		runsql ('UPDATE config
				SET val='.sqlValue($val).'
				WHERE var='.sqlValue($var).'
				      AND lang_code='.sqlValue($lang)			
			,1);
	}
}

?>