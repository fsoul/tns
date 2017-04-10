<%getFolderFromGet%>
<select <%iif::readonly,,,disabled%> name="<%:field_name%>">
<option value="">/</option>
<%parse_sql_to_html:

 SELECT id as option_value\,
	concat('/'\, folder) as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM v_tpl_path_content
   WHERE language = <%sqlValue::language%>
,templates/<%:modul%>/option%>

</select>
<%include:hidden_input_instead_of_disabled_select%>
