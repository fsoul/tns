<?
$publish_item_fields=array("title"=>"title","description"=>"description","pubDate"=>"pubDate");
$publish_channel_fields=array("title"=>"title","description"=>"description","author"=>"author","language"=>strtolower($language));

function get_channel_events($channel_id, $limit='', $status='')
{
	global $language; //, $default_language;
//	if ($language) { $lang=$language; } else {$lang=$default_language; }
	$sql = "SELECT *, DATE_FORMAT(PublishedDate, '%e %M %Y %H:%i:%s') pubDate from v_events_db
				WHERE language='$language'
				AND channel_id=$channel_id";
	if ($status) $sql.=" AND status_text='".$status."'";
	$sql .= " ORDER BY PublishedDate";
	if ($limit) $sql.=" LIMIT ".$limit;
	$rs = ViewSQL($sql,0);
	if (db_sql_num_rows($rs)) {
		$arr = array();
		for ($i=0; $i<db_sql_num_rows($rs); $i++) {
			$arr[] = db_sql_fetch_assoc($rs);
		}
	} else { $arr = 0; }
	return $arr;
}
function get_channel_params($channel_id) {

	global $language; //, $default_language;
//	if ($language) { $lang=$language; } else {$lang=$default_language; }
	$sql = "SELECT * from v_channel_db
				WHERE status=1
				AND language='$language'
				AND channel_id=$channel_id";
	$rs = ViewSQL($sql,0);
	if (db_sql_num_rows($rs)) {
		$arr = db_sql_fetch_assoc($rs);
	} else { $arr = 0; }

	return $arr;
}

function rss_headers() {

	global $encoding, $language, $export_run; //, $default_language;
//	if ($language) { $lang=$language; } else {$lang=$default_language; }
	$rs = ViewSQL("SELECT l_encode FROM V_language WHERE language_code='".$language."'",0);
	list($encoding) = db_sql_fetch_row($rs);
	if( get('admin_template')!="yes" && $export_run != 1) header("Content-type: text/xml");
}

function filter_by_status ($arr, $status) {

	if(!$arr) return '';
	if($status==-1) return $arr;
	$filtered = array();
	foreach ($arr as $row) {
		if ($row["status"]==$status) $filtered[]=$row;
	}
	return $filtered;
}

function array_2_rss($arr,$publish_fields) {
	global $status;
	$result=array();
	if (is_array($arr) > 0) foreach ($arr as $item) {
		$row = array();
		$ind=0;
		foreach ($publish_fields as $key=>$val) {
			if (isset($item[$val])) {
				$row[$ind]["name"]=$key;
				$row[$ind]["value"]=$item[$val];
			} else {
				$row[$ind]["name"]=$key;
				$row[$ind]["value"] = $val;
			}
			$ind++;
		}
		$result[] = $row;
	}
	return $result;
}

function get_news_published($pid,$tpl)
{
	$channel_id=cms("page_channel_".$pid);
	$limit = cms("page_news_limit_".$pid);
	$arr = get_channel_events($channel_id,$limit,PUBLISHED);
	if(!$arr) return "";
	return parse_array_to_html($arr,$tpl);
}

function get_news_archive($pid,$tpl)
{
	$channel_id=cms("page_channel_".$pid);
	$limit = cms("page_news_limit_".$pid);
	$arr = get_channel_events($channel_id,$limit,ARCHIVE);
	if(!$arr) return "";
	return parse_array_to_html($arr,$tpl);
}

function get_news_info($channel_id,$news_id,$tpl)
{
	$arr = get_channel_events($channel_id);
	if(!$arr) return '';
	$result = array();
	foreach ($arr as $row) {
		if ($row["news_id"]==$news_id) { $result[]=$row; break; }
	}
	return parse_array_to_html($result, $tpl);
}

function get_news_published_rss($pageref, $rss_template) {

	preg_match('/[?&]t=(\d+)/i',$pageref, $res);
	$pid = $res[1];
	$channel_id=cms("page_channel_".$pid);
	$limit = cms("page_news_limit_".$pid);
	$header = get_channel_params($channel_id);
	$items = get_channel_events($channel_id,$limit,PUBLISHED);
	return make_rss($header, $items, $rss_template);
}

function make_rss($header, $items, $rss_template) {

	global $publish_channel_fields,$publish_item_fields;
	$res="";
	$header = array_2_rss(array(0=>$header),$publish_channel_fields);
	$res .= parse_array_to_html($header[0],$rss_template);

	$items = array_2_rss($items,$publish_item_fields);
	foreach ($items as $row) {

		$res .= "\n<item>".parse_array_to_html($row,$rss_template)."</item>\n";
	}
	return $res;
}

?>