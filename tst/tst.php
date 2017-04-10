<html>
<head>
    <meta charset="utf-8"/>
</head>
<body>

<?php
error_reporting(E_ALL);

include('library/Requests.php');
Requests::register_autoloader();

class AccessPanel_DBHttpRequest {
protected $key;
public $headers;
public $url = 'http://192.168.4.25:8080/b36panel/Entry/';

function __construct() {
if(!isset($_SESSION)){
session_start();
}
$this->key = file_get_contents('../key');
//$this->key = file_get_contents($_SERVER['SERVER_NAME'].'/key');
echo $this->key;
$this->headers = array('Content-Type' => 'application/json', 'X-Current-Key' => $this->key);
}
function __destruct() {
}

function request($operation, $data = false){
if($data){
$response = Requests::post($this->url.$operation, $this->headers, json_encode($data));
}else{
$response = Requests::get($this->url.$operation, $this->headers);
}

$response = json_decode($response->body);
if($response->response_code != 000){
echo '<b>error text: '.$response->response_text.'</b>';
//logTo('[' . date("Y-m-d H:i:s") . '] ' . 'data: ' . $data . ' error text: ' . $response->response_text, 'DBRequest.txt');
}
return $response;
}

function authorize($data, $a2, $plugin_id = false, $cookie = false){
    $data = array('email' => $data, 'pass' => $a2);
    //$data = array("email"=> "gorelova@macc.com.ua", "pass"=> "123123", "cookie"=> "39215823AF014D098221C34D3BDD5236");
    if($plugin_id){
        $data['plugin_id']=$plugin_id;
    }
    if($cookie){
        $data['cookie']=$cookie;
    }
    var_dump($data);
if($_SESSION['auth']){
return true;
}
$res = $this->request('authorize', $data);
if($res->response_code == '000'){
$_SESSION['auth'] = $data['email'];
return true;
}
else return false;
}
function unAuthorize(){
unset($_SESSION['auth']);
}
function dic_region_list(){
$res =  $this->request('dic_region_list');
return $res->response;
}
function dic_area_list($data){
$res =  $this->request('dic_area_list', $data);
return $res->response;
}
function dic_city_list($data){
$res =  $this->request('dic_city_list', $data);
return $res->response;
}
function dic_info_source_list(){
$res =  $this->request('dic_info_source_list');
return $res->response;
}
function is_email_exists($data){
//$data  = array('email'=>$data);
$res =  $this->request('is_email_exists', $data);
if($res->response->is_exists == '1')
return true;
else return false;
}
function  is_phone_exists($data){
$data  = array('phone'=>$data);
    var_dump($data);
$res =  $this->request('is_phone_exists', $data);
if($res->response->is_exists == '1')
return true;
else return false;
}
function formDataArray(){}
}

$obj = new AccessPanel_DBHttpRequest();
//$res = $obj->authorize(array('email' => 'gorelova@macc.com.ua', 'pass' => '123123'));
$res = $obj->authorize('gorelova@macc.com.ua','123123');
res($res, 'authorize');

$res = $obj->dic_region_list();
//res($res, 'dic_region_list');

$res = $obj->dic_area_list(array('dic_region_id' => 1));
res($res, 'dic_area_list');

$res = $obj->dic_city_list(array('dic_area_id' => 1));
res($res, 'dic_city_list');

$res = $obj->dic_info_source_list();
res($res, 'dic_info_source_list');

$res = $obj->is_email_exists('gorelova@macc.com.ua');
res($res, 'is_email_exists');

$res = $obj->is_phone_exists('0672223344');
res($res, 'is_phone_exists');

$obj->unAuthorize();


function res($res, $a=''){
echo '<pre><b>'.$a.'</b><br>';
    var_dump($res);
    //echo '<hr>';
//echo $res->response_text;
    echo '</pre><hr>';
}
/*
$obj = new AccessPanel_DBHttpRequest();
$res = $obj->authorize(array('email' => 'gorelova@macc.com.ua', 'pass' => '123123'));
res($res, 'authorize');

$res = $obj->dic_region_list();
//res($res, 'dic_region_list');

$res = $obj->dic_area_list(array('dic_region_id' => 1));
res($res, 'dic_area_list');

$res = $obj->dic_city_list(array('dic_area_id' => 1));
res($res, 'dic_city_list');

$res = $obj->dic_info_source_list();
res($res, 'dic_info_source_list');

$res = $obj->is_email_exists(array('email' => 'gorelova@macc.com.ua'));
res($res, 'is_email_exists');

$res = $obj->is_phone_exists(array('phone_number' => '0672223344'));
res($res, 'is_phone_exists');

$obj->unAuthorize();


function res($res, $a=''){
echo '<pre><b>'.$a.'</b><br>';
    var_dump($res);
    //echo '<hr>';
//echo $res->response_text;
    echo '</pre><hr>';
}
/**/
?>

</body>
</html>