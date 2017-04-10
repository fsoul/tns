<?php
require_once('library/Requests.php');
Requests::register_autoloader();

class AccessPanel_DBHttpRequest {
    protected $key;
    protected $headers;
    public $url = ORACLE_API_LINK;

    function __construct() {
        if (!session_id()){
            session_start();
        }
        $this->key = trim( file_get_contents(dirname(__FILE__).'/../key') );
        $this->headers = array('Content-Type' => 'application/json', 'X-Current-Key' => $this->key);
        $this->options = array('verify'=>false, 'timeout'=>20,'connect_timeout'=>20);
    }

    function request($operation, $data = false){
        if($data){
            $response = Requests::post($this->url.$operation, $this->headers, json_encode($data), $this->options);
        }else{
            $response = Requests::get($this->url.$operation, $this->headers, $this->options);
        }
        $response = json_decode($response->body, true);
        if($response['response_code'] != 000){
            /*echo '<b>error text: '.iconv('utf-8','windows-1251',$response['response_text']).'</b><br>';
            res($response);
            */
            logTo('[' . date("Y-m-d H:i:s") . '] ' . ' Function: '. $operation . ' Error text: ' . $response['response_text'], 'DBRequest.txt');
            if($data){
                $log = '';
                foreach($data as $k => $v){
                    $log .= $k . ': ' . $v . ' / ';
                }
                logTo($log, 'DBRequest.txt');
            }
        }
        return $response;
    }

