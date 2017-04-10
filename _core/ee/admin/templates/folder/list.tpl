<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Folder</title>
<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<script language="JavaScript"  type="text/javascript">
function check() {
	frm=document.fi;
	if(frm.aName.value=="") {
		alert("Please, enter new Folder Name");
		frm.aName.focus();
	} else frm.submit();
}
</script>
<%print_admin_js%>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<center>
<form name="fi" action="folder.php" method="post">
<input type="hidden" name="f_name" value="<%getValueOf:f_name%>">
<input type="hidden" name="op" value="<%getValueOf:op%>">
<input type="hidden" name="save" value="true">
<input type="hidden" name="admin_template" value="<%getValueOf:admin_template%>">
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="40" colspan="3"><%getValueOf:pageTitle%></td>
	</tr>
	<tr>
		<td bgcolor="#092869" colspan="3"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr bgcolor="#EFEFDE">
		<td width="33%" class="CmsMainText" height="30">&nbsp;&nbsp;<b>New Folder Name</b></td>
		<td width="33%" align="center"><input type="text" name="aName" value=""></td>
		<td class="error"><%getError:aName%></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE" colspan="3"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
</table><br><input type="button" value="Save" name="save" class="button" onclick="check()">&nbsp;&nbsp;<input type="button" value="Cancel" class="button" onclick="window.parent.closePopup()">
</form></center>
</body>
</html>
