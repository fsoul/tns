<table width="100%" cellpadding="4" cellspacing="0" border="0" class="tableborder">
<form action="" method="POST" name="filter">
<tr >
	<td class="table_header" width="110px">Start date:</td>
	<td width="250px"><%getValueOf:aReportDate%></td>
	<td width="*">&nbsp;</td>
	<td class="table_header" width="150px"></td>
</tr>
<tr >
	<td class="table_header" width="110px">Period:</td>
	<td width="250px"><%func:SetReportPeriodName:aPeriodSelect%></td>
	<td width="*">&nbsp;</td>
	<td></td>
</tr>
<tr><td colspan="4">
<table >	
	<tr >
		<td class="table_header" align="right">User type:</td>
		<td ><%func:user_type_name:user_type%></td>
		<td width="*" class="table_header" align="right"><nobr>Browsers category</nobr>:</td>
		<td  width="150px"><%getValueOf:user_browsers%></td>
		<td width="*" class="table_header" align="right"><nobr>Engine category</nobr>:</td>
		<td width="150px"><%getValueOf:engine_browsers%></td>
	</tr>
</table>
</td></tr></table>