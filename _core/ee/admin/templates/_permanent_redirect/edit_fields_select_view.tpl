<%iif:<%getField:SELECT COUNT(*) FROM tpl_views%>,1,
<select id="tpl_view" name="tpl_view" disabled="disabled">
	<%parse_sql_to_html:SELECT tpl_views.*\, '<%:t_view%>' AS sel_t_view  FROM tpl_views,templates/<%:modul%>/view_list%>
</select>,
<select id="tpl_view" name="tpl_view" onchange="change_target_url('target_url');">
	<%parse_sql_to_html:SELECT tpl_views.*\, '<%:t_view%>' AS sel_t_view FROM tpl_views,templates/<%:modul%>/view_list%>
</select>
%>
<script>edit_current('<%iif::target_url,,open_sat_page,open_url%>');</script>
