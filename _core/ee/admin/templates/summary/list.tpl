<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Summary report</title>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/main.css" type="text/css">
	<script src="calendar.js"></script>
	<style>
		.dottedBorder{
			border-width:1px;
			border-left-style:none;
			border-right-style:dotted;
			border-top-style:none;
			border-bottom-style:none;
		}
		.dottedBorderTitle{
			background:#ededed;
			border-width:1px;
			border-left-style:none;
			border-right-style:dotted;
			border-top-style:dotted;
			border-bottom-style:dotted;
		}
		.noneBorder{
			border-width:1px;
			border-left-style:none;
			border-right-style:dotted;
			border-top-style:none;
			border-bottom-style:none;
		}
	</style>
</head>

<body>
<table width="100%" border=0>
	<tr>
		<td width="35px" ><img src="<%:EE_HTTP%>img/barchart32.gif" width="32px"></td>
		<td class="header" width="300" height="31">Summary report</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
</table><br>
<table width="100%" cellpadding="4" cellspacing="0" border="0" class="tableborder">
<form action="" method="POST" name="filter">
<tr >
	<td class="table_header" width="110px">Report date:</td>
	<td width="250px"><input type="text" name="aReportDate" value="<%getValueOf:aReportDate%>" id="report_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
	<td width="*">&nbsp;</td>
	<td class="table_header" width="150px"><nobr><a href="#" onClick="document.filter.submit();" class="table_header"><img src="<%:EE_HTTP%>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>
</tr>
</form>
</table>
<%summary_content%>
<br><table width="100%" border=0>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
	<tr>
		<td class="header" width="300" height="31"><a href="#" class="table_header"><img src="<%:EE_HTTP%>img/info24.gif" align="absmiddle" border="0">&nbsp;Information</a></nobr></td>
		<td width="*">&nbsp;</td>
	</tr>
</table><br>
<script>
var format = "y-mm-dd";
var needReload = false;
initCalendar("report_date", format);
</script>
</body>
</html>
