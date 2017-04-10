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
</tr>
	<tr>
	<td></td>
	<td></td>
	<td align="right">Период №2: <input type="checkbox" name="period" value="ok" <%getValueOf:periodCheck%>></td>
	<td>Date from: <input type="text" name="aDateFrom2" value="<%getValueOf:aDateFrom2%>" id="date_from2" datepickerIcon="<%:EE_HTTP%>img/calend.gif"></td>
	<td> To: <input type="text" name="aDateTo2" value="<%getValueOf:aDateTo2%>" id="date_to2" datepickerIcon="<%:EE_HTTP%>img/calend.gif"></td>
	<td></td>
</tr>
</form></table>
</td></tr>