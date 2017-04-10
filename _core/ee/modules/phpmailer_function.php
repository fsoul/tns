<?
define('MAIL_WORD_WRAP', 70);

/**
* Function create object with mailer and define its properties
* @param string|array $php_mailer_properties - array with email properties, for example from address or from name properties
* @return boolean result of sending email
*/
function phpmailer_create_mailer($php_mailer_properties = '')
{
	require_once(EE_PATH.EE_HTTP_PREFIX_CORE.'lib/phpmailer/class.phpmailer.php');

	global $CONFIG;
	$mail = new PHPMailer();
	$mail->Host		= !empty($CONFIG['SMTP_host']) ? $CONFIG['SMTP_host'] : 'localhost';
	$mail->Mailer   = 'mail';
	$mail->From     = (is_array($php_mailer_properties) && array_key_exists('From', $php_mailer_properties)) ? $php_mailer_properties['From'] : ((defined('SUPPORT_EMAIL')) ? SUPPORT_EMAIL : '');
	$mail->FromName = (is_array($php_mailer_properties) && array_key_exists('FromName', $php_mailer_properties)) ? $php_mailer_properties['FromName'] : '';
	$mail->CharSet =  !empty($CONFIG['mail_character_set']) ? $CONFIG['mail_character_set'] : 'iso-8859-1';
	$mail->WordWrap = MAIL_WORD_WRAP;
	$mail->IsHTML(true);
    return $mail;
}

//NOT IN USE
/*function phpmailer_send_admin_mail($subject, $body)
{
	global $global_admin_email, $global_admin_email_name;
	return phpmailer_send_mail($global_admin_email, $global_admin_email_name, $subject, $body);
}*/

/**
* Function send email with difined properties
* @param string $recipient_email - email adrress of recipient
* @param string $recipient_name - name of recipient
* @param string $subject - subject of mail letter
* @param string $body - body of mail letter
* @param string|array $attachments - array with attachment properties or empty string
* @param string|array $php_mailer_properties - array with email properties, for example from address or from name properties
* @used phpmailer_create_mailer()
* @return boolean result of sending email
*/
function phpmailer_send_mail($recipient_email, $recipient_name, $subject, $body, $attachments = '', $php_mailer_properties = '')
{
	$mail = phpmailer_create_mailer($php_mailer_properties);
	$mail->LE = PHP_EOL;
	$mail->AddAddress($recipient_email, $recipient_name);
	$mail->MsgHTML($body);
	$mail->Subject = $subject;
	if (($attachments != '') && is_array($attachments))
	{
		foreach ($attachments as $key=>$val) {
			$mail->AddStringAttachment($val['content'],$val['attachment_file_name']);
		}
	}
	$res = $mail->Send();
   	$mail->ClearAddresses();
	$mail->ClearAttachments();
	
	//used before ($mail->smtp->error['error'].' ('.$mail->Host.')');
	
	if (!$res)
	{
		$return = '';
		if ($mail->Mailer == 'smtp' and !is_null($mail->smtp))
			$return = $mail->smtp->getError();
		else
			$return =$mail->ErrorInfo;
		return $return;
	}
	else
	{
		return true;
	}
}
?>