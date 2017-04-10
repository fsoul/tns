<?php
// add statistic
function add_statistic()
{
	global $language;
	// все константы по посетителю
	$ipaddr=getenv("REMOTE_ADDR");        // get user ip
	$iphost=($_SERVER["REMOTE_HOST"] == '')?$ipaddr:$_SERVER["REMOTE_HOST"];        // get user ip
	$from_page=$_SERVER['HTTP_REFERER'];  // get referer
	$to_page= $_SERVER['REQUEST_URI'];     // get current page
	$to_page = preg_replace('/PHPSESSID=(.)+&/', '', $to_page);
	$to_page = preg_replace('/PHPSESSID=(.)+/', '', $to_page);
	$to_page = rtrim($to_page, '?');
	$to_page = rtrim($to_page, '&');

	if(preg_match("/.gif$/", $to_page) || preg_match("/.jpg$/", $to_page))
	{
		return;
	}
	$to_page = EE_HTTP_SERVER.$to_page;
	$browser=$_SERVER['HTTP_USER_AGENT']; // get user browser

	$date_now = date("Y-m-d H:i:s");
	$browser = (strlen($_SERVER['HTTP_USER_AGENT']) == 0) ? 'Unknown' : $_SERVER['HTTP_USER_AGENT'];
	$sql = 'INSERT INTO stat_online_pages(page_from, page, user_ip, user_host, browser, visit_date) VALUES("'.$_SERVER['HTTP_REFERER'].'", "'.$to_page.'", "'.getenv("REMOTE_ADDR").'", "'.$iphost.'", "'.$browser.'", NOW())';
	runsql($sql);
//	@db_sql_query($sql);
}


function check_ip($_ip, $_host)
{
	$sql = 'select count(*) from ips where value = "'.$_ip.'"';
	list($count) = @db_sql_fetch_array(db_sql_query($sql));
	if($count == 0)
	{
		$sql_insert = 'insert into ips(value, full_value) values("'.$_ip.'", "'.$_host.'")';
		db_sql_query($sql_insert);
	}
}

function check_browser($name)
{
	$sql = 'select name from browsers ';
	$rs = db_sql_query($sql);
	$exist = false;
	if(strlen($name) == 0) $name = 'Unknown';
	
	while($r = db_sql_fetch_array($rs)){
		if(@preg_match('/'.$r['name'].'/', $name) || $r['name'] == $name) $exist = true;
	}
	
	if($exist == false)
	{
		$sql_insert = sprintf('insert into browsers(id, name, type) values("", "%s", "USER")', $name);
		db_sql_query($sql_insert);
	}
////////////////////////////////////
	$sql = 'select count(*) from used_browsers where name= "'.$name.'"';
	list($count) = @db_sql_fetch_array(db_sql_query($sql));
	if($count == 0)
	{
		$sql_insert = 'insert into used_browsers(name) values("'.$name.'")';
	//	db_sql_query($sql_insert);
	}

}
function check_page($path = '')
{
	global $language;
	$default_rank = array();
	//$path = str_replace("&language=".$language, '', $path);
	//$path = str_replace("language=".$language, '', $path);

	$sql = sprintf('select count(*) from site_pages where path = "%s"', $path);
	list($count) = @db_sql_fetch_array(db_sql_query($sql));
	if($count == 0)
	{
		$sql_insert = sprintf('insert into site_pages(id, parent_id, sort_order, alias, path) values("", 0, 0, "", "%s")', $path);
		db_sql_query($sql_insert);
		$page_id = db_sql_insert_id();
		$user_types = getUserTypes();
		while(list($type_id, $value) = each($user_types))
		{
			db_sql_query('insert into page2rating(page_id, users_group_id, rating) values("'.$page_id.'", "'.$type_id.'", "'.$value.'")');
		}
	}
}

function getUserTypes()
{
	$sql = 'select * from stat_users_type';
	$rs = db_sql_query($sql);
	$types = array();
	while($r = db_sql_fetch_array($rs))
	{
		$types[$r['id']] = $r['default_value'];
	}
	return $types;
}


