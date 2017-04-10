<select  style="margin:10px;" name="<%:cms_field_instance_name%>">
<option value=''></option>
	<%parse_sql_to_html:
		 	SELECT 			
				g.gallery_title as option_text\,
				g.gallery_id as option_value\,
				"<%:<%:cms_field_instance_name%>%>" as option_value_test			
			FROM
			
				(<%create_sql_view_by_name:gallery,1%>) as g                       			
							
	,option%>
</select>
