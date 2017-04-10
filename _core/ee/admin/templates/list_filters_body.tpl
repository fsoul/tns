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
		<input style="background:#eee; border:#eee" type="image" src="<%:EE_HTTP%>img/showAll.gif" alt="<%words:<%cons:Show_all%>%>" title="<%words:<%cons:Show_all%>%>" border="0" onClick="document.location.href='<%:modul%>.php<%iif:<%:edit%>,,,?edit=<%:edit%>%>'; return false;">
	</td>
	
		<%iif::modul,_tpl_page,<td><a href="#" style="background:#eee; border:#eee" onclick = "<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH%>,,selected_rows_submit('copy_sel_items'\\,'<%:COPY_SEL_GRID_ITEM_CONFIRM%>');,alert('<%:NO_CONTENT_ACCESS%>');%> return false;"><img src="<%:EE_HTTP%>img/<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH%>,,copy_btn.gif,copy_btn_gray.gif%>" width="24" height="24" alt="<%:COPY_SEL_GRID_IMAGE_ALT%>" title="<%:COPY_SEL_GRID_IMAGE_ALT%>" border="0"></a></td>%>
	
	<td>
		<%iif::modul,_seo,,_error_page,,_mailing,,_object_seo,,<a href="#" style="background:#eee; border:#eee" onclick = "<%iif:<%check_content_access::CA_READ_ONLY%>,,selected_rows_submit('del_sel_items'\\,'<%:DELETE_SEL_GRID_ITEM_CONFIRM%>');,alert('<%:NO_CONTENT_ACCESS%>');%>  return false;"><img src="<%:EE_HTTP%>img/<%iif:<%check_content_access::CA_READ_ONLY%>,,del_btn.gif,del_btn_gray.gif%>" width="24" height="24" alt="<%:DELETE_SEL_GRID_IMAGE_ALT%>" title="<%:DELETE_SEL_GRID_IMAGE_ALT%>" border="0"></a>%>
	</td>
	<td>
		<%include:<%iif::modul,_seo,,_error_page,,_mailing,,_object_seo,,selected_rows_switcher%>%>
	</td>
	<td>
		<%iif::modul,_tpl_page,<a href="#" style="background:#eee; border:#eee" onclick = "<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH%>,,selected_rows_submit('refresh_page_date'\\,'<%:REFRESH_A_PAGE_DATE_TO_CURRENT%>'\\,true);,alert('<%:NO_CONTENT_ACCESS%>');%> return false;"><img src="<%:EE_HTTP%>img/<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH%>,,doc_refresh.gif,doc_refresh_gray.gif%>" width="24" height="24" alt="<%:REFRESH_A_PAGE_DATE_TO_CURRENT%>" title="<%:REFRESH_A_PAGE_DATE_TO_CURRENT%>" border="0"></a>%>
	</td>
</tr>
