<?
	include("../geo/geoip.inc");
	require('../define_constants.php');

	$periods = array('day'=>'Day', 'week'=>'Week', 'week2'=>'2 Weeks', 'month'=>'1 Month');
	setDate();
	function setDate()
	{
		$configs = array('aStartDate', 'aEndDate', 'engine_browsers', 'aUserIP', 'user_browsers', 'user_type');

		set_session_name(EE_HTTP_PREFIX);
		session_start();

		if($GLOBALS['REQUEST_METHOD'] == 'POST'){
			while(list(, $val) = each($configs)){
				if(isset($_POST[$val])){
					session_register($val);
					$GLOBALS[$val] = $_POST[$val];
					$_SESSION[$val] = $_POST[$val];
				}
			}
		}else{
			while(list(, $val) = each($configs)){
				if(isset($_SESSION[$val])){
					$GLOBALS[$val] = $_SESSION[$val];
				}
			}
		}
	}
	function getCountries($ips)
	{
		$gi = geoip_open("../geo/GeoIP.dat",GEOIP_STANDARD);
		while(list(, $ip) = each($ips)){
			$countries[$ip] = geoip_country_name_by_addr($gi, $ip);
		}
		geoip_close($gi);
		return $countries;
	}
	function parseIP2Country()
	{
		$gi = geoip_open("../geo/GeoIP.dat",GEOIP_STANDARD);
		$sql = 'select distinct ip from stat_rep_sessions where country = ""';
		$rs = db_sql_query($sql);
		while(list($ip) = db_sql_fetch_array($rs) )
		{
			$country = geoip_country_name_by_addr($gi, $ip);
			if(strlen($country) == 0) $country = "Unknown";
			$sql_update = 'update stat_rep_sessions set country = "'.$country.'" where ip = "'.$ip.'"';
			db_sql_query($sql_update);
		}
		geoip_close($gi);
	}

#### BLOCK SUMMARY
		
	function summary_content()
	{
		global $aReportDate;
		$rows = array('line1'=>'Web Users'
						, 'visitors'=>'Visitors'
						, 'hits'=>'Pages(hits)'
						, 'hosts'=>'Hosts'
						, 'unique'=>'Unique pages'
						, 'coverage'=>'Coverage'
						, 'line2'=>'Search Engines'
						, 'robots'=>'Engines'
						, 'robots_type'=>'Types Engines'
						, 'robots_hits'=>'Pages indexed'
						, 'robots_unique'=>'Unique pages'
						, 'robots_coverage'=>'Coverage'
						);

		$date = split('-', $aReportDate);
		$timeNow = mktime(0, 0, 0, $date[1], $date[2], $date[0]);

		$Period['day'] = createPeriodArray($timeNow, 1);
		$Period['week'] = createPeriodArray($timeNow, 7);
		$Period['month'] = createPeriodArray($timeNow, 30);

		$s = '<br><table border="1" style="border-style:none" cellspacing = "0" cellpadding="3"><tr ><td class="noneBorder">&nbsp;</td>';
		$s .= '<td class="dottedBorderTitle">Today</td><td class="dottedBorderTitle">Yesterday</td><td colspan="2" class="dottedBorderTitle">Comparison</td>';
		$s .= '<td class="dottedBorderTitle">Last 7 days</td><td class="dottedBorderTitle">7 days before</td><td colspan="2" class="dottedBorderTitle">Comparison</td>';
		$s .= '<td class="dottedBorderTitle">Last 30 days</td><td class="dottedBorderTitle">30 day before</td><td colspan="2" class="dottedBorderTitle">Comparison</td>';
		$s .= '</tr>';
		while(list($key, $title) = each($rows))
		{
			if($key == 'line1' || $key == 'line2')
			{
				$s .= '<tr><td colspan="13">'.$title.'</td></tr>';
				continue;
			}
			$s .= '<tr>';
			reset($Period);
//			$s .= '<td class="noneBorder" align="right">'.$title.'</td>';
			$s .= '<td class="noneBorder" align="right">'.$key.'</td>';
			while(list(, $period) = each($Period))
			{
				$color = $period['comp'][$key]['color'];
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['current'][$key.'_link'].'&nbsp;</td>';
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['prev'][$key.'_link'].'&nbsp;</td>';
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['comp'][$key]['count'].'&nbsp;</td>';
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['comp'][$key]['arrears'].'&nbsp;</td>';
			}
			$s .= '</tr>';
		}
		$s .= '</table>';

		return $s;
	}
	
	function summary_content_report()
	{
		global $aReportDate, $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $aPeriodSelect, $hideUnvisited, $periods;

		$rows = array('line1'=>'Web Users', 'visitors'=>'Visitors', 'hits'=>'Pages(hits)', 'hosts'=>'Hosts', 'line2'=>'Search Engines', 'robots'=>'Engines', 'robots_type'=>'Types Engines', 'robots_hits'=>'Pages indexed');
		$date = split('-', $aEndDate);
		$timeNow = mktime(0, 0, 0, $date[1], $date[2], $date[0]);
		$dateStart = split('-', $aStartDate);
		$timeStart = mktime(0, 0, 0, $dateStart[1], $dateStart[2], $dateStart[0]);

		$Period['day'] = createPeriodArray_report($timeNow, $timeStart);

		$s = '<br><table border="1" style="border-style:none" cellspacing = "0" cellpadding="3"><tr ><td class="noneBorder">&nbsp;</td>';
		$s .= '<td class="dottedBorderTitle">'.$periods[$aPeriodSelect].'</td><td class="dottedBorderTitle">'.$periods[$aPeriodSelect].' before</td><td colspan="2" class="dottedBorderTitle">Comparison</td>';
		$s .= '</tr>';
		while(list($key, $title) = each($rows))
		{
			if($key == 'line1' || $key == 'line2')
			{
				$s .= '<tr><td colspan="13">'.$title.'</td></tr>';
				continue;
			}
			$s .= '<tr>';
			reset($Period);
			$s .= '<td class="noneBorder" align="right">'.$title.'</td>';
			while(list(, $period) = each($Period))
			{
				$color = $period['comp'][$key]['color'];
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['current'][$key.'_link'].'&nbsp;</td>';
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['prev'][$key.'_link'].'&nbsp;</td>';
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['comp'][$key]['count'].'&nbsp;</td>';
				$s .= '<td class="dottedBorder" bgcolor="'.$color.'" align="right">'.$period['comp'][$key]['arrears'].'&nbsp;</td>';
			}
			$s .= '</tr>';
		}
		$s .= '</table>';

		return $s;
	}


	function createPeriodArray($timeNow, $period)
	{
		$nowEnd = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow), date('Y', $timeNow) ) ) ;
		$nowStart = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow) - ($period - 1), date('Y', $timeNow) ) ) ;

//		print 'now ['.$nowStart.' = '.$nowEnd.']';
		$dayNow = get_stat_for_period($nowStart, $nowEnd);

		$prevEnd = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow) - $period , date('Y', $timeNow) ) ) ;
		$prevStart = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow) - (2*$period - 1) , date('Y', $timeNow) ) ) ;

//		print 'prev ['.$prevStart.' = '.$prevEnd.']<br>';
		$dayPrev = get_stat_for_period($prevStart, $prevEnd);
		
		$Comparisions['visitors']  = createComparision($dayNow, $dayPrev, 'visitors');
		$Comparisions['hits']  = createComparision($dayNow, $dayPrev, 'hits');
		$Comparisions['hosts']  = createComparision($dayNow, $dayPrev, 'hosts');
		$Comparisions['unique']  = createComparision($dayNow, $dayPrev, 'unique');
		$Comparisions['coverage']  = createComparision($dayNow, $dayPrev, 'coverage');

		$Comparisions['robots']  = createComparision($dayNow, $dayPrev, 'robots');
		$Comparisions['robots_type']  = createComparision($dayNow, $dayPrev, 'robots_type');
		$Comparisions['robots_hits']  = createComparision($dayNow, $dayPrev, 'robots_hits');
		$Comparisions['robots_unique']  = createComparision($dayNow, $dayPrev, 'robots_unique');
		$Comparisions['robots_coverage']  = createComparision($dayNow, $dayPrev, 'robots_coverage');
//var_dump($dayNow);
		return array('current'=>$dayNow, 'prev'=>$dayPrev, 'comp'=>$Comparisions);
	}

	function createPeriodArray_report($timeNow, $timeStart)
	{
		$nowEnd = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow), date('Y', $timeNow) ) ) ;
		$nowStart = date('Y-m-d', mktime(0, 0, 0, date('m', $timeStart), date('d', $timeStart) , date('Y', $timeStart) ) ) ;

//		print 'now ['.$nowStart.' = '.$nowEnd.']';
		$dayNow = get_stat_for_period($nowStart, $nowEnd);
		$period = $timeNow - $timeStart ;
		$prevEnd = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow - $period)-1 , date('Y', $timeNow) ) ) ;
		$prevStart = date('Y-m-d', mktime(0, 0, 0, date('m', $timeNow), date('d', $timeNow - 2*$period ) -1 , date('Y', $timeNow) ) ) ;

		$dayPrev = get_stat_for_period($prevStart, $prevEnd);
