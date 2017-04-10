<select <%iif::readonly,,,disabled%> name="filter_<%:field_name%>">
<option value="">All
<%parse_sql_to_html:
   SELECT login as option_value\,
	login as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM v_user
,templates/<%:modul%>/option%>
</select>
<%include:hidden_input_instead_of_disabled_select%>