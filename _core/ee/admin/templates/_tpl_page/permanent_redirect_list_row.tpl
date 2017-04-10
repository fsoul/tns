<%row%
<tr align="center" height="22">
	<td><input type="checkbox" name="selected_items[]" value="<%:redirect_id%>" /></td>
	<td><%:source_url%></td>
	<td>
		<%iif::t_view,,
			<%get_href::page_id,:lang_code%>,
			<%iif::t_view,:t_view_default,
				<%get_href::page_id,:lang_code%>,
				<%get_view_href::page_id,:t_view,:lang_code%>
			%>
		%>
	</td>
	<td align="center">
		<a href="#" id="edit_redirect_<%:redirect_id%>" onclick="edit_redirect(<%:redirect_id%>);"><img src="<%:EE_HTTP%>img/edit/doc_edit.gif" border="0" title="Edit" /></a>
		<a href="#" onclick="delete_redirect(<%:redirect_id%>);" ><img src="<%:EE_HTTP%>img/edit/doc_delete.gif" border="0" title="Delete" /></a>
	</td>
</tr>
%row%>
<%row_empty%
<tr><td colspan="3" align="center"> No permanent redirect. In order to add redirection click "Add button" <a id="add_redirect" href="#"><img src="<%:EE_HTTP%>img/edit/doc_add.gif" border="0" title="Add redirect link" onclick="add_redirect(); return false;" /></a></td></tr>
%row_empty%>