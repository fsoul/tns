<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Images and Link</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<script language="JavaScript"  type="text/javascript">
function check() {
	frm=document.fi;
	n=frm.nfile.value.search("\.jpg$");
	if(frm.nfile.value!="" && n<1) alert("Only pdf file can be uploaded!");
	else frm.submit();
}
</script>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<center>
<form name="fi" action="img2.php" method="post" enctype="multipart/form-data">
<input type="hidden" name="i_name" value="<%getValueOf:i_name%>">
<input type="hidden" name="save" value="true">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="40" colspan="2">Upload Image:&nbsp;&nbsp;<%getValueOf:i_name%></td>
	</tr>
	<tr>
		<td bgcolor="#092869" colspan="2"><img src="img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE">
		<td class="CmsMainText" height="30">&nbsp;&nbsp;<b>Link</b></td>
		<td><input type="text" name="aLname" value="<%aLname%>" size=50></td>
	</tr>
	<tr bgcolor="#EFEFDE" class="table_header">
		<td class="CmsMainText">&nbsp;&nbsp;<b>File</b></td>
		<td height="30"><input type="file" name="nfile"></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE" colspan="2"><img src="img/inv.gif" width="1" height="1"></td>
	</tr>
</table><br><input type="button" value="Cancel" class="button" onclick="window.close()">&nbsp;&nbsp;<input type="button" value="Save" name="save" class="button" onclick="check()">
</form></center>
</body>
</html>
