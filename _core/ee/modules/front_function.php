<?php

function str_to_title($str)
{
	return case_title_all(words($str));
}

function words($str)
{
	return str_replace('_', ' ', $str);
}

function select_options_list($sql, $selected='', $blank='', $debug=0) {
	global $$selected;
	
	if (empty($blank)) $blank = array('',''); 
		else $blank=explode(':',$blank);
	$blank_value  = $blank[0];
	$blank_option = ($blank[1]!='')?((DEBUG_MODE?$blank_value.': ':'').$blank[1]):('');

	$s='<option value="'.$blank_value.'">'.$blank_option.'</option>'."\n";

	if (!strpos(strtolower($sql),'order by'))
		$sql=$sql.' order by 2';
	$rs=viewsql($sql, $debug);
	while ($r=db_sql_fetch_array($rs)) {
		$s.='<option value="'.$r[0].'"'.($r[0]==$$selected?' selected':'').'>'.(DEBUG_MODE?$r[0].': ':'').$r[1]."\n";
	}
	return $s;
}


function country_list($tag_name='country') {
	$sql = 'select name as id, name from country order by name';
	$s = select_options_list($sql, $tag_name);
	return $s;
}

function language_list($tag_name='language', $blank) {
	$sql = '
		SELECT language_code as id, language_name
		  FROM v_language
		 WHERE status=1
		 ORDER BY 1
	';
	$s = select_options_list($sql, $tag_name, ':'.$blank);
	return $s;
}

function nl__multiple_groups_list($tag_name='page_subscribe_group')
{
	global $t;
	$arr = array();
	$r = db_sql_query('SELECT * from content where var LIKE \'page_subscribe_group%\' and page_id='.sqlValue($t));
	while ($f = db_sql_fetch_assoc($r))
	{
		$arr[]=$f["val"];
	}
	$sql = 'select id, group_name from nl_group WHERE nl_group.show_on_front=1 order by 2';
	$r = db_sql_query($sql);
//	$s='<option value="\'\'"></option>'."\n";
	$s = '';
	while ($f = db_sql_fetch_assoc($r))
	{
		$s.='<option value="'.$f["id"].'"'.(in_array($f["id"],$arr)==1?' selected':'').'>'.$f["group_name"]."\n";
	}
	return $s;
}

function nl_groups_list($tag_name='nl_group_id') {
	$sql = 'select id, group_name from nl_group order by 2';
	$s = select_options_list($sql, $tag_name);
	return $s;
}

function nl_languages_list($tag_name='language') {
	$sql = 'select language, language from nl_subscriber union SELECT language_code as id, language_name FROM v_language WHERE status=1 ORDER BY 2';
	$s = select_options_list($sql, $tag_name);
	return $s;
}

function nl_subscriber_status_list($tag_name='status') {
	$sql = 'select id, status from nl_subscriber_status order by 2';
	$s = select_options_list($sql, $tag_name);
	return $s;
}

function nl_tpl_list($tag_name='email_tpl') {
	if (EE_DBMS == 'mssql')
 		$sql = 'select file_name, (file_name+\'.tpl\') as tpl from tpl_files where file_name like \'nl/%\' ';
	elseif (EE_DBMS == 'mysql')
 		$sql = 'select file_name, CONCAT(file_name,\'.tpl\') as tpl from tpl_files where file_name like \'nl/%\' ';

	$s = select_options_list($sql, $tag_name, 'nl/empty:Empty template');
	return $s;
}

function nl_list() {
	global $edit;
	$sql='select a.email_subject, a.email_id from v_nl_email AS a,ms_mail AS b WHERE a.email_status=\'sent\' AND a.email_id=b.original_id GROUP BY a.email_subject ORDER BY b.date_reg DESC LIMIT 2';
	viewsql($sql);
	$r = db_sql_query($sql);
	$s = array();
	while ($f=db_sql_fetch_assoc($r))
	{
		$i++;
		$f["pos"]=$i % 2;
		$s[]=$f;
	}
	if (!isset($edit)) {
	return parse_array_to_html($s,"center_newsletter_block");
	} else {return cms("news_letter_body_".$edit); }
}

function nl_get($id_news_letter=0) { //0-last newsletter
	global $nl_date_reg,$nl_subject, $nl_body;

	if ($id_news_letter==0)
		$sql = 'select DATE_FORMAT(date_reg,\'%d.%m.%Y\') as nl_date_reg, subject as nl_subject, body as nl_body from v_ms_mail WHERE status=\'sent\' ORDER BY id DESC LIMIT 1';
	else
		$sql = 'select DATE_FORMAT(date_reg,\'%d.%m.%Y\') as nl_date_reg, subject as nl_subject, body as nl_body from v_ms_mail WHERE status=\'sent\' AND id='.sqlValue($id_news_letter);

	$r = db_sql_query($sql);
	$f = db_sql_fetch_assoc($r);

	$nl_date_reg = $f["nl_date_reg"];
	$nl_subject = $f["nl_subject"];
	$nl_body = $f["nl_body"];
}

//Emulate $_GET array
function _get($name){
	$url = $_SERVER['REQUEST_URI'];
	$pos = strpos($url, '?');
	$res = array();
	if($pos !== false)
	{
		$url = urldecode(substr($url, $pos+1));
		$get_array = explode('&', $url);
		for($i=0; $i<sizeof($get_array); $i++){
			$new_get_array = explode('=', $get_array[$i]);
			$res[$new_get_array[0]] = $new_get_array[1];
		}
	}
	if(array_key_exists($name, $res)){
		return $res[$name];
	}else{
		return null;
	}
}

?>