//		print 'prev ['.$prevStart.' = '.$prevEnd.']<br>';
		
		$Comparisions['visitors']  = createComparision($dayNow, $dayPrev, 'visitors');
		$Comparisions['hits']  = createComparision($dayNow, $dayPrev, 'hits');
		$Comparisions['hosts']  = createComparision($dayNow, $dayPrev, 'hosts');
		$Comparisions['unique']  = createComparision($dayNow, $dayPrev, 'unique');
		$Comparisions['coverage']  = createComparision($dayNow, $dayPrev, 'coverage');

		$Comparisions['robots']  = createComparision($dayNow, $dayPrev, 'robots');
		$Comparisions['robots_type']  = createComparision($dayNow, $dayPrev, 'robots_type');
		$Comparisions['robots_hits']  = createComparision($dayNow, $dayPrev, 'robots_hits');
		$Comparisions['robots_unique']  = createComparision($dayNow, $dayPrev, 'robots_unique');
		$Comparisions['robots_coverage']  = createComparision($dayNow, $dayPrev, 'robots_coverage');

		return array('current'=>$dayNow, 'prev'=>$dayPrev, 'comp'=>$Comparisions);
	}

	function createComparision($periodNow, $periodPrev, $type)
	{
		$count = $periodNow[$type] - $periodPrev[$type];
		if($count > 0)
		{
			$comparision['count'] = '+'.$count;
			$comparision['color'] = '#A5EEA5';
		}else if ($count < 0){
			$comparision['count'] = $count;		
			$comparision['color'] = '#FFFFA5';
		}else{
			$comparision['count'] = $count;		
			$comparision['color'] = '#FFFFFF';
		}

		
		if(!empty($periodPrev[$type]) AND $periodPrev[$type]!=0){
			$comparision['arrears'] = round((($periodNow[$type] - $periodPrev[$type])/$periodPrev[$type])*100).'%';
		}else{
			$comparision['arrears'] = 'n/a';
		}
		return $comparision;
	}

	function get_stat_for_period($aDateFrom, $aDateTo)
	{
//		print 'from ['.$aDateFrom.'] => ['. $aDateTo .']<br>';
		$result = array();
		$filters = array();
		$filters_cov = array();
		if($aDateFrom != ''){
			$filters[] = ' visit_start_date >= "'.$aDateFrom.'"';
			$filters_cov[] = ' visit_date >= "'.$aDateFrom.'"';
		}
		if($aDateTo != ''){	
			$filters[] = 'visit_start_date <= "'.$aDateTo.' 23:59:59"';
			$filters_cov[] = 'visit_date <= "'.$aDateTo.' 23:59:59"';
		}
		$filters[] = ' rb.id = rs.browser_id ';

		$typeUSER = ' and rb.is_useragent = 1 and rs.is_filtered = 0 ';
		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);
		$where_cov = (count($filters_cov) == 0)?'':' where '.join(' and ', $filters_cov);

		$sql = 'select SUM(pages_visited) hits, count(*) hosts from stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeUSER;

		list($result['hits'], $result['hosts']) = db_sql_fetch_row(db_sql_query($sql));
		$result['hits'] = (int)$result['hits'];
		$result['hits_link'] = LinkToSessions('visitors', $aDateFrom, $aDateTo, $result['hits'], '&act=by_pages');

		$result['hosts_link'] =  LinkToSessions('visitors', $aDateFrom, $aDateTo, $result['hosts']);

		$sql_visitors = 'select count(*) from stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeUSER.' group by ip';
		$result['visitors'] = db_sql_num_rows(db_sql_query($sql_visitors));
		$result['visitors_link'] = LinkToSessions('visitors', $aDateFrom, $aDateTo, $result['visitors']);

		$sql_unique = 'select srv.* from stat_rep_visits srv, stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeUSER.' and srv.session_id = rs.sid group by page_id';
		$unique_count = db_sql_num_rows(db_sql_query($sql_unique));
		print db_sql_error();
		$result['unique'] = $unique_count;
		$result['unique_link'] = $unique_count;

//ps!
		// количество уникальных страниц, для которых заведены алиасы
		$sql_orig_total =
		"SELECT COUNT(DISTINCT original)".
		"  FROM aliase";

		$row = db_sql_fetch_row(db_sql_query($sql_orig_total));
		$orig_total = $row[0];

		$path_prefix  = EE_HTTP;
		$path_prefix2 = $path_prefix."index.php";
		$sql_orig_visited =
		"SELECT COUNT(DISTINCT a.original)".
		"  FROM (((stat_rep_pages AS p INNER JOIN stat_rep_visits AS v ON p.id=v.page_id)".
		"          INNER JOIN stat_rep_sessions AS rs ON v.session_id=rs.sid)".
		"          INNER JOIN stat_rep_browsers AS rb ON rs.browser_id = rb.id)".
		"          INNER JOIN aliase AS a".
		"    ON (concat('".$path_prefix."',a.original)=p.path".
		"    OR  concat('".$path_prefix2."',a.original)=p.path".
		"    OR  concat('".$path_prefix."',a.alias)=p.path)".
		" ".$where_cov;

//msg ($sql_orig_visited.$typeUSER, 'sql_orig_visited.typeUSER');

		$row = db_sql_fetch_row(db_sql_query($sql_orig_visited.$typeUSER));
		$orig_visited = $row[0];

//msg ($orig_visited, 'orig_visited');
//msg ($orig_total, 'orig_total');

		$result['coverage'] = ((int)(100*($orig_visited/$orig_total)))."%";
		$result['coverage_link'] = $result['coverage'];

		$typeROBOT = ' and rb.is_useragent = 0 and rs.is_filtered = 0 ';
		$sql_robots = 'select count(*) from stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeROBOT.' group by rs.browser';
		$result['robots'] = db_sql_num_rows(db_sql_query($sql_robots));
		$result['robots_link'] = LinkToSessions('searches', $aDateFrom, $aDateTo, $result['robots']);
		
		$sql_robots = 'select count(*) from stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeROBOT.' group by rb.browser_name';
		$result['robots_type'] = db_sql_num_rows(db_sql_query($sql_robots));
		
		/// Total browser group
		$group_count = db_sql_num_rows(db_sql_query('select count(*) from  stat_rep_browsers rb group by browser_name'));
		///

		$result['robots_type_link'] = LinkToSessions('searches', $aDateFrom, $aDateTo, $result['robots_type'].'/'.$group_count);
		
		$sql_robots = 'select SUM(pages_visited) hits from stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeROBOT;
		list($result['robots_hits']) = db_sql_fetch_row(db_sql_query($sql_robots));
		$result['robots_hits'] = (int)$result['robots_hits'];
		$result['robots_hits_link'] = LinkToSessions('searches', $aDateFrom, $aDateTo, $result['robots_hits'], '&act=by_pages');
                      	$sql_unique_robots = 'select srv.* from stat_rep_visits srv, stat_rep_sessions rs, stat_rep_browsers rb '.$where.$typeROBOT.' and srv.session_id = rs.sid group by page_id';
		$unique_count_robots = db_sql_num_rows(db_sql_query($sql_unique_robots));
		print db_sql_error();
		$result['robots_unique'] = $unique_count_robots;
		$result['robots_unique_link'] = $unique_count_robots;

//msg ($sql_orig_visited.$typeROBOT, 'sql_orig_visited.typeROBOT');

		$row = db_sql_fetch_row(db_sql_query($sql_orig_visited.$typeROBOT));
		$orig_visited = $row[0];

//msg ($orig_visited, 'orig_visited_robot');
//msg ($orig_total, 'orig_total');

		$result['robots_coverage'] = ((int)(100*($orig_visited/$orig_total)))."%";
		$result['robots_coverage_link'] = $result['robots_coverage'];

		return $result;
	}
	function LinkToSessions($linkpage, $start, $finish, $count, $act = '')
	{
		$link = '<a href="'.$linkpage.'.php?aStartDate='.$start.'&aEndDate='.$finish.$act.'" target="_self">'.$count.'<a>';
		return $link;
	}

#### BLOCK SUMMARY

