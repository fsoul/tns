<table border="0" class="table_header" cellpadding="0" cellspacing="0">
<form action="" method="post">
<input type="hidden" name="edit" value="<%getValueOf:edit%>">
<input type="hidden" name="is_useragent" value="<%getValueOf:is_useragent%>">
<tr height="30px">
	<td align="right" width="200px">Agent string:&nbsp;</td>
	<td colspan="2"><input type="text" name="aAgentString" value="<%getValueOf:aAgentString%>" size="40"></td>
</tr>
<tr>
	<td align="right">Browser type name:&nbsp;</td>
	<td class="row" valign="middle"><input valign="middle" type="radio" name="agent" value="new" id="agent_new" <%getValueOf:agentNewCheck%>>&nbsp;<label for="agent_new">new</label></td>
	<td><input type="text" style="width:189px" name="aAgentType" value="<%getValueOf:aAgentType%>" size="30"></td>
</tr>
<tr>
	<td align="right">&nbsp;</td>
	<td class="row"><input type="radio" name="agent" value="existed" id="agent_existed" <%getValueOf:agentExistedCheck%>>&nbsp;<label for="agent_existed">existed</label></td>
	<td><select style="width:189px" name="existedAgentType"><%getAgentTypesOptions%></select></td>
</tr>
<tr>
	<td colspan="3"><input type="image" name="save" value="1" src="<%:EE_HTTP%>img/save.gif">&nbsp;<input type="image" name="cancel" value="1" src="<%:EE_HTTP%>img/cancel.gif">&nbsp;</td>
</tr>
</form>
</table>