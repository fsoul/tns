<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Summary report</title>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
    <!--- link rel="stylesheet" href="<%:EE_HTTP%>css/main.css" type="text/css" --->
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
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
		<td class="header" width="300" height="31">Site Pages</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td colspan="2" bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
</table><br>
<table width="100%" border=0>
	<form name="fu" action="" method="post">

	<tr>
		<td width="300px" >Page url</td>
		<td width="250px" colspan="2">Users: <select name="user_type" onChange="document.fu.submit();"><%user_type%></select></td>
	</tr>
	</form>
	<form name="fd" action="" method="post">
	<input type="hidden" name="user_type" value="<%getValueOf:user_type%>">
	<%pages_list%>
	<tr>
		<td colspan="3" ><input type="image" name="refresh" border="0" src="<%:EE_HTTP%>img/refresh24.gif"></td>
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
