<?php
if(!function_exists('get_user_additional_information'))
{//custom function may be used in core
	function get_user_additional_information($mail_id=null, $user_id=null)
	{
		return array();
	}
}

if(!function_exists('add_additional_user_info_to_session'))
{//custom function may be used in core
	function add_additional_user_info_to_session($user_id=null)
	{
	}
}

if(!function_exists('get_additional_user_info_fields_list'))
{//custom function may be used in core
	function get_additional_user_info_fields_list()
	{
		return array();
	}
}

// Function set new value to global variable
function setGlobalValueOf($type, $name, $value)
{
	eval('$_'.strtoupper($type).'[\''.$name.'\'] = '.$value.';');
}
//Function returns form attributes
function get_form_attr($id = 0, $html = 1)
{
	if(!empty($_GET['edit']))
	{
		$id = intval($_GET['edit']);
	}
	$res = mysql_fetch_array(mysql_query('SELECT serialized, user_name FROM ('.create_sql_view_by_name('form_mails').') AS v WHERE record_id='.$id));
	$arr = unserialize($res[0]);
	$user_id = $res[1];
	
	$msg = '';
	if(is_array($arr))
	{
		$msg .= '<table border="0" cellpadding="2" cellspacing="1">';
		for($i = 0; $i < sizeof($arr); $i++)
		{
			if(strtolower($arr[$i]['type']) == 'file')
			{
				$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">'.htmlspecialchars($arr[$i]['name']).':</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">'.(empty($arr[$i]['value'])?'&nbsp;':'<a href="'.EE_HTTP.'action.php?action=fb_get_file&name='.$arr[$i]['file_name'].'&t=0">'.htmlspecialchars($arr[$i]['value']).'</a>').'</td></tr>'."\n";
			}
			else if(strtolower($arr[$i]['type']) == 'separator')
			{
				$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">&nbsp;</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">&nbsp;</td></tr>'."\n";
			}
			else
			{
				$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">'.htmlspecialchars($arr[$i]['name']).':</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">'.(empty($arr[$i]['value'])?'&nbsp;':htmlspecialchars($arr[$i]['value'])).'</td></tr>'."\n";
			}
		}
		//additional use information
		$additional_arr = get_user_additional_information($id, $user_id);
		if(sizeof($additional_arr)>0)
		{
			$additional_arr = array_merge(array("USER INFORMATION" => ""), $additional_arr);
			foreach($additional_arr as $key => $value)
			{
				$msg .= '<tr><td width="151" valign="top" style="border-bottom: 1px dotted black;">'.htmlspecialchars($key).':</td><td valign="top" width="201" style="border-bottom: 1px dotted black;">'.(empty($value)?'&nbsp;':htmlspecialchars($value)).'</td></tr>'."\n";
			}
		}
		//if($html)
		//{
		//	$msg = nl2br($msg);
		//}
		$msg .= '</table>';
		return $msg;
	}
	else return '';
}
//Function return text_edit_(page_)cms for form builder
function form_builder_print_text_cms_edit($var)
{
	global $form_builder_page_dependent, $form_builder_suffix;
	if($form_builder_page_dependent == 1 || !isset($form_builder_page_dependent))
	{
		return text_edit_page_cms($var);
	}
	return text_edit_cms($var.$form_builder_suffix);
}
//Function return cms content and editor
function form_builder_print_text_cms_e($var)
{
	return form_builder_print_cms($var).' '.form_builder_print_text_cms_edit($var);
}
//Function return (page_)cms for form builder
function form_builder_print_cms($var)
{
	global $form_builder_page_dependent, $form_builder_suffix;
	if($form_builder_page_dependent == 1 || !isset($form_builder_page_dependent))
	{
		return page_cms($var);
	}
	return cms($var.$form_builder_suffix);
}
//Function return (page_)cms_e for form builder
function form_builder_print_cms_edit($var)
{
	global $form_builder_page_dependent, $form_builder_suffix;
	if($form_builder_page_dependent == 1 || !isset($form_builder_page_dependent))
	{
		return edit_page_cms($var);
	}
	return edit_cms2($var.$form_builder_suffix);
}
//Function return cms content and editor
function form_builder_print_cms_e($var)
{
	return form_builder_print_cms($var).' '.form_builder_print_cms_edit($var);
}
//Function return cms value as checkbox
function print_checkbox($checkbox_name, $cms_name, $page_dependent=1)
{
	if($page_dependent)
	{
		return '<input type="checkbox" name="'.$checkbox_name.'" value="'.page_cms($cms_name).'">';
	}
	else
	{
		return '<input type="checkbox" name="'.$checkbox_name.'" value="'.cms($cms_name).'">';
	}
	
}
/* Function returns form builder
* @param string $form_name - name of form
* @param boolean $page_dependent - flag, which indicates if form must be dependent of page or not (by default = 1)
* @param boolean $display_email - flag, which indicates if we must dispalay e-mail field, which would be verificated by pattern (by default = 0)
* @param boolean $store_in_db - flag, which indicates if we must store submitted information into db (by default = 0)
* @param boolean $send_email - flag, which indicates if we must sent submitted information into specified e-mail address (by default = 0)
* @param string $to_email - e-mail address into which would be sent e-mail massage (by default = '')
* @param string $from_email - e-mail address from which would be sent e-mail massage (by default = '')
* @param string $mail_subject - e-mail subject (by default = '')
*/
function get_form_builder(
	$form_name,
	$page_dependent = 1,
	$display_email = 0,
	$store_in_db = 0,
	$send_email = 0,
	$to_email = '',
	$from_email = '',
	$mail_subject = '')
{
	global $t;
	global $form_builder_hide_config;
	$form_builder_hide_config = 1;//Hide form config if form builder calls from function
	global $form_builder_page_dependent;
	$form_builder_page_dependent = $page_dependent;
	
	//set passed values
	$page_id = 0;
	$suffix = $form_name;
	if($page_dependent == 1)
	{
		$page_id = $t;
		$suffix = '';
	}
	global $form_builder_suffix;
	$form_builder_suffix = $suffix;
	save_cms('form_builder_form_name_'.$suffix, $form_name, $page_id);
	save_cms('form_builder_display_email_'.$suffix, $display_email, $page_id);
	save_cms('form_builder_store_in_db_'.$suffix, $store_in_db, $page_id);
	save_cms('form_builder_send_email_'.$suffix, $send_email, $page_id);
	save_cms('form_builder_to_email_'.$suffix, $to_email, $page_id);
	save_cms('form_builder_from_email_'.$suffix, $from_email, $page_id);
	save_cms('form_builder_mail_subject_'.$suffix, $mail_subject, $page_id);
	
	//return parse('form_builder');//testing
	return parse('form_builder_body');
}
?>