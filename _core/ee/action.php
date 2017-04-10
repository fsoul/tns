<?
//********************************************************************
	include_once('lib.php');
//********************************************************************

switch ($action) {
//***********************************************************************************
	case 'login':
//***********************************************************************************
//		�������� �����������
//***********************************************************************************
//vdump ($_POST, '_POST');
		$t = '?t=index';
		$t_back = '?t=index';
		$error_msg = '';

		if (empty($_POST["login"])) {	
			$error_msg = 'Invalid login.';
		}
		else if (!($res = autorize($_POST["login"], $_POST["pass"]))) {
			$error_msg = 'Invalid password.';
		}

		if (!empty($error_msg)) {
			set_error($t_back, 0, $error_msg.'  Please contact the administrator');
			echo post_error($_POST);
			exit;
		}
//msg ($res, '$res ' );
//vdump($_SESSION, '$_SESSION');
//msg (session_id(), 'session_id()');
//exit;
		break;
	case 'anketa_login':
		$t = '?t=courses/my_trainings';
		$t_back = '?t=';
		if (!($res = autorize_soap($_POST["login"],md5($_POST["pass"])))) 
		{
			set_error($t_back, 0, $err);
			
			echo post_error($_POST);
			exit;
		}
		break;


//***********************************************************************************
//		Front-end login
//***********************************************************************************
	case 'frontpage_login':

		$redir_page = (post(redir_if_logined)) ? post(redir_if_logined) : 'access_allow';		

		if (!($res = autorize(post('login'),md5(post('pass')),-1))) 
		{
			$redir_page = (post(redir_if_unlogined)) ? post(redir_if_unlogined) : 'access_deny';		
		}

		header('Location: '.$redir_page);
		exit;

		break;

	case 'frontpage_logout':
		logout();
		header('Location: '.EE_HTTP);
		exit;

		break;

//***********************************************************************************
//		RSS Generating
//***********************************************************************************
	case 'news_export':
		$news_show = generate_news($news_export, $channel_id);	
		header('Content-Type: text/xml');
		echo 	$news_show;exit;
		break;
//***********************************************************************************
//		Logout
//***********************************************************************************
	case 'logout':
		logout();
		break;
//***********************************************************************************

	case 'newsletter_subscribe':
		subscriber_subscribe();
		break;

	case 'newsletter_unsubscribe':
		subscriber_unsubscribe();
		break;	

	case 'nl_confirm':
		subscriber_confirm();
		break;

	case 'nl_subscribe':
		go_to_subscribe_page();
		break;

	case 'nl_unsubscribe':
		go_to_unsubscribe_page();
		break;

	//works on Master site
	case 'newsletter_slave_subscribe':
		subscriber_slave_subscribe();
		break;

	case 'newsletter_slave_unsubscribe':
		subscriber_slave_unsubscribe();
		break;
	
	//works on Master site
	case 'nl_slave_confirm':
		subscriber_slave_confirm();
		break;

//***********************************************************************************
	case 'fb_form_submit':
//***********************************************************************************
//		�������� ����� formbuilder'�
//***********************************************************************************
	handle_form_submit();
	
	break;
//***********************************************************************************
	case 'fb_get_file':
//***********************************************************************************
//		�������� ����� formbuilder'�
//***********************************************************************************
	handle_fb_get_file();
	
	break;
//***********************************************************************************
	case 'fb_get_cms':
//***********************************************************************************
//		��������� ���� cms ��� formbuilder'�
//***********************************************************************************
	handle_fb_get_cms();
	
	break;
//***********************************************************************************
	case 'fb_copy_cms':
//***********************************************************************************
//		����������� cms ����� ������ formbuilder'�
//***********************************************************************************
	handle_fb_copy_cms();
	
	break;
/***********************************************************************************/
	case 'ajax_check_captcha':
//***********************************************************************************
//		�������� ����� ����� � ������� ajax
//***********************************************************************************
	$_POST["recaptcha_response_field"] = $_GET["response"];
	$_POST["recaptcha_challenge_field"] = $_GET["challenge"];
	echo check_re_captcha();
	exit;
	
	break;
//***********************************************************************************
		
	case 'show_captcha':
//***********************************************************************************
//	generate and return captcha
//***********************************************************************************
	getCaptchaWord();
	$img = new securimage();
	$img->show();
	exit;	
	break;
//***********************************************************************************

//*******
	case 'admin_section_login':
		$res = 'ERR';

		if (	!empty($_POST['login']) &&
			!empty($_POST['password'])
		)
		{
			$where = 'WHERE 
					login = '.sqlValue($_POST['login']).'
		   			AND
					passw = '.sqlValue(md5($_POST['password'])).'
		   			AND
					role > '.USER.'
		   			AND
					status = '.ENABLED;

			$sql = 'SELECT 
					resetpassw
		  		FROM 
					users '."\r\n".$where;
			$rs = viewsql($sql,1);

			list($reset) = db_sql_fetch_array($rs);
			if ($reset == 1)
			{
				$res = 'RESET_PASSWORD';
			}
			else
			{
				$is_authorized = autorize($_POST['login'], md5($_POST['password']));

				if ($is_authorized)
				{
					if(check_password($_POST['login'], $_POST['password']) != 1)
					{
						logout();
						$res = 'CHANGE_PASSWORD';
					}
					else
					{
						$res = 'OK';
					}
				}
				else
				{
					if(!$is_authorized)
					{
						$res = 'NOT_AUTH';
					}
					logout();
				}

			}
		}

		print $res;
		exit;
		break;

	case 'load_modules':
		global 	$ar_admin_modules_black_list,
			$admin_template;

		$admin_template = 'yes';
		generate_dyn_menu($ar_admin_modules_black_list);
		print 'OK';
		exit;
		break;

	case 'check_modul_loading':

		$string = $_SESSION['__LOADED_MODULES__'];
		$arr 	= explode(';', $string);

		$new_arr['count_all_modules'] 		= $arr[0];
		$new_arr['count_current_modules'] 	= $arr[1];
		$new_arr['current_modul_name'] 		= trim(str_to_title(basename($arr[2], '.php')));

		echo json_encode($new_arr);

		exit;
		break;

	case 'get_object_file':
		$file = $_GET['file'];
		handle_get_object_file($file);
		exit;
		break;


//*******


	default:
		logout();
//vdump ($_SESSION, '$_SESSION'); exit;
		$t='';
		break;
//***********************************************************************************
}
header('Location: index.php'.$t.($admin_template?'&admin_template='.$admin_template:'').'&language='.$language);
?>