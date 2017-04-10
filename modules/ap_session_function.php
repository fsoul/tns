<?

function ap_is_respondent_authorized()
{
	$res = (int)(array_key_exists('respondent', $_SESSION));
	return $res;
}

function checkFrontEndAdmin()
{
	return ap_is_respondent_authorized();
}

function ap_get_respondent_id()
{
	return ap_get_respondent_session_param('id_');
}

function ap_get_respondent_email()
{
	return ap_get_respondent_param('email_');
}

function ap_get_respondent_fio()
{
	return ap_get_respondent_first_name().' '.ap_get_respondent_last_name();
}

function ap_get_respondent_first_name()
{
	return ap_get_respondent_param('first_name_');
}

function ap_get_respondent_last_name()
{
	return ap_get_respondent_param('last_name_');
}

function ap_get_respondent_session_param($param_name)
{
	$res = false;
    if(!array_key_exists('respondent', $_SESSION) && array_key_exists('stored_session', $_COOKIE)) {
        $ss = unserialize($_COOKIE['stored_session']);
        foreach($ss as $k=>$v) {
            $_SESSION[$k] = $v;
        }
    } elseif (array_key_exists('respondent', $_SESSION)) {
        setcookie('stored_session',serialize($_SESSION),time()+3600,'/');
    }
	if (	array_key_exists('respondent', $_SESSION) &&
		is_array($_SESSION['respondent']) &&
		array_key_exists($param_name, $_SESSION['respondent'])
	)
	{
		$res = $_SESSION['respondent'][$param_name];
	}
	else
	{
		$res = false;
	}

	return $res;
}

function ap_get_respondent_param($param_name)
{
	$res = false;

	if (!($res = ap_get_respondent_session_param($param_name)))
	{
		$resp = ap_resp_init();
		$resp_id = ap_get_respondent_id();

		if (	$resp &&
			!empty($resp_id) &&
			$info = $resp->Get_Info($resp_id) &&
			is_array($info) &&
			array_key_exists($param_name, $info)
		)
		{
			$res = $info[$param_name];
		}
	}

	return $res;
}



function ap_authorized_only()
{
	if (!ap_is_respondent_authorized())
	{
		parse_error_code('403');
	}
}
