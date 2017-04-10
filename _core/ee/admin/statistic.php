<?	
	$admin = true;
	$UserRole=0;
	$modul='statistic';
//********************************************************************
	include('../lib.php');
//********************************************************************
	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
//********************************************************************
	
	function list_statistic_all()
	{
		global $modul, $user_ip, $browser_type, $aDateFrom, $aDateTo, $user_type;

		$filters = array();
		if($aDateFrom != ''){ $filters[] = ' dates >= "'.$aDateFrom.'"'; }
		if($aDateTo != ''){	
			$filters[] = ' dates <= "'.$aDateTo.' 23:59:59"';
		}
		if($user_type != ''){ $filters[] = ' type = "'.$user_type.'"'; }
		if($browser_type != ''){ $filters[] = ' browser_type = "'.$browser_type.'"';}
		if($user_ip != ''){ $filters[] = ' ip = "'.$user_ip.'"';}

		$whereDate = join(' and ', $filters);

		
		list($start_date) = db_sql_fetch_row(db_sql_query('select dates from sessions order by dates asc limit 1'));
		list($end_date) = db_sql_fetch_row(db_sql_query('select dates from sessions order by dates desc limit 1'));

		$source = parse($modul.'/users_filter');
		$user_types = getTypes();

		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);

		$sql = 'select SUM(count) all_ip, count(*) count from sessions '.$where;
		list($count_all, $count_sessions) = db_sql_fetch_row(db_sql_query($sql));
		$sql_ip = 'select count(*) from sessions '.$where.' group by ip';
		$count_ip = db_sql_num_rows(db_sql_query($sql_ip));
		
		$source .= '<tr><td colspan=2 height=1 bgcolor=navy></td></tr>';
		if($aDateFrom == '' && $aDateTo == '') $source .= '<tr><td colspan=2 >от: <b>'.$start_date.'</b> по: <b>'.$end_date.'</b></td></tr>';
		$source .= '<tr><td colspan=2 height=1 bgcolor=navy></td></tr>';
		$source .= '<tr><td>Кол-во сессий</td><td>'.$count_sessions.'</td></tr>';
		$source .= '<tr><td>Кол-во хостов</td><td>'.$count_ip.'</td></tr>';
		$source .= '<tr><td>Кол-во хитов</td><td>'.$count_all.'</td></tr>';

		
		return $source;
	}
	function list_statistic_pages()
	{
		global $modul, $user_ip, $browser_type, $aDateFrom, $aDateTo, $user_type;

		$filters = array();
		if($aDateFrom != ''){ $filters[] = ' se.dates >= "'.$aDateFrom.'"'; }
		if($aDateTo != ''){	
			$filters[] = ' se.dates <= "'.$aDateTo.' 23:59:59"';
		}
		if($user_type != ''){ $filters[] = ' se.type = "'.$user_type.'"'; }
		if($browser_type != ''){ $filters[] = ' se.browser_type = "'.$browser_type.'"';}
		if($user_ip != ''){ $filters[] = ' se.ip = "'.$user_ip.'"';}

		$whereDate = join(' and ', $filters);

		
		$source = parse($modul.'/users_filter');
		$user_types = getTypes();
		$filters[] = ' p.path = st.page '; 
		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);

		$sql_sessions = 'select SUM(count) all_ip, count(*) count from sessions '.$where;
		
		$sql = 'select page path, count(*) count_hit, se.sid, p.alias from stat st, site_pages p join sessions se on st.sid = se.sid '.$where.' group by page order by count_hit desc';

		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr height="30px">';
			$source .= '<td><a href="'.$r['path'].'" target="_blank">to page</a>&nbsp;'.$r['path'].'</td>';
			$source .= '<td>'.$r['alias'].'</td>';
			$source .= '<td width="90" align="right">';
			$source .= $r['count_hit'];
			$source .= '</td>';
			$source .= '<td width="*"></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="5" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	function list_statistic()
	{
		global $browser, $ip;
		$sql = 'select * from stat order by dates asc limit 50';
		if(!empty($browser))
		{
			$sql = 'select * from stat, browsers where stat.browser like CONCAT(\'%\',browsers.name,\'%\') and browsers.id = '.$browser.' order by dates desc';
		}
		if(isset($_GET['ip']))
		{
			$sql = 'select * from stat where user_ip = "'.$_GET['ip'].'" order by dates';
		}

		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';
		$source.= '<tr bgcolor="#eeeeee" class="table_header">';
		$source.= '<td align="center" height="30">Browser</td>';
		$source.= '<td align="center">IP-address</td>';
		$source.= '<td align="center">From page</td>';
		$source.= '<td align="center">Page</td>';
		$source.= '<td align="center">Date - Time</td>';
		$source.= '<td width="*">&nbsp;</td></tr>';
		
		//print $sql.'<br>';

		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$time = date2time($r['dates']);
			$source .= '<tr height="30px">';
			$source .= '<td>'.$r['browser'].'</td>';
			$source .= '<td>'.$r['user_ip'].'</td>';
			$source .= '<td>'.$r['page_from'].'</td>';
			$source .= '<td>'.$r['page'].'</td>';
			$source .= '<td nowrap>'.$r['dates'].'</td>';
			$source .= '<td></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="6" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	
	function list_ips()
	{
		global $sub_act;
		if($sub_act == 'rebuild')
		{
			update_country_ip();
		}
		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';
		$source .= '<tr><td><a href="?act=ip&sub_act=rebuild">Update country</a></td></tr>'; 
		$sql = 'select user_ip, count(*) count, ips.type, ips.country , ips.block block  from stat left join ips on ips.value = user_ip group by user_ip';
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr height="30px">';
			$source .= '<td>';
			$source .='<a href="#" onClick="openIPs(\''.$r['user_ip'].'\')">Edit</a>||';
			$source .= '<a href="?act=stat&ip='.$r['user_ip'].'">select</a>&nbsp;';
			$source .= $r['user_ip'].'</td>';
			$source .= '<td>'.$r['country'].'</td>';
			$source .= '<td>'.$r['count'].'</td>';
			$source .= '<td>'.$r['type'].'&nbsp;&nbsp;'.(($r['block'] == 1)?'blocked':'open').'</td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="3" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	function update_country_ip()
	{
		$sql = 'select * from ips where country = ""';
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$country = get_country_by_ip($r['value']);
			$sql = 'update ips set country = "'.$country.'" where value = "'.$r['value'].'"'; 
			db_sql_query($sql);
		}
	}
	function list_browsers()
	{
		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';

//		$sql = 'select  browsers.name browser, browsers.type type, count(*) count, browsers.id from stat left join browsers on stat.browser like CONCAT(\'%\',browsers.name,\'%\') group by browser ' ;
		$sql = 'select  name browser, type, id, block from browsers';
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			list($count) = db_sql_fetch_array(db_sql_query('select count(*) count from stat where browser like \'%'.$r['browser'].'%\''));
			$source .= '<tr height="30px"><td>';
			$source .='<a href="#" onClick="openBrowsers(\''.$r['id'].'\')">Edit</a>||';
			if(!empty($r['id'])) $source .= '<a href="?act=stat&browser='.$r['id'].'">select</a>&nbsp;';
			$source .= $r['browser'];
			$source .= '</td><td>'.$count.'</td>';
			$source .= '<td width="50px">'.$r['type'].'</td>';
			$source .= '<td width="*">'.(($r['block'] == 1) ? 'blocked' : 'open' ).'</td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="4" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	
	function list_users()
	{
		global $modul, $user_ip, $browser_type, $aDateFrom, $aDateTo, $user_type;
		$filters = array();
		if($aDateFrom != ''){ $filters[] = ' dates >= "'.$aDateFrom.'"'; }
		if($aDateTo != ''){	
			$filters[] = ' dates <= "'.$aDateTo.' 23:59:59"';
		}

		if($user_type != ''){ $filters[] = ' type = "'.$user_type.'"'; }
		if($browser_type != ''){ $filters[] = ' browser_type = "'.$browser_type.'"';}
		if($user_ip != ''){ $filters[] = ' ip = "'.$user_ip.'"';}

		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);

		$source = parse($modul.'/users_filter');
		$user_types = getTypes();
		list($count_all) = db_sql_fetch_array(db_sql_query('select SUM(count) from sessions '.$where));
		$sql = 'select * from sessions '.$where.' order by count desc';
		$rs = db_sql_query($sql);
		$sessions = db_sql_num_rows($rs);
		
		
		if($aDateFrom == '' ){list($start_date) = db_sql_fetch_row(db_sql_query('select dates from sessions order by dates asc limit 1'));
		}else{ $start_date = $aDateFrom; }
		if($aDateTo == '') { list($end_date) = db_sql_fetch_row(db_sql_query('select dates from sessions order by dates desc limit 1')); }
		else{ $end_date = $aDateTo;}

		$source .= '<tr><td colspan="5">&nbsp;&nbsp;Период с <b>'.$start_date.'</b> по <b>'.$end_date.'</b></td></tr>';
		$source .= '<tr><td colspan="5">&nbsp;&nbsp;User sessions count = '.$sessions.'</td></tr>';
		$source .= '<tr><td><table>';
		while($r = db_sql_fetch_array($rs))
		{
			list($page_from, $start_dates) = db_sql_fetch_row(db_sql_query('select page_from, dates from stat where rid = "'.$r['rid_start'].'"'));
			list($end_dates) = db_sql_fetch_row(db_sql_query('select dates from stat where rid = "'.$r['rid_end'].'"'));
			$delta = date2time($end_dates) - date2time($start_dates);
			
			if($delta > 60 ){
				$format_time = round($delta/60). ' min '. ($delta%60).' sec';
			}else{ 
				$format_time = $delta.' sec';
			}
			
			$result = unserialize(stripslashes($r['marks']));
			$source .= '<tr>';
			$source .= '<td height="20" width="150">'.$start_dates.'</td>';
			$source .= '<td width="70">'.$r['ip'].'</td>';
			$source .= '<td width="70"><a href="?act=session&sid='.$r['sid'].'"><b>'.$r['type'].'</a></b></td>';
			$source .= '<td width="20">'.$r['count'].'</td>';
			$source .= '<td width="50"><nobr>'.($format_time).'</nobr></td>';
			//$source .= '&nbsp;'.join(' ', $result).'&nbsp;&nbsp;||';
			//$source .= '&nbsp;'.substr($r['browser'], 0, 20).'&nbsp;&nbsp;||';
			$source .= '<td width="*">'.$page_from.'</td>';
			$source .= '</tr>';
		}
		$source .= '</table></td></tr>';
		return $source;
	}
	function rebuildUserSection()
	{
		$start_build = time();
		db_sql_query('TRUNCATE `sessions`');
		buildUserSection();
		$end_build = time();
		return 'OK<br>'.($end_build - $start_build).' seconds';
	}
	function buildUserSection()
	{
		global $modul;
		$sql_count = 0;
		$start_build = getmicrotime();
		list($last_update_date) = db_sql_fetch_row(db_sql_query('select date_build from sessions order by date_build desc limit 1'));
		
		$user_types = getTypes();
		$sql = 'select  stat.browser, browsers.type, count(*) count, id from stat, browsers where stat.browser like CONCAT(\'%\',browsers.name,\'%\') and browsers.block = 0 group by stat.browser';
		$rs = db_sql_query($sql);
		$all_users = array();
		reset($user_types);
		while(list($type_id, ) = each($user_types)) $all_users[$type_id] = 0;
		
		
$sid = 0;

		while($r = db_sql_fetch_array($rs))
		{
			$browser_type = $r['type'];
			$browser_name = $r['browser'];

			$sql_ip = 'select user_ip, count(*) count from stat, ips where browser = "'.$r['browser'].'" and ips.value = stat.user_ip and ips.block = 0 group by user_ip';
			$rs_ip = db_sql_query($sql_ip);
			
			while($r_ip = db_sql_fetch_array($rs_ip))
			{
				$user_ip = $r_ip['user_ip'];
				$sql_all = sprintf('select rid, dates, page from stat where browser = "%s" and user_ip = "%s" and dates > "'.$last_update_date.'" order by dates desc',  $r['browser'], $r_ip['user_ip'] );
				$rs_all = db_sql_query($sql_all);
				
				$data_temp = time();
				$dates_prev = time();
				$start_time = 0;
				$marks = array();
				
				$sid++;
				$rid_start = 0;
				$rid_end = 0;
				$count = 0;
				$ses_string = '';
				while($row = db_sql_fetch_array($rs_all))
				{
					$count++;
					$rid_start = $row['rid'];
					if($rid_end == 0) $rid_end = $row['rid'];

					//
					if($start_time == 0) $start_date = $row['dates'];
					$delta = $dates_prev - date2time($row['dates']);
					$dates_prev = date2time($row['dates']);
					$page =  $row['page'];
					reset($user_types);
					while(list($type_id, ) = each($user_types))
					{
						$rank_sql = 'select pr.rating from page2rating pr, site_pages pg where pr.page_id = pg.id and pr.users_group_id = '.$type_id.' and pg.path = "'.$page.'"';
						$rank_rs = db_sql_query($rank_sql);
						if(db_sql_num_rows($rank_rs) == 0)
						{
							$rank = 0;
						}else{
							list($rank) = db_sql_fetch_array($rank_rs); 
						}
						$marks[$type_id] += $rank;
					}
					if( $delta > 3600){
						buildSessions($marks, $sid, $rid_start, $rid_end, $count, $browser_type, $browser_name, $user_ip, crc32($ses_string));
						$ses_string = '';
						$marks = array();
						$sid++;
						$count = 0;
					}
					// set sid
					$ses_string .= $row['page']; 
					$sql_setsid = 'update stat set sid = "'.$sid.'" where rid = "'.$row['rid'].'" ';
					db_sql_query($sql_setsid);
				}
				//// update session
				buildSessions($marks, $sid, $rid_start, $rid_end, $count, $browser_type, $browser_name, $user_ip, crc32($ses_string));
				$ses_string = '';
				////

			}
		}
		$end_build = getmicrotime();
		return 'ok<br>'.($end_build - $start_build).' sec<br>';
	}
	function buildSessions($_marks, $_sid, $_rid_start, $_rid_end, $count, $browser_type, $browser_name, $user_ip, $crc32)
	{
		if($count == 0) return;
		$user_types = getTypes();
		reset($_marks);
		$result = array();
		$max = 0;
		$result_type = '';
		while(list($type_id, $sum_mark) = each($_marks))
		{
			if($max < $sum_mark)
			{
				$max = $sum_mark;
				$result_type = $user_types[$type_id];
				$result_type_id = $type_id;
			}
			$result[] = $user_types[$type_id].':'.$sum_mark;
		}

		$sql_session = 'update stat set type= "'.$result_type.'" , marks = "'.addslashes(serialize($result)).'" where sid = '.$_sid.'';
//		print $sql_session;
		db_sql_query($sql_session);
		list($session_date) = db_sql_fetch_row(db_sql_query('select dates from stat where rid = "'.$_rid_end.'"'));
		$sql_insert = 'insert into sessions(sid, rid_start, rid_end, marks, type, count, browser_type, browser, ip, dates, date_build, crc32) values("'.$_sid.'", "'.$_rid_start.'", "'.$_rid_end.'", "'.addslashes(serialize($result)).'", "'.$result_type.'", "'.$count.'", "'.$browser_type.'", "'.$browser_name.'", "'.$user_ip.'", "'.$session_date.'", "'.date("Y-m-d H:i:s").'", '.$crc32.')';
		db_sql_query($sql_insert);
	}
	function user_type()
	{
		global $user_type;
		$sql = 'select type from stat group by type';

		$rs = db_sql_query($sql);
		$txt = '';
		while(list($_type) = db_sql_fetch_row($rs))
		{
			if($user_type == $_type) $txt .= '<option selected value="'.$_type.'">'.$_type;
			else $txt .= '<option value="'.$_type.'">'.$_type;
		}
		return $txt;
	}
	function getUserIps()
	{
		global $user_ip;
		$sql = 'select user_ip from stat group by user_ip';

		$rs = db_sql_query($sql);
		$txt = '';
		while(list($_ip) = db_sql_fetch_row($rs))
		{
			if($user_ip == $_ip) $txt .= '<option selected value="'.$_ip.'">'.$_ip;
			else $txt .= '<option value="'.$_ip.'">'.$_ip;
		}
		return $txt;
	}
	function list_pages()
	{
		$sql = 'select * from stat_users_type';
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$types[$r['id']] = $r['name'];
		}

		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';

		$source .= '<tr height="30px"><td>Page path</td>';
		$source .= '<td width="*">Title</td>';
		$source .= '<td width="20">Rank</td>';
		$source .= '<td width="*">'.join('&nbsp;|&nbsp;', $types);
		$source .= '</td>';
		$source .= '<td width="*"></td>';
		$source .='</tr>';
		$source .='<tr><td height="1" colspan="4" bgcolor="navy"></td></tr>';

		$sql = 'select * from site_pages';
		$rs = db_sql_query($sql);
		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr height="30px">';
			$source .= '<td><a href="'.$r['path'].'" target="_blank">to page</a>&nbsp;'.$r['path'].'</td>';
			$source .= '<td>'.$r['alias'].'</td>';
			$source .= '<td width="20"><a href="#" onclick = "openWin(\''.$r['id'].'\')">Rank&nbsp;page</a></td>';
			$source .= '<td width="90" align="right">';
			$ranks = array();
			reset($types);
			while(list($type_id, $name) = each($types)){
				$sql_select = 'select rating from page2rating where page_id = '.$r['id'].' and users_group_id = '.$type_id;
				list($rank) = db_sql_fetch_array(db_sql_query($sql_select));
				$ranks[] = $rank; 
			}
			$source .= join('&nbsp;|&nbsp;', $ranks);
			$source .= '</td>';
			$source .= '<td width="*"></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="5" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	function getTypes()
	{
		$sql = 'select * from stat_users_type';
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
	function browser_types()
	{
		global $browser_type;
		$types = array('USER', 'ROBOT');
		$txt = '';
		while(list(, $type) = each($types))
		{
			if($browser_type == $type) $txt .= '<option selected value="'.$type.'">'.$type;
			else $txt .= '<option value="'.$type.'">'.$type;
		}
		return $txt;
	}
	
	function session_show()
	{
		global $sid;
		$sql = 'select s.*, p.alias from stat s left join site_pages p on p.path = s.page where sid = "'.$sid.'" ';
		$rs = db_sql_query($sql);
		
		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';
		$source.= '<tr bgcolor="#eeeeee" class="table_header">';
		$source.= '<td align="left" colspan="6"><a href="javascript:window.history.back()">Назад</a></tr>';
		$dates_prev = 0;
		$rows = array();
		$deltas = array();
		while($r = db_sql_fetch_array($rs))
		{
			$delta = date2time($r['dates']) - $dates_prev;
			$dates_prev = date2time($r['dates']);
			$rows[] = $r;
			$deltas[] = $delta;
		}
		$r1 = $rows[0]; 
		list($agent, $user_type, $ip, $start_date, $count, $rid_end) = db_sql_fetch_row(db_sql_query('select browser, type, ip, dates, count, rid_end from sessions where sid = "'.$sid.'"'));
		list($end_dates) = db_sql_fetch_row(db_sql_query('select dates from stat where rid = "'.$rid_end.'"'));
		$delta = date2time($end_dates) - date2time($start_date);
		if($delta > 60 ){
			$format_time = round($delta/60). ' min '. ($delta%60).' sec';
		}else{ 
			$format_time = $delta.' sec';
		}
		
		$source .= '<tr height="20px"><td colspan="4">Посетитель <b>'.$user_type.'</b></td></tr>';
		$source .= '<tr height="20px"><td colspan="4">IP - address <b>'.$ip.'</b></td></tr>';
		$source .= '<tr height="20px"><td colspan="4">Дата <b>'.$start_date.'</b></td></tr>';
		$source .= '<tr height="20px"><td colspan="4">Глубина <b>'.$count.'</b></td></tr>';
		$source .= '<tr height="20px"><td colspan="4">Длительность <b>'.$format_time.'</b></td></tr>';
		$source .= '<tr><td colspan="4">Agent : '.$agent.'</td></tr>';
		$source .='<tr><td height="1" colspan="6" bgcolor="navy"></td></tr>';
		$source .= '<tr height="30px">';
		$source .= '<td colspan="4">Пришел с: <a href="'.$r1['page_from'].'" target="_blank">'.$r1['page_from'].'</a></td>';
		$source .='</tr>';
		$source .='<tr><td height="1" colspan="6" bgcolor="navy"></td></tr><tr><td colspan="6"><table>';
		while(list($i, $r) = each($rows))
		{
			$delta = $deltas[$i+1];
			if(empty($deltas[$i+1])) $delta = 0;
			if($delta > 60 ){
				$format_time = round($delta/60). ' min '. ($delta%60).' sec';
			}else{ 
				$format_time = $delta.' sec';
			}
			$source .= '<tr height="20px">';
			$time = split(" ", $r['dates']);
			$source .= '<td nowrap width="30">'.$time[1].'</td>';
			$source .= '<td nowrap width="50"><nobr>'.$format_time.'</nobr></td>';
			$source .= '<td  nowrap width="50">'.$r['alias'].'</td>';
			$source .= '<td width="*"><a href="'.$r['page'].'" target="_blank">'.$r['page'].'</a></td>';
			$source .='</tr>';
		}
		$source .= '</table></td></tr>';
		return $source;
	}
	function pages_in()
	{
		$sql = 'select s.rid_start, t.page, count(s.rid_start) total from sessions s, stat t where s.rid_start = t.rid group by t.page order by total desc';
		$rs = db_sql_query($sql);
		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';
		$source.= '<tr bgcolor="#eeeeee" class="table_header">';
		$source.= '<td align="center">Page</td>';
		$source.= '<td align="center"></td>';
		$source.= '<td width="*">&nbsp;</td></tr>';

		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr height="30px">';
			$source .= '<td>'.$r['page'].'</td>';
			$source .= '<td>'.$r['total'].'</td>';
			$source .= '<td></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="3" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	function pages_out()
	{
		$sql = 'select s.rid_end, t.page, count(s.rid_end) total from sessions s, stat t where s.rid_end = t.rid group by t.page order by total desc';
		$rs = db_sql_query($sql);
		$source = '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">';
		$source.= '<tr bgcolor="#eeeeee" class="table_header">';
		$source.= '<td align="center">Page</td>';
		$source.= '<td align="center"></td>';
		$source.= '<td width="*">&nbsp;</td></tr>';

		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr height="30px">';
			$source .= '<td>'.$r['page'].'</td>';
			$source .= '<td>'.$r['total'].'</td>';
			$source .= '<td></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="3" bgcolor="navy"></td></tr>';
		}
		return $source;
	}
	function setMonthList()
	{
		global $modul, $user_ip, $browser_type, $aDateFrom, $aDateTo, $aDateFrom, $aDateTo, $user_type, $period, $periodCheck;
		$period = true;
		$filters = array();
		if($aDateFrom != ''){ $filters[] = ' dates >= "'.$aDateFrom.'"'; }
		if($aDateTo != ''){	
			$filters[] = ' dates <= "'.$aDateTo.' 23:59:59"';
		}
		if($user_type != ''){ $filters[] = ' type = "'.$user_type.'"'; }
		if($browser_type != ''){ $filters[] = ' browser_type = "'.$browser_type.'"';}
		if($user_ip != ''){ $filters[] = ' ip = "'.$user_ip.'"';}

		$whereDate = join(' and ', $filters);

		
		list($start_date) = db_sql_fetch_row(db_sql_query('select dates from sessions order by dates asc limit 1'));
		list($end_date) = db_sql_fetch_row(db_sql_query('select dates from sessions order by dates desc limit 1'));

		$user_types = getTypes();

		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);

		$sql = 'select SUM(count) all_ip, count(*) count from sessions '.$where;
		print $sql;
		list($count_all, $count_sessions) = db_sql_fetch_row(db_sql_query($sql));
		$sql_ip = 'select count(*) from sessions '.$where.' group by ip';
		$count_ip = db_sql_num_rows(db_sql_query($sql_ip));
		if(isset($period))
		{
			$periodCheck = 'checked';
			$filters2 = array();
			if($aDateFrom2 != ''){ $filters2[] = ' dates >= "'.$aDateFrom2.'"'; }
			if($aDateTo2 != ''){	
				$filters2[] = ' dates <= "'.$aDateTo2.' 23:59:59"';
			}
			if($user_type != ''){ $filters2[] = ' type = "'.$user_type.'"'; }
			if($browser_type != ''){ $filters2[] = ' browser_type = "'.$browser_type.'"';}
			if($user_ip != ''){ $filters2[] = ' ip = "'.$user_ip.'"';}

			$whereDate2 = join(' and ', $filters2);
			$where2 = (count($filters2) == 0)?'':' where '.join(' and ', $filters2);

			$sql2 = 'select SUM(count) all_ip, count(*) count from sessions '.$where2;
			list($count_all2, $count_sessions2) = db_sql_fetch_row(db_sql_query($sql2));
			$sql_ip2 = 'select count(*) from sessions '.$where2.' group by ip';
			$count_ip2 = db_sql_num_rows(db_sql_query($sql_ip2));
		}
		
		$source = parse($modul.'/users_filter2');

		$source .= '<tr><td colspan=3 height=1 bgcolor=navy></td></tr>';
		if($aDateFrom == '' && $aDateTo == '') $source .= '<tr><td colspan=3 >от: <b>'.$start_date.'</b> по: <b>'.$end_date.'</b></td></tr>';
		$source .= '<tr><td colspan=3 height=1 bgcolor=navy></td></tr>';
		$source .= '<tr><td colspan="2"></td><td>период 1</td><td>период 2</td></tr>';
		$source .= '<tr><td colspan="2">Кол-во сессий</td><td>'.$count_sessions.'</td><td>'.$count_sessions2.'</td></tr>';
		$source .= '<tr><td colspan="2">Кол-во хостов</td><td>'.$count_ip.'</td><td>'.$count_ip2.'</td></tr>';
		$source .= '<tr><td colspan="2">Кол-во хитов</td><td>'.$count_all.'</td><td>'.$count_all2.'</td></tr>';

		//return $source;
		/////////////Page 1//////////////////////

		$filters = array();
		if($aDateFrom != ''){ $filters[] = ' se.dates >= "'.$aDateFrom.'"'; }
		if($aDateTo != ''){	
			$filters[] = ' se.dates <= "'.$aDateTo.' 23:59:59"';
		}
		if($user_type != ''){ $filters[] = ' se.type = "'.$user_type.'"'; }
		if($browser_type != ''){ $filters[] = ' se.browser_type = "'.$browser_type.'"';}
		if($user_ip != ''){ $filters[] = ' se.ip = "'.$user_ip.'"';}
		$whereDate = join(' and ', $filters);
		$filters[] = ' p.path = st.page '; 
		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);
		$sql_sessions = 'select SUM(count) all_ip, count(*) count from sessions '.$where;
		$sql = 'select page path, count(*) count_hit, se.sid, p.alias from stat st, site_pages p join sessions se on st.sid = se.sid '.$where.' group by page order by count_hit desc';
		$rs = db_sql_query($sql);
		$result_array = array();
		while($r = db_sql_fetch_array($rs))
		{
			$result_array[$r['path']] = $r['count_hit'];
			/*
			$source .= '<tr height="30px">';
			$source .= '<td><a href="'.$r['path'].'" target="_blank">to page</a>&nbsp;'.$r['path'].'</td>';
			$source .= '<td>'.$r['alias'].'</td>';
			$source .= '<td width="90" align="right">';
			$source .= $r['count_hit'];
			$source .= '</td>';
			$source .= '<td width="*"></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="5" bgcolor="navy"></td></tr>';
			*/
		}
		/////////////Page 2//////////////////////

		$filters = array();
		if($aDateFrom != ''){ $filters[] = ' se.dates >= "'.$aDateFrom.'"'; }
		if($aDateTo != ''){	
			$filters[] = ' se.dates <= "'.$aDateTo.' 23:59:59"';
		}
		if($user_type != ''){ $filters[] = ' se.type = "'.$user_type.'"'; }
		if($browser_type != ''){ $filters[] = ' se.browser_type = "'.$browser_type.'"';}
		if($user_ip != ''){ $filters[] = ' se.ip = "'.$user_ip.'"';}
		$whereDate = join(' and ', $filters);
		$filters[] = ' p.path = st.page '; 
		$where = (count($filters) == 0)?'':' where '.join(' and ', $filters);
		$sql_sessions = 'select SUM(count) all_ip, count(*) count from sessions '.$where;
		$sql = 'select page path, count(*) count_hit, se.sid, p.alias from stat st, site_pages p join sessions se on st.sid = se.sid '.$where.' group by page order by count_hit desc';
		$rs = db_sql_query($sql);
		$result_array2 = array();
		$source .= '<tr><td colspan=3 height=1 bgcolor=navy></td></tr>';
		while($r = db_sql_fetch_array($rs))
		{
			$source .= '<tr height="30px">';
			$source .= '<td><a href="'.$r['path'].'" target="_blank">to page</a>&nbsp;'.$r['path'].'</td>';
			$source .= '<td>'.$r['alias'].'</td>';
			$source .= '<td>'.$result_array[$r['path']].'</td>';
			$source .= '<td width="90" align="right">';
			$source .= $r['count_hit'];
			$source .= '</td>';
			$source .= '<td width="*"></td>';
			$source .='</tr>';
			$source .='<tr><td height="1" colspan="5" bgcolor="navy"></td></tr>';
		}
		/////////////Result//////////////////////

		return $source;
	}
	// get country by ip
	function get_country_by_ip($user_ip='')
	{
	  if ($user_ip)
	   {  // Запрос на получение страны по IP
		 $url = "http://ip-to-country.webhosting.info/node/view/36";
		 $ch = @curl_init();
		 curl_setopt($ch, CURLOPT_URL,$url); // set url to post to
		 curl_setopt($ch, CURLOPT_FAILONERROR, 1);
		 curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);// allow redirects
		 curl_setopt($ch, CURLOPT_RETURNTRANSFER,1); // return into a variable
		 curl_setopt($ch, CURLOPT_TIMEOUT, 3); // times out after 4s
		 curl_setopt($ch, CURLOPT_POST, 1); // set POST method
		 curl_setopt($ch, CURLOPT_POSTFIELDS, "ip_address=$user_ip&submit=Find+Country"); // add POST fields
		 $result = curl_exec($ch); // run the whole process
		 curl_close($ch);
		 preg_match("/IP Address(.*?)belongs to(.*?)\./i", $result, $matches);

		 if (strlen($matches[2])>0)
		  {
			$matches[2]=strip_tags($matches[2]);
			if (!preg_match('/Dont/', $matches[2])) $country=$matches[2]; else $country="Unknown";
		  } else $country="Unknown";
		 return trim($country);
	   }
		else return;
	}
	function getmicrotime () 
	{ 
		list($usec, $sec) = explode(" ", microtime ()); 
	    return ((float)$usec + (float)$sec)*1000; 
	} 

	function stat_content()
	{
		global $act;
		$res = '';
		switch($act)
		{
			case 'stat_all':
				$res = list_statistic_all();
				break;
			case 'stat_pages':
				$res = list_statistic_pages();
				break;
			case 'browser':
				$res = list_browsers();
				break;
			case 'ip':
				$res = list_ips();
				break;
			case 'users':
				$res = list_users();
				break;
			case 'pages':
				$res = list_pages();
				break;
			case 'session':
				$res = session_show();
				break;
			case 'in':
				$res = pages_in();
				break;
			case 'out':
				$res = pages_out();
				break;
			case 'rebuild':
				$res = rebuildUserSection(); 
				break;
			case 'build':
				$res = buildUserSection(); 
				break;
			case 'month':
				$res = setMonthList(); 
				break;
//			default: buildUserSection(); 
		}

		return $res; 
	}

	echo parse($modul.'/list');
?>
