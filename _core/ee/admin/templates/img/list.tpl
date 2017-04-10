<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Image</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<%print_admin_js%>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<center>
<form name="fi" action="img.php" method="post" enctype="multipart/form-data">
<input type="hidden" name="i_name" value="<%getValueOf:i_name%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="40">Edit Image:&nbsp;&nbsp;<%getValueOf:i_name%> (<%getValueOf:size_x%>x<%getValueOf:size_y%>px)</td>
	</tr>
	<tr>
		<td bgcolor="#092869"><img src="img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE" class="table_header">
		<td align="center" height="30"><input type="file" name="nfile"></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE"><img src="img/inv.gif" width="1" height="5"></td>
	</tr>
</table><br><input type="button" value="Cancel" class="button" onclick="window.close()">&nbsp;&nbsp;<input type="submit" value="Save" name="save" class="button">
</form></center>
</body>
</html>
