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
<table border=0 cellpadding="5">
<tr><td>
	<table cellpadding="2" cellspacing="0" style="border:1px solid #999">
	<tr bgcolor="#eeeeee">
		<td colspan=3><b>Export completed successfully</b></td>
	</tr>
	<tr style="background-color: #999;"><td width="25"></td><td width="170"></td><td width="120"></td></tr>
	<tr>
		<td colspan="2">&nbsp;Total exported directory size:</td>
		<td><%:total_export_size%></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;Exported directories:</td>
		<td><%:total_export_dir_count%></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;Exported files:</td>
		<td><%:total_export_file_count%></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;External files downloaded:</td>
		<td><%:total_export_external_file_count%></td>
	</tr>
	<tr><td width="25"></td><td width="170"></td><td width="120"></td></tr>
	<%iif:<%:export_archived%>,1,
	<tr bgcolor="#eeeeee">
		<td colspan="3" style="border-top:1px solid #999"><b>Files archived successfully</b></td>
	</tr>
	<tr style="background-color: #999;"><td width="25"></td><td width="170"></td><td width="120"></td></tr>
	<tr>
		<td colspan="2">&nbsp;Archive size:</td>
		<td><%:export_archive_size%></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;Archive compression rate:</td>
		<td><%:export_compression_rate%></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;Download link:</td>
		<td><a href="<%:export_download_link%>" style="border: 1px solid #999; text-decoration: none; display: block; text-align: center; padding: 1px;">&nbsp; download &nbsp;</a></td>
	</tr>%>
	</table>
</table>
<form method="post">
<%include:buttons/btn_back%>
</form>
</form></div>

</body>
</html>