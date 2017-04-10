<html>
<head>
	<title>User Password Edit</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body>

<div style="height:31px" class="header">User Password Edit</div>

<form
action=""
name="form1"
method="POST"
><input type="hidden" name="refresh" value="yes"><input type="hidden" name="uid" value="<%:uid%>">
<table width="100%" cellpadding="2" cellspacing="0" class="tableborder" border="0" style="padding-left:6px; background-color:#ededfd">
<tr>
<td height="30">User Name:  </td><td><%:user_name%></td>
</tr>
<tr>
<td height="30">Login:  </td><td><%:user_login%></td>
</tr>
<tr>
<td height="30">Current password:</td>
<td><input style="width:200px" type="password" name="oldpass" autocomplete="off" /></td>
</tr>
<tr>
<td height="30">New password:</td>
<td><input style="width:200px" type="password" name="newpass" autocomplete="off" /></td>
</tr>
<tr>
<td height="30">Confirm new password:</td>
<td><input style="width:200px" type="password" name="confnewpass" autocomplete="off" /></td>
</tr>
<tr>
<td height="30"><a onclick="window.close(); return false;"><%include:buttons/btn_cancel%></a>&nbsp;
<%include:buttons/btn_save%>&nbsp;</td><td></td>
</tr>
</table>
</form>

<br><div class="error"><%getError:password_edit%></div>

</body>

</html>