<?

$channel_table = "channel_db";
$channel_view = "v_channel_db";
//$channel_fields = array("channel_id","channel_status", "channel_author","channel_type","channel_title","channel_description","channel_rss","channel_copyright");
$channel_fields = array("channel_id", "status", "author","channel_type","title","description","rss","copyright");
$channel_date_fields = array();
$channel_identifier = "channel_id";

function DeleteChannel($channel_id)
{
	global $channel_table, $channel_fields;
	return DeleteItem($channel_table, $channel_fields, $channel_id);
}
function AddChannel()
{
	global $channel_table, $channel_fields, $channel_identifier;
	$channel_multilang_fields = array();
	return AddItem($channel_table, $channel_fields, $channel_multilang_fields,$channel_identifier);
}

function EditChannel($channel_id)
{
	global $channel_table, $channel_fields, $channel_identifier;
	$channel_multilang_fields = array();
	return EditItem($channel_table, $channel_fields, $channel_multilang_fields, $channel_identifier, $channel_id);
}
function GetChannel($channel_id)
{
	global $channel_view, $channel_identifier;
	GetItem($channel_id, $channel_view, $channel_identifier);
}

/*
// depricated ?
function CreateViewChannel()
{
	global $channel_table, $channel_view, $channel_fields, $default_language, $language, $channel_date_format, $channel_date_fields, $channel_identifier;
	$add_sql_join = '';
	CreateCustomView($channel_view, $channel_table, $channel_fields, array(), $channel_date_format, $channel_identifier, $add_sql_join, 1);
	
}
*/

function build_channel_list($current = '')
{
	global $language, $default_language;
	$ret='';
	$sql = 'select channel_id, title from v_channel_db WHERE status=1'; // WHERE c.var = CONCAT('.sqlValue($prefix).',t.id)';
		if (strlen($language)>0)
		 	$sql.=' AND language='.sqlValue($language);
		else 
		 	$sql.=' AND language='.sqlValue($default_language);
		
	$sql.= ' ORDER BY channel_id';
	$res = ViewSQL($sql);
	while ($row = db_sql_fetch_assoc($res))
	{
		if ($current == $row['channel_id'])
			$ret .= '<option value="'.$row['channel_id'].'" selected>'.$row['title'].'</option>';
		else
			$ret .= '<option value="'.$row['channel_id'].'">'.$row['title'].'</option>';
	}
	return $ret;
}


