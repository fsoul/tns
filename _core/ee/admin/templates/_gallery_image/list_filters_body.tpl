<input type="hidden" name="refresh" value="true">

<tr bgcolor="#eeeeee">
<%row%
	<td style="<%:col_style%>">&nbsp;</td>
	<td style="<%:col_style%>" height="30" align="<%:filter_align%>" <%iif::filter_valign,,,valign="<%:filter_valign%>"%>>
		<%include:<%:modul%>/list_filters_<%:type%>%>
	</td>
%row%>
	<td>&nbsp;&nbsp;</td>
	<td nowrap="1" align="center" <%iif::filter_valign,,,valign="<%:filter_valign%>"%>>
		<input style="background:#eee; border:#eee;margin-left:15px;" type="image" src="<%:EE_HTTP%>img/search.gif" alt="<%words:<%cons:Apply_filter%>%>" title="<%words:<%cons:Apply_filter%>%>" border="0">
		<input style="background:#eee; border:#eee" type="image" src="<%:EE_HTTP%>img/showAll.gif" alt="<%words:<%cons:Show_all%>%>" title="<%words:<%cons:Show_all%>%>" border="0" onClick="document.location.href='<%:modul%>.php'; return false;">
	</td>
	<td align="center">
		&nbsp;<a href="" style="background:#eee; border:#eee" onClick = "selected_rows_submit('del_sel_items','<%:DELETE_SEL_GRID_ITEM_CONFIRM%>'); return false;"><img src="<%:EE_HTTP%>img/del_btn.gif" width="24" height="24" alt="<%:DELETE_SEL_GRID_IMAGE_ALT%>" title = "<%:DELETE_SEL_GRID_IMAGE_ALT%>" border="0"></a>&nbsp;
	</td>
	<td>
		<%include:selected_rows_switcher%>
	</td>
</tr>
