<tr bgcolor="#ededfd" style="<%:row_style%>">
	<td height="30" class="table_data">&nbsp;&nbsp;Page <%iif::in_draft_state,Yes,last edited,published%> at</td>
	<td><%:edit_date<%iif::in_draft_state,Yes,_draft%>%>&nbsp;&nbsp;&nbsp;&nbsp;<%iif::edit_user,,,by <%:edit_user%>%></td>
	<td class="error">&nbsp;&nbsp;</td>
</tr>