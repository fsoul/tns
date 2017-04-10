<select style="width:100px" <%iif::readonly,,,disabled%> name="filter_<%:field_name%>">
<option value="">All
<%parse_sql_to_html:
	SELECT DISTINCT
		v.gallery_id as option_value\,
		v.<%iif:<%getField:SELECT distinct object_field_name FROM object_content a INNER JOIN object_field b on b.id = a.object_field_id WHERE b.object_field_type = 'TEXT' and b.object_id = '<%getField:SELECT id FROM object WHERE name = 'gallery'%>' limit 0\,1%>,,gallery_id,<%getField:SELECT distinct object_field_name FROM object_content a INNER JOIN object_field b on b.id = a.object_field_id WHERE b.object_field_type = 'TEXT' and b.object_id = '<%getField:SELECT id FROM object WHERE name = 'gallery'%>' limit 0\,1%>%> as option_text\,
		"<%:<%:field_name%>%>" as option_value_test
	   FROM (<%create_sql_view_by_name:gallery,1%>) as v
,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
