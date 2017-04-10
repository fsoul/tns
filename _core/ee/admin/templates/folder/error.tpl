<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Folder</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<center>
<form name="fi" action="folder.php" method="post">
<input type="hidden" name="f_name" value="<%getValueOf:f_name%>">
<input type="hidden" name="op" value="<%getValueOf:op%>">
<input type="hidden" name="save" value="true">
<table width="100%" border=0>
    <tr><td class="header" width="300" height="31">Files</td></tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="40"><%getValueOf:pageTitle%></td>
	</tr>
	<tr>
		<td bgcolor="#092869"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE" class="error" height="20" align="center"><%getValueOf:error%></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
</table><br><input type="button" value="Cancel" class="button" onclick="window.document.location = '<%:EE_ADMIN_URL%>_files.php?folder=<%:folder%>'">
</form></center>
</body>
</html>
