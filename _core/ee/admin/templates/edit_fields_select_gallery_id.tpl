<%setValueOf:gallery_sub_sql_request,<%getField:SELECT distinct object_field_name FROM object_content a INNER JOIN object_field b on b.id = a.object_field_id WHERE b.object_field_type = 'TEXT' and b.object_id = '<%getField:SELECT id FROM object WHERE name = 'gallery'%>' limit 0\,1%>%>

<%iif:<%:gallery_sub_sql_request%>,,<span class="error">Please create gallery</span>,
<select <%iif::readonly,,,readonly%> name="<%:field_name%>">
<%parse_sql_to_html:SELECT DISTINCT v.gallery_id as option_value\, "<%:<%:field_name%>%>" as option_value_test\,v.<%iif:<%:gallery_sub_sql_request%>,,*,<%:gallery_sub_sql_request%>%> as option_text FROM (<%create_sql_view_by_name:gallery,1%>) as v,templates/<%:modul%>/option%>
</select>
%>

