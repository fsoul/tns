<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Languages</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/main.css" type="text/css">
</head>

<body onload="parent.menu.imgClick('search_stat')">
<table width="100%" border=0>
	<tr>
		<td class="header" width="300" height="31">Statistics</td>
		<td height="32" rowspan="2" align="right"><a href="top.php?logout=yes" target="_top"><img src="<%:EE_HTTP%>img/logout.gif" alt="Logout" border="0"></a></td>
	</tr>
	<tr><td bgcolor="#ff0000" height="1"><img src="img/inv.gif" width="1" height="1"></td></tr>
</table><br>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee">
		<td height="30" align="center"><%decode:1%><a href="search_stat.php?srt=<%getValueOf:srt%>&click=1&op=0&page=<%getValueOf:page%>&load_cookie=true" class="table_header">Date</a></td>
		<td ><%decode:2%><a href="search_stat.php?srt=<%getValueOf:srt%>&click=2&op=0&page=<%getValueOf:page%>&load_cookie=true" class="table_header">Ip</a></td>
		<td ><%decode:3%><a href="search_stat.php?srt=<%getValueOf:srt%>&click=3&op=0&page=<%getValueOf:page%>&load_cookie=true" class="table_header">Search string</a></td>
		<td align="center" class="table_header">Action</td>
	</tr>
<form name="fs" action="search_stat.php?srt=<%getValueOf:srt%>&op=0&page=<%getValueOf:page%>" method="post">
	<input type="hidden" name="refresh" value="true">
	<tr bgcolor="#eeeeee">
		<td height="30" align="center"><input type="text" name="fDate" value="<%getValueOf:fDate%>"></td>
		<td><input type="text" name="fIp" value="<%getValueOf:fIp%>"></td>
		<td><input type="text" name="fQuery" value="<%getValueOf:fQuery%>"></td>
		<td align="center">
			<a href="javascript: document.fs.submit()"><img src="<%:EE_HTTP%>img/search.gif" alt="Apply Filter" border="0"></a>
			<a href="javascript: document.location.href='search_stat.php'"><img src="<%:EE_HTTP%>img/showAll.gif" alt="Show All" border="0"></a>
		</td>
	</tr>
</form>
	<tr bgcolor="092869"><td colspan="4"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td></tr>
	<%print_list%>
</table><br>
</body>
</html>
