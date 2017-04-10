<?

function get_allowed_moduls_list($user_name)
{
	$str_allowed_moduls = config_var('allowed_moduls');
//vdump($allowed_moduls, '$allowed_moduls 0');
	if (!empty($str_allowed_moduls))
	{
		// take whole array of user's access to moduls
		$ar_allowed_moduls = unserialize($str_allowed_moduls);
//vdump($ar_allowed_moduls, '$ar_allowed_moduls 1');
		if (is_array($ar_allowed_moduls) && array_key_exists($user_name, $ar_allowed_moduls))
		{
			// take list of allowed for current user moduls
			$ar_allowed_moduls = $ar_allowed_moduls[$user_name];
		}
//vdump($ar_allowed_moduls, '$ar_allowed_moduls 2');
	}
	return ((isset($ar_allowed_moduls) && is_array($ar_allowed_moduls)) ? $ar_allowed_moduls : array() );
}

function check_modul_rights($allowed_users='', $menu_str='')
{
	global $UserRole, $op;
	global $UserName, $modul;

	$ar_allowed_moduls = get_allowed_moduls_list($UserName);

//vdump($UserName, '$UserName');
//vdump($UserRole, '$UserRole');
//vdump(ADMINISTRATOR, 'ADMINISTRATOR');
//vdump($ar_allowed_moduls, '$ar_allowed_moduls');
//vdump($modul, '$modul');
//vdump($op, '$op');

	// Administrator has access for all moduls in system
	// other users has access only for moduls mentioned in list
	$allowed = (	$UserRole==ADMINISTRATOR
			||
			(
				is_array($ar_allowed_moduls) &&
				in_array($modul, $ar_allowed_moduls)
			)
	);

	switch ($op)
	{
		case 'menu_array':
			echo ( $allowed ? $menu_str : '' );
			exit;

		case 'self_test':
			echo ( $allowed ? print_self_test() : '' );
			exit;

		default:
			if (!$allowed || !CheckAdmin())
			{
				echo parse_tpl(EE_CORE_ADMIN_PATH.'templates/norights');
				exit;
			}
	}
}

