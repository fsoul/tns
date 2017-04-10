<table align="left" border="0" width="25%">
<%row%
	
	<tr><td><input type="checkbox"<%check_email_send%> <%iif::email_status,draft,,disabled%> name="language_ids[]" value="<%:lang%>"></td><td width="100%"><%:lang%></td></tr>
%row%>
</table>