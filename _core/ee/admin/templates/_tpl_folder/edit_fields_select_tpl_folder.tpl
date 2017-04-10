<%iif:<%:<%:field_name%>%>,,<%setValueOf:<%:field_name%>,<%get:<%:field_name%>%>%>%>
<select <%iif::readonly,,,disabled%> name="<%:field_name%>">
<option value="">/</option>
<%parse_sql_to_html:

 SELECT id as option_value\,
	concat('/'\, folder) as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM v_tpl_path_content
   WHERE concat('/'\, CONCAT(folder\, '/')) not like '%/<%:page_name_<%:language_code%>%>/%'
   AND language = <%sqlValue::language%>
,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
