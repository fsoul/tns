<?php

function get_user_agent()
{
	$usrAgent = '';
	$usrAgent = $_SERVER['HTTP_USER_AGENT'];

	if($pos = strpos($usrAgent, 'MSIE'))
	{
		$str = substr($usrAgent, $pos);
		return 'Internet Explorer '.substr($str,5,strpos($str,";")-5);
	}
	else if($pos = strpos($usrAgent, 'Firefox'))
	{
		return str_replace('/',' ', substr($usrAgent, $pos));
	}
	else if($pos = strpos($usrAgent, 'pera'))
	{
		return str_replace('/',' ', substr($usrAgent, $pos-1, strpos($usrAgent,' ')));
	}
	else if($pos = strpos($usrAgent, 'Safari'))
	{
		$vPos = strpos($usrAgent, 'Version/');
		$version = substr($usrAgent, $vPos+8, 3);
		return substr($usrAgent, $pos, 6).' '.$version;
	}
	return $usrAgent;
}

function upd_usr_statistic()
{
	
	$lastIP      = $_SESSION['UserLastIP'] 	    = getField('SELECT ip FROM users WHERE id='.$_SESSION['UserId']);
	$lastBrowser = $_SESSION['UserLastBrowser'] = getField('SELECT browser FROM users WHERE id='.$_SESSION['UserId']);
	$lastLogin   = $_SESSION['LastLogin']       = getField('SELECT login_datetime FROM users WHERE id='.$_SESSION['UserId']);

	$visits      = getField('SELECT month_visits FROM users WHERE id='.$_SESSION['UserId'].'');
	
	$lastLoginMonth = getField('SELECT DATE_FORMAT(login_datetime, \'%m\') as login_datetime FROM users WHERE id='.$_SESSION['UserId']);
	if($lastLoginMonth == date('m')) $visits++;
	else $visits = 1; 

	runSQL('UPDATE users SET ip='.sqlValue($_SESSION['UserIP']).', browser='.sqlValue($_SESSION['UserBrowser']).', login_datetime=NOW(), month_visits='.sqlValue($visits).' WHERE id='.$_SESSION['UserId']);
}

function logout()
{
	set_session_name(EE_HTTP_PREFIX);
	session_start();
	if (AUTHORIZE_SOAP)
	{
		$params = array (
			$_SESSION['ei_server_session'],
			ei_gf_createSystemInfo()
		);
		soap_call('ei_um_logoutUser', $params);
	}
	session_unset();
	session_destroy();

	return true;
}

/**
*  Authorize for draft mode, uses basic apache authenticate system.
*/
function authorize_for_draft_mode($login, $password, $min_role=USER)
{
 	
      	if (!autorize($login, md5($password)))
	{	
                	header('WWW-Authenticate: Basic realm="Draft Mode"');
			header('HTTP/1.0 401 Unauthorized');
			echo "<center><span style = 'color:red;font-size:20px;'>".NOT_AUTHORIZED_MSG."</span></center>";
			exit;		
	}
	else
	{       
		return true;
	}	
}

// 8897

function check_password($login, $password, $fontend_rule = false)
{
	if($fontend_rule)
	{
		if(strlen($password) < MIN_PASSWORD_LENGTH_FRONTEND)
		{
			return PASSWORD_TOO_SHORT_FRONTEND;
		}
		elseif(!preg_match('/[a-z]/i',$password, $matches1))
		{
			return PASSWORD_MUST_CONTAIN_LETTERS;
		}
	}
	else
	{
		if(	strlen($password) < MIN_PASSWORD_LENGTH &&
			get_config_var('pass_min_8_symbol')
		)
		{
			return PASSWORD_TOO_SHORT;
		}
		elseif(	!preg_match('/[a-z]/i',$password, $matches1) &&
			get_config_var('pass_contain_letters')
		)
		{
			return PASSWORD_MUST_CONTAIN_LETTERS;
		}
		elseif((strtolower($password) == $password || 
			strtoupper($password) == $password) &&
			get_config_var('pass_contain_letters_with_diff_case')
		)
		{
			return PASSWORD_MUST_CONTAIN_LETTERS_WITH_DIFF_CASE;
		}
		elseif(	!preg_match('/[0-9]/i',$password, $matches2) &&
			get_config_var('pass_contain_numbers')	
		)
		{
			return PASSWORD_MUST_CONTAIN_NUMBER;
		}
		elseif((strtolower($login) == strtolower($password) ||
			strpos(strtolower($password), strtolower($login)) !== false) &&
			get_config_var('pass_not_have_login_inside')
		)
		{
			return PASSWORD_NOT_HAVE_LOGIN_INSIDE;			
		}
	}

	return 1;
}

// bug_id=11464
function login_expired($login)
{
	if (	($login_expiration_period = get_config_var('login_expiration_period'))>0 &&
		getField('

                   SELECT COUNT(*)
                     FROM users
                    WHERE
                          login='.sqlValue($login).'
                      AND
                          (passw_update_datetime IS NULL
                           OR
                           DATEDIFF(NOW(), passw_update_datetime) > '.sqlValue($login_expiration_period).'
                          )'
		)
	)
	{
		$result = true;
	}
	else
	{
		$result = false;
	}

	return $result;
}

