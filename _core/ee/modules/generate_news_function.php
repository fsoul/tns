<?php
/*
** Generates news by view (type_of_export) and by channel id
** $view - type of export (RSS, Atom etc)
** $channel_id - id of channel
*/

function generate_news($view, $channel_id)
{      
		$sqlItems = 'SELECT 
				a.item_title as title,
				a.item_description as description,
				a.item_link as link,
				FROM_UNIXTIME(a.item_pubDate,"%d-%m-%Y")  as pubDate,
				a.item_guid as guid,
				a.status_of_news as item_status,
				b.record_id as channel_id,
				b.status_id as channel_status	
			FROM
			
				('.create_sql_view_by_name('news_items').') as a

			INNER JOIN 

				('.create_sql_view_by_name('news_channels').') as b

			ON 
				b.record_id = a.item_channel_id

			AND
				b.record_id = '.$channel_id.'

			ORDER BY pubDate DESC';

		$sqlTemplate = '
		        	        SELECT template 

					FROM 	('.create_sql_view_by_name('news_export').') as news_export
				
					WHERE news_export.record_id = '.$view.'';

		$news_template = getField($sqlTemplate);  
                return parse_sql_to_html($sqlItems, EE_EXPORT_DIR.$news_template);
}

function show_news_item_content($news_id)
{
     $sql = 'SELECT * FROM ('.create_sql_view(GetField('SELECT id FROM object WHERE name = "News_items"')).') v WHERE v.record_id='.SQLValue($news_id).';';
     return parse_sql_to_html($sql,'nbad_news_show_row');
}

function show_generate_news($view, $channel_id)
{
	if($GLOBALS['admin_template']=='yes' && checkAdmin())
	{
		return print_admin_js().'news_export_id: '.cms('type_of_export').text_edit_cms('type_of_export').'<br>news_channel_id: '.cms('news_channel').text_edit_cms('news_channel');
	}
	else
	{
		header('HTTP/1.1 200');
		header('Status: 200');
		header('Content-Type: text/xml; charset='.getCharset());
		echo generate_news($view, $channel_id);
		exit;
	}
}
?>