#### BLOCK VISITORS
///********************************************************************
	function ReportNameVisitors()
	{
		global $act;
		$reports = array('sessions'=>'Sessions report', 'user_paths'=>'User paths report', 'by_pages'=>'By pages report', 'entry'=>'Entry points report', 'exit'=>'Exit points report', 'reference'=>'Reference pages report', 'broken'=>'Broken links report');
		return $reports[$act];
	}
	function prepareCompareDate()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate;

		$startTime = date2time($aStartDate.' 0:0:0');
		$endTime = date2time($aEndDate.' 0:0:0');
		$delta = $endTime - $startTime;
		
		$aCompareStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 1, date('Y', $startTime)) - $delta);
		$aCompareEndDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 1, date('Y', $startTime)));

	}

	function prepareFilterDate()
	{
		global $aReportDate, $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $aPeriodSelect, $hideUnvisited;
		$hideUnvisited = true; 
		$aEndDate = $aReportDate;
		$startTime = date2time($aEndDate.' 0:0:0');
		switch($aPeriodSelect)
		{
			case 'day': $aStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) , date('Y', $startTime)));
				break;
			case 'week': $aStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 6, date('Y', $startTime)));
				break;
			case 'week2': $aStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 13, date('Y', $startTime)));
				break;
			case 'month': $aStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime) - 1, date('d', $startTime), date('Y', $startTime)));
				break;
		}
		$endTime = date2time($aStartDate.' 0:0:0');
		$delta = $endTime - $startTime;
		
		$aCompareStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 1, date('Y', $startTime)) - $delta);
		$aCompareEndDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 1, date('Y', $startTime)));
	}

	function filter_include_visitors()
	{
		global $act, $modul;
		if(file_exists(EE_ADMIN_PATH.'templates/'.$modul.'/filter_'.$act.'.tpl'))
		{
			return parse($modul.'/filter_'.$act);
		}
	}
	function default_marks()
	{
		$sql = 'select id, default_rating from stat_rep_user_types';
		$rs = db_sql_query($sql);
		$marks = array();
		while(list($id, $mark) = db_sql_fetch_row($rs))
		{
			$marks[$id] = $mark;
		}
		return $marks;
	}
	function user_type_name($var)
	{
		global $$var;
		$id = $$var;
		list($name) = @db_sql_fetch_array(db_sql_query('select name from stat_rep_user_types where id = '.$id));
		return $name;
	}
	function user_type()
	{
		global $user_type;
		$sql = 'select id, name from stat_rep_user_types order by name';

		$rs = db_sql_query($sql);
		$txt = '';
		while(list($_id, $_type) = db_sql_fetch_row($rs))
		{
			if($user_type == $_id) $txt .= '<option selected value="'.$_id.'">'.$_type;
			else $txt .= '<option value="'.$_id.'">'.$_type;
		}
		return $txt;
	}
	function user_type_array()
	{
		$sql = 'select id, name from stat_rep_user_types order by name';
		$rs = db_sql_query($sql);
		$types = array();
		while(list($_id, $_type) = db_sql_fetch_row($rs))
		{
			$types[] = $_type;
		}
		return $types;
	}

	function getTypes()
	{
		$sql = 'select * from stat_rep_user_types';
		$rs = db_sql_query($sql);
		$types = array();
		while($r = db_sql_fetch_array($rs))
		{
			$value = (isset($page2rating[$r['id']]))?$page2rating[$r['id']]:0;
			$types[$r['id']] = $r['name'];
		}
		return $types;
	}
	function date2time($date)
	{
		list($root_path, $second_path) = split(' ', $date);
		list($year, $month, $day) = split('-', $root_path);
		list($hour, $minute, $second) = split(':', $second_path);
		return mktime($hour, $minute, $second, $month, $day, $year);
	}
	function get_times($date)
	{
		$temp = split(' ', $date);
		$part1 = split('-', $temp[0]);
		$part2 = split(':', $temp[1]);
		return $temp[0].'<br>'.$part2[0].':'.$part2[1];
	}
	function list_sessions()
	{
		global $modul, $aUserIP, $aStartDate, $aEndDate, $user_type, $user_browsers;
		/// Build filter for query
		$filters = array();
		$user_types = getTypes();
		$browser_ids = setBrowsersCategoryWhere($user_browsers);
		if($aStartDate != ''){ $filters[] = ' visit_start_date >= "'.$aStartDate.'"'; }
		if($aEndDate != ''){ $filters[] = ' visit_start_date <= "'.$aEndDate.' 23:59:59"'; }
		if($user_type != ''){ $filters[] = ' user_type_id = '.$user_type.''; }
		if($aUserIP != ''){ $filters[] = ' ip like \'%'.$aUserIP.'%\'';}
		$filters[] = ' is_useragent = 1 ';
		$filters[] = ' is_filtered = 0 ';
		if(count($browser_ids) != 0) $filters[] = ' browser_id in ('.join(', ', $browser_ids).') ';
		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);
		/// Build filter for query

		$sql = 'select * from stat_rep_sessions '.$where.' order by visit_start_date asc';

		$rs = viewsql($sql);

		$count = 0;
		$source = '';
		$UsersSessions = array();
		$UsersCounts = array();
		$TotalPages = 0;
		while($r = db_sql_fetch_array($rs))
		{
			$count++;
			$start_dates = $r['visit_start_date'];
			$end_dates = $r['visit_finish_date'];
			$page_from = $r['referer_page'];
			$user_ip = $r['ip'];
			$user_host = $r['ip_host'];

			$delta = date2time($end_dates) - date2time($start_dates);
			
			$format_time = getFullTimeFormat($delta);

			$source .= '<tr>';
			$source .= '<td width="10" valign="top" class="row" align="center">'.$count.'</td>';
			$source .= '<td height="20" width="*" class="row">';
			
			$source .= 'IP: <u>'.$user_ip.'</u> HOST: <u>'.$user_host.'</u> COUNTRY: <u>'.$r['country'].'</u><br />';

			if($page_from != ''){
				$source .= 'Reference link: <a href="'.$page_from.'" target="_blank">'.cut_all($page_from, 80).'</a>';
			}else{
				$source .= 'Reference link: (none)';
			}
			$source .= '</td>';
			$source .= '<td class="row">'.$user_types[$r['user_type_id']].'&nbsp;</td>';
			$source .= '<td align="right" class="row">'.get_times($start_dates).'</td>';
			$source .= '<td  class="row" align="right"><b>'.$format_time.'</b></td>';
			$source .= '</tr>';
			$UsersSessions[$user_types[$r['user_type_id']]]++; 
			// get pages for this sessions
				$sql_pages = 'select path as page, visit_date as dates from stat_rep_visits rv, stat_rep_pages rp where rv.page_id = rp.id and session_id = '.$r['sid'].' order by visit_date asc';
				$rs_pages = db_sql_query($sql_pages);
//				print $sql_pages.'<br>';
				$dates_prev = $start_dates;
				$rows = array();
				$deltas = array();
				while($rp = db_sql_fetch_array($rs_pages))
				{
					$delta = date2time($rp['dates']) - $dates_prev;
					$dates_prev = date2time($rp['dates']);
					$rows[] = $rp;
					$deltas[] = $delta;
				}
				while(list($i, $_r) = each($rows))
				{
					$UsersCounts[$user_types[$r['user_type_id']]]++;
					$TotalPages++;
					$source .= '<tr height="15px"><td class="row">&nbsp;</td><td class="rowpath">';
					if($i != 0) $source .= '<dd>';
					$delta = $deltas[$i+1];
					if(empty($deltas[$i+1])) $delta = 0;
					$format_time = getFullTimeFormat($delta);
					$time = split(" ", $_r['dates']);
					//$source .= $format_time;
					$source .= '<a href="'.$_r['page'].'" target="_blank" title="'.$_r['page'].'" class="a_row">'.cut_all($_r['page'], 80).'</a>';
					$source .= '</td><td colspan="2" class="row">&nbsp;</td><td class="row" align="right">'.$format_time.'</td></tr>';
//					$source .= '<tr><td height="1" colspan="5" bgcolor="navy"></td></tr>';
				}

			// get pages for this sessions
		}
		reset($UsersCounts);
		if($count == 0) $source .= '<tr><td colspan="5" class="row" align="center">No records</td></tr>';
		$source .= '<tr><td colspan="5" class="row"><hr color="grey"></td></tr>';
