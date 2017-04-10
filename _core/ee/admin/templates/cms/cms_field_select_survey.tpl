<select  style="margin:10px;" name="<%:cms_field_instance_name%>">
<option value="<%:option_value%>" <%iif:<%:option_value%>,<%:option_value_test%>,selected%>><%:option_text%></option>


	<%parse_sql_to_html:

		 	SELECT 			
				question.question as option_text\,
				question.record_id as option_value\,
				"<%:<%:cms_field_instance_name%>%>" as option_value_test			

			FROM
				(<%create_sql_view_by_name:question,1%>) as question
	
			WHERE
				question.active = 1
				
	,option%>
</select>
