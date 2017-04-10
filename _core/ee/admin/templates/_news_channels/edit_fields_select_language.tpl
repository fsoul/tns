<select  style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>" id="lang_forw" >
<%parse_sql_to_html:

 SELECT language_code as option_value\,
	language_name as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM v_language
	WHERE status = "1"

,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
