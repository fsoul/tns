Unique:<br />
<input type="text" name="<%:field_name%>_general" value="<%:<%:field_name%>_general%>" size="<%:size%>" />
<span class="error"><%getError:<%:field_name%>_general%></span><br />
<%parse_sql_to_html:
SELECT language_code\, language_name\, default_language FROM v_language
,templates/<%:modul%>/page_name_language%>