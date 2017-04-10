<?
define('DEBUG_MODE_0', 0);
define('DEBUG_MODE_1', 1);

//error_reporting(E_ALL);

class AccessPanel_Respondent implements AccessPanel_Respondent_Interface{
	var $_ar_errors;
    var $dbRequest;

	var $_ar_address_types = array(
		'region',
		'city'
		//'settlement'
	);

	public static $ar_convertion_types = array(
		'replenishment_mobile' => 1,
		'replenishment_webmoney' => 2,
		'post_order' => 3,
		'project_help' => 4
	);

	function __construct(){
        global $dbRequest;
        $this->dbRequest = $dbRequest;
        if(empty($this->dbRequest)){
            $this->dbRequest = initHttpReq();
        }
	}


	public function Get_Errors()
	{
		return $this->_ar_errors;
	}


	/**
	 * Returns true if Respondent was added successfully
	 *
	 * All fields are obligatory except of phones
	 * (only one of $phone & $phone_cell must be not empty)
	 *
	 * @param string	$last_name, 
	 * @param string	$first_name,
	 * @param bool		$sex,       
	 * @param string	$birth_date, 
	 * @param string	$phone_city,
	 * @param string	$phone_cell,
	 * @param string	$email,     	Must be used as login
	 * @param integer	$district_id,  
	 * @param string	$region,    
	 * @param string	$city,      
	 * @param string	$settlement,
	 * @param string	$street,    
	 * @param string	$house,     
	 * @param string	$flat,
	 * @param string	$cumulative_card_num,
	 * @param string	$reffer_email,	// email of other user which already exists in the system
	 * @param string	$reg_ip,
	 * @param string	$reg_cookie

	 * @return bool
	 */
	public function Add(
		$last_name,
		$first_name,
		$sex,
		$birth_date,
		
		$city_phone_number,
		$cell_phone_number,
		$email,
		
		$district_id,
		$region,
		$city,
		$settlement,
		$street,
		$house,
		$flat,

		$cumulative_card_num,

		$reffer_email,

		$reg_ip,
		$reg_cookie,
        $know_about_us = null,
        $know_about_us_other = null
	)
	{
		return $this->Save(
			null,

			$last_name,
			$first_name,
			$sex,
			$birth_date,

			$city_phone_number,
			$cell_phone_number,
			$email,

			$district_id,
			$region,
			$city,
			$settlement,
			$street,
			$house,
			$flat,

			$cumulative_card_num,

			$reffer_email,

			$reg_ip,
			$reg_cookie,
            $know_about_us,
            $know_about_us_other
		);
	}


	/**
	 * Returns true if Respondent was updated successfully
	 *
	 * All fields are obligatory except of phones
	 * (only one of $phone & $phone_cell must be not empty)
	 *
	 * @param integer	$id
	 * @param string	$last_name, 
	 * @param string	$first_name,
	 * @param bool		$sex,       
	 * @param string	$birth_date, 

	 * @param string	$city_phone_number,
	 * @param string	$cell_phone_number,
	 * @param string	$email     	Must be used as login

	 * @param string	$district_id,  
	 * @param string	$region,    
	 * @param string	$city,      
	 * @param string	$settlement,
	 * @param string	$street,    
	 * @param string	$house,     
	 * @param string	$flat,
	 * @param string	$cumulative_card_num,

	 * @return bool
	 */
	public function Edit(
		$respondent_id,

		$last_name,
		$first_name,
		$sex,
		$birth_date,

		$city_phone_number,
		$cell_phone_number,
		$email,

		$district_id,
		$region,
		$city,
		$settlement,
		$street,
		$house,
		$flat,

		$cumulative_card_num
	)
	{
		return $this->Save(
			$respondent_id,

			$last_name,
			$first_name,
			$sex,
			$birth_date,

			$city_phone_number,
			$cell_phone_number,
			$email,

			$district_id,
			$region,
			$city,
			$settlement,
			$street,
			$house,
			$flat,

			$cumulative_card_num
		);
	}


