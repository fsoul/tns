<?

define('DEBUG_MODE_0', 0);
define('DEBUG_MODE_1', 1);

class AccessPanel_Respondent implements AccessPanel_Respondent_Interface
{
	var $_oci;

	var $_ar_errors;

	var $_ar_address_types = array(
		'region',
		'city',
		'settlement'
	);

	public static $ar_convertion_types = array(
		'replenishment_mobile' => 1,
		'replenishment_webmoney' => 2,
		'post_order' => 3,
		'project_help' => 4 // �������� ������� "������ ������� �i���"
	);

	function __construct($oci)
	{
		if ($oci instanceof AccessPanel_DB_Oracle) 
		{
			$this->_oci = $oci;
			$this->_ar_errors = array();
		}
		else
		{
			$this->_ar_errors[] = 'Incorrect Database provider: '.print_r($oci, true);
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
		$reg_cookie
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
			$reg_cookie
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
		$reg_cookie=null
	)
	{
		$res = null;

		foreach ($this->_ar_address_types as $addr_type)
		{
			if (	ereg("^[0-9]+$", $$addr_type) &&
				!$this->Check_Address_Item($$addr_type, $addr_type)
			)
			{
				$this->_ar_errors[] = 'Incorrect '.$addr_type.' value';

				$res = false;
			}
		}

		foreach (array_merge($this->_ar_address_types, array('street')) as $addr_type)
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

				$ar_params = array_merge($ar_params, array('reffer_email' => $reffer_email));
				$ar_params = array_merge($ar_params, array('reg_ip_' => $reg_ip, 'reg_cookie_' => $reg_cookie));
			}
			else				// ->Edit()
			{
				$oracle_sp_name = 'mod_respondent';

				$ar_params = array_merge(array('respondent_id_' => $respondent_id), $ar_params);
			}

			$ar_params = array_merge($ar_params, array('cumulative_card_num_' => $cumulative_card_num));

			$ar_params = array_merge(array('is_complete_' => 0), $ar_params);
				
			$res = $this->_oci->sp('access_panel.access_package.'.$oracle_sp_name, $ar_params, 1);


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

		$res = $this->_oci->sp('access_panel.access_package.del_respondent'.( $check ? '' : '_no_check' ), $ar_params, DEBUG_MODE_0);

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
	public function Get_Info(
		$id
	)
	{
		$ar_params = array (
			'respondent_id_'		=> $id,
			'last_name_'			=> '',
			'first_name_'			=> '',
			'sex_'				=> '',
			'birth_date_'			=> '',
			'city_phone_number_'		=> '',
			'cell_phone_number_'		=> '',
			'email_'			=> '',
			'district_id_'			=> '',
			'region_'			=> '',
			'city_'				=> '',
			'settlement_'			=> '',
			'street_'			=> '',
			'house_'			=> '',
			'flat_'				=> '',
			'parent_respondent_id_'		=> '',
			'parent_respondent_email_'	=> '',
			'cumulative_card_num_'		=> ''
		);

		$res = $this->_oci->sp('access_panel.access_package.get_respondent_info_by_id', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$ar_params['district_'] = $ar_params['district_id_'];
			$res = $ar_params;
		}

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
	public function Get_Info_By_Email(
		$email
	)
	{
		$email = strtolower($email);

		$ar_params = array (
			'email_'			=> $email,
			'respondent_id_'		=> '',
			'last_name_'			=> '',
			'first_name_'			=> '',
			'sex_'				=> '',
			'birth_date_'			=> '',
			'city_phone_number_'		=> '',
			'cell_phone_number_'		=> '',
			'district_id_'			=> '',
			'region_'			=> '',
			'city_'				=> '',
			'settlement_'			=> '',
			'street_'			=> '',
			'house_'			=> '',
			'flat_'				=> '',
			'parent_respondent_id_'		=> '',
			'parent_respondent_email_'	=> '',
			'cumulative_card_num_'		=> ''
		);

		$res = $this->_oci->sp('access_panel.access_package.get_respondent_info_by_email', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$ar_params['district_'] = $ar_params['district_id_'];
			$res = $ar_params;
		}

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
		$passw
	)
	{
		$email = strtolower($email);

		$ar_params = array (
			'email_'	=> $this->_oci->spValue($email),
			'pass_'		=> $this->_oci->spValue($passw),
			'is_complete_'	=> 0
		);

		$res = $this->_oci->sp('access_panel.access_package.authorize', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['is_complete_'];
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
	public function Reset_Password_Get_Hash_Code(
		$email
	)
	{
		$email = strtolower($email);

		$ar_params = array (
			'email_'	=> $email,
			'request_id_'	=> ''
		);

		$res = $this->_oci->sp('access_panel.access_package.ins_pass_change_request', $ar_params, 0);

		if ($res)
		{
			$res = $ar_params['request_id_'];
		}

		return $res;
	}

	/**
	 * Returns all info related to request
	 *
	 * @param string	$hash_code

	 * @return array|bool
	 */
	public function Get_Request_Info(
		$hash_code
	)
	{
		$ar_params = array (
			'request_id_'		=> $hash_code,
			'request_date_'		=> '',
			'ap_respondent_id_'	=> '',
			'status_'		=> '',
			'is_exists_'		=> null
		);

		$res = $this->_oci->sp('access_panel.access_package.get_pass_change_request_info', $ar_params, DEBUG_MODE_0);

		if (	$res &&
			$ar_params['is_exists_'] == 1
		)
		{
			$res = $ar_params;
		}
		else
		{
			$res = false;
		}

		return $res;
	}

	/**
	 * Checks hash code. Will be used when Respondent clicks on url (in received email) with hashcode as param of the url.
	 * Returns true if such hash code is registered in DB (it means that system is ready to obtain new password from Respondent).
	 *
	 * @param string	$hash_code

	 * @return bool
	 */
	public function Reset_Password_Check_Hash_Code(
		$hash_code
	)
	{
		$ar_params = array (
			'request_id_'	=> $hash_code,
			'is_active_'	=> 0
		);

		$res = $this->_oci->sp('access_panel.access_package.check_pass_change_request', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['is_active_'];
		}

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
	public function Reset_Password(
		$hash_code,
		$new_password
	)
	{
		// if appropriate request exists and it is active
		if ($res = $this->Reset_Password_Check_Hash_Code($hash_code))
		{
			$ar_params = array (
				'request_id_'	=> $hash_code,
				'new_pass_'	=> $new_password,
				'is_complete_'	=> 0
			);

			$res = $this->_oci->sp('access_panel.access_package.change_pass', $ar_params, DEBUG_MODE_0);

			if ($res)
			{
				$res = $ar_params['is_complete_'];
			}
		}

		return $res;
	}

	/**
	 * Activates respondent
	 * Returns true if respondent is activated successfully or was activated before
	 * Otherwise returns false
	 *
	 * @param string	$respondent_id

	 * @return bool
	 */
	public function Activate(
		$respondent_id
	)
	{
		$ar_params = array (
			'respondent_id_'	=> $respondent_id,
			'result_'		=> 0
		);


		/*
		��������� ��� ��������� ������������:
		access_package.activate_respondent
		���������:
		  respondent_id_ - id �����������
		  result_ - �����. 0 - ��� ������. 1 - ���������� ��� �����������, 2 - ��� ������ ����������� 
		 */

		$res = $this->_oci->sp('access_panel.access_package.activate_respondent', $ar_params, DEBUG_MODE_0);

		if (	$res &&
			in_array($ar_params['result_'], array(0, 1))
		)
		{
			$res = true;
		}
		else
		{
			$res = false;
		}

		return $res;
	}


	public function Project_Complete(
		$project_code,
		$respondent_code,
		$complete_type=1
	)
	{
		$ar_params = array (
			'project_code_'		=> $project_code,
			'respondent_code_'	=> $respondent_code,
			'complete_type_'	=> $complete_type,
			'is_complete_'		=> null
		);

		$res = $this->_oci->sp('access_panel.access_package.complete_respondent_project', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['is_complete_'];
		}

		return $res;
	}


	public function Password_Update(
		$email,
		$new_password
	)
	{
		$email = strtolower($email);

		$res = false;

		if ($hash_code = $this->Reset_Password_Get_Hash_Code($email))
		{		
			$res = $this->Reset_Password($hash_code, $new_password);
		}

		return $res;
	}


	public function Check_If_Email_Exists(
		$email
	)
	{
		$email = strtolower($email);

		$ar_params = array (
			'email_'		=> $email,
			'is_exists_'		=> null
		);

		$res = $this->_oci->sp('access_panel.access_package.is_email_exists', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['is_exists_'];
		}

		return $res;
	}


	/**
	 * Checks if email is in black list or not
	 * Returns true or false
	 *
	 * @param string	$email

	 * @return bool
	 */
	public function Baned(
		$email
	)
	{
		$email = strtolower($email);

		$ar_params = array (
			'email_'	=> $email,
			'is_baned_'	=> null
		);

		$res = $this->_oci->sp('access_panel.access_package.is_email_baned', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['is_baned_'];
		}

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
	public function Add_Points_Convertion_Request(
		$respondent_id,
		$points_number,
		$convertion_type,
		$purpose
	)
	{
/*
��������� ��� ���������� ������ �� ������ - 

  access_package.ins_point_w_off_request(ap_respondent_id_ => :ap_respondent_id_,
                                       point_num_ => :point_num_,
                                       write_off_type_id_ => :write_off_type_id_,
                                       purpose_ => :purpose_,
                                  write_off_request_id_ =>:write_off_request_id_);
write_off_request_id_ - out ��������. � ���� ������������ id ��������� ������.
*/
		$ar_convertion_types = self::$ar_convertion_types;

		if (!array_key_exists($convertion_type, $ar_convertion_types))
		{
			trigger_error('Incorrect points convertion type: '.$convertion_type);

			$res = false;
		}
		else
		{
			if ('project_help' == $convertion_type)
			{
				$purpose = '';
			}

			$ar_params = array (
				'ap_respondent_id_'	=> $respondent_id,
				'point_num_'		=> $points_number,
				'write_off_type_id_'	=> $ar_convertion_types[$convertion_type],
				'purpose_'		=> $purpose,
				'write_off_request_id_'	=> null
			);

			$res = $this->_oci->sp('access_panel.access_package.ins_point_w_off_request', $ar_params, DEBUG_MODE_0);

			if ($res)
			{
				$res = (bool) $ar_params['write_off_request_id_'];
			}
		}

		return $res;
		
	}



	/**
	 * Check if respondent with such home/cell phone exists in DB
	 * Returns respondent's id if such phone already registered, false otherwise
	 *
	 * @param integer	$phone_number_		home or cell phone

	 * @return integer	$respondent_id_		respondent id or false if phone is not registered
	 */
	public function Get_Respondent_Id_By_Phone(
		$phone
	)
	{
		$ar_params = array (
			'phone_number_'		=> $phone,
			'respondent_id_'	=> null
		);

		$res = $this->_oci->sp('access_panel.access_package.get_respondent_id_by_phone', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			if ($ar_params['respondent_id_'] == '-1')
			{
				$res = false;
			}
			else
			{
				$res = $ar_params['respondent_id_'];
			}
		}

		return $res;
	}


	public function Check_Address_Item(
		$id,
		$type
	)
	{
		$id = (int)$id;

		if (!in_array($type, $this->_ar_address_types))
		{
			trigger_error('Incorrect address type is provided: '.$type, E_USER_ERROR);

			return false;
		}

		$ar_params = array(
			$type.'_id_'	=> $id,
			'result_'	=> 0
		);

		$res = $this->_oci->sp('access_panel.access_package.is_'.$type.'_exists', $ar_params, DEBUG_MODE_0);

		if ($res)
		{
			$res = $ar_params['result_'];
		}

		return $res;
	}


	public function Check_Region(
		$id
	)
	{
		return $this->Check_Address_Item($id, 'region');
	}


	public function Check_City(
		$id
	)
	{
		return $this->Check_Address_Item($id, 'city');
	}


	public function Check_Settlement(
		$id
	)
	{
		return $this->Check_Address_Item($id, 'settlement');
	}


	/**
	 * Gets minimal points for convertion value
	 * Returns integer if convertion type is known, false otherwise
	 *
	 * @param integer	$convertion_type	type of request (post_order, replenishment_mobile, replenishment_webmoney) ��� �����������(���� �� ���� - ���������, �������, �������� �������)

	 * @return integer|false
	 */
	public function Get_Min_Points_For_Convertion(
		$convertion_type
	)
	{
		$ar_convertion_types = self::$ar_convertion_types;

		if (!array_key_exists($convertion_type, $ar_convertion_types))
		{
			trigger_error('Incorrect points convertion type: '.$convertion_type);

			$res = false;
		}
		else
		{

/*
�������� ��������� 
get_min_convert_point_count(
 convert_type_number_ number,
 min_convert_point_count_ out number
),
���
 convert_type_number_
 - ��� �����������
( 1 - ���������, 2 - webmoney, 3 - �������� ��������� ),
 min_convert_point_count_ - ����������� ���������� ������ ��� �����������
*/
			$ar_params = array (
				'convert_type_number_'		=> $ar_convertion_types[$convertion_type],
				'min_convert_point_count_'	=> null
			);
//var_dump($ar_params);
			$res = $this->_oci->sp('access_panel.access_package.get_min_convert_point_count', $ar_params, DEBUG_MODE_0);
//var_dump($res);
			if ($res)
			{
				$res = $ar_params['min_convert_point_count_'];
			}
		}

		return $res;
	}
	
	/*
��������\������������ ������� ������������ ��� ����

  procedure add_user_location(
    ap_respondent_id_ number,
    cookie_ varchar2,
    dic_answers_id_ number
  );
	 */
	public function save_answer( $ap_respondent_id, $cookie, $resp_placement, $who_use_resp_machine )
 {
    $ar_params = array (
        'ap_respondent_id_'		=> $ap_respondent_id,
        'cookie_'	=> $cookie,
        'resp_placement_'	=> $resp_placement,
        'who_use_resp_machine_' => $who_use_resp_machine,
        'result_' => null 
    );
    $res = $this->_oci->sp('access_panel.access_package.add_answer', $ar_params, DEBUG_MODE_0);
    if( $res ){
        $res = $ar_params['result_'];
    }
    return $res;
 }
}