    function authorize($email, $pass, $plugin_id = false, $cookie = false){
        $data = array('email' => $email, 'pass' => md5($pass), 'ip' => $_SERVER['REMOTE_ADDR'], 'useragent'=>$_SERVER['HTTP_USER_AGENT'] );
        if(!empty($plugin_id))
            $data['plugin_id'] = $plugin_id;
        if(!empty($cookie))
            $data['cookie'] = $cookie;
        $res = $this->request('authorize', $data);
        if($res['response_code'] == '000'){
            $_SESSION['respondent']['id_'] = $res['response']['onl_respondent_id'];
            $_SESSION['respondent']['respondent_id_'] = $res['response']['onl_respondent_id'];
            $_SESSION['respondent']['email_'] = $res['response']['email'];
            $_SESSION['respondent']['first_name_'] = $res['response']['first_name'];
            $_SESSION['respondent']['last_name_'] = $res['response']['last_name'];
            $_SESSION['respondent']['sex_'] = $res['response']['sex'];
            $_SESSION['respondent']['district_'] = $res['response']['district_id'];
            $_SESSION['respondent']['city_'] = $res['response']['city'];
            $_SESSION['respondent']['region_'] = $res['response']['region'];
            $_SESSION['respondent']['birth_date_'] = $res['response']['birth_date'];
            $_SESSION['respondent']['urlid'] = $res['response']['urlid'];
            $_SESSION['auth'] = $data['email'];
            return true;
        } else {
            $_SESSION['auth_error'] = $res['response_code'];
            return false;
        }
    }
    function unAuthorize(){
        unset($_SESSION['auth']);
        unset($_SESSION['respondent']);
        unset($_SESSION['PA_ANS']);//delete all answered q_id
    }
    function dic_region_list(){
        $res =  $this->request('dic_region_list');
        return $res['response'];
    }
    function dic_area_list($data){
        $data = array('dic_region_id'=>$data);
        $res =  $this->request('dic_area_list', $data);
        return $res['response'];
    }
    function dic_city_list($data){
        $data = array('dic_area_id'=>$data);
        $res =  $this->request('dic_city_list', $data);
        return $res['response'];
    }
    function dic_info_source_list(){
        $res =  $this->request('dic_info_source_list');
        return $res['response'];
    }
    function is_email_exists($data){
        $data = array('email'=>$data);
        $res =  $this->request('is_email_exists', $data);
        if($res['response']['is_exists'] == '1')
            return true;
        else return false;
    }
    function  is_phone_exists($data){
        $data = array('phone_number' => $data);
        $res =  $this->request('is_phone_exists', $data);
        if($res['response']['is_exists'] == '1')
            return true;
        else return false;
    }
    function active_project_list($onl_respondent_id){
        $data = array('onl_respondent_id' => $onl_respondent_id);
        $res =  $this->request('active_project_list', $data);
        return $res['response'];
    }
    function complete_project_list($onl_respondent_id){
        $data = array('onl_respondent_id' => $onl_respondent_id);
        $res =  $this->request('complete_project_list', $data);
        return $res['response'];
    }
    function onl_respondent_ins($last_name,$first_name,$sex,$birth_date,$cell_phone_number,$email, $district_id, $region, $city,
                                $parent_respondent_email=null, $cookie = null,
                                $dic_know_about_us_id = null, $dic_know_about_us_other = null){
        $data = array('last_name' => iconv('cp1251', 'utf-8', $last_name),'first_name' => iconv('cp1251', 'utf-8', $first_name),
            'sex' => $sex,'birth_date' => $birth_date,
            'cell_phone_number' => $cell_phone_number,'email' => $email,'district_id' => $district_id, 'region'=> $region,'city' => $city,
            'ip' => $_SERVER['REMOTE_ADDR'], 'useragent'=>$_SERVER['HTTP_USER_AGENT']);
        if(!empty($parent_respondent_email)){
            $data['parent_respondent_email'] = $parent_respondent_email;
        }
        if(!empty($cookie)){
            $data['cookie'] = $cookie;
        }
        if(!empty($dic_know_about_us_id)){
            $data['dic_know_about_us_id'] = $dic_know_about_us_id;
        }
        if(!empty($dic_know_about_us_other)){
            $data['dic_know_about_us_other'] = $dic_know_about_us_other;
        }
        $res =  $this->request('onl_respondent_ins', $data);
        return $res['response']['respondent_id'];
    }
    function profile_get_respondent_last_question($onl_respondent_id,$poll_type_id, $url_id){
        $data = array('onl_respondent_id' => $onl_respondent_id,'poll_type_id' => $poll_type_id, 'url_id' => $url_id,);
        $res =  $this->request('profile_get_respondent_last_question', $data);
        return $res['response']['dic_ap_question_order_num'];
    }
    function profile_get_question_info($poll_type_id, $order_num = null, $dic_ap_question_id=null){
        $data = array('poll_type_id' => $poll_type_id);
        if(!empty($order_num))
            $data['order_num'] = $order_num;
        if(!empty($dic_ap_question_id))
            $data['dic_ap_question_id'] = $dic_ap_question_id;
        $res =  $this->request('profile_get_question_info', $data);
        return $res['response'];
    }
    function profile_save_question_answer($onl_respondent_id, $url_id, $dic_ap_question_id, $dic_answers, $cookie = null){
        $data = array('onl_respondent_id' => $onl_respondent_id,'url_id' => $url_id,'dic_ap_question_id' => $dic_ap_question_id,'dic_answers' => $dic_answers);
        if(!empty($cookie))
            $data['cookie'] = $cookie;
        $res =  $this->request('profile_save_question_answer', $data);
        return $res['response'];
    }
    function profile_complete($onl_respondent_id, $url_id ){
        $data = array('onl_respondent_id' => $onl_respondent_id,'url_id' => $url_id);
        $res =  $this->request('profile_complete', $data);
        return $res;
    }
    function plugin_link($onl_respondent_id, $plugin_id, $cookie = null){
        $data = array('onl_respondent_id' => $onl_respondent_id,'plugin_id' => $plugin_id, 'ip' => $_SERVER['REMOTE_ADDR'], 'useragent'=>$_SERVER['HTTP_USER_AGENT']);
        if(!empty($cookie))
            $data['cookie'] = $cookie;
        $res =  $this->request('plugin_link', $data);
        return $res;
    }
    function get_respondent_mini_survey($onl_respondent_id, $plugin_id = null){
        $data = array('onl_respondent_id' => $onl_respondent_id);
        if(!empty($plugin_id))
            $data['plugin_id'] = $plugin_id;
        $res =  $this->request('get_respondent_mini_survey', $data);
        return $res['response']['survey_id'];
    }
    function complete_respondent_project($complete_code, $complete_type){
        $data = array('complete_code' => $complete_code, 'complete_type'=>$complete_type);
        $res =  $this->request('complete_respondent_project', $data);
        return $res['response'];
    }
    function activate_respondent($onl_respondent_id){
        $data = array('onl_respondent_id' => $onl_respondent_id);
        $res =  $this->request('activate_respondent', $data);
        if($res['response_code'] == 000)
            return true;
        else return false;
    }

