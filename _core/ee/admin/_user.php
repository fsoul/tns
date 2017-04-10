<?
	$modul = basename(__FILE__, '.php');
	$modul_title = $modul;
//********************************************************************
	include_once('../lib.php');
	include('url_if_back.php');

	$popup_height = 620;
	$popup_scroll = true;
	$config_vars = array (
		array (

		'field_name' => 'login_expiration_period',
		'type' => 'integer',
		'field_title' => 'Login expiration period, days (0 means not to check, 100 maximum)',
		'size' => 2,
		'min' => 0,
		'max' => 100
		),


		array (

		'field_name' => 'pass_min_8_symbol',
		'type' => 'checkbox',
		'field_title' => 'Password must be minimal 8 characters'

		),
		array (

		'field_name' => 'pass_contain_letters',
		'type' => 'checkbox',
		'field_title' => 'Password must contain letters from a-zA-Z'

		),
		array (

		'field_name' => 'pass_contain_letters_with_diff_case',
		'type' => 'checkbox',
		'field_title' => 'Password must contains letters with different case'

		),

		array (

		'field_name' => 'pass_contain_numbers',
		'type' => 'checkbox',
		'field_title' => 'Password must contain numbers from 0-9'

		),
		array (

		'field_name' => 'pass_not_have_login_inside',
		'type' => 'checkbox',
		'field_title' => 'Password must not have login inside'

		)

	);
	
	if (!defined('ADMIN_MENU_ITEM_USER')) define('ADMIN_MENU_ITEM_USER', 'Administration/Users');


	if ($op !== 'reset_password' && $op !== 'change_reset_pass')
	{
		// if user has not access to this module but wants to edit own profile data
		// - let him to do it (will no check rights)
		// but with no possibility to edit login, status and role
		if (	$op == 1 &&
			checkAdmin() &&
			$_SESSION['UserRole'] != ADMINISTRATOR &&
			is_array($ar_allowed_moduls = get_allowed_moduls_list($UserName)) &&
			!in_array($modul, $ar_allowed_moduls) &&
			$_GET['edit'] == $_SESSION['UserId']
		)
		{
			$ar_readonly = array('login', 'status', 'role');
		}
		else
		{
			$ar_readonly = array();
			//провер€ем права и обрабатываем op='self_test', op='menu_array' 
			check_modul_rights(array(ADMINISTRATOR, POWERUSER), ADMIN_MENU_ITEM_USER);
		}
	}
	// главный список полей
	// по нему работают все функции

	// установка свойств по-умолчанию
	require ('set_default_grid_properties.php');

	// установка свойств, отличающихс€ от установленных по-умолчанию
	// только список (grid)
	//скрыть столбец
	$hidden = array('role_name');
 	// размер пол€ фильтра в списке
	$size_filter['id'] = 3;
	// тип фильтра
	$type_filter['status'] = 'select_status';
	$type_filter['role'] = 'select_role_id';
	// выравнивание
	$align['id']='right';
//	$valign['id']='bottom';
	// стиль столбца
//	$grid_col_style['id'] = 'display:none';
	// оформление самого значени€ в гриде
	$ar_grid_links['role'] = '<%%getField:select role_name from role where id=%'.(array_search('role',$fields)+1).'$s%%>';

	// стиль строки пол€ формы
	if ($op==3) $form_row_style['login_datetime'] = $form_row_style['month_visits'] = $form_row_style['ip'] = $form_row_style['browser'] = $form_row_style['currently'] = $form_row_style['new_password']=$form_row_style['confirm_new_password']=$form_row_style['change_password']=$form_row_style['old_password']='display:none';
		else $form_row_style['change_password']='font-weight:bold; font-size:150%;';

	// размер пол€
//	$size['login'] = '100';
	// доступно только дл€ чтени€
	if (is_array($ar_readonly))
	{
		$readonly = $ar_readonly;
	}
	// об€зательны дл€ заполнени€
	$mandatory = array('name', 'login', 'email', 'status');

	// список полей по группам
	$fields_group['general'] = array('id',
 					 'name', 
					 'login',
					 'email', 
					 'status',
					 'comment',
					 'icq',
					 'city',
					 'change_password',
					 'old_password',
					 'new_password',
					 'confirm_new_password',
					 'currently', 
					 'ip',
					 'browser',
					 'last_login',
					 'month_visits');
	$fields_group['user_groups'] = array('user_groups');
	$fields_group['backoffice_access'] = array('role', 'content_access');

	// тип пол€ ввода
	$form_row_style['id'] = 'display:none';
	
	$type['id'] = 'string';
	$type['status'] = 'select_DE';
	$type['role'] = 'select_role';
	$type['content_access'] = 'select_content_access';
	$type['change_password'] = 'string';
	$type['old_password'] = 'password';
	$type['new_password'] = 'password';
	$type['confirm_new_password'] = 'password';
	
	$type['currently']        = 'string';
	$type['ip']               = 'string';
	$type['browser']          = 'string';
	$type['last_login']       = 'string';
	$type['month_visits']     = 'string';
	$type['user_groups']      = 'select_groups';
	//$type['popup_header'] = 'select_popup_header';

