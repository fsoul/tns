<?
	$modul='support';
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if(!CheckAdmin() or ($UserRole!=ADMINISTRATOR && $UserRole!=POWERUSER)) {echo parse('norights');exit;}

	if(!isset($mc)) $mc=$MAX_CHARS;
	if(!isset($mr)) $mr=$MAX_ROWS_IN_ADMIN;
	if(!isset($clive)) $clive=$live;
	if(!isset($dl)) $dl=$default_language;
	$error=array();

	$config_fields = array("search_enable_search_for_website","search_exclude_html_tags","search_page_name","search_rate_page_name","search_page_title","search_rate_page_title","search_page_keywords","search_rate_page_keywords","search_user_content","search_rate_user_content","search_page_content","search_rate_page_content","search_media_library","search_rate_media_library","search_show_page_name","search_max_chars_page_name","search_show_page_url","search_max_chars_page_url","search_show_page_keywords","search_max_chars_page_keywords","search_show_page_content","search_max_chars_page_content","search_minimal_characters_to_search");

	if (!isset($contact_email))
		$contact_email = $_SESSION['UserEmail'];
	if (!isset($name))
		$name = $_SESSION['UserName'];


	if(!empty($send))
	{
		$body = parse($modul."/ml_support_request");
		$_POST["message"] = $_POST["message"];
		$headers = "Content-type: text/html; charset=iso-8859-1\nFrom:".$_POST['contact_email']." <".$_POST['contact_email'].">\r\nReply-To: ".$_POST['contact_email']."\r\n";
		mail(EE_SUPPORT_EMAIL, "support request from ".EE_HOST, $body, $headers);
		mail($_POST['contact_email'], "support request from ".EE_HOST, $body, $headers);
		$s = 'Location: support.php?op=view_request&name='.$_POST["name"].'&contact_email='.$_POST['contact_email'].'&contact_phone='.rawurlencode($_POST['contact_phone']).'&best_way='.rawurlencode($_POST['best_way']).'&message='.rawurlencode($_POST['message']);
//		echo $s;
//		exit;
	    header($s);
		exit;
	}
	if(!empty($back))
	{
	    header('Location: support.php');
	    exit;
	}
//********************************************************************
	if (!empty($op) && $op=='view_request')
		echo parse($modul.'/view_request');
	else
		echo parse($modul.'/list');

function parse_support_mail_message()
{
	$mess = post('message');

	if (!$mess)
		$mess = get('message');

	$mess = htmlspecialchars($mess, ENT_QUOTES);
	return nl2br($mess);
}

?>