    function pwd_request_ins($email){
        $data = array('email' => $email);
        $res =  $this->request('pwd_request_ins', $data);
        return $res['response']['request_id'];
    }
    function pwd_request_check($request_id){
        $data = array('request_id' => $request_id);
        $res =  $this->request('pwd_request_check', $data);
        if($res['response']['is_active'] == 1)
            return true;
        else return false;
    }
    function pwd_request_get_info($request_id){
        $data = array('request_id' => $request_id);
        $res =  $this->request('pwd_request_get_info', $data);
        return $res['response'];
    }
    function pwd_request_change_pass($request_id, $new_pass){
        $data = array('request_id' => $request_id, 'new_pass'=>$new_pass);
        $res =  $this->request('pwd_request_change_pass', $data);
        return $res;
    }
    function get_min_convertion_score($dic_score_convert_type_id){
        $data = array('dic_score_convert_type_id' => $dic_score_convert_type_id);
        $res =  $this->request('get_min_convertion_score', $data);
        return $res['response']['min_convert_score'];
    }
    function convertion_score_ins($onl_respondent_id, $score, $dic_score_convert_type_id, $destination = null){
        $data = array('onl_respondent_id' => $onl_respondent_id, 'score'=>$score, 'dic_score_convert_type_id'=>$dic_score_convert_type_id);
        if(!empty($destination))
            $data['destination'] = $destination;
        $data = $this->win2utf($data);
        $res =  $this->request('convertion_score_ins', $data);
        return $res['response']['score_conversion_id'];
    }
    function dic_score_convert_type_list(){
        $res =  $this->request('dic_score_convert_type_list');
        return $res['response'];
    }
    function get_respondent_info($onl_respondent_id = null, $email = null){
        $data = array();
        if(!empty($onl_respondent_id))
            $data['onl_respondent_id'] = $onl_respondent_id;
        else if(!empty($email))
            $data['email'] = $email;
        else return false;

        $res =  $this->request('get_respondent_info', $data);
        return $this->utf2win($res['response'][0]);
    }
    function utf2win($convert){
        foreach($convert as $key=>$v){
            $convert[$key] = iconv("UTF-8", "Windows-1251", $v);
        }
        return $convert;
    }
    function win2utf($convert){
        foreach($convert as $key=>$v){
            $convert[$key] = iconv("Windows-1251","UTF-8", $v);
        }
        return $convert;
    }
    function complete_respondent_mini_survey($onl_respondent_id, $survey_id, $complete_type, $cookie = null){
        $data = array('onl_respondent_id' => $onl_respondent_id, 'survey_id'=>$survey_id, 'complete_type'=>$complete_type);
        if(!empty($cookie))
            $data['cookie'] = $cookie;
        $res =  $this->request('complete_respondent_mini_survey', $data);
        if($res['response_code'] == 000)
            return true;
        else return false;
    }
    function set_respodent_decline_status($onl_respondent_id, $status){
        $data = array('onl_respondent_id' => $onl_respondent_id, 'status'=>$status);
        $res =  $this->request('set_respodent_decline_status', $data);
        if($res['response_code'] == 000)
            return true;
        else return false;
    }
    function set_adv_block_status($is_counter_block, $is_adv_block, $resp_id, $cookie, $plid_id){
        var_dump($is_counter_block);
        var_dump($is_adv_block);
        $data = array(
            'is_counter_block' => $is_counter_block,
            'is_adv_block' => $is_adv_block,
            'onl_respondent_id' => $resp_id,
            'cookie' => $cookie,
            'plugin_id' => $plid_id,
            'ip' => $_SERVER['REMOTE_ADDR'],
            'useragent' => $_SERVER['HTTP_USER_AGENT']
        );
        var_dump($data);
        $res =  $this->request('set_adv_block_status', $data);
        var_dump($res);
        if($res['response_code'] == 000)
            return true;
        else return false;
    }
}

/*
$obj = new AccessPanel_DBHttpRequest();
$res = $obj->get_respondent_info(1141);

res($res, 'get_respondent_info ID');

$res = $obj->get_respondent_info(null, 'danilchyk@macc.com.ua');

res($res, 'get_respondent_info mail');
/*
$res = $obj->complete_project_list(2);
res($res, 'complete_project_list');
/*
$res = $obj->authorize('gorelova@macc.com.ua','123123');
res($res, 'authorize');
$obj->unAuthorize();

$res = $obj->dic_region_list();
res($res, 'dic_region_list');

$res = $obj->dic_area_list( 2 );
res($res, 'dic_area_list');

$res = $obj->dic_city_list(1);
res($res, 'dic_city_list');
/*
$res = $obj->dic_info_source_list();
res($res, 'dic_info_source_list');

$res = $obj->is_email_exists('gorelova@macc.com.ua');
res($res, 'is_email_exists');

$res = $obj->is_phone_exists('0672223344');
res($res, 'is_phone_exists');

$res = $obj->active_project_list(1);
res($res, 'active_project_list');

$res = $obj->complete_project_list(1);
res($res, 'complete_project_list');

$obj->unAuthorize();
/**/
global $res_count;
$res_count = 0;
function res($res, $a=''){
    global $res_count;
    $res_count++;
    echo '<div class="res_" style="float: left;width: 49%;outline: 1px dashed grey;padding-left:1% "><pre>
<b>'.$a.'</b>('.$res_count.')<br>';
    var_dump($res);
    echo '</pre></div>';
}