//	$type['password'] = $type['password_confirm'] = 'password';

//	$caption['id'] = 'јйƒи';
//	$caption['login'] = 'Ћогин';
	$caption['role'] = '';
	$caption['content_access'] = '';
	$caption['user_groups'] = '';
	$caption['ip'] = 'IP:';
	$caption['browser'] = 'Browser:';
	$caption['currently'] = '<b>Currently:</b>';
	$caption['change_password'] = 'Change password:';
	$caption['popup_header'] = '';

	$check_pattern['icq'] = array('^[0-9]*$', 'Must be integer');
	$check_pattern['email'] = array(EMAIL_PATTERN, ERROR_EMAIL_PATTERN);

	// восстанавливаем значени€ фильтра, сортировки, страницы
	load_stored_values($modul);

	if (empty($srt)) $srt='';
	$ar_usl[] = 'srt='.$srt;

	// дл€ сортировки в sql-запросе
	if ($op == 0) $order = getSortOrder();

	// туда же
	function print_captions($export='')
	{
		return include('print_captions.php');
	}

	// пол€ фильтра в grid-е
	function print_filters()
	{
		return include('print_filters.php');
	}
	function print_fields_by_group()
	{
		return include('print_fields_by_group.php');
	}

	// список (grid)
	function print_list($export='')
	{
		include('print_list_init_vars_apply_filter.php');

		$tot = getsql('count(*) from v'.$modul.'_grid '.$where, 0);

		include('print_list_limit_sql.php');

		$s = '';

		if ($export)
		{
			$s = parse_sql_to_html($sql, 'templates/' . $modul . '/list_row_field' . $export);
		}
		else
		{
			$rs = viewsql($sql, 0);

			$j=0;
			$rows = array();
			while($r=db_sql_fetch_row($rs))
			{
				$row_field = array();
				for($i=0; $i<count($r); $i++)
				{
					$row_field[$i]['col_style'] = $grid_col_style[$fields[$i]];
					$row_field[$i]['field_align'] = $align[$fields[$i]];
					$row_field[$i]['field_value'] = parse2(vsprintf($ar_grid_links[$fields[$i]], $r));
				}
       	
				$row_field = remove_by_keys($row_field, array_keys(array_intersect($fields, $hidden)));

				$rows[$j]['row_fields'] = parse_array_to_html($row_field, 'templates/'.$modul.'/list_row_field'.$export);
				$rows[$j]['id'] = $r[0];
				$rows[$j]['current_user_role_id'] = $r[5];
				$rows[$j++]['name'] = SaveQuotes($r[1]);
			}
			$s = parse_array_to_html($rows, 'templates/'.$modul.'/list_row'.$export);
       	
			global $navigation;
			$navigation = navigation($tot, $MAX_ROWS_IN_ADMIN, $page, 'navigation/default');
		}

		return $s;
	}


	// список полей в окне редактировани€
	function print_fields()
	{
		return include('print_fields.php');
	}

	// добавление/сохранение записи
	function save()
	{
		global $modul, $op;
		global $pageTitle, $PageName, $error;
		global $modul;
		global $fields;
		global $mandatory;
		global $edit;
//		global $change_pass, $user_edit;
		global $email, $login, $newpassword;

		$pageTitle = (empty($edit)?'Add ':'Edit ').str_to_title($modul);
//		$user_edit = (empty($edit)?0:1);

		$field_values['user_groups_sel'] = post('user_groups_sel');
		$field_values['available_groups_sel'] = post('available_groups_sel');

		include ('save_init.php');

		if (post('refresh'))
		{
			if (count($error)==0)
			{
				//unset($field_values['password_confirm']);
				
				if (empty($edit)) // New object
				{
					unset($field_values['id'], $field_values['new_password'],$field_values['confirm_new_password'],$field_values['change_password'],$field_values['old_password'], $field_values['currently'], $field_values['ip'], $field_values['browser'], $field_values['login_datetime'], $field_values['month_visits']);
					$db_function = 'f_add'.$modul;
					$p_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
					$newpassword = substr(str_shuffle($p_chars), 0, 8);
					$field_values[]=$newpassword;
					$login = $_POST['login'];
					$email = $field_values['email'];
					global $login,$newpassword;
//					$mail = parse('password_mail');
					$res = $db_function($field_values['name'],
							$field_values['login'],
							$field_values['email'],
							$field_values['status'],
							$field_values['comment'],
							$field_values['icq'],
							$field_values['city'],
							$field_values['available_groups_sel'], //user_groups
							$field_values['role'],
							$field_values['content_access'],
							$newpassword);

				}
				else
				{
					unset($field_values['change_password']);
					$db_function = 'f_upd'.$modul;
					$res = $db_function($field_values['id'],
							$field_values['name'],
							$field_values['login'],
							$field_values['email'],
							$field_values['status'],
							$field_values['comment'],
							$field_values['icq'],
							$field_values['city'],
							$field_values['old_password'],
							$field_values['new_password'],
							$field_values['confirm_new_password'],
							$field_values['currently'],
							$field_values['ip'],
							$field_values['browser'],
							$field_values['login_datetime'],
							$field_values['month_visits'],
							$field_values['available_groups_sel'], //user_groups
							$field_values['role'],
							$field_values['content_access']);

				}

				if ($res < 0)
				{
					if ($res==-1 || $res==-3)
						$error['login'] = 'User with this login already exists';
					elseif ($res==-2 || $res==-4)
						$error['email'] = 'User with this email already exists';
					elseif ($res==-5)
						$error['old_password'] = 'Incorrect password';
					elseif ($res==-6)
						$error['new_password'] = 'New password and Confirm new password fields must be equal';
					elseif ($res==-7)
						$error['new_password'] = PASSWORD_TOO_SHORT;
					elseif ($res == -8)
						$error['new_password'] = PASSWORD_TOO_SHORT_FRONTEND;
					elseif ($res == -9)
						{}
					else
						$error['id'] = 'DataBase error '.$res;
				}
				else
				{
					if (post('save_add_more') || $op==3) 
					{
						$headers = from_server_mail_header();

						if (mail($email, YOUR_NEW_PASSWORD.' '.cons('on site').' '.EE_SITE_NAME, parse('password_mail'), $headers)===false)
						{
							$error['email'] = RECORD_SAVED_BUT_MAIL_SENDING_ERROR;
						}
					}

					if (count($error)==0)
					{
						if (post('save_add_more'))
						{
							header ('Location: '.$modul.'.php?op=3&added='.$res);
							exit;
						}
						else
						{
							close_popup('yes');
						}
					}
				}
			}
		}
		return parse($modul.'/edit');
	}

	function from_server_mail_header()
	{
		return 'From: '.EE_SITE_NAME.' Server <'.SUPPORT_CONTACTS_EMAIL.'>';
	}

	// удаление
	function del()
	{
		global $del, $modul, $url;
		RunNonSQLFunction('f_del'.$modul, array($del));

		header($url);
	}
	
	function reset_password()
	{
		global $modul, $error;
		global $login,$newpassword;
		if(!empty($_POST['login']) and !empty($_POST['email'])) 
		{
			$sql = 'SELECT * FROM users where login='.sqlValue($_POST['login']).' AND email='.sqlValue($_POST['email']);
			$rs = viewsql($sql, 0);

			if (db_sql_num_rows($rs)) 
			{
				//$p_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
				$p_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
				$newpassword = substr(str_shuffle($p_chars), 0, 8);
				$upd_sql = 'UPDATE users SET resetpassw=1, passw='.sqlValue(md5($newpassword)).', passw_update_datetime=NOW() WHERE login='.sqlValue($_POST['login']);
				RunSQL($upd_sql);
				$login = $_POST['login'];
				$email = $_POST['email'];

				$headers = from_server_mail_header(); 

				if (($mail_res = mail($_POST['email'], EE_SITE_NAME.' '.USERS_NEW_PASSWORD, parse('password_mail'), $headers)) !== false)
				{
					header('Location: '.EE_ADMIN_URL.'index.php?not=1');	
				}
				else
				{
					$error = PASSWORD_RESETED_BUT_MAIL_SENDING_ERROR;
				}
			} else {
				$error = "The given login does not exist in our database. Please try again";
			}	
		}
		return parse($modul.'/reset_password');
	}
	
	function change_reset_pass()
	{
		global $modul, $error;
		if ($_POST["cancel"]) 
		{
			header('Location: '.EE_ADMIN_URL.'index.php');
			exit;
		}
		if (!empty($_POST['current']) && !empty($_POST['newpass']) && !empty($_POST['confnewpass']) && $_POST['newpass']==$_POST['confnewpass']) 
		{
	
			$sql = 'SELECT * FROM users where login='.sqlValue($_POST["user"]).' AND passw= '.sqlValue(md5($_POST['current']));
			$rs = viewsql($sql,0);
			if (strlen($_POST['newpass']) < MIN_PASSWORD_LENGTH && get_config_var('pass_min_8_symbol')) 
			{
				$error = PASSWORD_TOO_SHORT;
			}
			else if (strlen($_POST['newpass']) < MIN_PASSWORD_LENGTH_FRONTEND && !get_config_var('pass_min_8_symbol'))
			{
				$error = PASSWORD_TOO_SHORT_FRONTEND;
			}
			else if (db_sql_num_rows($rs)) 
			{
				$i_error = check_password($_POST["user"], $_POST['newpass']);
				if($i_error == 1)
				{
					$upd_sql = 'UPDATE users SET resetpassw=0, passw='.sqlValue(md5($_POST['newpass'])).', passw_update_datetime=NOW() WHERE login='.sqlValue($_POST["user"]);
					RunSQL($upd_sql);
					autorize($_POST["user"],md5($_POST['newpass']));
					header('Location: '.EE_ADMIN_URL.'main.php');
					exit;
				}
				else
				{
					$error = $i_error;
				}
			}
			else {
				$error = 'Incorrect password';
			}	
		} 
		else if ($_POST["submit"]) $error = 'Please fill these fields carefully';
		return parse($modul.'/change_reset_pass');
	}

	include ('rows_on_page.php');

	function print_self_test()
	{
		global $modul;

		$ar_self_check[$modul] = array (

			'php_functions' => array (

				'mysql_query',
				'is_array'
			),

			'php_ini' => array (

				'max_execution_time'
			),

			'constants' => array (

				'EE_PATH',
			),

			'db_tables' => array (

				'v_user_grid',
				'v_user_edit',
				'user_group',
				'user_groups',
				'content_access'
			),

			'db_funcs'  => array ()
		);

		return parse_self_test($ar_self_check);
	}

