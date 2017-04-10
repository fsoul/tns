<?
header("Content-type: text/html; charset=utf-8");
$admin=true;
//********************************************************************
include_once('../lib.php');
    
// see 10123 task. To be fixed in another way.
if (defined('EE_USE_SENDDAEMON') && EE_USE_SENDDAEMON == true)
{
	send_all_emails();
}
echo 'Done';
//echo 'All emails are sended!';
?>