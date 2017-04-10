<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Summary report</title>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
	<script src="calendar.js"  type="text/javascript"></script>
	<style type="text/css">
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
		<td width="35px" ><img src="<%:EE_HTTP%>img/options32.gif" width="32px"></td>
		<td class="header" width="300" height="31">Configuration</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><%inv:1,1%></td></tr>
</table><br>
<table width="*" border=1 style="border-style:dashed" cellspacing="2" cellpadding="6" height="24px" >
	<tr>
		<td class="dottedBorder"><a href="?act=user_agents" class="table_header">User Agents</a></td>
		<td class="dottedBorder"><a href="?act=searches" class="table_header">Search Engines</a></td>
		<td class="dottedBorder"><a href="?act=filters" class="table_header">Filters</a></td>
	</tr>
</table>
<div class="table_header"><%ReportNameCongig%></div>
<%configuration_content%>
<br><table width="100%" border=0>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><%inv:1,1%></td></tr>
	<tr>
		<td class="header" width="300" height="31"><a href="#" class="table_header"><img src="<%:EE_HTTP%>img/info24.gif" align="absmiddle" border="0" alt="" />&nbsp;Information</a></nobr></td>
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