function get_folders_list()
{
	global $modul;

	$handle=opendir(EE_FILE_PATH);

	$folder_arr = array();

	while(false!==($folder=readdir($handle)))
	{       
		if($folder!="." and $folder!=".." and is_dir(EE_FILE_PATH.$folder))
		{
			$folder_arr[]['folder_name'] = $folder;
		}
	}
	closedir($handle);

	$res = parse_array_to_html($folder_arr, 'templates/'.$modul.'/folder_access_list_row');

	return $res;
}

function set_dir_permisions()
{
	global $UserRole, $modul, $folder, $pageTitle;

	$pageTitle = 'Allowing an access to next folders';

	if ($UserRole < ADMINISTRATOR)
	{
		echo parse('norights');
		exit;
	}

	if (post('refresh'))
	{
		$chosen_folders = post('chosen_folders');
		$all_folders	= post('all_folders');
		$user_id	= post('edit');

		foreach($all_folders as $current_foder)
		{
			set_folder_permissions($current_foder, $user_id, in_array($current_foder, $chosen_folders));
		}

		close_popup('yes');
	}
	else
	{
		return parse_popup($modul.'/set_dir_permissions');
	}
}

	function print_moduls_list($user_name, $ar_black_list=array())
	{
		global $modul, $edit;
		$ar_allowed_moduls = get_allowed_moduls_list($user_name);

		$ar_all_moduls = dir_to_array(EE_CORE_ADMIN_PATH, '^_.*\.php$', $ar_black_list);
	
	$array = $_SESSION['arr_admin_menu'];
	$arr_reverse = array_flip($_SESSION['arr_admin_menu_titles']);
	$i =0;
	$new_array = array();
	// формирование масива модулей сгрупированых "как в меню" на основе масива менюшки
	while(current($array))
	{
		$section = key($array);
		if(array_key_exists(key($array), $arr_reverse))
		{
			$new_array[$i]['modul_title'] = key($array);
			$new_array[$i]['section'] = $section;
			$new_array[$i]['modul_name'] = str_replace('.php', '', $arr_reverse[$new_array[$i]['modul_title']]);
			$new_array[$i]['modul_is_allowed'] = ((bool)(in_array($new_array[$i]['modul_name'], $ar_allowed_moduls)));
			$i++;
					 
		}
		$sub_array = $array[key($array)]['Submenu'];
		while(current($sub_array))
		{
			$subb_arr = $sub_array[key($sub_array)]['Submenu'];
			while(current($subb_arr))
			{
				if(array_key_exists(key($subb_arr), $arr_reverse))
				{
					$new_array[$i]['modul_title'] = key($subb_arr);
					$new_array[$i]['section'] = $section;
					$new_array[$i]['modul_name'] = str_replace('.php', '', $arr_reverse[$new_array[$i]['modul_title']]);
					$new_array[$i]['modul_is_allowed'] = ((bool)(in_array($new_array[$i]['modul_name'], $ar_allowed_moduls)));
					$i++;
					 
				}
				next($subb_arr);
			}
			if(array_key_exists(key($sub_array), $arr_reverse))
			{
				$new_array[$i]['modul_title'] = key($sub_array);
				$new_array[$i]['section'] = $section;
				$new_array[$i]['modul_name'] = str_replace('.php', '', $arr_reverse[$new_array[$i]['modul_title']]);
				$new_array[$i]['modul_is_allowed'] = ((bool)(in_array($new_array[$i]['modul_name'], $ar_allowed_moduls)));
				$i++;
			}
			next($sub_array);
		}
		next($array);
	}

		$ar_res = array();
		foreach($ar_all_moduls as $i=>$modul_name)
		{
			$ar_res[$i]['modul_name'] = str_replace('.php', '', $modul_name);

			if ('' == ($ar_res[$i]['modul_title'] = $_SESSION['arr_admin_menu_titles'][$modul_name]))
			{
				$ar_res[$i]['modul_title'] = $ar_res[$i]['modul_name'];
			}

			$ar_res[$i]['modul_is_allowed'] = ((bool)(in_array($ar_res[$i]['modul_name'], $ar_allowed_moduls)));
		}

		return parse_array_to_html($new_array, 'templates/'.$modul.'/moduls_list_row');
	}

	function save_moduls_list($user_name)
	{
		$ar_res = unserialize(config_var('allowed_moduls'));
		$ar_res[$user_name] = $_POST['moduls_list'];
		save_config_var('allowed_moduls', serialize($ar_res));
	}

	function edit_config()
	{
		return include('print_edit_config.php');
	}
	function get_modul_list($modul)
	{
		return include('get_yui_list.php');
	}
	function print_yui_captions($full='no')
	{
		return include('print_yui_captions.php');
	}


