<%row%
<tr <%tr_bgcolor%>>
	<td height="30" width="50" class="table_data">&nbsp;&nbsp;<input type="hidden" value="<%:folder_name%>" name="all_folders[]" /><input type="checkbox" value="<%:folder_name%>" name="chosen_folders[]" <%iif:<%check_folder_permissions:<%:folder_name%>,<%:edit%>%>,,,checked="checked"%>><img src="<%:EE_HTTP%>img/folder.gif" width="16" height="16" border="0"  /></td>
	<td height="30" width="100%" class="table_data"><%:folder_name%></td>
</tr>
%row%>
<!--
<%row_empty%
<tr><td align="center" colspan="20" height="30"><%words:No one folder was founded.%></td></tr>
%row_empty%>
-->