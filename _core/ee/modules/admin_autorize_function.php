<?php
//********************************************************************
//	Функция для проверки авторизации
//********************************************************************
function autorize($login, $password, $min_role=USER)
{
	if (defined(AUTHORIZE_SOAP) and AUTHORIZE_SOAP==1)
	{
		$res = autorize_soap($login, $password);
	}
	else
	{
		$sql_ee = '

		SELECT *
		  FROM users
		 WHERE login = '.sqlValue($login).'
		   and passw = '.sqlValue($password).'
		   and role > '.$min_role.'
		   and status = '.ENABLED.'
		';

		$res = autorize_by_sql($sql_ee, $login, $password);
	}

	return $res;
}

function autorize_by_sql($sql, $login, $password)
{
	if (!session_id())
	{
		set_session_name(EE_HTTP_PREFIX);
		session_start();
	}

	$rs = viewsql($sql, 0);
	$r = db_sql_fetch_array($rs);
	if (db_sql_num_rows($rs))
	{
		$_SESSION['UserBrowser'] = get_user_agent();
		$_SESSION['UserIP'] = USER_IP;
		$_SESSION['UserAccess'] = $r['content_access'];
		$_SESSION['already_checked'] = true;
		$_SESSION['startTime'] = time();
		$_SESSION['lastTime'] = $_SESSION['startTime'];
		$_SESSION['login'] = $login;
		$_SESSION['pass'] = $password;
		$_SESSION['UserId'] = $r['id'];
		$_SESSION['UserName'] = $r['name'];
		$_SESSION['UserRole'] = $r['role'];
		$_SESSION['UserGroups'] = get_user_groups();
		upd_usr_statistic();
		add_user_info_to_session($r['id']);
		return true;
	}
	else
	{
		return false;
	}
}

function checkAdmin()
{
	if (!session_id())
	{
		set_session_name(EE_HTTP_PREFIX);
		session_start();
	}

	// переменные, которые должны быть установлены
	// на основании одноименных переменных сессии
	$arr = array(
		'UserRole',
		'UserName',
		'UserId'
	);

//msg($_SESSION['startTime'], '$_SESSION[startTime]');
//msg($_SESSION['lastTime'], '$_SESSION[lastTime]');
//msg(config_var('live'), 'config_var(live)');
//msg(time(), 'time()');

	if (!isset($_SESSION['already_checked']))
	{
		if (	isset($_SESSION['login']) and
			isset($_SESSION['pass']) and
			autorize($_SESSION['login'], $_SESSION['pass'])
		)
		{
			$_SESSION['already_checked'] = true;
		}
		else
		{
			$_SESSION['already_checked'] = false;
		}
	}
	// если пользователь не работал с сайтом больше допустимого времени
	// - перебросить его на авторизацию
	elseif (isset($_SESSION['lastTime']) and
		($_SESSION['lastTime'] + config_var('live')) < time()
	)
	{
		$_SESSION['already_checked'] = false;
	}
	elseif ($_SESSION['already_checked'] and
		isset($_SESSION['lastTime'])
	)
	{
		$_SESSION['lastTime'] = time();
	}


	if ($_SESSION['already_checked'])
	{
		foreach ($arr as $var)
		{
			global $$var;
			$$var = $_SESSION[$var];
		}
	}

	return $_SESSION['already_checked'];
}


/**
 * If there is no custom checkFrontEndAdmin()-function - let it be just the checkAdmin()-aliase
 */
if (!function_exists('checkFrontEndAdmin'))
{
	/**
	 * Checks if front-end user is loged in.
	 * Should be redeclared in custom functions according to concrete site logic.
	 * @see menu_classes.php
	 * @see menu_function.php
	 * @return bool
	 */
	function checkFrontEndAdmin()
	{
		return checkAdmin();
	}
}