//********************************************************************

	switch ($op)
	{
		default:
		case '0':
			echo parse($modul.'/list');
			break;

		case '1':
			echo save();
			break;

		case '2':
			del();
			break;

		case '3':
			echo save();
			break;

		case 'del_sel_items': 
			del_selected_items($modul);
			echo parse($modul.'/list');
			break;			

		case 'moduls_list':
			echo print_moduls_list(get_user_name_by_id($edit), $ar_admin_modules_black_list);
			break;

		case 'moduls_list_save':
			save_moduls_list(get_user_name_by_id($edit));
			close_popup('yes');
//			echo parse($modul.'/list');
			break;

		case 'rows_on_page':
			rows_on_page();
			break;

		case 'self_test':
			echo print_self_test();
			break;

		case 'reset_password':
			echo reset_password();
			break;

		case 'change_reset_pass':
			echo change_reset_pass();
			break;

		case 'export_excel':
			header( 'Content-Type: application/vnd.ms-excel' );
			header( 'Content-Disposition: attachment; filename="'.$modul.'.xls"' );
			echo parse('export_excel');
			break;
		case 'set_dir_permissions':
			echo set_dir_permisions();
			break;
		case '9':
			save_user_groups($_GET['edit'], $_GET['g_op'], $_GET['user_groups'], $_GET['avail_groups']);
			echo save();
			break;
		case 'back_office_access':
			set_bo_access();
			break;

		case 'config':
			echo edit_config();
			break;
		case 'get_list' : echo get_modul_list($modul); break;
		case 'del_rows': del_selected_rows($modul); echo get_modul_list($modul); break;


	}
?>