//		sort($UsersCounts);
		$TotalSessions = $count;
		while(list($type, $count) = each($UsersSessions))
		{
			$source .= '<tr><td colspan="2" class="row">&nbsp;</td>';
			$source .= '<td align="right" class="row">'.$type.'</td>';
			$source .= '<td align="right" class="row">'.$count.'</td>';
			$source .= '<td align="right" class="row">'.round($count*100/$TotalSessions).'%</td></tr>';
		}
			$source .= '<tr><td colspan="2" class="row">&nbsp;</td>';
			$source .= '<td align="right" class="row">Total:</td>';
			$source .= '<td align="right" class="row">'.$TotalSessions.'</td>';
			$source .= '<td align="right" class="row">100%</td></tr>';

		return $source;
	}
	function fUnvisitedCheck()
	{
		global $aUnvisited, $hideUnvisited;
		if($aUnvisited == 'on' || $_SERVER['REQUEST_METHOD'] == 'GET' ){ 
			$hideUnvisited = true; 
			return 'CHECKED'; 
		}else{ 
			$hideUnvisited = false; 
			return '';
		}
	}
	function list_pages_visitors()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $hideUnvisited, $user_browsers;
		
		$sql = 'select id, path from stat_rep_pages order by path';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		$browser_ids = setBrowsersCategoryWhere($user_browsers);
		while($r = db_sql_fetch_array($rs))
		{
			$page_id = $r['id'];
			$page = $r['path'];

			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_visits rv, stat_rep_sessions rs WHERE rs.sid = rv.session_id  AND rs.is_useragent = 1 and rs.is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and browser_id in ('.join(', ', $browser_ids).')';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';

			$sql_group = ' AND rv.page_id = '.$page_id.' group by rv.page_id';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rv.visit_date >= "'.$aStartDate.'" AND rv.visit_date <= "'.$aEndDate.' 23:59:59" ';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			$pages_total[$page_id] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rv.visit_date >= "'.$aCompareStartDate.'" AND rv.visit_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page_id] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page_id, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 &&  $pages_prev[$page_id] == 0 && $hideUnvisited) continue;

			$number++;
			list($page) = db_sql_fetch_array(db_sql_query(' select path from stat_rep_pages where id = '.$page_id));
			$total += (int)$pages_total[$page_id];
			$prev_total += (int)$pages_prev[$page_id];
			$s .= get_row_visitors($page, $pages_total[$page_id], $pages_prev[$page_id], $number);
		}
		if($number == 0) $s .= '<tr><td colspan="5" class="row" align="center">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row" align="right">'.$total.'</td><td class="row" align="right">'.$prev_total.'</td>';
		$s .= '<td class="row" align="right">'.@round(($total - $prev_total)*100/$prev_total, 2).'%</td><td class="row" align="right">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}

	function broken_links_visitors()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $hideUnvisited, $user_browsers;

		$browser_ids = setBrowsersCategoryWhere($user_browsers);

		$sql_date = ' v.visit_date >= "'.$aStartDate.'" AND v.visit_date <= "'.$aEndDate.' 23:59:59" ';
		if(count($browser_ids) != 0) $sql_date .= ' AND browser_id in ('.join(', ', $browser_ids).')';
		if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';

		$sql =	'SELECT MAX(IF(length(rs.referer_page)>0,\'\',1)) as url,'.
			'	MAX(concat(IF(position("'.EE_HTTP.'" in rs.referer_page)>0,1,\'\'),IF(position("http://localhost'.EE_HTTP_PREFIX.'" in rs.referer_page)>0,1,\'\'))) as site,'.
			'	MAX(IF(length(rs.referer_page)>0 AND position("'.EE_HTTP.'" in rs.referer_page)<=0 AND position("http://localhost'.EE_HTTP_PREFIX.'" in rs.referer_page)<=0, 1, \'\')) AS web,'.
			'	COUNT(v.session_id) AS s_num, p.id, p.path'.
			'  FROM ((stat_rep_sessions as rs INNER JOIN stat_rep_visits AS v'.
			'    ON rs.sid=v.session_id) INNER JOIN stat_rep_pages AS p'.
			'    ON v.page_id=p.id) LEFT JOIN aliase AS a'.
			'    ON (p.path=concat("'.EE_HTTP.'",a.alias))'.
			'    OR ('.
			'	 position("?" in p.path)!=0'.
			'	 AND '.
			'	 substring(p.path,position("?" in p.path))=a.original'.
			'	)'.
			' WHERE a.original IS NULL'.
			'   AND position("admin_template=yes" in p.path)=0 '.
			'   AND position("'.EE_HTTP.EE_ADMIN_SECTION.'" in p.path)=0 '.
			'   AND '.$sql_date.
			' GROUP BY p.id, p.path'.
			' ORDER BY path';

		$rs = viewsql($sql);
		$alt = 'Go to CMS-page';
		$total_sess = 0;
		$number = 0;
		while($r = db_sql_fetch_array($rs))
		{
			$number++;
			$total_sess += (int)$r[s_num];
			$total_url  += (int)$r[url];
			$total_site += (int)$r[site];
			$total_web  += (int)$r[web];

			$page_id = $r['id'];
			$page = $r['path'];
			$page_cms = strpos($page, '?')?str_replace('?','?admin_template=yes&',$page):$page.'?admin_template=yes';

			$s .= '<tr>';
			$s .= '<td></td>';
			$s .= '<td class="rowpath">';
			$s .= '<a href="'.$page.'" target="_blank">';
			$s .= $page;
			$s .= '</a>';
			$s .= '</td>';
			$s .= '<td class="row" align="right">';
			$s .= '<a href="?page_id='.$page_id.'&aStartDate='.$aStartDate.'&aEndDate='.$aEndDate.'&user_type='.$user_type.'&user_browsers='.$user_browsers.'">';
			$s .= $r[s_num];
			$s .= '</a>';
			$s .= '</td>';
			$s .= '<td class="row" align="right">';
			$s .= '<a href="'.$page_cms.'">';
			$s .= '<img alt="'.$alt.'" title="'.$alt.'" border="0" src="<?=EE_HTTP?>img/menu/cms_a.gif">';
			$s .= '</a>';
			$s .= '</td>';

			$s .= '<td class="row" align="center">';
			$s .= '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr>';
			$s .= '<td align="center" width="33%">'.($r[url]?'<img src="<?=EE_HTTP?>img/doc_user.gif">':'&nbsp;').'</td>';
			$s .= '<td align="center" width="*">'.($r[site]?'<img src="<?=EE_HTTP?>img/doc.gif">':'&nbsp;').'</td>';
			$s .= '<td align="center" width="33%">'.($r[web]?'<img src="<?=EE_HTTP?>img/doc_web.gif">':'&nbsp;').'</td>';
			$s .= '</tr></table>';
			$s .= '</tr>';
		}
		if($number == 0) $s .= '<tr><td colspan="5" class="row" align="center">No records</td></tr>';
		$s .= '<tr><td colspan="5" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row" align="right">'.$total_sess.'</td><td class="row" align="center">'.$number.'</td>';
		$s .= '<td><table width="100%"><tr><td class="row" align="center">'.$total_url.'</td><td class="row" align="center">'.$total_site.'</td><td class="row" align="center">'.$total_web.'</td></tr></table></td></tr>';
		return $s;
	}

	function get_row_visitors($page, $total, $prev, $number, $server = true)
	{
		$add = (!empty($prev))?round( ($total - $prev)*100/$prev , 2):0;
		if($add > 0){
			$add = '+'.$add;
			$color = '#A5EEA5';
		}else if ($add < 0){
			$color = '#FFFFA5';
		}else{
			$color = '#FFFFFF';
		}
		if(empty($prev) && !empty($total)){ $add = '+100.00'; $color = '#A5EEA5';}

		$s .= '<tr><td></td>';
		$s .= '<td class="rowpath"><a href="'.$page.'" target="_blank" title="'.$page.'">'. cut_all($page, 80).'</a></td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$total.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$prev.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$add.'%</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.($total - $prev).'</td>';
		$s .= '</tr>';
		return $s;
	}

	function user_paths()
	{
		global $aStartDate, $aEndDate, $user_type, $user_browsers;
		$user_types = getTypes();
		$browser_ids = setBrowsersCategoryWhere($user_browsers);

		$sql = 'select count(*) count_ses, sid, user_type_id from stat_rep_sessions '; 
		$sql .= ' where visit_start_date >= "'.$aStartDate.'" AND visit_start_date <= "'.$aEndDate.' 23:59:59" AND is_useragent = 1 and is_filtered = 0 ';
		if(count($browser_ids) != 0) $sql .= ' and browser_id in ('.join(', ', $browser_ids).')';
		if(!empty($user_type)) $sql .= 'AND user_type_id = '.$user_type.' ';
		$sql .= ' group by path_code order by count_ses desc';

		$rs = db_sql_query($sql);

		$sql_total = 'select count(*) count_ses from stat_rep_sessions '; 
		$sql_total .= ' where visit_start_date >= "'.$aStartDate.'" AND visit_start_date <= "'.$aEndDate.' 23:59:59" AND is_useragent = 1 and is_filtered = 0 ';
		if(count($browser_ids) != 0) $sql .= ' and browser_id in ('.join(', ', $browser_ids).')';
		if(!empty($user_type)) $sql .= ' AND user_type_id = '.$user_type.' ';
		list($total_sessions) = db_sql_fetch_array(db_sql_query($sql_total));
		$s = '';
		$count = 0;
		$types = array();
		while($r = db_sql_fetch_array($rs))
		{
			$count++;
			$sql_pages = 'select rp.path as page from stat_rep_pages rp, stat_rep_visits rv where rp.id = rv.page_id and session_id = '.$r['sid'].' order by visit_date asc';	
//			print $sql_pages;
			$rs_pages = db_sql_query($sql_pages);
			$s .= '<tr><td valign="top" align="center" class="row">'.$count.'</td><td valign="top" class="row"><table border="0" width="100%" cellpadding="2" cellspacing="0">'; 
			$p = 0;
			while($p_r = db_sql_fetch_array($rs_pages))
			{
				$s .= '<tr>';
				if($p == 0) $s.='<td class="rowpath" width="20px"><!--img src="<?=EE_HTTP?>img/info.gif" border="0" width="16px" height="16px" valign="absmiddle"--></td><td class="rowpath">';
				if($p != 0) $s .= '<td class="rowpath" colspan="2"><dd>';
				$s .= '<a href="'.$p_r['page'].'" target="_blank" title="'.$p_r['page'].'">'.cut_all($p_r['page'], 80).'</a></td></tr>';
				$p++;
			}
			$s .= '</table></td>';
			$s .= '<td valign="top" class="row"><b>'.$user_types[$r['user_type_id']].'</b></td>';
			$s .= '<td valign="top" class="row" align="right">'.$r['count_ses'].'</td>';
			$s .= '<td valign="top" class="row" align="right">'.round($r['count_ses']*100/$total_sessions, 2).'%</td>';
			$s .='</tr>';
			$types[$r['user_type_id']] += (int)$r['count_ses'];
		}
		if($count == 0) $s .= '<tr><td colspan="5" class="row" align="center">No records</td></tr>';
		$s .= '<tr><td colspan="5" class="row"><hr color="grey"></td></tr>';
		while(list($type, $count) = each($types))
		{
			$s .= '<tr><td colspan="2" class="row"></td><td class="row"><b>'.$user_types[$type].'</b></td><td class="row" align="right">'.$count.'</td><td class="row" align="right">'.round($count*100/$total_sessions, 2).'%</td></tr>';
		}
		$s .= '<tr><td colspan="2" class="row"></td><td class="row">Total</td><td class="row" align="right">'.$total_sessions.'</td><td class="row" align="right">100%</td></tr>';
		return $s;
	}

	function entry_pages_visitors()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $user_browsers;
		$sql = 'select id, path from stat_rep_pages order by path';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		$browser_ids = setBrowsersCategoryWhere($user_browsers);

		while($r = db_sql_fetch_array($rs))
		{
			$page_id = $r['id'];
			$page = $r['path'];

			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_visits rv, stat_rep_sessions rs WHERE rs.sid = rv.session_id AND rv.order_in_session = 0 AND rs.is_useragent = 1 and is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).')';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';

			$sql_group = ' AND rv.page_id = '.$page_id.' group by rv.page_id';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rv.visit_date >= "'.$aStartDate.'" AND rv.visit_date <= "'.$aEndDate.' 23:59:59" ';
