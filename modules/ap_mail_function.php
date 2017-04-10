<?


function mail_respondent($to_email, $subject, $message, $link, $first_name, $last_name, $sex_=1, $use_html=false)
{
//var_dump(debug_backtrace());
//var_dump($link); exit;
//	$subject = page_cms('email_subject');
	$subject = str_replace('{HTTP}', EE_HTTP, $subject);
	$subject = str_replace('{SITE_NAME}', EE_SITE_NAME, $subject);

	$from = NOREPLY_EMAIL;

	//send email
	$eol = "\r\n";
    $headers = 'From: '.$from.$eol;
    $headers .= 'Reply-To: '.$from.$eol;
    $headers .= 'Return-Path: '.$from.$eol;
	$headers .= 'MIME-Version: 1.0'.$eol;
	$headers .= 'Content-Type: text/'.( $use_html ? 'html' : 'plain' ).'; charset='.getCharset().$eol;
	$headers .= 'X-Mailer: PHP/'.phpversion();

	if ($use_html)
	{
		$message = 
		'<html>'."\r\n".
		'<head>'."\r\n".
        	'<title>'.$subject.'</title>'."\r\n".
		'</head>'."\r\n".
		'<body>'."\r\n".
		$message.
		'</body>'."\r\n".
		'</html>'."\r\n";
	}

	$message = str_replace(
		array (
			'{HTTP}',
			'{login}',
			'{first_name}',
			'{last_name}',
			'{link}',

			'&lt;br&gt;',
			'&lt;br/&gt;',
			'&lt;br /&gt;',
			'<br>',
			'<br/>',
			'<br />'
		),

		array (
			EE_HTTP,
			$to_email,
			$first_name,
			$last_name,
			$link,

			"\r\n",
			"\r\n",
			"\r\n",
			"\r\n",
			"\r\n",
			"\r\n"
		),

		$message
	);


	if ($sex_ != 1)
	{
		global $language;

		$ar_refers = array(
			'UA'=>array('Шановна', 'Шановний'),
			'RU'=>array('Уважаемая', 'Уважаемый')
		);

		if (array_key_exists($language, $ar_refers))
		{
			$message = str_replace($ar_refers[$language][1], $ar_refers[$language][0], $message);
		}
	}
	

	if (!$use_html)
	{
		$message = strip_tags($message);
	}


	if (empty($subject))
	{
		trigger_error('Empty email subject');
	}

	if (empty($message))
	{
		trigger_error('Empty email message');
	}
	
	$subject = "=?".getCharset()."?b?".base64_encode($subject)."?=";

	$res = mail($to_email, $subject, $message, $headers);

$h = fopen(EE_PATH.'log/mail.html', "a");
fwrite($h, 'Date/time: '."\r\n".date("Y-m-d H:i:s")."\r\n\r\n");
fwrite($h, 'IP (remote address): '."\r\n".$_SERVER['REMOTE_ADDR']."\r\n\r\n");
fwrite($h, 'HTTP_X_FORWARDED_FOR: '."\r\n".getenv('HTTP_X_FORWARDED_FOR')."\r\n\r\n");
fwrite($h, 'Page id: '."\r\n".getValueOf('page_id')."\r\n\r\n");
fwrite($h, '$to_email: '."\r\n".$to_email."\r\n\r\n");
fwrite($h, '$subject:'."\r\n".$subject."\r\n\r\n");
fwrite($h, '$message:'."\r\n".$message."\r\n\r\n");
fwrite($h, '$headers:'."\r\n".$headers."\r\n\r\n\r\n");

fclose($h);

	return $res;
}

