<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Visitors report</title>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/main.css" type="text/css">
	<script src="calendar.js"></script>
	<style>
		.dottedBorder{
			border-width:1px;
			border-style:dotted;
		}
		.solidBorder{
			border-width:1px;
			border-style:solid;
		}
		.solidBorderText{
			border-width:1px;
			border-style:solid;
			font-size:12px;
		}
		.row{
			border-width:1px;
			border-style:none;
			font-size:12px;
		}
		.rowpath{
			border-width:1px;
			border-style:none;
			font-size:14px;
		}
		.a_row{
			text-decoration:none;
			color:#000000;
		}
	</style>
</head>

<body>
<table width="100%" border=0>
	<tr>
		<td width="35px" ><img src="<%:EE_HTTP%>img/web_search32.gif" width="32px"></td>
		<td class="header" width="300" height="31">Search Engines</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
</table>
<table width="*" border=1 style="border-style:dashed" cellspacing="2" cellpadding="6" height="24px" >
	<tr>
		<td class="dottedBorder"><a href="?act=summary" class="table_header">Summary</a></td>
		<td class="dottedBorder"><a href="?act=by_pages" class="table_header">By Pages</a></td>
		<td class="dottedBorder"><a href="?act=entry" class="table_header">Entry points</a></td>
		<td class="dottedBorder"><a href="?act=exit" class="table_header">Exit points</a></td>
		<td class="dottedBorder"><a href="?act=reference" class="table_header">Reference pages</a></td>
	</tr>
</table>
<div class="table_header"><%ReportName%></div>
<table width="100%" cellpadding="2" cellspacing="0" border="0" >
<form action="" method="POST" name="filter">
	<tr >
		<td width="10px" rowspan="4">&nbsp;</td>
		<td class="table_header" width="120px" align="right">Date begin:</td>
		<td width="250px"><input type="text" name="aStartDate" value="<%getValueOf:aStartDate%>" id="start_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td class="table_header" width="120px" align="right">Date end:</td>
		<td width="250px"><input type="text" name="aEndDate" value="<%getValueOf:aEndDate%>" id="end_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
		<td width="*">&nbsp;</td>
		<td class="table_header" width="150px"><nobr><a href="#" onClick="document.filter.submit();" class="table_header"><img src="<%:EE_HTTP%>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr></td>
	</tr>
	<tr >
		<td class="table_header" align="right">Compare&nbsp;with:</td>
		<td colspan="5"></td>
	</tr>
	<tr >
		<td class="table_header" width="110px" align="right">Date begin:</td>
		<td width="250px"><%getValueOf:aCompareStartDate%></td>
		<td class="table_header" width="110px" align="right">Date end:</td>
		<td width="250px"><%getValueOf:aCompareEndDate%></td>
		<td width="*">&nbsp;</td>
		<td class="table_header" width="150px"></td>
	</tr>
</table>
<%filter_include_robots%>
</form>
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
initCalendar("start_date", format);
initCalendar("end_date", format);
</script>
</body>
</html>
