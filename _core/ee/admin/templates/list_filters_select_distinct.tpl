<select name="filter_<%:field_name%>">

<option value=""><%cons:All%>
<%parse_sql_to_html:

 SELECT DISTINCT <%:field_name%> as option_value\,
	<%:field_name%> as option_text\,
	"<%:filter_<%:field_name%>%>" as option_value_test
   FROM v<%:modul%>_grid
  ORDER BY 1
,templates/<%:modul%>/option%>

</select>
