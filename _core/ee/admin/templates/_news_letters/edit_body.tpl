<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Content</td>
	<td> <%include:<%iif::email_status,draft,<%:modul%>/edit_body_edit_cms%>%></td>
	<td class="error">&nbsp;&nbsp;<%getError:body%></td>
</tr>
<tr <%tr_bgcolor%>>
	<td colspan="3">
<iframe
	id="iframe_preview"
	src="<%:EE_HTTP%>index.php?t=<%:email_tpl%>&edit=<%:edit%>&admin_template=yes"
	width="600" height="200" frameborder="no" scrolling="yes"
>
</iframe>
	</td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Attachments</td>
	<td> 
<%parse_sql_to_html:SELECT file_name\, id\, LENGTH(file_content) as length FROM nl_attachments WHERE nl_id=<%:edit%>,templates/<%:modul%>/view_attachment_row%>
<%include:<%iif::email_status,draft,<%iif::add_attachment,,<%:modul%>/add_button,<%:modul%>/edit_attachment%>%>%><br /><br /></td>
	<td class="error">&nbsp;&nbsp;</td> 
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Total attachments size</td>
	<td><%setValueOf:total_attach,<%getField:SELECT sum(LENGTH(file_content)) from nl_attachments where nl_id=<%:edit%>%>%>
<b><%size_hum_read:<%:total_attach%>%></b>
(encoded size - <b><%size_hum_read:<%ceil:<%tpl_div:<%tpl_mult:<%:total_attach%>,3%>,2%>%>%></b>)
	<td class="error">&nbsp;&nbsp;</td> 
</tr>
