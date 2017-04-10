<%setValueOf:default_language,<%getField:SELECT language_code FROM <%:TABLE_PREFIX%>v_language WHERE default_language=1%>%>
<input  <%iif::readonly,,,readonly%> type="radio" name="select_lang_forw" value="default_language" onfocus="hide_lang_forw('lang_forw');return false;"<%iif:<%:language_forwarding%>,<%:default_language%>,value="<%:default_language%>" checked%> <%iif:<%getField:SELECT count(language_code) FROM <%:TABLE_PREFIX%>v_language WHERE status = 1%>,1,value="<%:default_language%>" checked%> /> Default language (<%:default_language%>)
&nbsp;
<%iif:<%getField:SELECT count(language_code) FROM <%:TABLE_PREFIX%>v_language WHERE status = 1%>,1,,
<input <%iif::readonly,,,readonly%> type="radio" name="select_lang_forw" value="null" onfocus="show_lang_forw('lang_forw');return true;" <%iif:<%:language_forwarding%>,<%:default_language%>,,checked%> />
<%include:edit_fields_sel_lang_forwarding%>%>


