<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">
<option value=""></option>

<%parse_sql_to_html:

 SELECT object_field_type as option_value\,
	object_field_type as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM object_field_type

,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
