<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
<tr><td colspan="4">
<table>
	<form action="" method="post">
	<tr>
	<td>IP address: <select name="user_ip"><option value="">ALL<%getUserIps%></select></td>
	<td><a href="user_types.php">User Types:</a> <select name="user_type"><option value="">ALL<%user_type%></select></td>
	<td>Agents: <select name="browser_type"><option value="">ALL<%browser_types%></select></td>
	<td>Date from: <input type="text" name="aDateFrom" value="<%getValueOf:aDateFrom%>" id="date_from" datepickerIcon="<%:EE_HTTP%>img/calend.gif"></td>
	<td> To: <input type="text" name="aDateTo" value="<%getValueOf:aDateTo%>" id="date_to" datepickerIcon="<%:EE_HTTP%>img/calend.gif"></td>
	<td><input type="submit" name="submit" value="Filter"></td>
</tr></form></table>
</td></tr>
