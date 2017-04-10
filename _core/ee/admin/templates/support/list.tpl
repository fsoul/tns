<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>Support</title>
    <link rel="stylesheet" href="../css/admin_panel_style.css" type="text/css">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
<%print_admin_js%>
</head>

<body>
<%:admin_menu%>
<table border=0 class="tableborder">
    <tr><td height="31"><img src="../img/support_title.gif"> <td class="header" width="300">Support</td></tr>
</table>

<form name="fs" method="POST">
<table border=0 cellpadding="5">
<tr>
<td><strong>Request form</strong>

<b>The following information will be send with your request:</b><br />
<%include:<%:modul%>/following_information%>
<hr />
</td>
<tr>
<td>
<table cellpadding="5" cellspacing="0">
<tr><td>
	Your name:
	<td><input type=text name="name" value="<%:name%>">
	<td rowspan="3" valign="top">
		Best way to contact with me:<br />
		<input type="radio" name="best_way" value="e-mail" <%iif::best_way, e-mail, checked%>>E-mail<br />
		<input type="radio" name="best_way" value="phone" <%iif::best_way, phone, checked%>>Phone<br />
	</td>
<tr><td>
	Contact e-mail:
	<td><input type=text name="contact_email" value="<%:contact_email%>">
<tr><td>
	Contact phone:
	<td><input type=text name=contact_phone value="<%:contact_phone%>">
<tr><td colspan=3>
	Message:<br />
	<textarea rows="5" cols="30" name="message"><%:message%></textarea>
<tr><td>
	&nbsp;&nbsp;<%include:buttons/btn_send%>
</table>

</form>
</tr>
<tr>
<td>
<%include:<%:modul%>/you_are_welcome%>
</table>

</body>
</html>
