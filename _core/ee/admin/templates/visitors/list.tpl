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
		<td width="35px" ><img src="<%:EE_HTTP%>img/user_search32.gif" width="32px"></td>
		<td class="header" width="300" height="31">Visitors</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
</table>
<table width="*" border=1 style="border-style:dashed" cellspacing="2" cellpadding="6" height="24px" >
	<tr>
		<td class="dottedBorder"><a href="?act=sessions" class="table_header">Sessions</a></td>
		<td class="dottedBorder"><a href="?act=user_paths" class="table_header">User paths</a></td>
		<td class="dottedBorder"><a href="?act=by_pages" class="table_header">By Pages</a></td>
		<td class="dottedBorder"><a href="?act=entry" class="table_header">Entry points</a></td>
		<td class="dottedBorder"><a href="?act=exit" class="table_header">Exit points</a></td>
		<td class="dottedBorder"><a href="?act=reference" class="table_header">Reference pages</a></td>
		<td class="dottedBorder"><a href="?act=broken" class="table_header">Broken links</a></td>
	</tr>
</table>
<%filter_include_visitors%>
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
