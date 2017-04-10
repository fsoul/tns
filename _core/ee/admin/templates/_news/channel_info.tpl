<table cellpadding=0 cellspacing=0>
<tr><td>
	<table cellpadding=5 cellspacing=0>
	<%row%
	  <tr><td><b>Channel Name </b><td> <%:title%></td></tr>
	  <tr><td><b>Channel Description </b><td> <%:description%></td></tr>
	  <tr><td><b>Author</b><td> <%:author%></td></tr>
	  <tr><td><b>Copyright</b><td> <%:copyright%></td></tr>
	  <tr><td><b>Type</b><td> <%:channel_type%></td></tr>
	%row%>
	</table>
</td>
<td valign="top">
<a href="javascript:openPopup('_channel.php?op=1&edit=<%:channel_id%>',<%:popup_width%>,325)"><img src="<%:EE_HTTP%>img/editBt.gif" width="16" height="16" alt="Edit" border="0">
</a>
</td>
</tr>
</table>
