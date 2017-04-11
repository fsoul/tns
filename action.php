<?

//********************************************************************
	include_once('_core/ee/lib.php');
//********************************************************************

	require_once(EE_PATH.'autoloader.php');


$action = ( array_key_exists('action', $_GET) ? $_GET['action'] : (array_key_exists('action', $_POST) ? $_POST['action'] : null));
switch ($action) {
	case 'access_package.authorize':

		$resp = ap_resp_init();
		if ($resp->Authorize($_POST['login'], $_POST['passw'], $_POST['login_plid'], $_POST['login_cookie']))
		{
			$info = $resp->Get_Info_By_Email($_POST['login']);
			$_SESSION['respondent']['id_'] = $info['respondent_id_'];
			$_SESSION['respondent']['email_'] = $info['email_'];
			if(strpos($_SERVER['HTTP_REFERER'],get_href('Authorization')) === false) {
				$to = $_SERVER['HTTP_REFERER'];
			} else {
				$to = get_href(45);
			}
            setcookie('respondent_id', $info['respondent_id_'], time() + (3600*24*7),'/');
			header('Location: '.($_POST['backurl']?$_POST['backurl']:$to));
		}
		else
		{
			if(strpos($_SERVER['HTTP_REFERER'],get_href('Authorization')) === false) {
				$to = $_SERVER['HTTP_REFERER'];
			} else {
				$to = get_href(45);
			}
			header('Location: '.get_href('Authorization').'?page_error_flag=1&backurl='.($_POST['backurl']?$_POST['backurl']:$to));
		}
		exit;

	case 'respondent_proshol_opros':
		echo 'respondent_id: '.$_GET['respondent_id'].'<br/>';
		echo 'opros_id: '.$_GET['opros_id'].'<br/>';
		exit;

	case 'respondent_logout':
        $dbRequest = initHttpReq();
        $dbRequest->unAuthorize();

        SetCookie("respondent_id","");
		header('Location: '.$_SERVER['HTTP_REFERER']);
		exit;

	break;

	case 'ap_select_options':

		$dictionary = ( array_key_exists('dictionary', $_GET) ? $_GET['dictionary'] : (array_key_exists('dictionary', $_POST) ? $_POST['dictionary'] : null));

		$func = 'ap_select_'.$dictionary.'_options';
//echo $func;
		header('Content-type: text/xml; charset='.$langEncode[$language]);

		echo	'<?xml version="1.0" encoding="'.($langEncode[$language]).'"?>'."\r\n".
			'  <options>'."\r\n".
			$func((array_key_exists('filter_id', $_GET) ? $_GET['filter_id'] : null)).
			'  </options>';


		exit;
	break;
	case 'ap_select_city_options_from_region':
		header('Content-type: text/html; charset='.$langEncode[$language]);
		echo ap_select_city_options_from_region((array_key_exists('filter_id', $_GET) ? $_GET['filter_id'] : null));
		exit;
	break;

//***********************************************************************************
	case 'login':
//***********************************************************************************
//		Проверка авторизации
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
        
	case 'user_unsubscribe':
		$resp = ap_resp_init();
		$resp->set_resp_declined(ap_get_respondent_id());
                $dbRequest = initHttpReq();
                $dbRequest->unAuthorize();

                setcookie('stored_session','',time()-3600,'/');
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
//		Отправка формы formbuilder'а
//***********************************************************************************
	handle_form_submit();
	
	break;
//***********************************************************************************
	case 'fb_get_file':
//***********************************************************************************
//		Отправка формы formbuilder'а
//***********************************************************************************
	handle_fb_get_file();
	
	break;
//***********************************************************************************
	case 'fb_get_cms':
//***********************************************************************************
//		Получение поля cms для formbuilder'а
//***********************************************************************************
	handle_fb_get_cms();
	
	break;
//***********************************************************************************
	case 'fb_copy_cms':
//***********************************************************************************
//		Копирование cms полей опшина formbuilder'а
//***********************************************************************************
	handle_fb_copy_cms();
	
	break;
/***********************************************************************************/
	case 'ajax_check_captcha':
//***********************************************************************************
//		Проверка капчи формы с помощью ajax
//***********************************************************************************
//	$_POST["recaptcha_response_field"] = $_GET["response"];
//	$_POST["recaptcha_challenge_field"] = $_GET["challenge"];

    $code = $_GET['code'];
    $img = new AccessPanel_Securimage();
    $captcha = $img->check($code);

    echo json_encode(array('code'=>$code, 'captcha' => $captcha));

    exit;
	
	break;
//***********************************************************************************
		
	case 'show_captcha':
//***********************************************************************************
//	generate and return captcha
//***********************************************************************************
	$img = new AccessPanel_Securimage();

	$img->set_image_bg_color('#333333');
	$img->set_font_size(11);
	$img->set_text_minimum_distance(12);
	$img->set_text_maximum_distance(12);
	$img->set_text_x_start(8);
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
		
 case 'show_popup':
    $resp = ap_resp_init();
	$resp_id = ap_get_respondent_id();
	if(!$resp_id) exit;
    header('Content-Type: text/json');
    $check = $resp->get_respondent_survey($resp_id,$_GET['cookie'],$_GET['plid']);
    echo '{"resp":"'.$check.'"}';
    exit;
 break;

 case 'save_popup1':
     $resp = ap_resp_init();
	 $resp_id = ap_get_respondent_id();
	 if(!$resp_id) exit;
     //$resp->complete_respondent_survey(ap_get_respondent_id(),$_GET['cookie']);
     $resp->complete_respondent_survey($resp_id,(int)$_GET['type'],$_GET['cookie']);
     //$resp->save_answer(ap_get_respondent_id(),$_GET['cookie'],0,0);
     if((int)$_GET['type'] == 1) header('Location: /'.$language.'/Plugin.html#plugin_form_title');
     exit;
 break;

 case 'save_popup':
    $resp = ap_resp_init();
    header('Content-Type: text/json');
    
    //$resp_placement       = isset( $_GET['placement'] )    ? (int)$_GET['placement']      : -1;
    $who_use_resp_machine = isset( $_GET['using_machine'] )? (int)$_GET['using_machine']  : -1; 
    //$dev_count = isset( $_GET['dev_count'] )? (int)$_GET['dev_count']  : -1;
    $cookie               = isset( $_GET['cookie'] )       ? $_GET['cookie']              : '';
    $resp_id              = ap_get_respondent_id();
    
    if( /*in_array( $resp_placement, array( 0, 4, 5, 6 ) ) &&*/
        /*in_array( $who_use_resp_machine, array( 0, 1, 2, 3) ) && */
        $who_use_resp_machine >= 0 &&
        /*in_array( $dev_count, array( 0, 7, 8, 9, 10, 11 ) ) &&*/
        !empty($cookie) &&
        $resp_id > 0
    ){ 
        if($resp->save_answer( $resp_id, $cookie, $who_use_resp_machine)){
            echo '{"resp":"1"}';
        } else {
            echo '{"resp":"0"}';
        }
    } else {
       echo '{"resp":"0"}';  
    }
    exit;
 break;
    case 'link_plugin_id':
        $resp = ap_resp_init();
        $cookie  = isset( $_GET['tns_id'] )  ? trim( $_GET['tns_id'] ) : '';
        $respondent_id  = isset( $_GET['id_resp'] )  ? (int)trim( $_GET['id_resp'] ) : 0;
        $plugin_id  = isset( $_GET['id_pl'] )  ? (int)trim( $_GET['id_pl'] ) : 0;
		if($respondent_id > 0) {
			$resp->plugin_package_link_plugin_id($respondent_id, $plugin_id, $cookie);
		}
        exit;
        break;
//*******

    case 'test':
        //ap_profile_anketa();
        mail_respondent('yurabid@gmail.com', 'some test subject', 'some test message', '', 'Yu', 'Bi');
		exit;
        break;
	case 'check_adblock':
		$is_counter_block  = isset( $_GET['is_counter_block'] )  ? trim( $_GET['is_counter_block'] ) : '';
		$is_adv_block  = isset( $_GET['is_adv_block'] )  ? trim( $_GET['is_adv_block'] ) : '';
		//$result = array('is_counter_block' => $is_counter_block, 'is_adv_block' => $is_adv_block);
		$resp_id = ap_get_respondent_id();
		$cookie = isset( $_GET['cookie'] ) ? $_GET['cookie'] : '';
		$plid_id =  isset( $_GET['plid'] ) ? $_GET['plid'] : '';
		var_dump($resp_id);
		var_dump($cookie);
		var_dump($plid_id);
		$resp = ap_resp_init();
		$resp_id = ap_get_respondent_id();
		if(!$resp_id) exit;
		$check = $resp->set_adv_block_status($is_counter_block, $is_adv_block, $resp_id, $cookie, $plid_id);
		echo json_encode($check);
		exit;
		break;
	default:
		logout();
//vdump ($_SESSION, '$_SESSION'); exit;
		$t='';
		break;
//***********************************************************************************
}
header('Location: index.php'.$t.($admin_template?'&admin_template='.$admin_template:'').'&language='.$language);