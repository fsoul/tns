<%row%
<tr <%tr_bgcolor%>>
	<td height="30" width="50" class="table_data">&nbsp;&nbsp;<input type="checkbox" value="1" name="user_<%:id%>" <%iif:<%check_folder_permissions::folder,<%:id%>%>,,,checked%>></td>
	<td height="30" width="100%" class="table_data">&nbsp;&nbsp;<%:name%></td>
</tr>
%row%>
<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:<%cons:No power users found%>%></td></tr>
%row_empty%>
-->