<%iif:<%getField:SELECT COUNT(*) FROM v_language%>,1,
<select id="lang_code" name="lang_code" disabled="disabled">
	<%parse_sql_to_html:SELECT * FROM v_language,templates/<%:modul%>/lang_list%>
</select>
,
<select id="lang_code" name="lang_code" onchange="change_target_url('target_url');">
	<%parse_sql_to_html:SELECT * FROM v_language,templates/<%:modul%>/lang_list%>
</select>
%>