//			print $sql_date.$sql_date1.$sql_group.'<br>';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			$pages_total[$page_id] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rv.visit_date >= "'.$aCompareStartDate.'" AND rv.visit_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page_id] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page_id, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 && $pages_prev[$page_id] == 0) continue;
			$number++;
			list($page) = db_sql_fetch_array(db_sql_query(' select path from stat_rep_pages where id = '.$page_id));
			$total += $pages_total[$page_id];
			$prev_total += $pages_prev[$page_id];
			$s .= get_row_visitors($page, $pages_total[$page_id], $pages_prev[$page_id], $number);
		}
		if($number == 0) $s .= '<tr><td colspan="6" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row" align="right">'.$total.'</td><td class="row" align="right">'.$prev_total.'</td>';
		$s .= '<td class="row" align="right">'.@round(($total - $prev_total)*100/$prev_total, 2).'%</td><td class="row" align="right">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}
	function exit_pages_visitors()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $user_browsers;
		$sql = 'select id, path from stat_rep_pages order by path';			
		$rs = db_sql_query($sql);
		$browser_ids = setBrowsersCategoryWhere($user_browsers);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$page_id = $r['id'];
			$page = $r['path'];

			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_visits rv, stat_rep_sessions rs WHERE rs.sid = rv.session_id AND rv.order_in_session = ( rs.pages_visited - 1 ) AND rs.is_useragent = 1 and rs.is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).')';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';

			$sql_group = ' AND rv.page_id = '.$page_id.' group by rv.page_id';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rv.visit_date >= "'.$aStartDate.'" AND rv.visit_date <= "'.$aEndDate.' 23:59:59" ';
//			print $sql_date.$sql_date1.$sql_group.'<br>';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			$pages_total[$page_id] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rv.visit_date >= "'.$aCompareStartDate.'" AND rv.visit_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page_id] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page_id, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 && $pages_prev[$page_id] == 0) continue;
			$number++;
			list($page) = db_sql_fetch_array(db_sql_query(' select path from stat_rep_pages where id = '.$page_id));
			$total += $pages_total[$page_id];
			$prev_total += $pages_prev[$page_id];
			$s .= get_row_visitors($page, $pages_total[$page_id], $pages_prev[$page_id], $number);
		}
		if($number == 0) $s .= '<tr><td colspan="6" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row" align="right">'.$total.'</td><td class="row" align="right">'.$prev_total.'</td>';
		$s .= '<td class="row" align="right">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row" align="right">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}
	
	function reference_pages_visitors()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $user_browsers;
		$sql = 'select referer_page from stat_rep_sessions where referer_page <> "" group by referer_page  order by referer_page';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$browser_ids = setBrowsersCategoryWhere($user_browsers);
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$page = $r['referer_page'];
//			print $page.'<br>';
			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_sessions rs WHERE rs.is_useragent = 1 and is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).')';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';
			$sql_group = ' AND rs.referer_page = "'.$page.'" group by rs.referer_page';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rs.visit_start_date >= "'.$aStartDate.'" AND rs.visit_start_date <= "'.$aEndDate.' 23:59:59" ';
//			print $sql_date.$sql_date1.$sql_group.'<br>';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
//			print db_sql_error();
			$pages_total[$page] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rs.visit_start_date >= "'.$aCompareStartDate.'" AND rs.visit_start_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page, $count) = each($pages_total))
		{
			if($pages_total[$page] == 0 && $pages_prev[$page] == 0) continue;
			$number++;
			$total += $pages_total[$page];
			$prev_total += $pages_prev[$page];
			$s .= get_row_visitors($page, $pages_total[$page], $pages_prev[$page], $number);
		}
		if($number == 0) $s .= '<tr><td colspan="6" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row" align="right">'.$total.'</td><td class="row" align="right">'.$prev_total.'</td>';
		$s .= '<td class="row" align="right">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row" align="right">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}

	function cut_all($str, $num)
	{
		return substr($str, 0, $num);
	}


	function getFullTimeFormat($delta)
	{
		$delta = abs($delta);
		$hours = floor($delta/3600);
		$minuts = floor( ($delta - $hours*60)/60);
		$seconds = $delta - $hours*3600 - $minuts*60;

		$minuts = ($minuts < 10)?'0'.$minuts:$minuts;
		$seconds = ($seconds < 10)?'0'.$seconds:$seconds;
		return $hours.':'.$minuts.':'.$seconds;
	}
	function user_browsers()
	{
		global $user_browsers;
		$sql = 'select DISTINCT browser_name from stat_rep_browsers where is_useragent = 1';

		$rs = db_sql_query($sql);
		$txt = '';
		while(list($_type) = db_sql_fetch_row($rs))
		{
			if($user_browsers == $_type) $txt .= '<option selected value="'.$_type.'">'.$_type;
			else $txt .= '<option value="'.$_type.'">'.$_type;
		}
		return $txt;
	}
#### BLOCK VISITORS
### BLOCK ROBOTS


///********************************************************************
	function ReportName()
	{
		global $act;
		$reports = array('summary'=>'Summary', 'by_pages'=>'By pages report', 'entry'=>'Entry points report', 'exit'=>'Exit points report', 'reference'=>'Reference pages report');
		return $reports[$act];
	}
	/*
	function prepareCompareDate()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate;

		$startTime = date2time($aStartDate.' 0:0:0');
		$endTime = date2time($aEndDate.' 0:0:0');
		$delta = $endTime - $startTime;
		
		$aCompareStartDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 1, date('Y', $startTime)) - $delta);
		$aCompareEndDate = date('Y-m-d', mktime(0, 0, 0, date('m', $startTime), date('d', $startTime) - 1, date('Y', $startTime)));

	}
	*/
	function filter_include_robots()
	{
		global $act, $modul;
		if(file_exists(EE_ADMIN_PATH.'templates/'.$modul.'/filter_'.$act.'.tpl'))
		{
			return parse($modul.'/filter_'.$act);
		}
	}

	function list_summary()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type;
		$sql = 'select distinct browser_name from stat_rep_browsers where is_useragent = 0';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$browser_group = $r['browser_name'];

			$sql_date = 'SELECT count(*) FROM stat_rep_sessions rs, stat_rep_browsers rb WHERE rs.browser_id = rb.id and rs.is_filtered = 0 and rb.browser_name  = "'.$browser_group.'" ';
			$sql_group = ' group by rb.browser_name';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rs.visit_start_date >= "'.$aStartDate.'" AND rs.visit_start_date <= "'.$aEndDate.' 23:59:59" ';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			print db_sql_error();
			$pages_total[$browser_group] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rs.visit_start_date >= "'.$aCompareStartDate.'" AND rs.visit_start_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$browser_group] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($browser_group, $count) = each($pages_total))
		{
			$number++;
			list($last_indexed) = db_sql_fetch_array(db_sql_query(' select visit_finish_date  from stat_rep_sessions rs, stat_rep_browsers rb WHERE rs.browser_id = rb.id and rs.is_filtered = 0 and rb.browser_name  = "'.$browser_group.'" order by visit_finish_date desc '));
			$total += $pages_total[$browser_group];
			$prev_total += $pages_prev[$browser_group];
			$s .= get_browser_row($last_indexed, $browser_group, $pages_total[$browser_group], $pages_prev[$browser_group], $number);
		}
		$s .= '<tr><td colspan="7" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="3" align="right" class="row">Total:</td><td class="row" align="right">'.$total.'</td><td align="right" class="row">'.$prev_total.'</td>';
		$s .= '<td class="row" align="right">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row" align="right">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}
	
	function get_browser_row($last_indexed, $browser_name, $total, $prev, $number)
	{
		$add = (!empty($prev))?round(($total - $prev)*100/$prev):0;
		if($add > 0){
			$add = '+'.$add;
			$color = '#A5EEA5';
		}else if ($add < 0){
			$color = '#FFFFA5';
		}else{
			$color = '#FFFFFF';
		}
		if(empty($prev) && !empty($total)){ $add = '+100'; $color = '#A5EEA5';}

		$s .= '<tr><td></td>';
		$s .= '<td class="rowpath">'. cut_all($browser_name, 60).'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="center">'.$last_indexed.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$total.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$prev.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$add.'%</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.($total - $prev).'</td>';
		$s .= '</tr>';
		return $s;
	}

	function list_pages()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $hideUnvisited, $engine_browsers;
		
		$browser_ids = setBrowsersCategoryWhere($engine_browsers);
		
		$sql = 'select id, path from stat_rep_pages order by path';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$page_id = $r['id'];
			$page = $r['path'];

			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_visits rv, stat_rep_sessions rs WHERE rs.sid = rv.session_id  AND rs.is_useragent = 0  and rs.is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).') ';
			$sql_group = ' AND rv.page_id = '.$page_id.' group by rv.page_id';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rv.visit_date >= "'.$aStartDate.'" AND rv.visit_date <= "'.$aEndDate.' 23:59:59" ';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			$pages_total[$page_id] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rv.visit_date >= "'.$aCompareStartDate.'" AND rv.visit_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page_id] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page_id, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 &&  $pages_prev[$page_id] == 0 && $hideUnvisited) continue;
			$number++;
			list($last_indexed) = db_sql_fetch_array(db_sql_query(' select visit_date  from stat_rep_visits where page_id = '.$page_id.' order by visit_date desc '));
			$total += $pages_total[$page_id];
			$prev_total += $pages_prev[$page_id];
			$s .= get_pages_row($last_indexed, $page_id, $pages_total[$page_id], $pages_prev[$page_id], $number);
		}
		if($number == 0 )$s .= '<tr><td colspan="7" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="7" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="3" align="right" class="row">Total:</td><td class="row" align="right">'.$total.'</td><td align="right" class="row">'.$prev_total.'</td>';
		$s .= '<td class="row" align="right">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row" align="right">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}
	
	function get_pages_row($last_indexed, $page_id, $total, $prev, $number)
	{
		global $engine_browsers;
		$add = (!empty($prev))?round(($total - $prev)*100/$prev):0;
		list($page) = db_sql_fetch_array(db_sql_query(' select path from stat_rep_pages where id = '.$page_id));
		if($add > 0){
			$add = '+'.$add;
			$color = '#A5EEA5';
		}else if ($add < 0){
			$color = '#FFFFA5';
		}else{
			$color = '#FFFFFF';
		}
		if(empty($prev) && !empty($total)){ $add = '+100'; $color = '#A5EEA5';}

		$s .= '<tr><td></td>';
		$s .= '<td class="rowpath"><a href="'.$page.'" target="_blank" title="'.$page.'">'. cut_all($page, 80).'</a></td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="center">'.$last_indexed.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$total.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$prev.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$add.'%</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.($total - $prev).'</td>';
		$s .= '</tr>';
		if($engine_browsers == '') $s .= get_browser_groups($page_id);
		return $s;
	}
	function get_browser_groups($page_id)
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type;
		$sql = 'select distinct browser_name from stat_rep_browsers where is_useragent = 0';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$browser_group = $r['browser_name'];

			$sql_date = 'SELECT count( * ) FROM stat_rep_visits rv, stat_rep_browsers rb, stat_rep_sessions rs WHERE rs.sid = rv.session_id and is_filtered = 0 and rs.browser_id = rb.id and rb.browser_name  = "'.$browser_group.'" and rv.page_id = '.$page_id. ' ';
			$sql_group = ' group by rb.browser_name';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rs.visit_start_date >= "'.$aStartDate.'" AND rs.visit_start_date <= "'.$aEndDate.' 23:59:59" ';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			print db_sql_error();
			$pages_total[$browser_group] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rs.visit_start_date >= "'.$aCompareStartDate.'" AND rs.visit_start_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$browser_group] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($browser_group, $count) = each($pages_total))
		{
			if($pages_total[$browser_group]==0 &&  $pages_prev[$browser_group] == 0 )continue;

			$number++;
			list($last_indexed) = db_sql_fetch_array(db_sql_query(' SELECT rv.visit_date FROM stat_rep_visits rv, stat_rep_browsers rb, stat_rep_sessions rs WHERE rs.sid = rv.session_id and rs.is_filtered = 0 and rs.browser_id = rb.id and rb.browser_name  = "'.$browser_group.'" and rv.page_id = '.$page_id. ' order by visit_finish_date desc '));
			$total += $pages_total[$browser_group];
			$prev_total += $pages_prev[$browser_group];
			$s .= get_browser_row($last_indexed, '<dd>'.$browser_group, $pages_total[$browser_group], $pages_prev[$browser_group], $number);
		}
		return $s;
	}
	function get_row($page, $total, $prev, $number, $server = true)
	{
		$add = (!empty($prev))?round(($total - $prev)*100/$prev):0;
		if($add > 0){
			$add = '+'.$add;
			$color = '#A5EEA5';
		}else if ($add < 0){
			$color = '#FFFFA5';
		}else{
			$color = '#FFFFFF';
		}
		if(empty($prev) && !empty($total)){ $add = '+100'; $color = '#A5EEA5';}

		$s .= '<tr><td></td>';
		$s .= '<td class="rowpath"><a href="'.$page.'" title="'.$page.'" target="_blank">'. cut_all($page, 80).'</a></td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$total.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$prev.'</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.$add.'%</td>';
		$s .= '<td bgcolor="'.$color.'" class="row" align="right">'.($total - $prev).'</td>';
		$s .= '</tr>';
		return $s;
	}
	

	function entry_pages()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $engine_browsers, $hideUnvisited;
		$sql = 'select id, path from stat_rep_pages order by path';			
		$browser_ids = setBrowsersCategoryWhere($engine_browsers);
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$page_id = $r['id'];
			$page = $r['path'];

			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_visits rv, stat_rep_sessions rs WHERE rs.sid = rv.session_id AND rv.order_in_session = 0 AND rs.is_useragent = 0 and is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).') ';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';

			$sql_group = ' AND rv.page_id = '.$page_id.' group by rv.page_id';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rv.visit_date >= "'.$aStartDate.'" AND rv.visit_date <= "'.$aEndDate.' 23:59:59" ';
