<table align="left" border="0" width="75%">
<%row%
	<tr><td><input type="checkbox" <%iif::email_count,1,checked%> <%iif::email_status,draft,,disabled%> name="group_ids[]" value="<%:id%>"></td><td width="100%"><%:group_name%></td></tr>
%row%>
<%row_empty%
	<tr><td>No groups available</td></tr>
%row_empty%>
</table>