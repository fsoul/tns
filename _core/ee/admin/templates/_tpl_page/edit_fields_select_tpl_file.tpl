<select <%iif::readonly,,,disabled%> name="<%:field_name%>" onchange="check_cachable_page(this.value);">
<%parse_sql_to_html:

 SELECT id as option_value\,
	concat(file_name\,".tpl") as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM v_tpl_file ORDER BY option_text

,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
