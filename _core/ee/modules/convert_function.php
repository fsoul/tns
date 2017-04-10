<?

function convert_from_utf($str, $lang)
{
	global $langEncode;

	if (!isset($langEncode) or empty($langEncode))
	{
		$langEncode = get_Array_Language_Encode();
	}

	if (!in_array(strtoupper($lang), $langEncode))
	{
		global $default_language;
		$lang = $default_language;
	}

	$enc = $langEncode[strtoupper($lang)];

	$return = iconv("utf-8", $enc.'//IGNORE', $str);

	return $return;
}

function convert_to_utf($str, $lang) 
{
	global $langEncode;

	if (!isset($langEncode) or empty($langEncode))
	{
		$langEncode = get_Array_Language_Encode();
	}

	if (!in_array(strtoupper($lang), $langEncode))
	{
		global $default_language;
		$lang = $default_language;
	}

	$enc = $langEncode[strtoupper($lang)];

	return iconv($enc, "utf-8//IGNORE", $str);
}


function need_convert_from_utf($need_convert_from_utf = true)
{
	global $modul;

//msg($modul, '$modul');
//msg(EE_PHP_SELF, 'EE_PHP_SELF');
//msg(EE_HTTP_PREFIX.EE_HTTP_PREFIX_CORE.EE_ADMIN_SECTION, 'EE_HTTP_PREFIX.EE_HTTP_PREFIX_CORE.EE_ADMIN_SECTION');
//msg($page_file, '$page_file');

	if (	$need_convert_from_utf &&
		empty($modul) &&
		strpos(EE_PHP_SELF, EE_HTTP_PREFIX.EE_HTTP_PREFIX_CORE.EE_ADMIN_SECTION) === false
	)
	{
		$need_convert_from_utf = true;
	}
	else
	{
		$need_convert_from_utf = false;
	}

//msg($need_convert_from_utf, 'need_convert_from_utf()');

	return $need_convert_from_utf;
}

function covert_bracket_to_entities($str)
{
	$str = str_replace('<', '&amp;lt;', $str);
	$str = str_replace('>', '&amp;gt;', $str);
	return $str;
}