	private function Save(
		$respondent_id,

		$last_name,
		$first_name,
		$sex,
		$birth_date,

		$city_phone_number,
		$cell_phone_number,
		$email,

		$district_id,
		$region,
		$city,
		$settlement,
		$street,
		$house,
		$flat,

		$cumulative_card_num,

		$reffer_email=null,

		$reg_ip=null,
		$reg_cookie=null,
        $know_about_us = null,
        $know_about_us_other = null
	)
	{
		$res = null;

		foreach ($this->_ar_address_types as $addr_type)
		{
			if (	preg_match("/^[0-9]+$/", $$addr_type) &&
				!$this->Check_Address_Item($$addr_type, $addr_type)
			)
			{
				$this->_ar_errors[] = 'Incorrect '.$addr_type.' value';

				$res = false;
			}
		}

		foreach ($this->_ar_address_types as $addr_type)
		{
			if (empty($$addr_type))
			{
				$this->_ar_errors[] = 'Field '.$addr_type.' is mandatory';

				$res = false;
			}
		}

		if ($res !== false)
		{
			$email = strtolower($email);
			$reffer_email = strtolower($reffer_email);

			$ar_params = array (
				'last_name_'		=> $last_name, 
				'first_name_'		=> $first_name,
				'sex_'			=> $sex,       
				'birth_date_'		=> $birth_date,
				'city_phone_number_'	=> $city_phone_number,
				'cell_phone_number_'	=> $cell_phone_number,
				'email_'		=> $email,     
				'district_id_'		=> $district_id,  
				'region_'		=> $region,    
				'city_'			=> $city,      
				'settlement_'		=> $settlement,
				'street_'		=> $street,    
				'house_'		=> $house,     
				'flat_'			=> $flat
			);

			if (is_null($respondent_id))	// ->Add()
			{
				$oracle_sp_name = 'ins_respondent';
				$ar_params = array_merge($ar_params, array('referer_email_' => $reffer_email));
				$ar_params = array_merge($ar_params, array('reg_ip_' => $reg_ip, 'reg_cookie_' => $reg_cookie));
			}
			else				// ->Edit()
			{
				$oracle_sp_name = 'mod_respondent';
				$ar_params = array_merge(array('respondent_id_' => $respondent_id), $ar_params);
			}

			$ar_params = array_merge($ar_params, array('cumulative_card_num_' => $cumulative_card_num));
            $ar_params = array_merge($ar_params, array('dic_know_about_us_id_' => $know_about_us, 'dic_know_about_us_other_' => $know_about_us_other));
			$ar_params = array_merge(array('is_complete_' => 0), $ar_params);

			$res = $this->_oci->sp('b36_director.access_package.'.$oracle_sp_name, $ar_params, 1);


			if ($res)
			{
				$res = $ar_params['is_complete_'];
			}
			else
			{
				$this->_ar_errors[] = $this->_oci->_error_message;
			}
		}

		return $res;
	}

	/**
	 * Returns true if Respondent was deleted successfully
	 *
	 * @param integer	$id

	 * @return bool
	 */
	public function Delete(
		$id,
		$check = true
	)
	{
		$ar_params = array (
			'respondent_id_'	=> $id,
			'is_complete_'		=> 0
		);

		$res = $this->_oci->sp('b36_director.access_package.del_respondent'.( $check ? '' : '_no_check' ), $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['is_complete_'];
		}

		return $res;
	}

	/**
	 * If Respondent with such id exists returns all info as associative array,
	 * otherwise returns false.
	 *

	 * @param integer	$id

	 * @return array|bool
	 */
	public function Get_Info($id){

        $res = $this -> dbRequest -> get_respondent_info($id);
        $res = array (
            'respondent_id_'		=> $id,
            'last_name_'			=> $res['last_name'],
            'first_name_'			=> $res['first_name'],
            'sex_'				=> $res['sex'],
            'birth_date_'			=> $res['birth_date'],
            'cell_phone_number_'		=> $res['cell_phone_number'],
            'email_'			=> $res['email'],
            'district_id_'			=> $res['district_id'],
            'district_'			=> $res['district_id'],
            'region_'			=> $res['region'],
            'city_'				=> $res['city'],
            'parent_respondent_id_'		=> $res['parent_respondent_id']
            //'cumulative_card_num_'		=> $res['urlid']
        );
		return $res;
	}

