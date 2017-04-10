<?php
//include file with text values depend on language
include_once('formbuilder_lang.php');

//error_reporting(E_ALL ^ E_NOTICE);
function handle_form_submit()
{
	global $language;
	//получаем список полей указанной формы
	$form_id = $_POST['fb_form_id'];
	$sql = create_sql_view_by_name('formbuilder');
	$sql = 'SELECT * FROM('.$sql.') AS formbuilder WHERE record_id='.sqlValue($form_id).' LIMIT 0,1';
	$rs = viewSql($sql);
	$res = db_sql_fetch_assoc($rs);
	$form_config = unserialize($res['form_config']);
	$content = unserialize($res['content']);
	$date = date("Y-m-d G:i:s");
	
	//проверяем доступна ли форма для незарегистрированных пользователей и может ли пользователь отправить ее более раза
	$check_for_registered = check_for_registered_and_can_sent($form_id, $form_config);
	if(!is_null($check_for_registered))
	{
		return $check_for_registered;
	}
	
	//проверяем на наличие ошибок
	$errors = 0;
	$file_errors = array();
	$thanks_page = $form_config['fb_thanks_page'];
	$page_url = $_POST['page_url'];
	$fb_stored_values = array();
	
	//проверяем существует ли папка для формбилдера, если нет то создаем ее
	$file_dir = EE_PATH.FORMBUILDER_FOLDER;
	if(!is_dir($file_dir) || !file_exists($file_dir))
		mkdir($file_dir, 0777);
	
	$user_input = array();//сериализированное поле для объекта
	$files_count = 1;//счетчик файлов
	
	//radio кнопки с одинаковыми именами будем показывать только один раз
	//поэтому запоминаем в данном масиве их имена и проверяем не показывали ли мы ее ранее 
	$showed_radio_fields = array();
	
	for($i=0; $i<sizeof($content); $i++)
	{
		if($content[$i]['type'] == 'radio')
		{
			if(in_array($content[$i]['name'], $showed_radio_fields))
			{
				continue;
			}
			$showed_radio_fields[] = $content[$i]['name'];
		}
		if($content[$i]['type'] != 'submit' && $content[$i]['type'] != 'reset' && $content[$i]['type'] != 'text_line' && $content[$i]['type'] != 'paragraph_text' && $content[$i]['type'] != 'html_field' && $content[$i]['type'] != 'captcha')
		{
			//Формируем запись для БД
			$j = sizeof($user_input);
			$user_input[$j]['label'] = cms('fb_label'.$content[$i]['id']);
			$user_input[$j]['name'] = $content[$i]['name'];
			$fb_stored_values[$content[$i]['name']] = $_POST[$content[$i]['name']];
			
			$user_input[$j]['type'] = $content[$i]['type'];
			$user_input[$j]['value'] = $_POST[$content[$i]['name']];
			//загружаем файлы
			if($content[$i]['type'] == 'file')
			{
				$file = $_FILES[$user_input[$j]['name']];
				$file_tmp_name = $file['tmp_name'];
				if(!empty($file_tmp_name)){
					$file_name = $file['name'];
					$file_type = $file['type'];
					
					$allow_all_extensions = 0;
					if(empty($content[$i]['extensions']))//если типы разрешенных файлов не заданый значит разрешены все
					{
						$allow_all_extensions = 1;
					}
					$max_file_size = 1000;//1 Gb
					if(!empty($content[$i]['max_size']))
					{
						$max_file_size = $content[$i]['max_size'];
					}
					$alowed_extensions = explode(',', $content[$i]['extensions']);
					$alowed_extensions = array_map('trim', strtolower($alowed_extension));
					$path_parts = pathinfo($file_name);
					$extention = strtolower($path_parts['extension']);
					//Поскольку пользователь может отключить опцию сохранения данных БД
					//то мы будем переименовывать файлы не по названию record_id, а по дате
					$new_file_name = str_replace(' ','_',$date);
					$new_file_name = str_replace(':','-',$new_file_name).'_'.$files_count.'.'.$extention;
					$new_file_path = $file_dir.$new_file_name;
					$files_count++;
					//echo 'begining of uploading file '.$file_name.'<br>';
					if(in_array($extention, $alowed_extensions) || $allow_all_extensions)//Проверим тип файла
					{
						//echo 'file type accepted<br>';
						if($file['size'] <= ($max_file_size * 1024 * 1024))//Проверим размер файла
						{
							if(!move_uploaded_file($file_tmp_name, $new_file_path))
							{
								$file_errors[] = $content[$i]['id'];
								$errors = -2;//Не могу загрузить файл
							}
							else
							{
								$user_input[$j]['file_path'] = $new_file_path;
								$user_input[$j]['file_name'] = $new_file_name;
								$user_input[$j]['file_type'] = $file_type;
							}
						}
						else
						{
							$file_errors[] = $content[$i]['id'];
							$errors = -3;//Превышен размер файла
						}
					}
					else
					{
						$file_errors[] = $content[$i]['id'];
						$errors = -4;//Тип файла не разрешен к загрузке
					}
					
					$user_input[$j]['value'] = $file_name;//перезаписываем значение
				}
				else
				{
					//файл не был добавлен
					if($content[$i]['required'] == 'yes' && $content[$i]['check'] != 'none')
					{
						$file_errors[] = $content[$i]['id'];
						$errors = -6;//Требуется загрузить файл
					}
				}
			}
		}
		//Проверяем капчу
		else if($content[$i]['type'] == 'captcha')
		{
			$captcha = new Securimage();
			if($captcha->check($_POST[$content[$i]['name']]) === false)
			{
				$file_errors[] = $content[$i]['id'];
				$errors = -7;//Капча не правильная
			}
		}
	}
	//сохраняем введенные пользователем данные в БД
	if($errors == 0)
	{//////////
	$user_name = '';
	if(isset($_SESSION['UserId']))
		$user_name = $_SESSION['UserId'];
	$db_fields = array('record_id' => '', 'form_id' => $form_id, 'user_name' => $user_name, 'serialized' => serialize($user_input), 'language' => $language, 'date' => $date, 'ip' => ((!empty($_SERVER['HTTP_X_FORWARDED_FOR']))?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']));
	
	if($form_config['fb_store_in_db'])
	{
		$res_id = f_add_object_modul($db_fields, Get_object_id_by_name('form_mails'));
		if ($res_id < 0)
		{
			$errors = -1;//Не могу занести данные в БД
		}
	}
	
	$eol = "\r\n";
		$boundary=md5(uniqid(time()));//Генерируем разделитель
	
	//отправляем на и-мейл
	if($form_config['fb_send_to_email'])
	{
		$to_email = $form_config['fb_dest_email'];
		$from_email = $form_config['fb_from_email'];
		$email_title = cms('fb_mail_title_'.$form_id.'a');
		$email_charset = $form_config['fb_email_charset'];
		
		//формируем текст письма
		$headers = 'From: '.$from_email.$eol;
		$headers .= 'MIME-Version: 1.0'.$eol;
		$msg = '<html>'."\n";
		$msg .= '<head>'."\n";
		$msg .= '<title>'.$email_title.'</title>'."\n";
		$msg .= '</head>'."\n";
		$msg .= '<body>'."\n";
		$msg .= '<table border="0" cellpadding="2" cellspacing="1" style="font: 11px Helvetica, Verdana, Arial, sans-serif;">'."\n";
		for($i = 0; $i < sizeof($user_input); $i++)
		{
			if($user_input[$i]['type'] == 'separator')
			{
				$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">&nbsp;</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">&nbsp;</td></tr>'."\n";
			}
			else
			{
				$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">'.htmlspecialchars($user_input[$i]['name']).':</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">'.(empty($user_input[$i]['value'])?'&nbsp;':htmlspecialchars($user_input[$i]['value'])).'</td></tr>'."\n";
			}
		}
		$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">'.FB_DATE.':</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">'.$date.'</td></tr>'."\n";
		$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">'.FB_USER_IP.':</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">'.$_SERVER['REMOTE_ADDR'].'</td></tr>'."\n";
		$msg .= '</table>'."\n";
		$msg .= '</body>'."\n";
		$msg .= '</html>'."\n";
		$msg = str_replace('&lt;br /&gt;', '<br />', $msg);
		$msg = str_replace('&lt;br&gt;', '<br>', $msg);
		
		if($files_count != 1)//Формируем письмо с атачем
		{
			$headers.='Content-type: multipart/mixed; boundary="'.$boundary.'"'.$eol.$eol;//text plus attachments
			$message='--'.$boundary.$eol;
			$message.='Content-Type: text/html; charset='.$email_charset.$eol;
			$message.='Content-Transfer-Encoding: 7bit'.$eol.$eol;
			$message.=$msg.$eol.$eol;
			$message.=$message2;
			for($i = 0; $i < sizeof($user_input); $i++)
			{
				if($user_input[$i]['type'] == 'file')
				{
					//Читаем прикрипленный файл
					if(file_exists($user_input[$i]['file_path']) && is_file($user_input[$i]['file_path']))
					{
						$attach = file_get_contents($user_input[$i]['file_path']);
						$message .= '--'.$boundary.$eol;
						//$message .= 'Content-Type: '.$user_input[$i]['file_type'].$eol;//было application/octet-stream
						//$message .= 'Content-Transfer-Encoding: base64'.$eol;
						//$message .= 'Content-Desposition: attachment; filename="'.$user_input[$i]['value'].'"'.$eol.$eol;

						$message .= 'Content-Transfer-Encoding: base64'.$eol;
						$message .= 'Content-Type: application/octet-stream; name="'.$user_input[$i]['value'].'"'.$eol;//было 
						$message .= 'Content-Disposition: attachment'.$eol.$eol;

						$message .= chunk_split(base64_encode($attach)).$eol.$eol;
					}
				}
			}
			$message.='--'.$boundary.'--'.$eol.$eol;
		}
		else//Формируем простое письмо
		{
			$headers .= 'Content-Type: text/html; charset='.$email_charset.$eol;
			$headers .= 'X-Mailer: PHP/'.phpversion();
			$message = $msg;
		}
		
		$email_title = "=?".$email_charset."?b?".base64_encode($email_title)."?=";
		if(!mail($to_email, $email_title, $message, $headers))
		{
			//$errors = -5;//Не могу послать и-мейл
		}
	}
	}//////////
	//переадресовываем пользователя
	if($thanks_page != '')
	{
		$location = EE_HTTP.get_default_aliase_for_page($thanks_page);
	}
	if($errors != 0 || $thanks_page == '')
	{
		//delete old errors
		$page_url = preg_replace('/[&]?file_errors=(.*)/', '', $page_url);
		if($errors != 0)
		{
			if(strpos($page_url, '?') === false)
				$page_url .= '?';
			else
				$page_url .= '&';
			$page_url .= 'file_errors='.urlencode(implode(',', $file_errors));
			foreach($fb_stored_values as $key => $value)
			{
				$page_url .= '&'.urlencode('fb_'.$key).'='.urlencode($value);
			}
		}
		$location = $page_url;
	}
	header('Location: '.$location);
	exit;
}

function handle_fb_get_file()
{
	if (!checkAdmin() or !($UserRole==ADMINISTRATOR or $UserRole==POWERUSER or $UserRole==USER or $UserStatus==ADMINISTRATOR))
	{
		echo parse('norights');
		exit;
	}
	$file_name = $_GET['name'];
	$file_path = EE_PATH.FORMBUILDER_FOLDER.$file_name;
	if(file_exists($file_path))
	{
        header("Content-Type: application/octet-stream");
        header("Content-Disposition: attachment; filename=\"".$file_name."\"");
		readfile($file_path);
		exit; 
	}
}

function handle_fb_copy_cms()
{
	if(isset($_GET['ids']) && isset($_GET['previous_lang']) && isset($_GET['next_lang']) && isset($_GET['select_id']))
	{
		$previous_lang = urldecode($_GET['previous_lang']);
		$next_lang = urldecode($_GET['next_lang']);
		$select_id = urldecode($_GET['select_id']);
		$pre_fields = explode(';', urldecode($_GET['ids']));
		foreach($pre_fields as $pre_field)
		{
			$fields = explode(',', $pre_field);
			for($i = 0; $i < sizeof($fields); $i++)
			{
				//copy options selected & empty values
				if(cms('fb_sel_opt_'.$previous_lang.$select_id.'a') == $fields[0])
				{
					save_cms('fb_sel_opt_'.$next_lang.$select_id.'a', $fields[1]);
				}
				if(cms('fb_emp_opt_'.$previous_lang.$select_id.'a') == $fields[0])
				{
					save_cms('fb_emp_opt_'.$next_lang.$select_id.'a', $fields[1]);
				}
				
				//copy options
				save_cms('fb_opt_text'.$fields[1].'a', cms('fb_opt_text'.$fields[0].'a'));
				save_cms('fb_opt_title'.$fields[1].'a', cms('fb_opt_title'.$fields[0].'a'));
				save_cms('fb_opt_value'.$fields[1].'a', cms('fb_opt_value'.$fields[0].'a'));
			}
		}
		echo 'Done';
	}
	exit;
}

//function check if value presents in array and returns its value
function fb_get_value_from_array($field, $arr)
{
	$return = '';
	if(is_array($arr))
	{
		$return = (array_key_exists($field, $arr))?$arr[$field]:'';
	}
	return $return;
}
function fb_get_form_parameter($value, $parameter)
{
	$return = '';
	if($parameter == '') $return = ' '.$value;
	else $return = ($value == '')?'':' '.$parameter.'="'.htmlspecialchars($value, ENT_QUOTES).'"';
	return $return;
}
function add_option_text($option)
{
	global $clear_name;
	$selected = '';
	if(isset($_GET['fb_'.$clear_name]))
	{
		if($_GET['fb_'.$clear_name] == $option)
		{
			$selected = ' selected';
		}
	}
	return '<option value="'.$option.'"'.$selected.'>'.$option.'</option>';
}
//function get template name by it id
function get_template_name($id)
{
	return getField('SELECT file_name FROM tpl_files WHERE id='.sqlValue($id));
}
function check_for_registered_and_can_sent($form_id, $form_config)
{
	$return = null;
	//check if this form only for registered users
	if($form_config['fb_for_registered'])
	{
		//check if form was requested by register user
		if(empty($_SESSION['fb_user_id']))
		{
			if($form_config['fb_for_registered_message_type'] == 1)//html
			{
				$return = cms('fb_for_registered_text_'.$form_id.'a');
			}
			else if($form_config['fb_for_registered_message_type'] == 2)//template
			{
				$return = parse_tpl(get_template_name($form_config['fb_for_registered_template']));
			}
			return $return;
		}
		//check if this form may be submitted by registered users only 1 time
		if($form_config['fb_submit_once'])
		{
			//check if this form submit current user
			if(getField('SELECT 1 FROM ('.create_sql_view_by_name('form_mails').') AS form_mails WHERE form_id='.sqlValue($form_id).' AND user_name='.sqlValue($_SESSION['fb_user_id']).' LIMIT 0,1')>0)
			{
				if($form_config['fb_submit_once_message_type'] == 1)//html
				{
					$return = cms('fb_submit_once_text_'.$form_id.'a');
				}
				else if($form_config['fb_submit_once_message_type'] == 2)//template
				{
					$return = parse_tpl(get_template_name($form_config['fb_submit_once_template']));
				}
				return $return;
			}
		}
	}
	return $return;
}
//main function for parsing forms (creating forms from serialized array)
//$return_type may be also 'array'
function create_formbuilder_form($id, $return_type='text')
{
	global $admin_template, $clear_name, $language;
	$id = intval($id);
	if(empty($id)) return '';
	$return = array();
	$javascript_validation = '';
	$server_side_validation = '';
	//get serialized array by id
	$sql = create_sql_view_by_name('formbuilder', 0, '', 1);
	$sql = 'SELECT * FROM('.$sql.') AS formbuilder WHERE record_id='.sqlValue($id).' LIMIT 0,1';
	$rs = viewSql($sql);
	$res = db_sql_fetch_assoc($rs);
	$form_name = '_'.media_to_file_name($res['form_name']);
	$form_config = unserialize($res['form_config']);
	$content = unserialize($res['content']);
	//print_r($content);exit;
	
	//check if this form only for registered users and register user can sent it multiple times
	$check_for_registered = check_for_registered_and_can_sent($id, $form_config);
	if(!is_null($check_for_registered))
	{
		return $check_for_registered;
	}
	for($i=0; $i<sizeof($content); $i++)
	{
		//error
		$error_text = cms('fb_error'.$content[$i]['id'].'a');
		$error_class = fb_get_value_from_array('error_class', $content[$i]);
		//text
		$label_text = cms('fb_label'.$content[$i]['id'].'a');
		$text_class = fb_get_value_from_array('text_class', $content[$i]); $text_class = fb_get_form_parameter($text_class, 'class');
		//fields
		$type = fb_get_value_from_array('type', $content[$i]);
		$name = fb_get_value_from_array('name', $content[$i]); $clear_name = $name; $name = fb_get_form_parameter($name, 'name');
		$get_default_value = _get('fb_'.$clear_name);
		$field_class = fb_get_value_from_array('field_class', $content[$i]); $field_class = fb_get_form_parameter($field_class, 'class');
		$maxlength = fb_get_value_from_array('maxlength', $content[$i]); $maxlength = fb_get_form_parameter($maxlength, 'maxlength');
		$content[$i]['default_value'] = isset($_GET['fb_'.$clear_name])?urldecode($_GET['fb_'.$clear_name]):((is_array($content[$i]) && array_key_exists('default_value', $content[$i])) ? $content[$i]['default_value'] : null);
		$default_value = '';
		if(
			$content[$i]['type'] != 'text_line' &&
			$content[$i]['type'] != 'paragraph_text' &&
			$content[$i]['type'] != 'html_field' &&
			$content[$i]['type'] != 'select' &&
			$content[$i]['type'] != 'file'
			)
		{
			$default_value = cms('fb_value'.$content[$i]['id'].'a');
			//в значении по умолчанию могут вставляться значения из сессии которые имеют вид {fb_XXX}
			preg_match_all('/{fb_[^}]+}/is', $default_value, $session_replacements);
			$searches = array();
			$replacements = array();
			foreach($session_replacements[0] as $search)
			{
				$searches[] = '/'.$search.'/is';
				if(array_key_exists(trim($search, '{}'), $_SESSION))
				{
					$replacements[] = $_SESSION[trim($search, '{}')];
				}
				else
				{
					$replacements[] = '';
				}
			}
			$default_value = preg_replace($searches, $replacements, $default_value);
			
			//если пользователь уже послал форму но возникли ошибки то вставляем в поля то что он ввел ранее
			if(!is_null($get_default_value) && ($type == 'text' || $type == 'textarea'))
			{
				$default_value = $get_default_value;
			}
			
			$clear_value = $default_value;
			$default_value = fb_get_form_parameter($default_value, 'value');
		}
		$check = fb_get_value_from_array('check', $content[$i]);
		$cols = fb_get_value_from_array('cols', $content[$i]); $cols = fb_get_form_parameter($cols, 'cols');
		$rows = fb_get_value_from_array('rows', $content[$i]); $rows = fb_get_form_parameter($rows, 'rows');
		$multiply = fb_get_value_from_array('multiply', $content[$i]); $multiply = fb_get_form_parameter($multiply, '');
		//если пользователь уже ввел значение, то востанавливаем его
		if(!is_null($get_default_value) && $type == 'checkbox')
		{
			$checked = ($get_default_value != '')?'checked':'';
		}
		else if(!is_null($get_default_value) && $type == 'radio')
		{
			if(strtolower($get_default_value) == 'on')
			{
				$get_default_value = '';
			}
			$checked = (strcasecmp($get_default_value, $clear_value) === 0)?'checked':'';
		}
		else
		{
			$checked = fb_get_value_from_array('checked', $content[$i]);
		}
		$checked = fb_get_form_parameter($checked, '');
		$extensions = fb_get_value_from_array('extensions', $content[$i]);
		$max_size = fb_get_value_from_array('max_size', $content[$i]);
		$options = '';
		if(isset($content[$i]['options_ids_'.$language]))
		{
			$opts = explode(',', $content[$i]['options_ids_'.$language]);
			foreach($opts as $opt)
			{
				//достаем информацию об опшинах из цмс полей
				$opt_value = htmlspecialchars(cms('fb_opt_value'.$opt.'a'), ENT_QUOTES);//'fb_opt_value'.$option_id.'a'
				$opt_text = htmlspecialchars(cms('fb_opt_text'.$opt.'a'), ENT_QUOTES);//'fb_opt_text'.$option_id.'a'
				$opt_title = htmlspecialchars(cms('fb_opt_title'.$opt.'a'), ENT_QUOTES);//'fb_opt_title'.$option_id.'a'
				$opt_selected = '';//'fb_sel_opt_'.$lang.$select_id.'a'
				//устанавливаем значение по умолчанию
				if(is_null($get_default_value) && cms('fb_sel_opt_'.$language.$content[$i]['id'].'a') == $opt)
				{
					$opt_selected = ' selected';
				}
				//устанавливаем значение которое ввел пользователь до возникновения ошибкм
				else if(!is_null($get_default_value) && strcasecmp($opt_value, $get_default_value) === 0)
				{
					$opt_selected = ' selected';
				}
				
				$options .= '<option value="'.$opt_value.'" title="'.$opt_title.'"'.$opt_selected.'>'.$opt_text.'</option>'."\n";
			}
			//find empty option
			$empty_option = '';//for using below
			$empty_opt = cms('fb_emp_opt_'.$language.$content[$i]['id'].'a');
			if($empty_opt != '' && in_array($empty_opt, $opts))
			{
				$empty_option = $empty_opt;
			}
		}
		$required = fb_get_value_from_array('required', $content[$i]);
		//return error fields
		//if(!empty($error_text) || !empty($error_class)) {//if this field would be required and user do not inser name or class of this filed on validation step we will get error because field would be undefined
		if ($content[$i]['wrapper'] != '')
		{
			$return[] = '<'.$content[$i]['wrapper'].' class="'.$content[$i]['wrapper_class'].'">';
		}
		if(
			$content[$i]['type'] != 'text_line' &&
			$content[$i]['type'] != 'paragraph_text' &&
			$content[$i]['type'] != 'html_field' &&
			$content[$i]['type'] != 'separator' &&
			$content[$i]['type'] != 'hidden' &&
			$content[$i]['type'] != 'submit' &&
			$content[$i]['type'] != 'reset'
			) {
			$return[] .= '<div class="fb_error_field '.$error_class.'" id="error'.$content[$i]['id'].'">'.$error_text.'</div>'."\n";//error
		}
		//return fields
		if(!empty($label_text) || !empty($text_class)) {
			$inc = sizeof($return);
			if(
				$content[$i]['type'] == 'radio' ||
				$content[$i]['type'] == 'checkbox'
				)
			{
				$inc = sizeof($return) + 1;
			}
			$return[$inc] = (array_key_exists($inc, $return) ? $return[$inc] : '' ).'<div'.$text_class.'>'.$label_text.'</div>'."\n";//label
		}
		//determine what field should be used
		if($type == 'text')
		{
			$return[] .= '<div'.$field_class.'><input type="text" id="field'.$content[$i]['id'].'"'.$name.$maxlength.$default_value.' /></div>'."\n";//field
		}
		if($type == 'textarea')
		{
			$return[] .= '<div'.$field_class.'><textarea id="field'.$content[$i]['id'].'"'.$name.$cols.$rows.'>'.$clear_value.'</textarea></div>'."\n";//field
		}
		if($type == 'select')
		{
			$return[] .= '<div'.$field_class.'><select id="field'.$content[$i]['id'].'"'.$name.$multiply.'>'.$options.'</select></div>'."\n";//field
		}
		if($type == 'radio')
		{
			$return[(sizeof($return) - 1)] = (array_key_exists((sizeof($return) - 1), $return) ? $return[(sizeof($return) - 1)] : '' ).'<div'.$field_class.'><input type="radio" id="field'.$content[$i]['id'].'"'.$name.$checked.$default_value.' /></div>'."\n";//field
		}
		if($type == 'checkbox')
		{
			$return[(sizeof($return) - 1)] .= '<div'.$field_class.'><input type="checkbox" id="field'.$content[$i]['id'].'"'.$name.$checked.$default_value.' /></div>'."\n";//field
		}
		if($type == 'file')
		{
			$return[] .= '<div'.$field_class.'><input type="file" size="'.$content[$i]['field_size'].'" id="field'.$content[$i]['id'].'"'.$name.' /></div>'."\n";//field
		}
		if($type == 'captcha')
		{
			$return[] .='<div'.$field_class.'>'."\n".
			'	<div class="fb_captcha_image">'."\n".
			'	<script type="text/javascript">'."\n".
			'	<!--'."\n".
			'		document.write("<img src=\"'.EE_HTTP.'action.php?action='.$content[$i]['action_type'].'&"+Math.random()+"\" align=\"absmiddle\"  border=\"0\" alt=\"\" />");'."\n".
			'	//-->'."\n".
			'	</script>'."\n".
			'	</div>'."\n".
			'	<div class="fb_captcha_field">'."\n".
			'		<input type="text" id="field'.$content[$i]['id'].'"'.$name.' />'."\n".
			'	</div>'."\n".
			'</div>'."\n";//field
		}
		if($type == 'hidden')
		{
			$return[] .= '<div'.$field_class.'><input type="hidden" id="field'.$content[$i]['id'].'"'.$name.$default_value.' /></div>'."\n";//field
		}
		if($type == 'reset')
		{
			$return[] .= '<div'.$field_class.'><input type="reset" id="field'.$content[$i]['id'].'"'.$name.$default_value.' /></div>'."\n";//field
		}
		if($type == 'submit')
		{
			$return[] .= '<div'.$field_class.'><input type="submit" id="field'.$content[$i]['id'].'"'.$name.$default_value.' /></div>'."\n";//field
		}
		if($type == 'separator')
		{
			$return[] .= '<!-- separator -->'."\n";//field
		}

		//add rules for javascript validation
		$required = fb_get_value_from_array('required', $content[$i]);
		$required_indicator = fb_get_value_from_array('required_indicator', $content[$i]);
		$check = fb_get_value_from_array('check', $content[$i]);
		$value_type = 'value';

		if(
			$content[$i]['type'] != 'text_line' &&
			$content[$i]['type'] != 'paragraph_text' &&
			$content[$i]['type'] != 'html_field' &&
			$content[$i]['type'] != 'separator' &&
			$content[$i]['type'] != 'hidden' &&
			$content[$i]['type'] != 'submit' &&
			$content[$i]['type'] != 'reset' &&
			$required_indicator &&
			$required == 'yes'
			)
		{
			$return[] .= '<span class="required_field_class">*</span>'."\n";//error
		}
		if ($content[$i]['wrapper'] != '')
		{
			$return[] = '</'.$content[$i]['wrapper'].'>';
		}
		if($required == 'yes' && ($check == 'not_empty' || $content[$i]['type'] == 'captcha') && !empty($clear_name))
		{
			if($content[$i]['type'] == 'radio'){
				$javascript_validation .= "if(checkIsNotChecked".$form_name."('".$clear_name."')){"."\n";
			}
			else if($content[$i]['type'] == 'checkbox'){
				$javascript_validation .= "if(document.".$form_name.".".$clear_name.".checked == false){"."\n";
			}else if($content[$i]['type'] == 'select'){
				if($empty_option != '')//check if isset empty value
				{
					$javascript_validation .= 'if(document.'.$form_name.'.'.$clear_name.'.options[document.'.$form_name.'.'.$clear_name.'.selectedIndex].value == "'.cms('fb_opt_value'.$empty_option.'a').'"){'."\n";
				}
			}else{
				$javascript_validation .= "if(document.".$form_name.".".$clear_name.".value == ''){"."\n";
			}
			if($content[$i]['type'] != 'select' || ($content[$i]['type'] == 'select' && $empty_option != ''))
			{
				$javascript_validation .= "\t"."document.getElementById('error".$content[$i]['id']."').style.display='block';"."\n".
					"\t"."ret = false;"."\n".
				"} else {"."\n".
					"\t"."document.getElementById('error".$content[$i]['id']."').style.display='none';"."\n".
				"}"."\n";
			}
		}
		if($required == 'yes' && $check == 'email_pattern' && !empty($clear_name))
		{
			$javascript_validation .= "if(!/^[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]{2,6}$/i.test(document.".$form_name.".".$clear_name.".value)){"."\n".
				"\t"."document.getElementById('error".$content[$i]['id']."').style.display='block';"."\n".
				"\t"."ret = false;"."\n".
			"} else {"."\n".
				"\t"."document.getElementById('error".$content[$i]['id']."').style.display='none';"."\n".
			"}"."\n";
		}
		$javascript_validation .= '';
	}
	$javascript_validation = "<script type='text/javascript'>"."\n<!--\n".
	"function validateFbForm".$form_name."(){"."\n".
		"var ret = true;"."\n".
		$javascript_validation.
		"\t"."return ret;"."\n".
	"}"."\n".
	"function checkIsNotChecked".$form_name."(fieldName){"."\n".
		"\t"."eval('var fieldName = document.".$form_name.".'+fieldName);"."\n".
		"\t"."var ret = true;"."\n".
		"\t"."for(var i = 0; i < fieldName.length; i++ ){"."\n".
			"\t"."\t"."if(fieldName[i].checked == true)"."\n".
			"\t"."\t"."ret = false;"."\n".
		"\t"."}"."\n".
		"\t"."return ret;"."\n".
	"}"."\n".
	"\n//-->\n</script>"."\n";
	;
	
	if(_get('file_errors') != '')
	{
		$file_errors = explode(',',_get('file_errors'));
		foreach($file_errors as $error_id)
		{
			$server_side_validation .= "\t"."document.getElementById('error".$error_id."').style.display='block';"."\n";
		}
		$server_side_validation = "<script type='text/javascript'>"."\n<!--\n".
			$server_side_validation.
		"\n//-->\n</script>"."\n";
	}
	$action = isset($form_config['fb_form_action']) && $form_config['fb_form_action'] != '' ? $form_config['fb_form_action'] : 'fb_form_submit';
//var_dump($action);
//var_dump($return);
	ksort($return);//сортируем массив чтобы radio и checkbox подписи были после елементов
	if($return_type == 'array')
	{
		return array($return, $content, array('form_name'=>$form_name, 'id'=>$id));
	}
	else
	{
		//add form tag
		$return = $javascript_validation.'<form method="post" enctype="multipart/form-data" action="'.EE_HTTP.'action.php?action='.$action.'" onsubmit="return validateFbForm'.$form_name.'();" name="'.$form_name.'">'."\n".implode('', $return)."\n".'<input type="hidden" name="fb_form_id" value="'.$id.'" />'."\n".'<input type="hidden" name="page_url" value="'.EE_HTTP_SERVER.EE_REQUEST_URI.'" />'."\n".'<input type="hidden" name="admin_template" value="'.$admin_template.'" />'."\n".'</form>'.$server_side_validation."\n";
		return $return;
	}
	
}

//function returns cms control
function fb_print_edit_cms($var, $t, $alt='', $type='')
{
	global $UserRole,$admin_template;
	if ($alt=='') $alt = $var;
	$s='';
	if (checkAdmin() and $admin_template=='yes' and ($UserRole==ADMINISTRATOR or $UserRole==POWERUSER) and !check_content_access(CA_READ_ONLY))
	{
		$img_alt_text = '"'.ADMIN_EDIT_PAGE_CONTENT.''.($alt==''?'':' of '.$alt).'"';
		$s = '<a class="fb_cms" href="javascript:void(0);" onclick="fbOpenEditor(\\\''.$var.'\\\',\\\''.$t.'\\\',\\\''.$type.'\\\');return false;" title="Edit Page Content'.($alt==''?'':' of '.$alt).'"><img src="'.EE_HTTP.'img/cms_edit_bt'.($type==''?'':'_'.$type).'.gif" width="43" height="16" alt='.$img_alt_text.' title='.$img_alt_text.' border="0" /></a><span id="'.$var.'">'.str_replace("'", "\'", cms($var)).'</span>';
	}
	return $s;
}

//function to pass store php value to javascript
function fb_restore_values($only_form_config=0) {
	$sql = 'SELECT * FROM('.create_sql_view_by_name('formbuilder').') AS formbuilder WHERE record_id='.sqlValue($_GET['edit']).' LIMIT 0,1';
	$rs = viewSQL($sql);
	$res = db_sql_fetch_assoc($rs);
	global $fb_form_name;
	$fb_form_name = $res['form_name'];

	$form_config = unserialize($res['form_config']);
	if(is_array($form_config))//deviant
	{
		foreach($form_config as $key => $value)
		{
			global $$key;
			$$key = $value;
		}
	}
	
	//if we want just print firm configuration in form preview
	if($only_form_config) return;
	
	$content = unserialize($res['content']);
	//print_r($content);
	global $restore_fields;
	$restore_fields = 'var p_oEvent = null;'."\n";
	$restore_variables = '';
	//get all and default languages for select lists
	$sql = 'SELECT DISTINCT language_code AS lang FROM v_language ORDER BY default_language DESC';
	$rs = viewSQL($sql);
	if(db_sql_num_rows($rs) > 0)
	{
		$def_lang = '';
		$langs = array();
		while($res = db_sql_fetch_assoc($rs))
		{
			if($def_lang == '')	$def_lang = $res['lang'];
			$langs[] = $res['lang'];
		}
		$restore_variables = 'var allAvailableLangs = "'.implode(',',$langs).'";'."\n".'var defaultLang = "'.$def_lang.'";'."\n";
		//var allAvailableLangs = "EN,DE,FR,ND";//example
		//var defaultLang = "EN";//example
	}

	$fields_with_texts = array();
	for($i=0; $i<sizeof($content); $i++)
	{
		if(!is_array($content[$i]) || !array_key_exists("type", $content[$i])) continue;//deviant
		$restore_fields .= 'onButtonClick(p_oEvent, \''.fb_delete_new_lines($content[$i]['type'],1).'\', \''.fb_delete_new_lines($content[$i]['id'],1).'\');'."\n";
		foreach($content[$i] as $key => $value)
		{
		//global ${$key.$content[$i]['id']};
		//${$key.$content[$i]['id']} = $value;
			//$value = str_replace("\r\n", "\t", $value);
			//$value = str_replace("\n", "\t", $value);
			$restore_variables .= "var ".fb_delete_new_lines($key.$content[$i]['id'],1,1)."='".fb_delete_new_lines($value,1)."';"."\n";
		}
		//restore text values
		$fields_with_texts[] = fb_delete_new_lines($content[$i]['id'],1);
		if(
			$content[$i]['type'] != 'hidden' &&
			$content[$i]['type'] != 'submit')
		{
			$restore_variables .= "var label_text".fb_delete_new_lines($content[$i]['id'],1,1)."='".fb_delete_new_lines(cms('fb_label'.$content[$i]['id'].'a'),1)."';"."\n";//text label
		}
		if(
			$content[$i]['type'] != 'text_line' &&
			$content[$i]['type'] != 'paragraph_text' &&
			$content[$i]['type'] != 'html_field' &&
			$content[$i]['type'] != 'hidden' &&
			$content[$i]['type'] != 'submit')
		{
			$restore_variables .= "var error_text".fb_delete_new_lines($content[$i]['id'],1,1)."='".fb_delete_new_lines(cms('fb_error'.$content[$i]['id'].'a'),1)."';"."\n";//text error
		}
		if(
			$content[$i]['type'] != 'text_line' &&
			$content[$i]['type'] != 'paragraph_text' &&
			$content[$i]['type'] != 'html_field' &&
			$content[$i]['type'] != 'select' &&
			$content[$i]['type'] != 'file')
		{
			$restore_variables .= "var default_value".fb_delete_new_lines($content[$i]['id'],1,1)."='".fb_delete_new_lines(cms('fb_value'.$content[$i]['id'].'a'),1)."';"."\n";//default value text
		}
		if($content[$i]['type'] == 'select')
		{
			$used_langs = explode(',',$content[$i]['options_langs']);
			foreach($used_langs as $lang)
			{
				$cms_values = explode(',',$content[$i]['options_ids_'.$lang]);
				foreach($cms_values AS $cms_value)
				{
				//значения цмс полей для опшинов
					$restore_variables .= "var option_text".$cms_value."='".fb_delete_new_lines(cms('fb_opt_text'.$cms_value.'a'),1)."';"."\n";
					$restore_variables .= "var option_value".$cms_value."='".fb_delete_new_lines(cms('fb_opt_value'.$cms_value.'a'),1)."';"."\n";
				}
				//default and empty values of selected lists
				$restore_variables .= "var selected_option_".$lang.$content[$i]['id']."='".fb_delete_new_lines(cms('fb_sel_opt_'.$lang.$content[$i]['id'].'a'),1)."';"."\n";
				$restore_variables .= "var empty_option_".$lang.$content[$i]['id']."='".fb_delete_new_lines(cms('fb_emp_opt_'.$lang.$content[$i]['id'].'a'),1)."';"."\n";
			}
		}
	}
	$fields_with_texts = array_map('sqlvalue', $fields_with_texts);
	$fields_with_texts = "var fieldsWithText = new Array(".implode(', ', $fields_with_texts).");";
	//do not use line breaks in java code
	return $restore_variables."\n".$fields_with_texts;;
}

//function make text safely for using in javascript variables
function fb_delete_new_lines($text, $delete_single_quotes = 0, $delete_double_quotes = 0)
{
	$text = str_replace("\r\n", "\t", $text);
	$text = str_replace("\n", "\t", $text);
	if($delete_single_quotes)
	{
		$text = str_replace("'", "", $text);
	}
	if($delete_double_quotes)
	{
		$text = str_replace('"', "", $text);
	}
	return $text;
}

//function return value of cms field
function handle_fb_get_cms()
{
	$return = '';
	if(checkAdmin())
	{
		$return = cms(trim($_GET['field']));
	}
	echo $return;
	exit;
}

//function return link to satellite page
function print_formbuilder_thankyou_url($thanks_page)
{
	global $language;
	$return = '';
	if($thanks_page != '')
	{
		$url = get_default_alias_for_page($thanks_page);
		$name = getField('SELECT val FROM content WHERE var="page_name_" AND var_id='.sqlValue($thanks_page).' AND language='.sqlvalue($language).' LIMIT 0,1');
		if($name == '')
		{
			$name = getField('SELECT page_name FROM tpl_pages WHERE id='.sqlvalue($thanks_page).' LIMIT 0,1');
		}
		$return = '<a href="'.EE_HTTP.$url.'" target="_blank">'.$name.'</a>';
	}
	return $return;
}


//function show enable or disable button for export formbuilder form in list
function show_formbuilder_export_button($id)
{
	global $modul;
	$tpl = $modul.'/export_button_p';
	if(getField('SELECT COUNT(*) FROM('.create_sql_view_by_name_for_fields_filter_by_fields('form_id', array('form_id'=>$id), 'form_mails', 0, $GLOBALS['default_language']).') AS forms') > 0)
	{
		$tpl = $modul.'/export_button_a';
	}
	return parse_tpl($tpl);
}

//function handle export to csv selected form of formbuilder
function formbuilder_form_export()
{
	$result = '';
	//get all content of submitted form
	$sql = 'SELECT * FROM('.create_sql_view_by_name_for_fields_filter_by_fields('record_id,date,ip,user_name,language,serialized,form_id', array('form_id'=>$_GET['edit']), 'form_mails', 0, $GLOBALS['default_language']).') AS forms';
	$rs = viewsql($sql);
	$result_fields = array();
	//$title_fields = array('record_id', 'date', 'ip', 'user_name', 'language');
	if(db_sql_num_rows($rs) > 0)//мало ли...
	{
		$i = 0;
		while($res = db_sql_fetch_assoc($rs))
		{
			$result_fields['record_id'][$i] = $res['record_id'];
			$result_fields['date'][$i] = $res['date'];
			$result_fields['ip'][$i] = $res['ip'];
			$result_fields['user_id'][$i] = $res['user_name'];
			$sql = 'SELECT `name`, `login`, `email` FROM `users` WHERE `id`='.sqlValue($res['user_name']).' LIMIT 0,1';
			$rs2 = viewsql($sql);
			$result_fields['user_name'][$i] = $result_fields['user_login'][$i] = $result_fields['user_email'][$i] = '';
			if(db_sql_num_rows($rs2) > 0)
			{
				$res2 = db_sql_fetch_assoc($rs2);
				//on raymond-weil.com site spaces in user names replaces with &nbsp; entitles
				$res2['name'] = str_replace('&nbsp;', ' ', $res2['name']);
				$result_fields['user_name'][$i] = $res2['name'];
				$result_fields['user_login'][$i] = $res2['login'];
				$result_fields['user_email'][$i] = $res2['email'];
			}
			
			$result_fields['language'][$i] = $res['language'];
			
			$content = unserialize($res['serialized']);
			if(is_array($content))
			{
				foreach($content as $fields)
				{
					$result_fields[$fields['name']][$i] = $fields['value'];
				}
			}
			//additional use information
			$additional_arr = get_user_additional_information($res['record_id'], $res['user_name']);//$res['user_name'] store user id
			if(sizeof($additional_arr)>0)
			{
				foreach($additional_arr as $key => $value)
				{
					$result_fields[$key][$i] = $value;
				}
			}
			$i++;
		}
		//title
		foreach($result_fields as $key => $value)
		{
			$result .= convert_to_csv($key);
		}
		$result .= "\n";
		//fields
		$sub_results = array();//переформатируем полученные результаты для вывода их в excel
		foreach($result_fields as $key => $value)
		{
			if(is_array($value))
			{
				for($i=0; $i<db_sql_num_rows($rs); $i++)
				{
					$sub_results[$i][] = (array_key_exists($i, $value))?$value[$i]:'';
				}
			}
		}
		//return fields
		foreach($sub_results as $value)
		{
			$value = array_map('convert_to_csv', $value);
			$result .= implode('', $value)."\n";
		}
	}
	return $result;
}

//function add quotes to passed text
function convert_to_csv($text)
{
	return '"'.$text.'"' . EE_DEFAULT_CSV_SEPARATOR;
}

//function copy formbuilder form
function handle_copy_formbuilder_form()
{
	global $object_id, $modul, $language;
	if(isset($_GET['form_id']))
	{
		$form_id = $_GET['form_id'];
		//проверяем есть ли такая форма в БД
		$sql = 'SELECT * FROM('.create_sql_view_by_name(trim($modul, '_')).') AS formbuilder WHERE record_id='.sqlValue($form_id).' LIMIT 0,1';
		$rs = viewSQL($sql);
		if(db_sql_num_rows($rs)>0)
		{
			//достаем из соответствующего объекта всю информацию
			$res = db_sql_fetch_assoc($rs);
			$form_name = $res['form_name'];
			$content = unserialize($res['content']);
			$form_config = unserialize($res['form_config']);
			
			//генерируем новое имя
			$new_form_name = '';
			$i = 1;
			do
			{
				if($i < 2)
				{
					$prefix = 'copy_';
				}
				else
				{
					$prefix = 'copy_'.$i.'_';
				}
				$i++;
				if($i>333) break;
				$new_form_name = $prefix.$form_name;
			}while(getField('SELECT COUNT(record_id) FROM('.create_sql_view_by_name(trim($modul, '_')).') AS formbuilder WHERE form_name='.sqlValue($new_form_name).' LIMIT 0,1') > 0);
				
			//генерируем новый конфиг
			$new_form_config = $form_config;
				
			//генерируем новый контент
			$new_content = array();
			$new_id = floor(microtime(true)*1000);
			//////////print_r($content);
			foreach($content as $item_num => $item_array)
			{
				$old_id = ltrim($item_array['id']);
				$field_type = $item_array['type'];
				foreach($item_array as $key => $value)
				{
					//обзываем новым id
					if($key == 'id')
					{
						$new_content[$item_num]['id'] = '_'.$new_id;
						$old_id = ltrim($value, '_');
					}
					//все остальное в тупую копируем, кроме опшинов select списка
					else if(strpos($key, 'options_ids_') === false)
					{
						$new_content[$item_num][$key] = $value;
					}
				}
				
				/////копируем cms поля
				//копируем label
				if($field_type != 'hidden' && $field_type != 'submit')
				{
					save_cms('fb_label_'.$new_id.'a', cms('fb_label_'.$old_id.'a'));
				}
				//копируем error
				if($field_type != 'text_line' && $field_type != 'paragraph_text' && $field_type != 'html_field' && $field_type != 'hidden' && $field_type != 'submit')
				{
					save_cms('fb_error_'.$new_id.'a', cms('fb_error_'.$old_id.'a'));
				}
				//копируем value
				if($field_type != 'text_line' && $field_type != 'paragraph_text' && $field_type != 'html_field' && $field_type != 'select' && $field_type != 'file')
				{
					save_cms('fb_value_'.$new_id.'a', cms('fb_value_'.$old_id.'a'));
				}
				
				//копируем опшини select списков
				if($field_type == 'select'){
					//находим языки на которых добавлены опшины
					//example [options_langs] => EN,DE
					$options_langs = explode(',', $item_array['options_langs']);
					//копируем опшины на указанных языках
					foreach($options_langs as $options_lang)
					{
						$options_lang = trim($options_lang);
						$new_content[$item_num]['options_ids_'.$options_lang] = copy_formbuilder_options($item_array['options_ids_'.$options_lang], $options_lang, $old_id, $new_id);
					}
				}
				
				$new_id++;
			}
			//print_r($new_content);exit;
			
			//пихаем обратно в БД
			$db_fields['record_id'] = '';
			$db_fields['form_name'] = htmlspecialchars($new_form_name, ENT_QUOTES);
			$db_fields['form_config'] = serialize($new_form_config);
			$db_fields['content'] = serialize($new_content);
			$db_fields['language'] = $language;
			$res = f_add_object_modul($db_fields, Get_object_id_by_name('formbuilder'));
			
			//копируем заголовок письма
			if($res > 0)
			{
				save_cms('fb_mail_title_'.$res.'a', cms('fb_mail_title_'.$form_id.'a'));
			}
		}
	}
}

function handle_export_2_xml()
{
	global $default_language;
	$return = '';
	if(isset($_GET['form_id']))
	{
		$form_id = (int)$_GET['form_id'];
		$res = viewSql('SELECT * FROM ('.create_sql_view_by_name('formbuilder').') AS formbuilder WHERE record_id="'.$form_id.'" LIMIT 0,1');
		if(db_sql_num_rows($res)>0)
		{
			$row = db_sql_fetch_assoc($res);
			$return .= '<?xml version="1.0" encoding="'.getCharset().'"?>'."\n";
			$return .= '<form>'."\n";
			
			//export form properties
			$return .= '<form_name><![CDATA['.$row['form_name'].']]></form_name>'."\n";
			$return .= '<content><![CDATA['.$row['content'].']]></content>'."\n";
			$return .= '<form_config><![CDATA['.$row['form_config'].']]></form_config>'."\n";
			$return .= '<language><![CDATA['.$row['language'].']]></language>'."\n";
			
			//export cms fields based on form id
			$cms_id_fields = array();
			$cms_id_fields['fb_mail_title'] = 'fb_mail_title_'.$form_id.'a';
			$cms_id_fields['fb_for_registered_text'] = 'fb_for_registered_text_'.$form_id.'a';
			$cms_id_fields['fb_submit_once_text'] = 'fb_submit_once_text_'.$form_id.'a';
			
			//export cms fields
			$cms_fields = array();
			
			$langs = array();
			$langs_res = viewSql('SELECT * FROM v_language ORDER BY default_language DESC');
			if(db_sql_num_rows($langs_res)>0)
			{
				while($lang = db_sql_fetch_assoc($langs_res))
				{
					$langs[] = $lang['language_code'];
				}
			}
			
			$content = unserialize($row['content']);
			for($i=0; $i<sizeof($content); $i++)
			{
				if($content[$i]['type'] == 'select')
				{
					foreach(explode(',', $content[$i]['options_langs']) as $lang) {
						$cms_fields[] = 'fb_emp_opt_'.$lang.$content[$i]['id'].'a';
						$cms_fields[] = 'fb_sel_opt_'.$lang.$content[$i]['id'].'a';
						$options = explode(',', $content[$i]['options_ids_'.$lang]);
						foreach($options as $option)
						{
							$cms_fields[] = 'fb_opt_value'.$option.'a';
							$cms_fields[] = 'fb_opt_text'.$option.'a';
							$cms_fields[] = 'fb_opt_title'.$option.'a';
						}
					}
				}
				
				if($content[$i]['type'] != 'separator' &&
				$content[$i]['type'] != 'hidden' &&
				$content[$i]['type'] != 'submit' &&
				$content[$i]['type'] != 'reset')
				{
					$cms_fields[] = 'fb_label'.$content[$i]['id'].'a';
				}
				
				if($content[$i]['type'] != 'text_line' &&
				$content[$i]['type'] != 'paragraph_text' &&
				$content[$i]['type'] != 'html_field' &&
				$content[$i]['type'] != 'separator' &&
				$content[$i]['type'] != 'hidden' &&
				$content[$i]['type'] != 'reset' &&
				$content[$i]['type'] != 'submit')
				{
					$cms_fields[] = 'fb_error'.$content[$i]['id'].'a';
				}
				
				if($content[$i]['type'] != 'text_line' &&
				$content[$i]['type'] != 'paragraph_text' &&
				$content[$i]['type'] != 'html_field' &&
				$content[$i]['type'] != 'separator')
				{
					$cms_fields[] = 'fb_value'.$content[$i]['id'].'a';
				}
			}
			foreach($langs as $lang)
			{
				foreach($cms_id_fields as $name=>$value)
				{
					$res = cms($value, 0, $lang);
					if($res != '')
					{
						$return .= '<cms_id var="'.$name.'" language="'.$lang.'"><![CDATA['.$res.']]></cms_id>'."\n";
					}
				}
				
				foreach($cms_fields as $cms)
				{
					$res = cms($cms, 0, $lang);
					if($res != '')
					{
						$return .= '<cms var="'.$cms.'" language="'.$lang.'"><![CDATA['.$res.']]></cms>'."\n";
					}
				}
			}
			$return .= '</form>'."\n";
			//ask user to save form
			header('Content-Type: text/xml; charset='.getCharset());
			header('Content-Length: '.strlen($return));
			header('Content-Disposition: attachment; filename="'.media_to_file_name($row['form_name']).'.xml"'); 
			echo $return;
			exit;
		}
		else
		{
			printf(FORMBUILDER_CANT_EXPORT_FORM, $form_id);
			exit;
		}
	}
	else
	{
		echo FORMBUILDER_CANT_FIND_FORM;
		exit;
	}
}

function handle_xml_import()
{
	global $modul, $formbuilder_import_error, $formbuilder_import_result;
	
	if(!empty($_POST['new_form_name']) && !empty($_FILES['xml_file']['tmp_name']))//user send us file
	{
		$file_name = $_FILES['xml_file']['tmp_name'];
		$new_form_name = $_POST['new_form_name'];
		
		if($_FILES['xml_file']['type'] != 'text/xml') {//check file type
			$formbuilder_import_error = FORMBUILDER_INVALID_FILE_TYPE;
		}
		else if($_FILES['xml_file']['size'] > (intval(ini_get('upload_max_filesize')) * 1024 * 1024))//check file type
		{
			$formbuilder_import_error = FORMBUILDER_REACHED_MAX_FILE_SIZE;
		}
		else//OK
		{
			$dom = new DOMDocument();
			$dom->load($file_name);
			
			$db_fields = array();
			$db_fields['record_id'] = '';
			//значение имени формы мы будем брать не из xml файла, а из формы
			//$form_names = $dom->getElementsByTagname('form_name');
			//foreach($form_names as $item)
			//{
			//	$db_fields['form_name'] = $item->nodeValue;
			//	break;
			//}
			$db_fields['form_name'] = $new_form_name;
			
			$contents = $dom->getElementsByTagname('content');
			foreach($contents as $item)
			{
				$db_fields['content'] = $item->nodeValue;
				break;
			}
			
			$form_configs = $dom->getElementsByTagname('form_config');
			foreach($form_configs as $item)
			{
				$db_fields['form_config'] = $item->nodeValue;
				break;
			}
			
			$languages = $dom->getElementsByTagname('language');
			foreach($languages as $item)
			{
				$db_fields['language'] = $item->nodeValue;
				break;
			}
			//check if new name of form is in use
			$sql = create_sql_view_by_name_for_fields_filter_by_fields('form_name', array('form_name'=>$new_form_name), 'formbuilder', 0, $GLOBALS['default_language']);
			$sql = 'SELECT COUNT(*) FROM('.$sql.') AS formbuilder';
			if(getField($sql) > 0)
			{
				$form_id = f_upd_object_modul($db_fields, get_object_id_by_name('formbuilder'));
			}
			else
			{
				$form_id = f_add_object_modul($db_fields, get_object_id_by_name('formbuilder'));
			}
			
			if($form_id > 0)
			{
				$cms_id = $dom->getElementsByTagname('cms_id');
				foreach($cms_id as $item)
				{
					check_and_save_cms($item->getAttribute('var').'_'.$form_id.'a', $item->nodeValue, 0, $item->getAttribute('language'));
				}
				
				$cms = $dom->getElementsByTagname('cms');
				foreach($cms as $item)
				{
					check_and_save_cms($item->getAttribute('var'), $item->nodeValue, 0, $item->getAttribute('language'));
				}
			}
			$formbuilder_import_result = FORMBUILDER_DONE;
		}
		
		//delete uploaded file
		unlink($file_name);
	}
	// show form for uploading file to server
	echo parse_tpl($modul.'/import_form');
	exit;
}

//function check if such cms filed exist on default language and if not save new cms value
function check_and_save_cms($var, $val, $page_id = 0, $lang = null)
{
	global $default_language;
//	if($default_language !=$lang)
//	{
		if($val != cms($var, $val, $page_id, $lang))
		{
			return save_cms($var, $val, $page_id, $lang);
		}
//	}
}

//function used for ajax request and check if new form name already used in formbuilder
function handle_check_form_name()
{
	$new_form_name = urlDecode($_GET['new_form_name']);
	$sql = create_sql_view_by_name_for_fields_filter_by_fields('form_name', array('form_name'=>$new_form_name), 'formbuilder', 0, $GLOBALS['default_language']);
	$sql = 'SELECT COUNT(*) FROM('.$sql.') AS formbuilder';
	echo getField($sql);
	exit;
}

//function copy options for one language from formbuilder select list
function copy_formbuilder_options($option_ids, $option_lang, $select_id, &$new_id)
{
	$select_id = '_'.$select_id;
	$new_select_id = '_'.$new_id;
	$new_option_ids = array();
	$option_ids = explode(',', $option_ids);
	//$option_ids example [options_ids_EN] => _1229614366293,_1229614657633
	foreach($option_ids as $option_id)
	{
		$new_id++;
		$option_id = trim($option_id);
		
		//copy options selected & empty values
		if(cms('fb_sel_opt_'.$option_lang.$select_id.'a') == $option_id)
		{
			save_cms('fb_sel_opt_'.$option_lang.$new_select_id.'a', '_'.$new_id);
		}
		if(cms('fb_emp_opt_'.$option_lang.$select_id.'a') == $option_id)
		{
			save_cms('fb_emp_opt_'.$option_lang.$new_select_id.'a', '_'.$new_id);
		}
		
		//copy options
		save_cms('fb_opt_text_'.$new_id.'a', cms('fb_opt_text'.$option_id.'a'));
		save_cms('fb_opt_title_'.$new_id.'a', cms('fb_opt_title'.$option_id.'a'));
		save_cms('fb_opt_value_'.$new_id.'a', cms('fb_opt_value'.$option_id.'a'));
		$new_option_ids[] = '_'.$new_id;
	}
	return implode(',', $new_option_ids);
}

//function store in session user information
//функция хранит в сессии информацию о юзере чтобы подставлять ее в поля формы чтобы зарегистрированнный пользователь мог ее не вводить
function add_user_info_to_session($user_id)
{
	//обязательные поля
	$fileds_info = get_user_info_fields_list();//get main fields
	$sql = 'SELECT '.implode(', ', array_keys($fileds_info)).' FROM `users` WHERE `id`='.sqlValue($user_id).' LIMIT 0,1';
	$rs = viewsql($sql);
	if(db_sql_num_rows($rs) > 0)
	{
		$res = db_sql_fetch_assoc($rs);
		foreach($fileds_info as $key=>$value)
		{
			$_SESSION[$value] = $res[$key];
		}
	}
	add_additional_user_info_to_session($user_id);
}

//function returns array of fields which we need to get from db
function get_user_info_fields_list()
{
	return array(
		'id'=>'fb_user_id',
		'name'=>'fb_user_name',
		'login'=>'fb_user_login',
		'email'=>'fb_user_email',
		'city'=>'fb_user_city'
	);
}

//function get session user or post information
function get_fb_default_value($field_name, $fb_value, $post_method = 'POST')
{
	$return = '';
	//trim values
	$field_name = trim($field_name);
	$fb_value = trim($fb_value);
	$post_method = strtoupper(trim($post_method));
	//set from session
	if(array_key_exists($fb_value, $_SESSION))
	{
		$return = $_SESSION[$fb_value];
	}
	//overwrite from post or get
	if($post_method == 'GET' && isset($_GET[$field_name]))
	{
		$return = urldecode($_GET[$field_name]);
	}
	else if($post_method == 'POST' && isset($_POST[$field_name]))
	{
		$return = $_POST[$field_name];
	}
	return $return;
}
?>
