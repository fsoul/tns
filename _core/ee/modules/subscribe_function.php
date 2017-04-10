<?
	define('SUBSCRIBE_CODE', 	0);
	define('SUBSCRIBE_CONFIRM', 1);
	define('START_SEND_MAIL', 	2);
	define('UNSUBSCRIBE_CODE', 	3);
	define('UNSUBSCRIBE_CONFIRM', 4);
	
	function get_back_form_string()
	{
		$s .= "";
		foreach($_POST as $var=>$val)
		{
			$s .= "&".$var."=".urlencode($val);
		}		
		return $s;
	}
	
	function get_back_form_get_string()
	{
		$s = "";
		foreach($_GET as $var=>$val)
		{
			$s .= "&".$var."=".$val;
		}		
		return $s;
	}
	
	function compose_subscribe_mail()
	{
		$Html = 'User: '.$_POST['name'].' '.$_POST['lname'].' <br> <a href="mailto:'.$_POST['email'].'">'.$_POST['email'].'</a><br>';
		$Html.= '<br>sent subscribe request for following newsletters:<br>';
		
		$r_gr = db_sql_query("SELECT * FROM v_nl_group");
		while ($f_gr = db_sql_fetch_assoc($r_gr))
		{
			if (isset($_POST["group_".$f_gr["id"]]))
			{
				$Html .= '<b>'.$f_gr["group_name"].'</b><br>';
			}
		}
		SendMailSimple(cms('dest_email'), cms('dest_email'), $Html, cms('dest_email')," Email System");
	}
	
	function compose_unsubscribe_mail()
	{
		$Html = 'User: <a href="mailto:'.$_POST['email'].'">'.$_POST['email'].'</a><br>';
		$Html.= '<br>sent unsubscribe request for following newsletters:<br>';
		$r_gr = db_sql_query("SELECT * FROM v_nl_group");
		while ($f_gr = db_sql_fetch_assoc($r_gr))
		{
			if (isset($_POST["group_".$f_gr["id"]]))
			{
				$Html .= '<b>'.$f_gr["group_name"].'</b><br>';
			}
		}
		SendMailSimple(cms('dest_email'), cms('dest_email'), $Html, cms('dest_email')," Email System");
	}
	
	function send_confirmation($letter_prefix, $ids, $ee_http, $tpl_prefix, $confirm_page, $language)
	{
		global $message, $t;
		//$tpl = get_subscribe_template('newsletter_'.$letter_prefix.'_notification', $tpl_prefix);
		//$mes_page_id = getField('SELECT id FROM tpl_pages WHERE page_name='.SqlValue($tpl));
		//$t = $mes_page_id;
		//$message = parse_tpl($tpl);
		$message = cms($tpl_prefix.$letter_prefix.'_notification');
		if(empty($tpl))
		{
			$message = cms($letter_prefix.'_notification');
		}
		$confirm_code = rand (100000, 999999).implode('',$ids);
		//если в функцию передали параметр $ee_http, значит имееи дело со slave сайтом
		if(!empty($confirm_page) && !empty($language))
		{
			$confirm_page = preg_replace('/<%:language%>/i', $language, urldecode($confirm_page));
			$link = '<a href="'.$confirm_page.'?confirm_code='.$confirm_code.'">'.$confirm_page.'?confirm_code='.$confirm_code.'</a>';
		}
		else
		{
			$link = '<a href="'.EE_HTTP.'action.php?action=nl_confirm&confirm_code='.$confirm_code.'&language='.$_POST["language"].'">'.EE_HTTP.'action.php?action='.$action.'&confirm_code='.$confirm_code.'&language='.$_POST["language"].'</a>';
		}
		$message = str_replace('{{CONFIRM_LINK}}', $link, $message);
		foreach ($ids as $id_subscriber)
		{
			RunSQL('UPDATE nl_subscriber SET 
				confirm_code = '.$confirm_code.', 
				language = '.sqlValue($_POST["language"]).', 
				last_send = NOW() 
				WHERE id = '.$id_subscriber);
		}
		$r_gr = db_sql_query("SELECT * FROM v_nl_group WHERE show_on_front=1");
		
		$s_group = '';
		while ($f_gr = db_sql_fetch_assoc($r_gr))
		{
			if (isset($_POST["group_".$f_gr["id"]]))
			{
				$s_group .= $f_gr["group_name"].", ";
			}
		}
		$s_group = substr($s_group,0,-2);
		$message = str_replace('{{GROUP_NAMES}}', $s_group, $message);
		
		$message = str_replace('{{LANGUAGE}}', $_POST['language'], $message);
		
		if($letter_prefix == 'subscribe')
		{
			$letter_subject = cms('nl_notification_subject', $mes_page_id, strtoupper($_POST["language"]));
			if(trim($letter_subject) == '')
				$letter_subject = cms('nl_notification_subject', 0, strtoupper($_POST["language"]));
			$letter_from_email = cms('nl_notification_from_email', $mes_page_id);
			if(trim($letter_from_email) == '')
				$letter_from_email = cms('nl_notification_from_email', 0);
		}
		else 
		{
			$letter_subject = cms('nl_uns_notification_subject', $mes_page_id, strtoupper($_POST["language"]));
			if(trim($letter_subject) == '')
				$letter_subject = cms('nl_uns_notification_subject', 0, strtoupper($_POST["language"]));
			$letter_from_email = cms('nl_uns_notification_from_email', $mes_page_id);
			if(trim($letter_from_email) == '')
				$letter_from_email = cms('nl_uns_notification_from_email', 0);
		}

		SendMailSimple(trim($_POST['email']), $letter_subject, $message, $letter_from_email, "");
	}
	
	//function return ? or & sign depend of url has query string parameters or not
	function check_if_url_has_params($url)
	{
		if (strpos($url, '?') === false)
		{
			$sign = '?';
		}
		else
		{
			$sign = '&';
		}

		return $sign;
	}
	
	function subscriber_subscribe()
	{
		$admin_template = $_POST['admin_template'];
		$form_page_id = $_POST['page_id'];//id of page with subscribe form
		$form_page_url = EE_HTTP.get_default_alias_for_page($form_page_id);//url of page with subscribe form
		$form_page_url_qs = $form_page_url.check_if_url_has_params($form_page_url);//url of page with subscribe form with first sign of query string
		
		$s = '';
		if(!check_email($_POST['email']) && $s=='')
		{
			$s = $form_page_url_qs.'result=err_invalid_email_format'.get_back_form_string();
		}

		if($s=='')
		{
			$r_gr = db_sql_query("SELECT * FROM v_nl_group WHERE show_on_front=1");
			$k=0;
			$ids = array();
			while ($f_gr = db_sql_fetch_assoc($r_gr))
			{
				if (isset($_POST["group_".$f_gr["id"]]))
				{
					$id_subscriber = nl_subscriber_add($_POST['email'], $f_gr["id"], SUBSCRIBE_CODE, $_POST['name'], $_POST['lname'], $_SERVER['REMOTE_ADDR']);
					if ($id_subscriber == -2) 
					{
						list($id_subscriber, $cur_status) = db_sql_fetch_row(viewSql('SELECT id, status FROM nl_subscriber WHERE email = TRIM('.sqlValue($_POST['email']).') AND nl_group_id = '.$f_gr["id"]));
						if ($cur_status != 1)
						{
							nl_subscriber_set_status($id_subscriber, SUBSCRIBE_CODE);
						}
					}
					if ($id_subscriber > 0) $ids[] = $id_subscriber;
					$k=1;
				}
			}
			if ($k==0)
				$s = $form_page_url_qs.'result=err_at_least_one_group'.get_back_form_string();
			
		}
	
		if ($s=='')
		{

			if (count($ids) >0) 
			{
				send_confirmation('subscribe', $ids);
				compose_subscribe_mail();
			}
			$s = cms_link('subscribe_thanks');
			if($s == '#' || $s == '')
			{
				$s = $form_page_url;
			}

		}
		header('Location: '.$s);
		exit;
	}
	
	function go_to_subscribe_page()
	{
		$slave_subscribe_page = $_GET['slave_subscribe_page'];
		unset($_GET['action']);
		$site_name = isset($_GET['site_name'])?$_GET['site_name']:'';//имя, оно же идентификатор сайта, если его не передали то будут использоватся шаблоны по умолчанию
		$site_name_with_suffix = ($site_name != '')?$site_name.'_':'';//имя вида "имя-сайта_"
		//проверяем существует ли запрошеная страница, в противном случае возвращаем дефолтную
		$page = get_subscribe_page($slave_subscribe_page, $site_name_with_suffix);
		$page_uri = get_page_url_by_template($page);
		$page_uri = $page_uri.check_if_url_has_params($page_uri);
		//$_GET['slave_subscribe_page'] = $page;//запоминаем ее на будущее чтобы повторно не проверять
		header('Location: '.$page_uri.get_back_form_get_string());
		exit;
	}
	
	function go_to_unsubscribe_page()
	{
		$slave_unsubscribe_page = $_GET['slave_unsubscribe_page'];
		unset($_GET['action']);
		$site_name = isset($_GET['site_name'])?$_GET['site_name']:'';//имя, оно же идентификатор сайта, если его не передали то будут использоватся шаблоны по умолчанию
		$site_name_with_suffix = ($site_name != '')?$site_name.'_':'';//имя вида "имя-сайта_"
		//проверяем существует ли запрошеная страница, в противном случае возвращаем дефолтную
		$page = get_subscribe_page($slave_unsubscribe_page, $site_name_with_suffix);
		$page_uri = get_page_url_by_template($page);
		$page_uri = $page_uri.check_if_url_has_params($page_uri);
		//$_GET['slave_unsubscribe_page'] = $page;
		header('Location: '.$page_uri.get_back_form_get_string());
		exit;
	}
	
	function subscriber_slave_subscribe()
	{
		$site_name = isset($_POST['site_name'])?$_POST['site_name']:'';//имя, оно же идентификатоg сайта, если его не пеgедали то будут использоватся шаблоны по умолчаниs
		$site_name_with_suffix = ($site_name != '')?$site_name.'_':'';//имя вида "имя-сайта_"
		$confirm_page = isset($_POST['confirm_page'])?$_POST['confirm_page']:'';//Стgаница на Slave сайте на котоgуs попадает пользователь после подтвеgждения подписки
		$slave_server = isset($_POST['slave_server'])?$_POST['slave_server']:'';
		$slave_prefix = isset($_POST['slave_prefix'])?$_POST['slave_prefix']:'';
		$request_uri = isset($_POST['request_uri'])?$_POST['request_uri']:'';
		$slave_subscribe_page = isset($_POST['slave_subscribe_page'])?$_POST['slave_subscribe_page']:'';
		$language = isset($_POST['language'])?$_POST['language']:'';
		//Пgовеgяем есть ли такой язык на сайте, если нет то добавляем
		$res = ViewSql('SELECT language_code FROM language WHERE language_code='.SqlValue($language));
		if(db_sql_num_rows($res) < 1)
			RunSql('INSERT INTO language SET language_code='.SqlValue($language).', language_name='.SqlValue($language).', l_encode='.SqlValue(getCharset()).', paypal_lang='.SqlValue($language).', status=0, default_language=0');

		//check form fields
		$err = '';
		if($_POST['name'] == '' && $err=='')
		{
			$err = 'result=err_blank_name'.get_back_form_string();
		}
		else if($_POST['lname'] == '' && $err=='')
		{
			$err = 'result=err_blank_lname'.get_back_form_string();
		}
		else if(!check_email($_POST['email']) && $err=='')
		{
			$err = 'result=err_invalid_email_format'.get_back_form_string();
		}

		//add subscriber
		if($err=='')
		{
			$r_gr = db_sql_query("SELECT * FROM v_nl_group WHERE show_on_front=1");
			$k=0;
			$ids = array();
			while ($f_gr = db_sql_fetch_assoc($r_gr))
			{
				if (isset($_POST["group_".$f_gr["id"]]))
				{
					$id_subscriber = nl_subscriber_add($_POST['email'], $f_gr["id"], SUBSCRIBE_CODE, $_POST['name'], $_POST['lname'], $_SERVER['REMOTE_ADDR']);
					if ($id_subscriber == -2) 
					{
						list($id_subscriber, $cur_status) = db_sql_fetch_row(viewSql('SELECT id, status FROM nl_subscriber WHERE email = TRIM('.sqlValue($_POST['email']).') AND nl_group_id = '.$f_gr["id"].' AND language='.sqlValue($_POST['language'])));
						if ($cur_status != 1)
						{
							nl_subscriber_set_status($id_subscriber, SUBSCRIBE_CODE);
						}
					}
					if ($id_subscriber > 0) $ids[] = $id_subscriber;
					$k=1;
				}
			}
			if ($k==0)
				$err = 'result=err_at_least_one_group'.get_back_form_string();
		}
		
		//send email
		if ($err=='')
		{
			if(count($ids) >0) 
			{
				send_confirmation('subscribe', $ids, $slave_server.$slave_prefix, $tpl_prefix, $confirm_page, $language);
				compose_subscribe_mail();
			}
			//посылаем и-мейл администgатоgу
			if(cms('newsletters_administrator_email') != '')
			{
				$eol = "\r\n";
				$headers = 'From: '.cms('nl_notification_from_email').$eol;
				$headers .= 'MIME-Version: 1.0'.$eol;
				$headers .= 'Content-Type: text/html; charset=utf-8'.$eol;
				$headers .= 'X-Mailer: PHP/'.phpversion();
				$message = parse(MASTER_NL_TEMPLATES_FOLDER.'email');
				
				$email_groups = '';
				foreach($_POST as $key => $value)
				{
					if(strpos($key, 'group_') !== false)
					{
						$email_groups .= getField('SELECT `group_name` FROM nl_group WHERE `id`='.sqlValue(substr($key, 6))).'<br>';
					}
				}
				
				$message = str_replace("{name}", $_POST['name'], $message);
				$message = str_replace("{lname}", $_POST['lname'], $message);
				$message = str_replace("{email}", $_POST['email'], $message);
				$message = str_replace("{language}", $_POST['language'], $message);
				$message = str_replace("{email_groups}", $email_groups, $message);
				$message = str_replace("{date}", date("Y.m.d G:i:s"), $message);
				$message = str_replace("{ip}", $_SERVER['REMOTE_ADDR'], $message);
				
				mail(cms('newsletters_administrator_email'), EE_SITE_NAME.' '.cms('newsletters_administrator_email_title'), $message, $headers);
			}

			//Выводим шаблон подтвеgждения подписки
			//но для начала удостовеgимся что кастомная стgаница существует, в пgотивном случае выволим стgаницу по умолчаниs
			$tpl = get_subscribe_page('nl_subscribe_thanks', $site_name_with_suffix);
			$page_uri = get_page_url_by_template($tpl);
			$page_uri = $page_uri.check_if_url_has_params($page_uri);
			$url = $page_uri.'site_name='.urlencode($site_name).'&slave_server='.urlencode($slave_server).'&slave_prefix='.urlencode($slave_prefix);
		}
		else//error
		{
			$page_uri = get_page_url_by_template($slave_subscribe_page);
			$page_uri = $page_uri.check_if_url_has_params($page_uri);
			$url = $page_uri.$err;
		}

		header('Location: '.$url);
		exit;
	}
	
	function subscriber_unsubscribe()
	{
		$admin_template = $_POST['admin_template'];
		$form_page_id = $_POST['page_id'];//id of page with unsubscribe form
		$form_page_url = EE_HTTP.get_default_alias_for_page($form_page_id);//url of page with unsubscribe form
		$form_page_url_qs = $form_page_url.check_if_url_has_params($form_page_url);//url of page with unsubscribe form with first sign of query string
		
		$s = '';
		if(!check_email($_POST['email']) && $s=='')
		{
			$s = $form_page_url_qs.'result=err_invalid_email_format'.get_back_form_string();
		}
		
		$ids = array();
		
		if($s=='')
		{
			$r_gr = ViewSQL("SELECT * FROM v_nl_group WHERE show_on_front=1",0);
			$k=0;
			while ($f_gr = db_sql_fetch_assoc($r_gr))
			{
				if (isset($_POST["group_".$f_gr["id"]]))
				{
					$r1 = ViewSQL('SELECT * FROM nl_subscriber WHERE email=TRIM('.sqlValue($_POST['email']).') AND nl_group_id = '.$f_gr["id"],0);
					$k=1;
					if (db_sql_num_rows($r1) > 0)
					{
						$f1 = db_sql_fetch_assoc($r1);
						nl_subscriber_set_status($f1["id"],UNSUBSCRIBE_CODE);
						$ids[] = $f1["id"];
					}					
				}
			}
			if ($k==0)
				$s = $form_page_url_qs.'result=err_at_least_one_group'.get_back_form_string();
		}
			
		if ($s=='')
		{
			$s = cms_link('unsubscribe_thanks');
			if($s == '#' || $s == '')
			{
				$s = $form_page_url;
			}
			if (count($ids) >0) 
			{
				send_confirmation('unsubscribe', $ids);
				compose_unsubscribe_mail();
			}
		}

		header('Location: '.$s);
		exit;
	}
	
	function subscriber_slave_unsubscribe($ee_http = EE_HTTP, $tpl_prefix = '', $confirm_page = '')
	{
		$site_name = isset($_POST['site_name'])?$_POST['site_name']:'';//имя, оно же идентификатоg сайта, если его не пеgедали то будут использоватся шаблоны по умолчаниs
		$site_name_with_suffix = ($site_name != '')?$site_name.'_':'';//имя вида "имя-сайта_"
		$confirm_page = isset($_POST['confirm_page'])?$_POST['confirm_page']:'';//Стgаница на Slave сайте на котоgуs попадает пользователь после подтвеgждения подписки
		$slave_server = isset($_POST['slave_server'])?$_POST['slave_server']:'';
		$slave_prefix = isset($_POST['slave_prefix'])?$_POST['slave_prefix']:'';
		$request_uri = isset($_POST['request_uri'])?$_POST['request_uri']:'';
		$slave_unsubscribe_page = isset($_POST['slave_unsubscribe_page'])?$_POST['slave_unsubscribe_page']:'';
		$language = isset($_POST['language'])?$_POST['language']:'';

		//check form
		$err = '';
		if(!check_email($_POST['email']) && $s=='')
		{
			$err = 'result=err_invalid_email_format'.get_back_form_string();
		}
		
		$ids = array();
		
		//delete subscriber
		if($err=='')
		{
			$r_gr = ViewSQL("SELECT * FROM v_nl_group WHERE show_on_front=1",0);
			$k=0;
			while($f_gr = db_sql_fetch_assoc($r_gr))
			{
				if(isset($_POST["group_".$f_gr["id"]]))
				{
					$r1 = ViewSQL('SELECT * FROM nl_subscriber WHERE email=TRIM('.sqlValue($_POST['email']).') AND nl_group_id = '.$f_gr["id"].' AND language='.sqlValue($_POST['language']),0);
					$k=1;
					if (db_sql_num_rows($r1) > 0)
					{
						$f1 = db_sql_fetch_assoc($r1);
						nl_subscriber_set_status($f1["id"],UNSUBSCRIBE_CODE);
						$ids[] = $f1["id"];
					}
				}
			}
			if($k==0)
				$err = 'result=err_at_least_one_group'.get_back_form_string();
		}
		
		if ($err=='')
		{
			if(count($ids) >0) 
			{
				send_confirmation('unsubscribe', $ids, $slave_server.$slave_prefix, $tpl_prefix, $confirm_page, $language);
				compose_unsubscribe_mail();
			}
			//Выводим шаблон подтвеgждения отписки
			//но для начал удостовеgимся что кастомный шаблон существует, в пgотивном слкчае выволим шаблон по умолчаниs
			$tpl = get_subscribe_page('nl_unsubscribe_thanks', $site_name_with_suffix);
			$page_uri = get_page_url_by_template($tpl);
			$page_uri = $page_uri.check_if_url_has_params($page_uri);
			$url = $page_uri.'site_name='.urlencode($site_name).'&slave_server='.urlencode($slave_server).'&slave_prefix='.urlencode($slave_prefix);
		}
		else//error
		{
			$page_uri = get_page_url_by_template($slave_unsubscribe_page);
			$page_uri = $page_uri.check_if_url_has_params($page_uri);
			$url = $page_uri.$err;
		}
		header('Location: '.$url);
		exit;
	}

	//function return cms link or default page alias
	function get_value_of_cms_link($var, $language = '')
	{
		$return = cms_link($var, '', $language);
		if($return == '' || $return == "#")
		{
			$return = EE_HTTP.get_default_alias_for_page(get_default_page_id(), '' , $language);
		}
		return $return;
	}
	
	function subscriber_confirm()
	{
		$error_page = get_value_of_cms_link('subscribe_error', $language);
		$error_page_qs = $error_page.check_if_url_has_params($error_page);
		$subscr_sucess_page = get_value_of_cms_link('subscribe_confirm_thanks', $language);
		$unsubscr_sucess_page = get_value_of_cms_link('unsubscribe_confirm_thanks', $language);
		
		$s='';
		if (get("confirm_code"))
		{
			$r = db_sql_query('SELECT * FROM v_nl_subscriber WHERE confirm_code='.sqlValue($_GET['confirm_code']));
			if ((db_sql_num_rows($r)==0)||($_GET["confirm_code"]==0)) // invalid code
			{
				$s = $error_page_qs.'result=invalid_code';
			} else {
				while ($f = db_sql_fetch_assoc($r))
				{
					if (($f["status"]==SUBSCRIBE_CODE)||($f["status"]==UNSUBSCRIBE_CONFIRM))
					{
						RunSQL('UPDATE nl_subscriber SET 
								status = '.SUBSCRIBE_CONFIRM.',
								confirm_code = \'0\'
								WHERE id = '.$f["id"]);
						$s = $subscr_sucess_page;
					}
					elseif ($f["status"]==UNSUBSCRIBE_CODE)
					{
						RunSQL('UPDATE nl_subscriber SET 
								status = '.UNSUBSCRIBE_CONFIRM.',
								confirm_code = \'0\'
								WHERE id = '.$f["id"]);
						$s = $unsubscr_sucess_page;
					}
				else // subscribe/unsubscribe already confirmed
					{
						RunSQL('update nl_subscriber set confirm_code = \'0\' where id = '.$f["id"]);
					}
				}
			}		
		} else $s = $error_page_qs.'result=invalid_code';
		
		header('Location: '.$s);
		exit;
	}
	
	function subscriber_slave_confirm($site_name_with_suffix = '')
	{
		//забиваем в post аgхив полученые значения чтобы они на совесть обgабатывылись функцией get_back_form_string
		$site_name = isset($_GET['site_name'])?$_GET['site_name']:'';//имя, оно же идентификатоg сайта, если его не пеgедали то будут использоватся шаблоны по умолчаниs
		$site_name_with_suffix = ($site_name != '')?$site_name.'_':'';//имя вида "имя-сайта_"
		$language = isset($_GET['language'])?$_GET['language']:'';
		$slave_server = isset($_GET['slave_server'])?$_GET['slave_server']:'';
		$slave_prefix = isset($_GET['slave_prefix'])?$_GET['slave_prefix']:'';

		$uri='';
		if(get("confirm_code"))
		{
		
			$r = db_sql_query('SELECT * FROM v_nl_subscriber WHERE confirm_code='.sqlValue($_GET['confirm_code']));
			if((db_sql_num_rows($r)==0)||($_GET["confirm_code"]==0)) // invalid code
			{
				$tpl = get_subscribe_page('nl_subscribe_error', $site_name_with_suffix);//
				$page_uri = get_page_url_by_template($tpl);
				$page_uri = $page_uri.check_if_url_has_params($page_uri);
				$uri = $page_uri.'result=invalid_code'.get_back_form_get_string();
			}
			else
			{
				while($f = db_sql_fetch_assoc($r))
				{
					if(($f["status"]==SUBSCRIBE_CODE))
					{
						RunSQL('UPDATE nl_subscriber SET 
								status = '.SUBSCRIBE_CONFIRM.',
								confirm_code = \'0\'
								WHERE id = '.$f["id"]);
						$tpl = get_subscribe_page('nl_subscribe_confirm_thanks', $site_name_with_suffix);
						$page_uri = get_page_url_by_template($tpl);
						$page_uri = $page_uri.check_if_url_has_params($page_uri);
						$uri = $page_uri.get_back_form_get_string();
					}
					else if($f["status"]==UNSUBSCRIBE_CODE)
					{
						RunSQL('UPDATE nl_subscriber SET 
								status = '.UNSUBSCRIBE_CONFIRM.',
								confirm_code = \'0\'
								WHERE id = '.$f["id"]);
						$tpl = get_subscribe_page('nl_unsubscribe_confirm_thanks', $site_name_with_suffix);
						$page_uri = get_page_url_by_template($tpl);
						$page_uri = $page_uri.check_if_url_has_params($page_uri);
						$uri = $page_uri.get_back_form_get_string();
					}
				else // subscribe/unsubscribe already confirmed
					{
						RunSQL('update nl_subscriber set confirm_code = \'0\' where id = '.$f["id"]);
						//Deviant add
						//Если пользователь подтвердид ранее
						if($f['subscriber_status'] == 'subscribed')
						{
							$tpl = get_subscribe_page('nl_subscribe_confirm_thanks', $site_name_with_suffix);
							$page_uri = get_page_url_by_template($tpl);
							$page_uri = $page_uri.check_if_url_has_params($page_uri);
							$uri = $page_uri.get_back_form_get_string();
						}
						else
						{
							$tpl = get_subscribe_page('nl_unsubscribe_confirm_thanks', $site_name_with_suffix);
							$page_uri = get_page_url_by_template($tpl);
							$page_uri = $page_uri.check_if_url_has_params($page_uri);
							$uri = $page_uri.get_back_form_get_string();
						}
					}
				}
			}		
		}
		else
		{
			$tpl = get_subscribe_page('nl_subscribe_error', $site_name_with_suffix);
			$page_uri = get_page_url_by_template($tpl);
			$page_uri = $page_uri.check_if_url_has_params($page_uri);
			$uri = $page_uri.'result=invalid_code'.get_back_form_get_string();
		}

		header('Location: '.$uri);
		exit;
	}
	
	//определяем есть ли кастомный шаблон, в противном случае выводим дефолтный
	function get_subscribe_template($tpl_name, $site_name_with_suffix = '')
	{
		$tpl = MASTER_NL_TEMPLATES_FOLDER.$site_name_with_suffix.$tpl_name;//кастомный шаблон
		if(!file_exists(EE_PATH.'templates/'.$tpl.'.tpl') && !file_exists(EE_CORE_PATH.'templates/'.$tpl.'.tpl'))
			$tpl = MASTER_NL_TEMPLATES_FOLDER.$tpl_name;//дефолтный шаблон
		return $tpl;
	}
	
	//определяем есть ли кастомный страница, в противном случае выводим дефолтную
	function get_subscribe_page($page_name, $site_name_with_suffix = '')
	{
		//Внимание! Unique page name не должно равнятся id
		$res = ViewSql('SELECT id FROM tpl_pages WHERE page_name='.SqlValue($site_name_with_suffix.$page_name));
		if(db_sql_num_rows($res) > 0) return $site_name_with_suffix.$page_name;
		else return $page_name;
	}
	
	//function set cms field with email title if it is empty
	function set_newsletter_title_cms($email_id, $email_subject)
	{
		if(cms('news_letter_subject_'.$email_id) == '')
		{
			save_cms('news_letter_subject_'.$email_id, $email_subject);
		}
	}
	
	//function get template_name and return page_id of first page based on this template
	function get_page_id_by_template($template)
	{
		return getField('SELECT p.id FROM tpl_pages AS p, tpl_files AS f WHERE p.tpl_id=f.id AND f.file_name='.sqlValue(MASTER_NL_TEMPLATES_FOLDER.$template).' LIMIT 0,1');
	}
	
	//function get template_name and return page_url of first page based on this template
	function get_page_url_by_template($template)
	{
		$return = '';
		$page_id = get_page_id_by_template($template);
		if($GLOBALS['admin_template'] == 'yes' && checkAdmin())
		{
			$return = EE_HTTP.'index.php?t='.$page_id.'&admin_template=yes';
		}
		else
		{
			$return = EE_HTTP.get_default_alias_for_page($page_id);
		}
		return $return;
	}
	
	function parse_confirm_url($url)
	{
		return urldecode(preg_replace('/<%:EE_HTTP%>/i', EE_HTTP, $url));
	}


