<table border="0" cellpadding="0" cellspacing="0" width="<%:satelit_table_width%>">
<tr>
	<td width="100%">
	<div id="sattelite_page_path<%:sat_sel_id_sufix%>" style="overflow: hidden;"><%iif:<%:sat<%:sat_sel_id_sufix%>%>,,,<%getField:SELECT CONCAT_WS('/'\,IF(`folder` = '/'\, ''\, `folder`)\,`page_name`) AS page_name FROM v_tpl_page_grid WHERE id=<%sqlValue:<%:sat<%:sat_sel_id_sufix%>%>%> AND language=<%sqlValue:<%:language%>%> LIMIT 0\,1%>%></div>
	</td>
	<td align="right">
	<span style="white-space: nowrap;"><input name="satelit<%:sat_sel_id_sufix%>" id="satelit<%:sat_sel_id_sufix%>" value="<%:sat<%:sat_sel_id_sufix%>%>" type="hidden">&nbsp;<input name="select_button" id="select_button" onclick="selectSattelitePage('<%:sat_sel_id_sufix%>');" value="<%:SELECT_BUTTON%>" type="button"></span>
	</td>
</tr>
</table>