	/**
	 *
	 * If Respondent with such email exists returns all info as associative array,
	 * otherwise returns false.
	 *

	 * @param string	$email			Must be used as login

	 * @return array|bool
	 */
	public function Get_Info_By_Email($email){
		$email = strtolower($email);
        $res = $this -> dbRequest -> get_respondent_info(null, $email);
        $res = array (
            'email_'			=> $email,
            'respondent_id_'		=> $res['onl_respondent_id'],
            'last_name_'			=> $res['last_name'],
            'first_name_'			=> $res['first_name'],
            'sex_'				=> $res['sex'],
            'birth_date_'			=> $res['birth_date'],
            'cell_phone_number_'		=> $res['cell_phone_number'],
            'district_id_'			=> $res['district_id'],
            'district_'			=> $res['district_id'],
            'region_'			=> $res['region'],
            'city_'				=> $res['city'],
            'parent_respondent_id_'		=> $res['parent_respondent_id']
        );

		return $res;
	}

	/**
	 *
	 * Returns true if Respondent with such email and such password exists,
	 * otherwise returns false.
	 *

	 * @param string	$email			Must be used as login
	 * @param string	$passw

	 * @return bool
	 */
	public function Authorize(
		$email,
		$passw,
        $plugin_id = null,
        $cookie = null
	)
	{
		$email = strtolower($email);
    if(!empty($this->dbRequest)){
        $res = $this->dbRequest ->authorize($email, $passw, $plugin_id, $cookie);
    }
		return $res;
	}

	/**
	 * Gets hash code for existed Respondent by email.
	 * Returns hash code if Respondent with passed email exists in DB. Otherwise returns false.
	 *
	 * @param string	$email

	 * @return string|bool
	 */
	public function Reset_Password_Get_Hash_Code($email){
		$email = strtolower($email);

        $res = $this -> dbRequest -> pwd_request_ins($email);
		return $res;
	}

	/**
	 * Returns all info related to request
	 *
	 * @param string	$hash_code

	 * @return array|bool
	 */
	public function Get_Request_Info($hash_code){
        $res = $this -> dbRequest -> pwd_request_get_info($hash_code);
        if($res['is_exists']){
            $res['ap_respondent_id_'] = $res['onl_respondent_id'];
            return $res;
        } else return false;
	}

	/**
	 * Checks hash code. Will be used when Respondent clicks on url (in received email) with hashcode as param of the url.
	 * Returns true if such hash code is registered in DB (it means that system is ready to obtain new password from Respondent).
	 *
	 * @param string	$hash_code

	 * @return bool
	 */
	public function Reset_Password_Check_Hash_Code($hash_code){
        $res = $this -> dbRequest -> pwd_request_check($hash_code);
		return $res;
	}

	/**
	 * Sets new password for Respondent if appropriate hash code is registered in the DB.
	 * Returns true if such hash code was registered in DB and password was updated successfully.
	 *
	 * @param string	$hash_code
	 * @param string	$new_password

	 * @return bool

	 * @see Reset_Password_Check_Hash_Code
	 */
	public function Reset_Password($hash_code, $new_password ){
		// if appropriate request exists and it is active
		if ($res = $this->Reset_Password_Check_Hash_Code($hash_code)){

            $res = $this -> dbRequest -> pwd_request_change_pass($hash_code, $new_password);
            if($res['response_code'] == '000')
                return true;
		}
        return false;

	}

	/**
	 * Activates respondent
	 * Returns true if respondent is activated successfully or was activated before
	 * Otherwise returns false
	 *
	 * @param string	$respondent_id

	 * @return bool
	 */
	public function Activate($respondent_id	){

        //$dbRequest = initHttpReq();
        $res = $this->dbRequest -> activate_respondent($respondent_id);

		return $res;
	}


	public function Project_Complete($project_code, $respondent_code, $complete_type=1){
        $res = $this->dbRequest -> complete_respondent_project($project_code.$respondent_code, $complete_type);
        $res = $res['result'];

		return $res;
	}
    public function Project_Complete_By_URL_ID($url_id, $complete_type=1 ){//нипо
        $res = $this->dbRequest -> complete_respondent_project($url_id, $complete_type);
        if($res['result']>0)
            $res = -2;//error
        else $res =  $res['point'];

        return $res;
    }

