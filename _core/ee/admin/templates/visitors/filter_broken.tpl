<div class="table_header"><%ReportNameVisitors%></div>
<table width="100%" cellpadding="2" cellspacing="0" border="0" >
<form action="" method="POST" name="filter">
	<tr >
		<td width="5px" rowspan="4">&nbsp;</td>
		<td class="table_header" width="100px" align="right">Date begin:</td>
		<td ><input size="10" type="text" name="aStartDate" value="<%getValueOf:aStartDate%>" id="start_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td class="table_header" width="140px" align="right">Date end:</td>
		<td ><input size="10" type="text" name="aEndDate" value="<%getValueOf:aEndDate%>" id="end_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td width="*">&nbsp;</td>
		<td class="table_header" width="150px"><nobr><a href="#" onClick="document.filter.submit();" class="table_header"><img src="<%:EE_HTTP%>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>
	</tr>
	<tr >
		<td class="table_header" width="100px" align="right">User type:</td>
		<td ><select name="user_type"><option value="">ALL</option><%user_type%></select></td>
		<td class="table_header" width="140px" align="right"><nobr>Browsers category:</nobr></td>
		<td class="table_header" ><select name="user_browsers" style="width:150px"><option value="">ALL</option><%user_browsers%></select></td>
		<td class="table_header" colspan="2"><!--label for="aUnvisited">Hide unvisited pages</label><input type="checkbox" id="aUnvisited" name="aUnvisited" <%fUnvisitedCheck%>--></td>
	</tr>
</form>
</table><br>
<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="0">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="10px" class="solidBorder">Sessions</td>
	<td  align="center" width="10px" class="solidBorder">cms</td>
	<td  align="center" width="70px" class="solidBorder">
		<table width="100%" border="0" cellspacing="3 cellpadding="0">
		<tr>
			<td align="center" colspan="3">From-type</td>
		</tr>
		<tr>
			<td>url</td>
			<td>site</td>
			<td>web</td>
		</tr>
		</table>
	</td>
</tr>
<%broken_links_visitors%>
</table>