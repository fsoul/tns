<pre>
<?
exit;
include('../_core/ee/lib.php');

$resp = ap_resp_init();
var_dump($resp);

$res = $resp->Add(
'�i����������',
'�����i�',
'0',
'25.10.1984',
'',
'0976429713',
'valeria.miroshnychenko.onemore@tns-ua.com',
'2',
'7',
'10268',
'149',
'3395',
'17a',
'84'
);

var_dump($res);

