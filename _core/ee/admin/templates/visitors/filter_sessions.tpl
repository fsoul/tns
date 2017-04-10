<div class="table_header"><%ReportNameVisitors%></div>
<table width="100%" cellpadding="2" cellspacing="0" border="0" >
<form action="" method="GET" name="filter">
	<tr >
		<td width="10px" rowspan="2">&nbsp;</td>
		<td class="table_header" width="110px">Date begin:</td>
		<td width="250px"><input type="text" name="aStartDate" value="<%getValueOf:aStartDate%>" id="start_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td class="table_header" width="110px">Date end:</td>
		<td width="250px"><input type="text" name="aEndDate" value="<%getValueOf:aEndDate%>" id="end_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td width="*">&nbsp;</td>
		<td class="table_header" width="150px"><nobr><a href="#" onClick="document.filter.submit();" class="table_header"><img src="<%:EE_HTTP%>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>
	</tr>
	<tr >
		<td class="table_header" width="110px">User type:</td>
		<td width="250px"><select name="user_type"><option value="">ALL<%user_type%></select></td>
		<td class="table_header" width="110px">Source IP:</td>
		<td width="250px"><input type="text" value="<%getValueOf:aUserIP%>" name="aUserIP"></td>
		<td width="*" align="right"><nobr>Browsers category</nobr></td>
		<td class="table_header" width="150px"><select name="user_browsers" style="width:150px"><option value="">ALL</option><%user_browsers%></select></td>
	</tr>
</form>
</table>
<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px" class="table_header">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Session path</td>
	<td  align="center" width="70px" class="solidBorder">User&nbsp;category</td>
	<td  align="center" width="50px" class="solidBorder">Start</td>
	<td  align="center" width="50px" class="solidBorder">Time</td>
</tr>
<%list_sessions%>
</table>