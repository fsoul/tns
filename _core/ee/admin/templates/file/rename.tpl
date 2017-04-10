<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>File</title>
<script language="JavaScript"  type="text/javascript">
function check() {
	frm=document.fi;
	if(frm.aFile.value=="") alert("Please, enter new file name");
	else frm.submit();
}
</script>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<center>
<form name="fi" action="file.php" method="post">
<input type="hidden" name="f_name" value="<%getValueOf:f_name%>">
<input type="hidden" name="op" value="<%getValueOf:op%>">
<input type="hidden" name="save" value="true">
<input type="hidden" name="admin_template" value="<%getValueOf:admin_template%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="40" colspan="2"><%getValueOf:pageTitle%></td>
	</tr>
	<tr>
		<td bgcolor="#092869" colspan="2"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE">
		<td class="CmsMainText" height="30">&nbsp;&nbsp;<b>Enter new File Name</b></td>
		<td><input type="text" name="aFile" value="<%getValueOf:f_name%>" size="30"></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE" colspan="2"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr><%getValueOf:error%>
</table><br><input type="button" value="Save" name="save" class="button" onclick="check()">&nbsp;&nbsp;<input type="button" value="Cancel" class="button" onclick="window.parent.closePopup('yes')">
</form></center>
</body>
</html>
