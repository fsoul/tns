<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Total report</title>
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
	<script language="JavaScript">
		function check(el, els)
		{
			for(i = 0; i < els.length; i++)
			{
				ch_elements = document.getElementsByName('reports['+els[i]+']');
				ch_elements[0].checked = el.checked;
			}
		}
	</script>
</head>
<body>
<table width="100%" border=0>
	<tr>
		<td width="35px" ><img src="<%:EE_HTTP%>img/barchart32.gif" width="32px"></td>
		<td class="header" width="300" height="31">Total report</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
</table><br>
<table width="100%" cellpadding="4" cellspacing="0" border="0" class="tableborder">
<form action="" method="POST" name="filter">
<tr >
	<td class="table_header" width="110px">Start date:</td>
	<td width="250px"><input type="text" name="aReportDate" value="<%getValueOf:aReportDate%>" id="report_date" datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"></td>
	<td width="*">&nbsp;</td>
	<td class="table_header" width="150px"><!--nobr><a href="#" onClick="document.filter.submit();" class="table_header"><img src="<%:EE_HTTP%>img/refresh24.gif" align="absmiddle" border="0">&nbsp;Refresh</a></nobr--></td>
</tr>
<tr >
	<td class="table_header" width="110px">Period:</td>
	<td width="250px"><select name="aPeriodSelect"><%SetReportPeriod%></select></td>
	<td width="*">&nbsp;</td>
	<td></td>
</tr>
<tr><td colspan="4"><table class="table_header">	
	<tr >
		<td class="table_header" align="right">User type:</td>
		<td ><select name="user_type"><option value="">ALL<%user_type%></select></td>
		<td width="*" align="right"><nobr>Browsers category</nobr></td>
		<td class="table_header" width="150px"><select name="user_browsers" style="width:150px"><option value="">ALL</option><%user_browsers%></select></td>
		<td width="*" align="right"><nobr>Engine category</nobr></td>
		<td class="table_header" width="150px"><select name="engine_browsers" style="width:150px"><option value="">ALL</option><%engine_browsers%></select></td>
	</tr>
</table></td></tr>
<tr >
	<td class="table_header" colspan="4" width="110px">Sections</td>
</tr>
<tr >
	<td class="table_header" width="110px">Summary</td>
	<td colspan="3"><input type="checkbox" checked name="reports[summary]" ></td>
</tr>
<%block_filters%>
<tr >
	<td class="table_header" width="110px"></td>
	<td width="250px"></td>
	<td width="*"></td>
	<td width="150px" align="right"><input type="submit" name="build" value="Build Report"></td>
</tr>
</form>
</table>
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