//			print $sql_date.$sql_date1.$sql_group.'<br>';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			print db_sql_error();
			$pages_total[$page_id] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rv.visit_date >= "'.$aCompareStartDate.'" AND rv.visit_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page_id] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page_id, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 &&  $pages_prev[$page_id] == 0 && $hideUnvisited) continue;
			$number++;
			list($page) = db_sql_fetch_array(db_sql_query(' select path from stat_rep_pages where id = '.$page_id));
			$total += $pages_total[$page_id];
			$prev_total += $pages_prev[$page_id];
			$s .= get_row($page, $pages_total[$page_id], $pages_prev[$page_id], $number);
		}
		if($number == 0 )$s .= '<tr><td colspan="7" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row">'.$total.'</td><td class="row">'.$prev_total.'</td>';
		$s .= '<td class="row">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}
	function exit_pages()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $engine_browsers, $hideUnvisited;
		$browser_ids = setBrowsersCategoryWhere($engine_browsers);
		$sql = 'select id, path from stat_rep_pages order by path';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$page_id = $r['id'];
			$page = $r['path'];

			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_visits rv, stat_rep_sessions rs WHERE rs.sid = rv.session_id AND rv.order_in_session = ( rs.pages_visited - 1 ) AND rs.is_useragent = 0 and is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).') ';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';

			$sql_group = ' AND rv.page_id = '.$page_id.' group by rv.page_id';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rv.visit_date >= "'.$aStartDate.'" AND rv.visit_date <= "'.$aEndDate.' 23:59:59" ';
//			print $sql_date.$sql_date1.$sql_group.'<br>';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
			$pages_total[$page_id] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rv.visit_date >= "'.$aCompareStartDate.'" AND rv.visit_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page_id] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page_id, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 &&  $pages_prev[$page_id] == 0 && $hideUnvisited) continue;
			$number++;
			list($page) = db_sql_fetch_array(db_sql_query(' select path from stat_rep_pages where id = '.$page_id));
			$total += $pages_total[$page_id];
			$prev_total += $pages_prev[$page_id];
			$s .= get_row($page, $pages_total[$page_id], $pages_prev[$page_id], $number);
		}
		if($number == 0 )$s .= '<tr><td colspan="7" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row">'.$total.'</td><td class="row">'.$prev_total.'</td>';
		$s .= '<td class="row">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}
	
	function reference_pages()
	{
		global $aStartDate, $aEndDate, $aCompareStartDate, $aCompareEndDate, $user_type, $engine_browsers, $hideUnvisited;
		$browser_ids = setBrowsersCategoryWhere($engine_browsers);
		$sql = 'select referer_page from stat_rep_sessions where referer_page <> ""  group by referer_page order by referer_page ';			
		$rs = db_sql_query($sql);
		$pages_total = array();
		$pages_prev = array();
		while($r = db_sql_fetch_array($rs))
		{
			$page = $r['referer_page'];
//			print $page.'<br>';
			$sql_date = 'SELECT count( * ) count_pages FROM stat_rep_sessions rs WHERE rs.is_useragent = 0 and is_filtered = 0 ';
			if(count($browser_ids) != 0) $sql_date .= ' and rs.browser_id in ('.join(', ', $browser_ids).') ';
			if(!empty($user_type)) $sql_date .= ' AND rs.user_type_id = '.$user_type.' ';
			$sql_group = ' AND rs.referer_page = "'.$page.'" group by rs.referer_page';
			
			///////TOTAL COUNT
			$sql_date1 = ' AND rs.visit_start_date >= "'.$aStartDate.'" AND rs.visit_start_date <= "'.$aEndDate.' 23:59:59" ';
//			print $sql_date.$sql_date1.$sql_group.'<br>';
			list($count1) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date1.$sql_group));
//			print db_sql_error();
			$pages_total[$page] = (int)$count1;
					
			///////PREVIOUS COUNT
			$sql_date2 = ' AND rs.visit_start_date >= "'.$aCompareStartDate.'" AND rs.visit_start_date <= "'.$aCompareEndDate.' 23:59:59" ';
			list($count2) = db_sql_fetch_array(db_sql_query($sql_date.$sql_date2.$sql_group));
			$pages_prev[$page] = (int)$count2;
		}
//		print '<pre>';
		arsort($pages_total);
//		print_r($pages_total);
		$s = '';
		$number = 0;
		while(list($page, $count) = each($pages_total))
		{
			if($pages_total[$page_id] == 0 &&  $pages_prev[$page_id] == 0 && $hideUnvisited) continue;
			$number++;
			$total += $pages_total[$page];
			$prev_total += $pages_prev[$page];
			if($pages_total[$page] == 0 && $pages_prev[$page] == 0) continue;
			$s .= get_row($page, $pages_total[$page], $pages_prev[$page], $number);
		}
		if($number == 0 )$s .= '<tr><td colspan="7" class="row">No records</td></tr>';
		$s .= '<tr><td colspan="6" class="row"><hr color="grey"></td></tr>';
		$s .= '<tr><td colspan="2" align="right" class="row">Total:</td><td class="row">'.$total.'</td><td class="row">'.$prev_total.'</td>';
		$s .= '<td class="row">'.@round(($total - $prev_total)*100/$prev_total).'%</td><td class="row">'.($total - $prev_total).'</td></tr>'; 
		return $s;
	}

	function engine_browsers()
	{
		global $engine_browsers;
		$sql = 'select DISTINCT browser_name from stat_rep_browsers where is_useragent = 0';

		$rs = db_sql_query($sql);
		$txt = '';
		while(list($_type) = db_sql_fetch_row($rs))
		{
			if($engine_browsers == $_type) $txt .= '<option selected value="'.$_type.'">'.$_type;
			else $txt .= '<option value="'.$_type.'">'.$_type;
		}
		return $txt;
	}

	function setBrowsersCategoryWhere($type)
	{
		$sql = 'select id from stat_rep_browsers where browser_name = "'.$type.'"';
		$rs = db_sql_query($sql);
		$browsers_id = array();
		while(list($id) = db_sql_fetch_row($rs))
		{
			$browsers_id[] = $id;
		}
		return $browsers_id;
	}

