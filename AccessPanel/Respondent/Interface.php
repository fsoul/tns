<?

interface AccessPanel_Respondent_Interface
{
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
	);


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
	);

	/**
	 * Returns true if Respondent was deleted successfully
	 *
	 * @param integer	$id

	 * @return bool
	 */
	public function Delete(
		$id
	);

	/**
	 * If Respondent with such id exists returns all info as associative array,
	 * otherwise returns false.
	 *

	 * @param integer	$id

	 * @return array|bool
	 */
	public function Get_Info(
		$id
	);

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
	);

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
	);

	/**
	 * Gets hash code for existed Respondent by email.
	 * Returns hash code if Respondent with passed email exists in DB. Otherwise returns false.
	 *
	 * @param string	$email

	 * @return string|bool
	 */
	public function Reset_Password_Get_Hash_Code(
		$email
	);

	/**
	 * Checks hash code. Will be used when Respondent clicks on url (in received email) with hashcode as param of the url.
	 * Returns true if such hash code is registered in DB (it means that system is ready to obtain new password from Respondent).
	 *
	 * @param string	$hash_code

	 * @return bool
	 */
	public function Reset_Password_Check_Hash_Code(
		$hash_code
	);

	/**
	 * Sets new password for Respondent if appropriate hash code is registered in the DB.
	 * Returns true if such hash code was registered in DB and password was updated successfully.
	 *
	 * @param string	$hash_code
	 * @param string	$new_password

	 * @return bool
	 */
	public function Reset_Password(
		$hash_code,
		$new_password
	);


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
	);


	public function Project_Complete(
		$project_code,
		$respondent_code,
		$complete_type=1
	);


	public function Password_Update(
		$email,
		$new_password
	);


	public function Check_If_Email_Exists(
		$email
	);


	/**
	 * Add points convertion request
	 * Returns true if request was added successfully, false otherwise
	 *
	 * @param integer	$respondent_id		respondent's id
	 * @param integer	$points_number		points number to convert
	 * @param integer	$convertion_type	type of request (post_order, replenishment_mobile, replenishment_webmoney) ��� �������樨(���� �� ��� - �������, �������, ���⮢� ��ॢ��)
	 * @param string	$purpose		�����祭�� (� �����뢠�� ����� ⥫�䮭�, ��� ��襫쪠 ������� ��� ���� ����뫪� ����� ����� ��ப�� �१ �������)

	 * @return bool
	 */
	public function Add_Points_Convertion_Request(
		$respondent_id,
		$points_number,
		$convertion_type,
		$purpose
	);

	/**
	 * Gets minimal points for convertion value
	 * Returns integer if convertion type is known, false otherwise
	 *
	 * @param integer	$convertion_type	type of request (post_order, replenishment_mobile, replenishment_webmoney) ��� �������樨(���� �� ��� - �������, �������, ���⮢� ��ॢ��)

	 * @return integer|false
	 */
	public function Get_Min_Points_For_Convertion(
		$convertion_type
	);

}
