<table align="left" border="0">
<%row%
	<tr><td><input type="checkbox" <%iif::email_count,1,checked%> <%iif::email_status,draft,,disabled%> name="group_ids[]" value="<%:id%>"></td><td><%:group_name%></td></tr>
%row%>
</table>