### BLOCK ROBOTS

### TOTAL REPORT
/*
		$summary
		$user_filter = array('sessions'=>'Sessions', 'user_paths'=>'Users Paths', 'bypages'=>'By Pages'
								, 'users_entry'=>'Entry Points', 'user_exit' => 'Exit Pages', 'user_ref'=>'References');
		$engines_filter = array('eng_sessions'=>'Sessions', 'eng_bypages'=>'By Pages'
								, 'eng_entry'=>'Entry Points', 'eng_exit' => 'Exit Pages', 'eng_ref'=>'References');
*/
	function create_report()
	{
		extract($_POST['reports']);
		/// Objects
		$user_filter = array('sessions'=>'Sessions', 'user_paths'=>'Users Paths', 'bypages'=>'By Pages'
								, 'users_entry'=>'Entry Points', 'user_exit' => 'Exit Pages', 'user_ref'=>'References');
		$user_functions = array('sessions'=>'list_sessions', 'user_paths'=>'user_paths', 'bypages'=>'list_pages_visitors'
								, 'users_entry'=>'entry_pages_visitors', 'user_exit' => 'exit_pages_visitors', 'user_ref'=>'reference_pages_visitors');

		$engines_filter = array('eng_sessions'=>'Sessions', 'eng_bypages'=>'By Pages'
								, 'eng_entry'=>'Entry Points', 'eng_exit' => 'Exit Pages', 'eng_ref'=>'References');
		$engines_fucntion = array('eng_sessions'=>'list_summary', 'eng_bypages'=>'list_pages'
								, 'eng_entry'=>'entry_pages', 'eng_exit' => 'exit_pages', 'eng_ref'=>'reference_pages');
		/// Globals
		while(list($key, ) = each($user_filter)){ $gl = $key.'_header'; global $$gl;}
		while(list($key, ) = each($engines_filter)){ $gl = $key.'_header'; global $$gl;}
		///
		$total = '';
		if(isset($summary))
		{
			$total .= '<h3>SUMMARY</h3>';
			$total .= summary_content_report();
		}
		$users_total = '<h3>WEB USER</h3>';
		while(list($key, $function) = each($user_functions))
		{
			if(isset($$key))
			{
				$users_key = true;
				$header = $key.'_header';
				$users_total .= '<div>'.$user_filter[$key].'<div>';
				$users_total .= $$header.$function().'</table>';
			}
		}
		$engines_total .= '<h3>ENGINES</h3>';
		while(list($key, $function) = each($engines_fucntion))
		{
			if(isset($$key))
			{
				$engines_key = true;
				$header = $key.'_header';
				$engines_total .= '<div>'.$engines_filter[$key].'<div>';
				$engines_total .= $$header.$function().'</table>';
			}
		}
		if($users_key) $total .= $users_total;
		if($engines_key) $total .= $engines_total;
		return $total;
	}

	function header_report()
	{
		return parse('total_report/report_header');
	}
### TOTAL REPORT

