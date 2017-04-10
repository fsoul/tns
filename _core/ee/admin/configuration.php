<?
	$modul='configuration';
//********************************************************************
	require_once('../lib.php');
	require_once('statistic_function.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
//********************************************************************
if(empty($aReportDate) ) $aReportDate = date('Y-m-d');
if(empty($act)) $act = 'filters';
///********************************************************************
	function ReportNameCongig()
	{
		global $act;
		$reports = array('filters' => 'Filters', 'filter_edit' => 'Filters', 'search_edit'=>'Edit search engine',  'agent_edit'=>'Edit user agent',  'user_agents' => 'User Agents', 'searches' => 'Search Engines');
		return $reports[$act];
	}
	
	function configuration_content()
	{
		global $act;

		switch($act)
		{
			case 'filters' : $s = FilterBlock();
				break;
			case 'filter_edit' : $s = FilterEdit();
				break;
			case 'user_agents' : $s = UserAgents(1);
				break;
			case 'searches' : $s = UserAgents(0);
				break;
			case 'agent_edit' : $s = UserAgentsEdit(1);
				break;
			case 'search_edit' : $s = UserAgentsEdit(0);
				break;
			default: $s = FilterBlock();
		}
		return $s;
	}
	echo parse($modul.'/list');
?>