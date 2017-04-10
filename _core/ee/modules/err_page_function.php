<?
// define an assoc array of error string
// in reality the only entries we should
// consider are E_WARNING, E_NOTICE, E_USER_ERROR,
// E_USER_WARNING and E_USER_NOTICE

$errortype = array (
		E_NOTICE             => 'Notice',
		E_USER_NOTICE        => 'User Notice',
		E_STRICT             => 'Runtime Notice',
		E_WARNING            => 'Warning',
		E_CORE_WARNING       => 'Core Warning',
		E_COMPILE_WARNING    => 'Compile Warning',
		E_USER_WARNING       => 'User Warning',
		E_ERROR              => 'Error',
		E_PARSE              => 'Parsing Error',
		E_CORE_ERROR         => 'Core Error', 
		E_COMPILE_ERROR      => 'Compile Error',
		E_USER_ERROR         => 'User Error',   
		E_RECOVERABLE_ERROR => 'Catchable Fatal Error'
		);

$errorcodes = array (
		E_NOTICE             => 'E_NOTICE',
		E_WARNING            => 'E_WARNING',
		E_ERROR              => 'E_ERROR',
		E_PARSE              => 'E_PARSE',
		E_CORE_ERROR         => 'E_CORE_ERROR',
		E_CORE_WARNING       => 'E_CORE_WARNING',
		E_COMPILE_ERROR      => 'E_COMPILE_ERROR',
		E_COMPILE_WARNING    => 'E_COMPILE_WARNING',
		E_USER_ERROR         => 'E_USER_ERROR',
		E_USER_WARNING       => 'E_USER_WARNING',
		E_USER_NOTICE        => 'E_USER_NOTICE',
		E_STRICT             => 'E_STRICT',
		E_RECOVERABLE_ERROR => 'E_RECOVERABLE_ERROR'
		);

$error_codes = array(
	400 => array ('description' => 'Bad Request'),	
	401 => array ('description' => 'Unauthorized'),	
	402 => array ('description' => 'Payment Required'),	
	403 => array ('description' => 'Forbidden'),	
	404 => array ('description' => 'Not Found'),	
	405 => array ('description' => 'Method Not Allowed'),	
	406 => array ('description' => 'Not Acceptable'),	
	407 => array ('description' => 'Proxy Authentication Required'),	
	408 => array ('description' => 'Request Timeout'),	
	409 => array ('description' => 'Conflict'),	
	410 => array ('description' => 'Gone'),	
	411 => array ('description' => 'Length Required'),	
	412 => array ('description' => 'Precondition Failed'),	
	413 => array ('description' => 'Request Entity Too Large'),	
	414 => array ('description' => 'Request-URI Too Long'),	
	415 => array ('description' => 'Unsupported Media Type'),	
	416 => array ('description' => 'Requested Range Not Satisfiable'),	
	417 => array ('description' => 'Expectation Failed'),
		
	500 => array ('description' => 'Internal Server Error'),	
	501 => array ('description' => 'Not Implemented'),	
	502 => array ('description' => 'Bad Gateway'),	
	503 => array ('description' => 'Service Unavailable'),	
	504 => array ('description' => 'Gateway Timeout'),	
	505 => array ('description' => 'HTTP Version Not Supported'),	
	600 => array ('description' => 'Check if DNS is enabled'),
);

function print_errorpage_footnote()
{
	if ($_GET['popup'] == 1)
	{
		$s = '';
	}
	else
	{
		$s = ERROR_PAGE_BACK;
	}

	return $s;
}

function print_error_page_submit_button()
{
	if ($_GET['popup']==1)
	{
		$s = '<img style="cursor:hand" onClick="window.close();" '.JScriptOverImg().' src="'.image_close_button().'">';
	}
	else
	{
		$s = '<input type="submit" value="'.BACK.'" name="errorpage_submit">';
	}

	return $s;
}

function restore_errorpage_post()
{
	if ($_POST['errorpage_submit'])
	{
		foreach ($_POST as $key=>$val)
		{
			global $$key;
			$$key = $val;
//msg ($$key, $key);
		}
	}
}

function print_post_hidden()
{
	$s = '';

	if (is_array($_POST) and count($_POST)>0)
	{
		foreach ($_POST as $key=>$val)
		{
			if (is_array($val))
			{
				foreach ($val as $name=>$value)
				{
					$params.=$key.'['.$name.']='.urlencode($value).'&';
					$s.='<input type="hidden" name="'.$key.'['.$name.']" value="'.htmlentities($value).'">'."\n";
				}
			}
			else
			{
				$s.='<input type="hidden" name="'.$key.'" value="'.htmlentities($val).'">'."\n";
			}
		}
//Old version:		foreach ($_POST as $key=>$val)	$s.='<input type="hidden" name="'.$key.'" value="'.$val.'">'."\n";
	}
	return $s;
}

function set_error($back_url, $err_id, $err_text='')
{
	global $language;

	$_POST['language'] = $language;

	if ($back_url=="")
	{
		$back_url = EE_HTTP;
	}

	$_POST['back_url'] = $back_url;
	$_POST['error_page_code'] = $err_id;

	$_POST['error_page_text'] = $err_text;
}

