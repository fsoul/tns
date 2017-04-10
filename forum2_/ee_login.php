<?
//var_dump($user);
include_once('ee_lib.php');

$AP_users_email = ap_get_respondent_email();

if (empty($AP_users_email))
{
	return;
}

if (!($user_id = getField('SELECT user_id FROM phpbb_users WHERE user_email='.sqlValue($AP_users_email))))
{
	// register new user

	include('includes/functions_profile_fields.php');
	include('includes/functions_user.php');
	$cp = new custom_profile();
	$error = $cp_data = $cp_error = array();
        
	// validate and register the custom profile fields
	$cp->submit_cp_field('register', $user->get_iso_lang_id(), $cp_data, $error);
	
	// create an inactive user key to send to them...
	$user_actkey = gen_rand_string(10);
	$key_len = 54 - (strlen(EE_HTTP));
	$key_len = ($key_len < 6) ? 6 : $key_len;
	$user_actkey = substr($user_actkey, 0, $key_len);


	// setup the user array for the new user
	$user_row = array(
	    'username'              => $AP_users_email,
	    'user_password'         => '',
	    'user_email'            => $AP_users_email,
	    'group_id'              => 2,
	    'user_type'             => USER_NORMAL,
	    'user_actkey'           => $user_actkey,
	    'user_ip'               => $user->ip,
	    'user_regdate'          => time(),
	    'user_lang'             => 'ru',
	);

	// Register user...
	$user_id = user_add($user_row, $cp_data);
}

if ($user_id)
{
	$tmp = $config['auth_method'];
	$config['auth_method'] = 'ap';
	$auth->login($AP_users_email, '');
	$config['auth_method'] = $tmp;
}
//var_dump($user_id); exit;