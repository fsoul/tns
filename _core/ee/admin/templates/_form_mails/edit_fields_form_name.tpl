<%getField:<%strip_commas:SELECT form_name FROM (<%create_sql_view_by_name:formbuilder%>) AS v WHERE record_id="<%:<%:field_name%>%>" LIMIT 1%>%>
