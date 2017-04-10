<select  style="margin:10px;" name="<%:cms_field_instance_name%>">
<option value=''></option>
	<%parse_sql_to_html:
		 	SELECT 			
				chan.channel_title as option_text\,
				chan.record_id as option_value\,
				"<%:<%:cms_field_instance_name%>%>" as option_value_test			
			FROM
				(<%create_sql_view_by_name:news_channels,1%>) as chan
			WHERE
				chan.status_id = 1
				
	,option%>
</select>
