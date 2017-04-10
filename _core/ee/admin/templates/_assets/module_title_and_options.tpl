<td class="header" height="31" nowrap><%str_to_title::modul_title%> Management</td>
<td width="10">&nbsp;</td>
<%try_include:<%:modul%>/list_modul_config_button%>
<%try_include:<%:modul%>/list_self_test_button%>
<%try_include:<%iif:<%config_var:ee_cache_html%>,1,<%:modul%>/delete_cache_buttons%>,<%:modul%>/cache_disabled%>