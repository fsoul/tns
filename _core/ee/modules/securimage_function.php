<?php                              
include_once ('securimage_class.php');
function getCaptchaWord()
{
	global $language;			
	$res = convert_from_utf(getField('SELECT v.captcha_word, RAND() as random_word  FROM ('.create_sql_view_by_name('captcha').') v ORDER BY random_word LIMIT 1',0), $language);
	$_SESSION['securimage_code_value'] = $res;
	return $res;
}