	public function Password_Update($email, $new_password){
		$email = strtolower($email);
		$res = false;

		if ($hash_code = $this->Reset_Password_Get_Hash_Code($email)){
			$res = $this->Reset_Password($hash_code, $new_password);
		}

		return $res;
	}


	public function Check_If_Email_Exists($email){
        //die('EMAIL CHECK  in Respondent.php');
		$email = strtolower($email);
        $res = $this->dbRequest ->is_email_exists($email);

		return $res;
	}

	/**
	 * Checks if email is in black list or not
	 * Returns true or false
	 *
	 * @param string	$email

	 * @return int
	 */
	public function set_resp_declined($resp_id){
        $res = $this-> dbRequest ->  set_respodent_decline_status($resp_id, 1);

		return $res;
	}


	/**
	 * Add points convertion request
	 * Returns true if request was added successfully, false otherwise
	 *
	 * @param integer	$respondent_id		respondent's id
	 * @param integer	$points_number		points number to convert
	 * @param integer	$convertion_type	type of request (1 - , 2 - , 3 - ) ��� �����������(���� �� ���� - ���������, �������, �������� �������)
	 * @param string	$purpose		���������� (���� ���������� ����� ��������, ��� �������� ������� ��� ����� ��������� ����� ����� ������� ����� �������)

	 * @return bool
	 */
	public function Add_Points_Convertion_Request($respondent_id, $points_number, $convertion_type, $purpose){
        $ar_convertion_types = self::$ar_convertion_types;

		if (!array_key_exists($convertion_type, $ar_convertion_types)){
			trigger_error('Incorrect points convertion type: '.$convertion_type);
            return false;
		} else {
			if ('project_help' == $convertion_type){
				$purpose = '';
			}

            $res = $this->dbRequest ->convertion_score_ins($respondent_id, $points_number, $ar_convertion_types[$convertion_type], $purpose);
            res($res,'$res - convertion_score_ins');
            return (bool)$res;
		}
	}

	public function is_phone_available($phone){
        $res = !($this->dbRequest ->is_email_exists($phone));//is_available == not exist
		return $res;
	}

	/**
	 * Gets minimal points for convertion value
	 * Returns integer if convertion type is known, false otherwise
	 *
	 * @param integer	$convertion_type	type of request (post_order, replenishment_mobile, replenishment_webmoney) ��� �����������(���� �� ���� - ���������, �������, �������� �������)

	 * @return integer|false
	 */
	public function Get_Min_Points_For_Convertion( $convertion_type ){
        $ar_convertion_types = self::$ar_convertion_types;
        $res = $this->dbRequest ->get_min_convertion_score($ar_convertion_types[$convertion_type]);
		return $res;
	}

	public function get_respondent_survey( $ap_respondent_id, $cookie, $plid = null ){
        $dbRequest = initHttpReq();
        $res = $dbRequest -> get_respondent_mini_survey($ap_respondent_id, $plid);
         return $res;
	}

	public function set_adv_block_status($is_counter_block, $is_adv_block, $resp_id, $cookie, $plid_id){
		$dbRequest = initHttpReq();
		$res = $dbRequest -> set_adv_block_status($is_counter_block, $is_adv_block, $resp_id, $cookie, $plid_id);
		return $res;
	}
	/*
  -------------------------------------------------------------------------
  -- �������� ����� ������ �����������
  -------------------------------------------------------------------------
  procedure complete_respondent_survey(
    onl_respondent_id_ number,
    survey_id_ number,
    complete_type_ number,
    cookie_ contact.cookie%type
  ); 
	 */
	public function complete_respondent_survey( $ap_respondent_id, $ct = 1, $cookie = null){
        $res = $this -> dbRequest-> complete_respondent_mini_survey($ap_respondent_id, 3, $ct, $cookie);
        return $res;
	}

    public function plugin_package_link_plugin_id($respondent_id, $plugin_id, $cookie = ''){
        return $this-> dbRequest -> plugin_link($respondent_id, $plugin_id, $cookie);
    }
}

