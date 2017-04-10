<?
require_once(EE_PATH.'autoloader.php');


function ap_captcha_init()
{
	$captcha = new AccessPanel_Securimage();

	return $captcha;
}

function ap_resp_init(){
	return new AccessPanel_Respondent();//$ar_access_panel_objects['resp'];
}

function initHttpReq(){
    global $dbRequest;
    if(empty($dbRequest)){
        $dbRequest = new AccessPanel_DBHttpRequest();
    }
    return $dbRequest;
}
$dbRequest = initHttpReq();