<table border="0" class="table_header" cellpadding="0" cellspacing="0">
<form action="" method="post">
<input type="hidden" name="edit" value="<%getValueOf:edit%>">
<tr height="30px">
	<td align="right" width="200px">Host:&nbsp;</td>
	<td><input type="text" name="aIP" value="<%getValueOf:aIP%>" size="40"></td>
</tr>
<tr>
	<td align="right">Browser or Agent Name:&nbsp;</td>
	<td><input type="text" name="aAgentName" value="<%getValueOf:aAgentName%>" size="40"></td>
</tr>
<tr>
	<td align="right">Filter phisically:&nbsp;</td>
	<td><input type="checkbox" name="aFilterPhisically" <%getValueOf:aFilterPhisicallyCheck%>></td>
</tr>
<tr>
	<td align="right">Active:&nbsp;</td>
	<td><input type="checkbox" name="aFilterActive" <%getValueOf:aFilterActiveCheck%>></td>
</tr>
<tr>
	<td colspan="2"><input type="image" name="save" value="1" src="<%:EE_HTTP%>img/save.gif">&nbsp;<input type="image" name="cancel" value="1" src="<%:EE_HTTP%>img/cancel.gif">&nbsp;</td>
</tr>
</form>
</table>