<?
	$admin = true;
	$UserRole=0;
	$modul='total_report';
//********************************************************************
	require_once('../lib.php');
	require_once('statistic_function.php');
	require_once('total_report_headers.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
//********************************************************************
if(empty($aReportDate) ) $aReportDate = date('Y-m-d');
///********************************************************************
	
	function SetReportPeriodName($var)
	{
		global $$var, $periods;
		return $periods[$$var];
	}
	function SetReportPeriod()
	{
		global $aPeriodSelect, $periods;
		$s = '';
		while(list($key, $value) = each($periods))
		{
			$s .= '<option ';
			if($aPeriodSelect == $key) $s .= ' selected ';
			$s .= ' value="'.$key.'">'.$value.'</option>';
		}
		return $s;
	}

	function block_filters()
	{
		$user_filter = array('sessions'=>'Sessions', 'user_paths'=>'Users Paths', 'bypages'=>'By Pages'
								, 'users_entry'=>'Entry Points', 'user_exit' => 'Exit Pages', 'user_ref'=>'References');

		$engines_filter = array('eng_sessions'=>'Sessions', 'eng_bypages'=>'By Pages'
								, 'eng_entry'=>'Entry Points', 'eng_exit' => 'Exit Pages', 'eng_ref'=>'References');
		$s .= '<tr><td colspan="4"><table width="90%" align="center" ><tr><td valign="top"><table width="100%">';
		$s .= '<tr><td class="table_header" width="110px">Web Users</td><td colspan="3"><input type="checkbox" checked onClick="check(this, Array(\'sessions\', \'user_paths\', \'bypages\', \'users_entry\', \'user_exit\', \'user_ref\'))"></td></tr>';
		while(list($key, $value) = each($user_filter))
		{
			$s .= '<tr ><td width="110px"><dd><nobr>'.$value.'</nobr></td><td colspan="3"><input checked type="checkbox" name="reports['.$key.']" ></td></tr>';
		}
		$s .= '</table></td><td valign="top"><table wodth="100%">';
		$s .= '<tr ><td class="table_header" width="110px">Engines</td><td colspan="3"><input type="checkbox" checked onClick="check(this, Array(\'eng_sessions\', \'eng_bypages\', \'eng_entry\', \'eng_exit\', \'eng_ref\'))"></td></tr>';
		while(list($key, $value) = each($engines_filter))
		{
			$s .= '<tr ><td width="110px"><dd><nobr>'.$value.'</nobr></td><td colspan="3"><input checked type="checkbox" name="reports['.$key.']" ></td></tr>';
		}
		$s .= '</table></td></tr></table></td></tr>';
		return $s;
	}
	if(isset($_POST['build']) && is_array($_POST['reports'])){
		prepareFilterDate();
		echo parse($modul.'/report');
	}else{
		echo parse($modul.'/list');
	}


?>