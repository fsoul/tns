<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Export - Burn to CD</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<%print_admin_js%>
</head>

<body>
<%:admin_menu%>

<table width="100%" border=0>
    <tr><td class="header" width="300" height="31">Export - Burn to CD</td></tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
    <tr bgcolor="#ededfd"><td></td><td align="right">&nbsp;</td></tr>
    <tr bgcolor="#092869"><td colspan="2"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td></tr>
</table><br>
<div align="center">
<form name="fd" action="" method="post">
<table border=0 cellpadding="5">
<tr><td>
	<table cellpadding="2" cellspacing="0" style="border:1px solid #999">
	<tr bgcolor="#eeeeee">
		<td colspan=3><b>General export options</b></td>
	</tr>
	<tr style="background-color: #999;"><td width="25"></td><td width="170"></td><td width="120"></td></tr>
	<tr><td><input type=checkbox value=1 name="archive_content" <%iif:<%:archive_content%>,1,checked%>></td><td colspan="2"> Put static version into archive</tr>
	<tr><td><input type=checkbox value=1 name="download_content" <%iif:<%:download_content%>,1,checked%>></td><td colspan="2"> Download external content</tr>
	<tr>
		<td colspan="2">&nbsp;Export into folder</td>
		<td><input type=text name="export_folder"  value="<%:export_folder%>"></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;Base folder for exported site &nbsp;</td>
		<td><input type=text name="export_base_folder"  value="<%:export_base_folder%>"></td>
	</tr>
	</table>
</table>
<br>&nbsp;&nbsp;<%include:buttons/btn_export%>&nbsp;&nbsp;
</form></div>

</body>
</html>