<?

$news_table = "events_db";
$news_view = "v_events_db";
$news_fields = array("news_id", "title", "description", "SystemDate", "ExpiryDate", "DisplayDate", "PublishedDate", "status", "channel_id", "show_on_home", "category");
$news_multilang_fields = array("news_title","DisplayDate","news_text");
$news_date_fields = array("SystemDate","ExpiryDate","PublishedDate");
$news_date_format = "%d.%m.%Y";
$news_identifier = "news_id";

function DeleteNews($news_id)
{
	global $news_table, $news_fields;
	return DeleteItem($news_table, $news_fields, $news_id);
}
function AddNews()
{
	global $news_table, $news_fields, $news_identifier,$news_multilang_fields;
	return AddItem($news_table, $news_fields, $news_multilang_fields,$news_identifier);
}
function EditNews($news_id)
{
	global $news_table, $news_fields, $news_identifier,$news_multilang_fields;
	return EditItem($news_table, $news_fields, $news_multilang_fields, $news_identifier, $news_id);
}
function GetNews($news_id)
{
	global $news_view, $news_identifier;
	GetItem($news_id, $news_view, $news_identifier);
}
function CreateViewNews()
{
	global $news_table, $news_view, $news_fields, $default_language, $language, $news_date_format, $news_date_fields, $news_identifier;
	$add_sql_join = ', (select 
				CASE TRIM(val)
				      WHEN \'0\' THEN \'draft\'
				      WHEN \'1\' THEN \'published\'
				      WHEN \'2\' THEN \'archive\'
				END AS val
				from content
	 	  		where var = CONCAT(\''.$news_table.'_\',id,\'_status\')
		    	and language in (lan.language_code, \''.$default_language.'\') 
		  		order by CONCAT((case language when lan.language_code then \'0\' else \'1\' end) ,language) LIMIT 1
				) as status_text';	
	CreateCustomView($news_view, $news_table, $news_fields, $news_date_fields,$news_date_format,$news_identifier,$add_sql_join,1);
	
}
?>