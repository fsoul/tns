<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">
<%parse_sql_to_html:

 SELECT id as option_value\,
	id as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM object_record <%:where_object_id%>

,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
