<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Languages</title>
    <!-- link rel="stylesheet" href="../css/main.css" type="text/css" -->
    <link rel="stylesheet" href="../css/admin_panel_style.css" type="text/css" />
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
<%print_admin_js%>
</head>

<body>
<%:admin_menu%>
<table width="100%" border=0>
	<tr>
		<td class="header" height="31"><%getValueOf:pageTitle%></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr>
	<td><img src="../img/inv.gif" width="200" height="1" alt=""/></td>
	<td width="100%"><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
	<td><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
</tr>
<%view_mail%>
<form action="<%:modul%>.php?op=0">
<tr>
	<td height="30" class="table_data">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
	</td>
	<td width="100%"><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
	<td><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
</tr>
</form>
</table>
</body>
</html>
