<select <%iif:<%:language_forwarding%>,<%:default_language%>,disabled%> style="width:100px" <%iif::readonly,,,disabled%> name="language_forwarding" id="lang_forw" >

<%parse_sql_to_html:

 SELECT language_code as option_value\,
	language_name as option_text\,
	"<%:language_forwarding%>" as option_value_test
   FROM v_language
   WHERE status = "1"
   AND default_language <> 1
         

,templates/<%:modul%>/option%>
</select>
         
<%iif::language_forwarding,,,<%iif:<%check_status_of_language:<%:language_forwarding%>%>,1,,<br /><%inv:135%><span class = "error">Warning! <%:language_forwarding%> language is disabled</span>%>%>
<%include:hidden_input_instead_of_disabled_select%>
