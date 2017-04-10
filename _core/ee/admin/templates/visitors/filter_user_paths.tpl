<div class="table_header"><%ReportNameVisitors%></div>
<table width="100%" cellpadding="2" cellspacing="0" border="0" >
<form action="" method="POST" name="filter">
	<tr >
		<td width="10px" rowspan="2">&nbsp;</td>
		<td class="table_header" width="120px" align="right">Date begin:</td>
		<td width="250px"><input type="text" name="aStartDate" value="<%getValueOf:aStartDate%>" id="start_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td class="table_header" width="120px" align="right">Date end:</td>
		<td width="250px"><input type="text" name="aEndDate" value="<%getValueOf:aEndDate%>" id="end_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td width="*">&nbsp;</td>
		<td class="table_header" width="150px"><nobr><a href="#" onClick="document.filter.submit();" class="table_header"><img src="<%:EE_HTTP%>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>
	</tr>
	<tr >
		<td class="table_header" width="110px" align="right">User type:</td>
		<td width="250px"><select name="user_type"><option value="">ALL<%user_type%></select></td>

		<td width="*" align="right"><nobr>Browsers category</nobr></td>
		<td class="table_header" width="150px"><select name="user_browsers" style="width:150px"><option value="">ALL</option><%user_browsers%></select></td>
	</tr>
</form>
</table><br>
<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">User category</td>
	<td  align="center" width="50px" class="solidBorder">Amount</td>
	<td  align="center" width="50px" class="solidBorder">%</td>
</tr>
<%user_paths%>
</table>