<select name="filter_<%:field_name%>">

<option value=""><%cons:All%>
<%parse_sql_to_html:

 SELECT role_name as option_value\,
	role_name as option_text\,
	"<%:filter_<%:field_name%>%>" as option_value_test
   FROM role

,templates/<%:modul%>/option%>

</select>