function find_error()
{
	global $err_id_value, $err_text_value, $back_url, $language, $support_url;

	$err_id_value = $err_text_value = $back_url = '';

	stripslashes_in_post();

	$err_id_value = $_POST['error_page_code'];

	if (!is_array($_POST['error_page_text']))
	{
		$err_text_value = $_POST['error_page_text'];
	}
	else 
	{
		$err_text_value = $_POST['error_page_text'][0];
		$err_text_value_detail = $_POST['error_page_text'][1];
		if (is_array($err_text_value_detail))
		{
			$err_text_value_detail = print_r($err_text_value_detail, true);
		}
	}

	$back_url = $_POST['back_url'];
	return "<br><b>Error: </b>".$err_text_value."<br><br><b>Details: </b>".$err_text_value_detail."<br><br><b>Advanced details: <br><br></b>";
}

function print_post_user_comment()
{
	$s = '<form name="FormName" action="action.php?action=send_error" method="post">
		<textarea name="user_notice" rows=10 cols=40 wrap="off"></textarea>
		<center>
		<input type="submit" value="Send">'.print_post_hidden().'
		</form>
		';
	return $s;
}

function parse_error_code($redir_status)
{
	$sql = 'SELECT val FROM config WHERE var=\'error_pages\'';

	$err_page_arr = unserialize(getField($sql));

	$row 			= $err_page_arr[$redir_status];
	$error_page 		= $row['value'];
	$error_page_type 	= $row['page_type'];
	$error_page_description = $row['description'];

	// vdump($error_page, '$error_page');
	// vdump($error_page_type, '$error_page_type');

	// we should get a response from the server according to error code which parsed
	// code "403" -> "403 Forbidden" response
	// but not
	// code "403" -> "200 OK" response
	header('HTTP/1.1 '.$redir_status.' '.$error_page_description);

	switch ($error_page_type)
	{
		case '0':
			global $t, $page_type;
			$t = $error_page;
			$page_type = 'html';

			global $language;
			$langEncode = get_Array_Language_Encode();
			$charset = $langEncode[$language];

			header('Content-type: text/html; charset='.$charset);

			echo reduce_html_links(parse($error_page));
			break;

		case '1':
			header("Location: ".$error_page);
			break;

		case '2':
			echo reduce_html_links(parse2($error_page));
			break;

		default:
			echo 'error '.$redir_status;
			break;
	}

	exit;
}

function send_error_report($title, $text)
{
	$xml_head = '<?xml version="1.0"?>'."\n\t";
	$ar_tags = array('post', 'get', 'session', 'server', 'cookie');

	$attachments = array();
	foreach ($ar_tags as $tag)
	{
		// $_POST, $_GET, ...
		$global_array_name = '_'.strtoupper($tag);

		global $$global_array_name;

		$result_array[$tag] = $$global_array_name;
	}

	$attachments[] = array(                
		'content' => $xml_head.'<debug>'.wddx_serialize_value($result_array).'</debug>'."\n",
		'attachment_file_name' => 'debug.xml'
	);  

	$res = phpmailer_send_mail(EE_SUPPORT_EMAIL, '', $title, $text, $attachments);
	if ($res !== true)
	{
		mail(EE_SUPPORT_EMAIL, $title, $text, 'Content-type: text/html;');
	}
}

/*
** Inputs string [$error_val] that may contain words [Notice|Warning|Error]
** Output highlight word by seniority.
*/
function highlight_by_group($error_val)
{
	$temp_val = $error_val;

	switch ($temp_val)
	{
		case preg_match('/Handling type/i', $temp_val) == 1:
			$res = '<span>'.$error_val.'</span>';
			break;

		case preg_match('/Notice/i', $temp_val) == 1:
			$res = '<span style = "color:green;">'.$error_val.'</span>';
			break;

		case preg_match('/Warning/i', $temp_val) == 1:
			$res = '<span style = "color:#CC9900;">'.$error_val.'</span>';
			break;

		case preg_match('/Error/i', $temp_val) == 1:
			$res = '<span style = "color:red;">'.$error_val.'</span>';
			break;
	}

	return $res;
}

function print_array($cur_arr, $pk = '', $l = 0)
{
	$s = $ob = $cb = $q = '';
	if ($cur_arr)
	{
		foreach($cur_arr as $k=>$v)
		{
			if (!is_numeric($k))
			{
				$q = '"';
			}

			if (is_array($v))
			{
				if ($l > 0)
				{
					$ob = '['.$q;
					$cb = $q.']';
				}
				$pk .= $ob.$k.$cb;
				$res = print_array($v, $pk, ++$l);
				--$l;
				$pk = str_replace($ob.$k.$cb,'',$pk);
				$s .= $res;
			}
			else
			{
				$s .=  $pk.($l > 0?'['.$q.$k.$q.']':$k).' = \''.htmlentities($v, ENT_QUOTES).'\'<br />';
			}
		}
	}
	else
	{
		$s = '&lt;empty&gt;';
	}
	return $s;
}