### CONFIGURATION
	function updateBrowsersType()
	{
		$sql = 'select * from stat_rep_browsers';
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$sql_update = 'update stat_rep_browsers set browser_type = "'.$r['browser_type'].'", is_useragent = '.$r['is_useragent'].' ';	
			$sql_update .= ' where browser_name like "'.$r['browser_string'].'"';
			db_sql_query($sql_update);
		}
	}
	function UserAgents($is_useragent = 1)
	{
		global $delete;
//		updateBrowsersType();
		$act = ($is_useragent == 1)?'user_agents':'searches';
		$act_edit = ($is_useragent == 1)?'agent_edit':'search_edit';

		$source = '<table width="100%" cellpadding="2" cellspacing="0" border="0" ><tr>';
		$source .= '<td class="table_header" width="150px"><nobr><a href="?act='.$act_edit.'&edit=0" class="table_header"><img src="<?=EE_HTTP?>img/doc_add24.gif" align="absmiddle" border="0">&nbsp;Add user agent</a></nobr></td>';
		$source .= '<td width="*">&nbsp;</td>';
		$source .= '<td class="table_header" width="150px"><nobr><a href="?act='.$act.'" class="table_header"><img src="<?=EE_HTTP?>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>';
		$source .= '</tr></table><br/>';
		//  TABLE
		$source .= '<table width="70%" cellpadding="2" cellspacing="0" border="0" ><tr>';
		$source .= '<td class="solidBorder" width="50px" align="center">#</td>';
		$source .= '<td class="solidBorder" width="*" align="center">Category</td>';
		$source .= '<td class="solidBorderText" width="*" align="center">Agent string</td>';
		$source .= '</tr>';

		if(!empty($delete)) db_sql_query('delete from stat_rep_browsers where id = '.$delete);
		$sql = 'select * from stat_rep_browsers where is_useragent = '.$is_useragent;
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr>';
			$source .= '<td align="center"><nobr><a href="?act='.$act_edit.'&edit='.$r['id'].'"><img src="<?=EE_HTTP?>img/doc_edit16.gif" border="0" width="16px" height="16px"></a>&nbsp;&nbsp;<a href="?act='.$act.'&delete='.$r['id'].'"><img src="<?=EE_HTTP?>img/doc_delete16.gif" border="0" width="16px" height="16px"></a></nobr></td>';
			$source .= '<td>'.$r['browser_name'].'</td>';
			$source .= '<td>'.$r['browser_string'].'</td>';
			$source .= '</tr>';
		}
		$source .= '</table>';
		$source .= listUndefined();
		return $source;
	}
	
	function listUndefined()
	{
		global $act, $type;
		if($type == 'addfilter') AddNewFilter();
		$filterWhere = getFiltersWhere();
		$browserFilter = getBrowserFilter();

		$sql = 'select rs.sid, rs.ip, rs.ip_host, rs.browser from stat_rep_sessions rs  ';
		if(strlen($browserFilter) != 0){
			$sql .= $browserFilter;
			if(strlen($filterWhere) != 0) $sql .= ' and '.$filterWhere;
		}else if(strlen($filterWhere) != 0){
			$sql .= ' where '.$filterWhere;
		}
		$sql .= ' group by browser order by visit_start_date desc ';

		$rs = db_sql_query($sql);
		$source = '<hr><div>List of undefined agents ('.db_sql_num_rows($rs).')</div><hr>';
		$source .= '<table width="70%" cellpadding="2" cellspacing="0" border="0" ><tr>';
		$source .= '<td class="solidBorder" width="50px" align="center">#</td>';
		$source .= '<td class="solidBorder" width="*" align="center">Agent string</td>';
		$source .= '<td class="solidBorderText" width="*" align="center">Source IP/Host of last visit</td>';
		$source .= '</tr>';

		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr>';
			$source .= '<td align="center"><nobr>';
			$source .= '&nbsp;<a href="?act=filter_edit&sid='.$r['sid'].'&edit=0"><img src="<?=EE_HTTP?>img/doc_delete16.gif" border="0" width="16px" height="16px"></a>&nbsp;';
			$source .= '&nbsp;<a href="?act=search_edit&sid='.$r['sid'].'&edit=0"><img src="<?=EE_HTTP?>img/doc_app16.gif" border="0" width="16px" height="16px"></a>&nbsp;';
			$source .= '&nbsp;<a href="?act=agent_edit&sid='.$r['sid'].'&edit=0"><img src="<?=EE_HTTP?>img/doc_user16.gif" border="0" width="16px" height="16px"></a>&nbsp;';
			$source .= '</nobr></td>';
			$source .= '<td>'.$r['browser'].'</td>';
			$source .= '<td>'.$r['ip'].' / '.$r['ip_host'].'</td>';
			$source .= '</tr>';
		}
		$source .= '</table>';
		return $source;
	}

	function UserAgentsEdit($is_useragent_arg = 1)
	{
		global $sid, $edit, $cancel, $save, $modul, $aAgentString, $agent, $aAgentType, $existedAgentType, $agentExistedCheck, $agentNewCheck, $is_useragent;
		$is_useragent = $is_useragent_arg;
		$act = ($is_useragent == 1)?'user_agents':'searches';

		if( $agent == 'existed' ) $agentExistedCheck = 'checked';
		else $agentNewCheck = 'checked';

//		if($cancel == 1) { header('Location: configuration.php?act=user_agents');exit;}
		if(isset($_POST['cancel_x'])) { header('Location: configuration.php?act=user_agents');exit;}


//		if($save == 1 ){
		if(isset($_POST['save_x'])){
			$AgentTypeSave = ($agent == 'new') ? $aAgentType : $existedAgentType ;
			if(!empty($edit))
			{
				$sql = 'update stat_rep_browsers set browser_string= "'.$aAgentString.'", browser_name = "'.$AgentTypeSave.'", is_useragent = '.$is_useragent.' ';	
				$sql .= ' where id = '.$edit;
				$res = db_sql_query($sql);
			}else{
				$sql = 'INSERT INTO stat_rep_browsers(browser_string, browser_name, is_useragent) ';	
				$sql .= ' VALUES("'.$aAgentString.'", "'.$AgentTypeSave.'", '.$is_useragent.')';
				$res = db_sql_query($sql);
				$edit = db_sql_insert_id();
			}
			if($res){ 
				header('Location: configuration.php?act='.$act);
				$session_update = 'update stat_rep_sessions set is_useragent = '.$is_useragent.', browser_id = '.$edit.' where browser = like "'.$aAgentString.'"';
				db_sql_query($session_update);
				exit;
			}
		}else{
			if(!empty($edit))
			{
				$sql = 'select * from stat_rep_browsers where id = '.$edit;	
				$r = db_sql_fetch_array(db_sql_query($sql));
				 $aAgentString = $r['browser_string'];
				 $aAgentType = $r['browser_name'];
				 $is_useragent = $r['is_useragent'];
			}
			if(!empty($sid))
			{
				$sql = 'select browser from stat_rep_sessions where sid = '.$sid;
				$r = @db_sql_fetch_array(db_sql_query($sql));
				$aAgentString = $r['browser'];
				$aAgentType = '';
			}
		}
		$source = parse($modul.'/addagent');
		return $source;

	}
	
	function Engines()
	{
	
	}
	function FilterBlock()
	{
		global $delete, $refresh;
		if($refresh = 1)
		{
			UpdateSessionsFilter();
		}
		//  HEADER
		$source = '<table width="100%" cellpadding="2" cellspacing="0" border="0" ><tr>';
		$source .= '<td class="table_header" width="150px"><nobr><a href="?act=filter_edit&edit=0" class="table_header"><img src="<?=EE_HTTP?>img/doc_add24.gif" align="absmiddle" border="0">&nbsp;Add new filter</a></nobr></td>';
		$source .= '<td width="*">&nbsp;</td>';
		$source .= '<td class="table_header" width="150px"><nobr><a href="?act=filters&refresh=1" class="table_header"><img src="<?=EE_HTTP?>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>';
		$source .= '</tr></table><br/>';
		//  TABLE
		$source .= '<table width="70%" cellpadding="2" cellspacing="0" border="0" ><tr>';
		$source .= '<td class="solidBorder" width="50px" align="center">#</td>';
		$source .= '<td class="solidBorder" width="*" align="center">IP(hosts)</td>';
		$source .= '<td class="solidBorderText" width="*" align="center">Agents</td>';
		$source .= '<td class="solidBorderText" width="50px">Filter phisically</td>';
		$source .= '<td class="solidBorderText" width="50px">Active</td>';
		$source .= '</tr>';

		if(!empty($delete)) db_sql_query('delete from stat_rep_filters where id = '.$delete);
		$sql = 'select * from stat_rep_filters order by id';
		$rs = db_sql_query($sql);
		
		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr>';
			$source .= '<td align="center"><nobr><a href="?act=filter_edit&edit='.$r['id'].'"><img src="<?=EE_HTTP?>img/doc_edit16.gif" border="0" width="16px" height="16px"></a>&nbsp;&nbsp;<a href="?act=filters&delete='.$r['id'].'"><img src="<?=EE_HTTP?>img/doc_delete16.gif" border="0" width="16px" height="16px"></a></nobr></td>';
			$source .= '<td>'.$r['user_host'].'</td>';
			$source .= '<td>'.$r['browser'].'</td>';
			$source .= '<td align="center">'.(($r['is_clean'] == 1)?'<img src="<?=EE_HTTP?>img/ok16.gif" border="0" width="16px" height="16px">':'<img src="<?=EE_HTTP?>img/stop16.gif" border="0" width="16px" height="16px">').'</td>';
			$source .= '<td align="center">'.(($r['is_active'] == 1)?'<img src="<?=EE_HTTP?>img/ok16.gif" border="0" width="16px" height="16px">':'<img src="<?=EE_HTTP?>img/stop16.gif" border="0" width="16px" height="16px">').'</td>';
			$source .= '</tr>';
		}
		
		$source .= '</table>';

		return $source;
	}
	function FilterEdit()
	{
		global $sid, $edit, $cancel, $save, $modul, $aIP, $aAgentName, $aFilterPhisically, $aFilterActive, $aFilterPhisicallyCheck, $aFilterActiveCheck;

		if($aFilterPhisically == 'on') $aFilterPhisicallyCheck = 'checked';
		if($aFilterActive == 'on') $aFilterActiveCheck = 'checked';
//		if($save == 1 ){
		if(isset($_POST['save_x'])){
			if(!empty($edit))
			{
				$sql = 'update stat_rep_filters set user_host= "'.$aIP.'", browser = "'.$aAgentName.'", is_clean = '.(($aFilterPhisically == 'on')?1:0).', is_active = '.(($aFilterActive == 'on')?1:0).' ';	
				$sql .= ' where id = '.$edit;
				$res = db_sql_query($sql);
			}else{
				$sql = 'INSERT INTO stat_rep_filters(user_host, browser, is_clean, is_active) ';	
				$sql .= ' VALUES("'.$aIP.'", "'.$aAgentName.'", '.(($aFilterPhisically == 'on')?1:0).', '.(($aFilterActive == 'on')?1:0).')';
				$res = db_sql_query($sql);
				if($res){ header('Location: configuration.php?act=filters');exit;}
			}
			if($res){ 
				UpdateSessionsFilter();
				header('Location: configuration.php?act=filters');
				exit;
				}
//		}else if($cancel == 1) { header('Location: configuration.php?act=filters');exit;}
		}else if(isset($_POST['cancel_x'])) { header('Location: configuration.php?act=filters');exit;}
		else{
			if(!empty($edit))
			{
				$sql = 'select * from stat_rep_filters where id = '.$edit;	
				$r = db_sql_fetch_array(db_sql_query($sql));
				 $aIP = $r['user_host'];
				 $aAgentName = $r['browser'];
				 $aFilterPhisicallyCheck = ($r['is_clean'] == 1) ? 'checked' : '' ;
				 $aFilterActiveCheck = ($r['is_active'] == 1) ? 'checked' : '' ;
			}
			if(!empty($sid))
			{
				$sql = 'select browser, ip_host from stat_rep_sessions where sid = '.$sid;
				$r = db_sql_fetch_array(db_sql_query($sql));
				$aAgentName = $r['browser'];
				$aFilterPhisicallyCheck = 'checked';
				$aFilterActiveCheck = '';
				 $aIP = $r['ip_host'];
			}
		}
		
		$source = parse($modul.'/addfilter');
		return $source;
	}
	function AddNewFilter()
	{
		global $sid;	
		$sql = 'select ip_host, browser from stat_rep_sessions where sid = '.$sid;
		$r = @db_sql_fetch_array(db_sql_query($sql));
		if($r['user_host'] != '' || $r['browser'] != ''){
			$sql_insert = 'INSERT INTO stat_rep_filters(user_host, browser, is_clean, is_active) ';	
			$sql_insert .= ' VALUES("'.$r['ip_host'].'", "'.$r['browser'].'", 1, 1)';
			@db_sql_query($sql_insert);
			UpdateSessionsFilter();
		}
	}
	function getAgentTypesOptions()
	{
		global $existedAgentType, $act;
		$is_useragent = ($act == 'agent_edit') ? 1 : 0;

		$sql = 'select distinct browser_name from stat_rep_browsers where is_useragent = '.$is_useragent;
		$rs = db_sql_query($sql);
		$s = '';
		while($r = db_sql_fetch_array($rs))
		{
			$ch = ($existedAgentType == $r['browser_name'])?' selected ':'';
			$s .= '<option '.$ch.' value="'.$r['browser_name'].'">'.$r['browser_name'].'</option>';
		}
		return $s;
	}

	function getFiltersWhere()
	{
		$sql_filter = 'select user_host, browser from stat_rep_filters where is_active = 1';
		$rs_filter = db_sql_query($sql_filter);
		$wheres = array();
		while($filter = db_sql_fetch_array($rs_filter))
		{
			$user_host = $filter['user_host'];
			$browser = $filter['browser'];
			$wh = array();
			if(!empty($user_host) && $user_host != '*') $wh[] = ' ip_host not like "'.$user_host.'"';
			if(!empty($browser) && $browser != '*') $wh[] = ' browser not like "'.$browser.'"';
			$wheres[] = '( '.join(' and ', $wh).' )';
		}
		$where = ( count($wheres) == 0 )? '' : join(' and ', $wheres);
		return $where;
	}
	function getBrowserFilter()
	{
		$sql = 'select DISTINCT browser_string from stat_rep_browsers ';
		$rs = db_sql_query($sql);
		$filters = array();
		while($r = db_sql_fetch_array($rs))
		{
			$filters[] = ' rs.browser not like "'.$r['browser_string'].'" ';
		}
		$where = (count($filters) == 0)?'': ' ,  stat_rep_browsers rb where '.join(' and ', $filters) ;
		return $where;
	}

	function UpdateSessionsFilter()
	{
		$where = getFiltersWhere();
		
		if(strlen($where) != 0 ){
			db_sql_query('update stat_rep_sessions set is_filtered = 1');
			$sql_update = 'update stat_rep_sessions set is_filtered = 0 where '.$where;
			db_sql_query($sql_update);
		//	print '<hr>'.$sql_update.'<hr>';
		}
	}

?>