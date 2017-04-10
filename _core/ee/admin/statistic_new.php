<?	
	$admin = true;
	$UserRole=0;
	$modul='statistic';
//********************************************************************
	include('../lib.php');
	include('statistic_function.php');
//********************************************************************
//	if(!CheckAdmin() or $UserRole!=ADMINISTRATOR) {echo parse('norights');exit;}
//********************************************************************
	rebuildInformation();

	function rebuildInformation()
	{
		$start_build = time();
		/*
		db_sql_query('TRUNCATE stat_rep_sessions');
		db_sql_query('TRUNCATE stat_rep_visits');
		db_sql_query('TRUNCATE stat_rep_pages');
		db_sql_query('TRUNCATE stat_rep_pageratings');
		db_sql_query('update stat_rep_pages set ratings = ""');
		updateRepPages();
		*/
		print '<pre>';
		$step1 = time();
		buildInformation();

		UpdateSessionsFilter();
		parseIP2Country();
		$end_build = time();
		print '<hr>OK<br>'.($end_build - $start_build).' seconds<br>';
		print 'Rating pages '.($step1 - $start_build).'<br>';
		list($ses_count) = db_sql_fetch_array(db_sql_query('select count(*) from stat_rep_sessions'));
		print 'Ses count = '.$ses_count.'<br>';
		list($visit_count) = db_sql_fetch_array(db_sql_query('select count(*) from stat_rep_visits'));
		print 'visit count = '.$visit_count.'<br>';
	}

	function buildInformation()
	{
		$deltaTime = 3600;
		$emptyRating = getUsers();
		
		$sql_filter = 'select user_host, browser from stat_rep_filters where is_clean = 1 and is_active = 1';
		$rs_filter = db_sql_query($sql_filter);
		$wheres = array();
		while($filter = db_sql_fetch_array($rs_filter))
		{
			$user_host = $filter['user_host'];
			$browser = $filter['browser'];
			$wh = array();
			if(!empty($user_host) && $user_host != '*') $wh[] = ' user_host not like "'.$user_host.'"';
			if(!empty($browser) && $browser != '*') $wh[] = ' browser not like "'.$browser.'"';
			$wheres[] = '( '.join(' and ', $wh).' )';
		}
		$where = ( count($wheres) == 0 )? '' : 'where '.join(' and ', $wheres);
		$sql = 'select op.browser, op.user_ip, op.user_host, op.page_from, op.visit_date, rb.id browser_id, rb.is_useragent from stat_online_pages op left join stat_rep_browsers rb on op.browser like rb.browser_string   '.$where.' group by browser, user_ip order by visit_date asc';
		$rs = db_sql_query($sql);
		$sql_last = 'select op.visit_date from stat_online_pages op left join stat_rep_browsers rb on op.browser like rb.browser_string   '.$where.' group by browser, user_host order by visit_date desc limit 1';
		list($last_visit_date) = db_sql_fetch_array(db_sql_query($sql_last)); 
		print 'GROUP count = '.db_sql_num_rows($rs).'<br>';
		while($r = db_sql_fetch_object($rs))
		{
			$browser_id = $r->browser_id;
			if(empty($browser_id)) $browser_id = 0;//checkBrowser($r->browser);
			$temp_time = 0;
			$sql_pages = 'select op.page, op.page_from, op.visit_date, rp.id page_id from stat_online_pages op left join stat_rep_pages rp on rp.path = op.page where browser = "'.$r->browser.'" and user_host = "'.$r->user_host.'" order by visit_date asc';

			$rs_pages = db_sql_query($sql_pages);
			$pages_visited = 0;
			$order_in_session = 0;
			$pages_string = '';
			$sessionRating = $emptyRating;
			while($row = db_sql_fetch_object($rs_pages)){

				$time = dateToTime($row->visit_date);
				if(abs($time - $temp_time) > $deltaTime){
					if($temp_time != 0)
					{
						closeSession($sid, $pages_visited, $visit_date, crc32($pages_string), $sessionRating);	
					}
					$sid = createNewSession($r, $browser_id, $row->visit_date, $row->page_from);
					$order_in_session = 0;
					$sessionRating = $emptyRating;
					$pages_string = '';
					$pages_visited = 0;
				}
				$temp_time = $time;

				$pages_visited++;
				$pages_string .= $row->page;
				$page_id = $row->page_id;
				if(empty($page_id)) $page_id = checkPage($row->page);
				$sessionRating = addRating($sessionRating, unserialize(stripslashes($row->ratings)));
				$visit_date = $row->visit_date;
				
				$sql_insert_visit  = 'INSERT INTO stat_rep_visits (page_id, order_in_session, session_id, visit_date) ';
				$sql_insert_visit .= ' VALUES('.$page_id.', '.$order_in_session.', '.$sid.', "'.$visit_date.'")';
				db_sql_query($sql_insert_visit);
				$vid = db_sql_insert_id();
				
				$order_in_session++;
			}
			closeSession($sid, $pages_visited, $visit_date, crc32($pages_string), $sessionRating);							
		}
		db_sql_query('delete from stat_online_pages where visit_date <= "'.$last_visit_date.'"'); 
	}
	
	function createNewSession($r, $browser_id, $visit_date, $page_from)
	{
		if(empty($browser_id)) $browser_id = 0;
		$is_useragent = (empty($r->is_useragent))?0:$r->is_useragent;
		$sql  = 'INSERT INTO stat_rep_sessions(browser, browser_id, is_useragent, ip, ip_host, visit_start_date, referer_page) ';
		$sql .= 'VALUES("'.$r->browser.'", "'.$browser_id.'", '.$is_useragent.', "'.$r->user_ip.'", "'.$r->user_host.'", "'.$visit_date.'", "'.$page_from.'")';
		db_sql_query($sql);
//		print $sql.'<br>';
//		print db_sql_error().'<br>';
		return db_sql_insert_id();
 	}
	
	function closeSession($sid, $pages_visited, $visit_finish_date, $crc32, $sessionRating = array())
	{
		arsort($sessionRating);
		$keys = array_keys($sessionRating);
		$user_type_id = $keys[0];
		$sql = 'UPDATE stat_rep_sessions SET pages_visited = '.$pages_visited.', visit_finish_date = "'.$visit_finish_date.'", path_code = '.$crc32.', ratings = "'.addslashes(serialize($sessionRating)).'", user_type_id = '.$user_type_id.' where sid = '.$sid;
		db_sql_query($sql);
	}
	
	function getUserRatings()
	{
		$rs = db_sql_query('select * from stat_rep_user_types');
		$types = array();
		while($r = db_sql_fetch_array($rs))
		{
			$types[$r['id']] = $r['default_rating'];
		}
		return $types;
	}
	function getUsers()
	{
		$rs = db_sql_query('select * from stat_rep_user_types');
		$types = array();
		while($r = db_sql_fetch_array($rs))
		{
			$types[$r['id']] = 0;
		}
		return $types;
	}
	
	function getFilters()
	{
		$sql = 'select user_host, browser from stat_rep_filters where is_clean = 1 and is_active = 1';
		$rs = db_sql_query($sql);
		$filters = array();
		while($r = db_sql_fetch_array($rs))
		{
			$filters[] = $r;
		}
		return $filters;
	}

	function getPageRating($page_id)
	{
		$rs = db_sql_query('select * from stat_rep_pagerating where page_id = '.$page_id); 
		$types = array();
		while($r = db_sql_fetch_array($rs))
		{
			$types[$r['user_type_id']] = $r['rating'];
		}
		$defaultTypes = getUserRatings();
		$resultRating = array();
		while(list($user_type_id, $default_rating) = each($defaultTypes))
		{
			if(empty($types[$user_type_id])){
				$resultRating[$user_type_id] = $default_rating;
				db_sql_query('insert into stat_rep_pagerating(user_type_id, page_id, rating) values('.$user_type_id.', '.$page_id.', '.$default_rating.')');
			}else{
				$resultRating[$user_type_id] = $types[$user_type_id] ;
			}
		}
		return $resultRating;
	}
	
	function updateRepPages()
	{
		$rs = db_sql_query('SELECT distinct page from stat_online_pages');
		while($r = db_sql_fetch_array($rs))
		{
			$page_id = checkPage($r['page']);
			$rating = getPageRating($page_id);
			db_sql_query('update stat_rep_pages set ratings = "'.addslashes(serialize($rating)).'" where id = '.$page_id);
		}

	}

	function checkPage($page)
	{
		$sql = 'select id from stat_rep_pages where path = "'.$page.'"';
		list($id) = db_sql_fetch_array(db_sql_query($sql));
		if(empty($id))
		{
			db_sql_query('insert into stat_rep_pages(path) values("'.$page.'")');
			$id = db_sql_insert_id();
		}
		return $id;
	}
	
	function checkBrowser($browser)
	{
		$sql = 'select id from stat_rep_browsers where browser_string like "'.$browser.'"';
		list($id) = db_sql_fetch_array(db_sql_query($sql));
		if(empty($id))
		{
			db_sql_query('insert into stat_rep_browsers(browser_name) values("'.$browser.'")');
			$id = db_sql_insert_id();
		}
		return $id;
	}
	function addRating($rating1, $rating2)
	{
		$result = array();
		while(list($key, $val1) = each($rating1))
		{
			$result[$key] = (int)$val1 + (int)$rating2[$key];
		}
		return $result;
	}
	function dateToTime($datetime)
	{
		list($date, $time) = split(' ', $datetime);
		list($year, $month, $day) = split('-', $date);
		list($h, $m, $s) = split(':', $time);
		return mktime($h, $m, $s, $month, $day, $year);
	}
	echo '!!';
?>
