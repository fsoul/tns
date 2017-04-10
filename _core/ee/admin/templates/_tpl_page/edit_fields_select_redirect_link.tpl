<div id="container"></div>

<table width="500" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr><th align="left">&nbsp;&nbsp;&nbsp;Redirect list: <span class="error"><%:folder_id%></span></th></tr>
</table>
<table width="100%" border="0">
<tr>
	<td align="right"><a href="#" onclick="delete_selected_items(); return false;"><img src="<%:EE_HTTP%>img/doc_delete_24.gif" border="0" title="Delete selected items" /></td>
</tr>
</table>
<div id="redirect_list">
	<table width="100%" border="0">
	<tr align="center">
		<th width="10px"><input type="checkbox" onclick="selected_rows_switch(this.checked);" /></th>
		<th>Source URL:</th>
		<th>Target URL:</th>
		<th width="40px"><a id="add_redirect" href="#"><img src="<%:EE_HTTP%>img/edit/doc_add.gif" border="0" title="Add redirect link" onclick="add_redirect(); return false;" /></a></th>
	</tr>
	<%get_redirect_list:%>
	</table>
</div>