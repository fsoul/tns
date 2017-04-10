<?
exit;
include('_core/ee/lib.php');


//mail_respondent('viktor.bozhko@tns-ua.com', '000', 'respondent-registration-approve', 'Test First Name', 'Test Last Name');
//var_dump(mail_respondent('viktor.bozhko@tns-ua.com,pletsky@gmail.com,kostyaz@2kgroup.com', 'TNS mail test', 'Test message body with no link', '000', 'respondent-registration-approve', 'Test First Name', 'Test Last Name'));
//var_dump(mail_respondent('viktor.bozhko@tns-ua.com,pletsky@gmail.com,kostyaz@2kgroup.com', 'TNS mail test', 'Test message body with link http://opros.tns-ua.com/UA/respondent-registration-approve.html?sid=000', '000', 'respondent-registration-approve', 'Test First Name', 'Test Last Name'));
$t = 47;
//$email = 'pletsky@gmail.com';
$resp = ap_resp_init();

foreach(array(
'drobot1979@yandex.ua',
'samonoff22@yandex.ua',
'mizer127@ukr.net',
'galachka07@inbox.ru ',
'julia_r88@mail.ru'
) as $email)
{
	$hash_code = $resp->Reset_Password_Get_Hash_Code($email);
	$info = $resp->Get_Info_By_Email($email);
	var_dump(mail_respondent($email, page_cms('email_subject'), page_cms('email_body'), get_href('respondent_activate').uri_separator().'sid='.$hash_code, $info['first_name_'], $info['last_name_'], $info['sex_']));
}


