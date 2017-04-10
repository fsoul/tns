<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>View Support Request</title>
    <!--- link rel="stylesheet" href="../css/main.css" type="text/css" --->
    <link rel="stylesheet" href="../css/admin_panel_style.css" type="text/css">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
<%print_admin_js%>
</head>

<body>
<%:admin_menu%>
<table border=0 class="tableborder">
    <tr><td height="31"><img src="../img/support_title.gif"> <td class="header" width="300">Support</td></tr>
</table>

<form name="fd" action="" method="post">
<table border=0 cellpadding="5">
<td>
<b>Thank you for your request! Our support team will process it soon and <br />
contact with you. Copy of request was sent to your e-mail</b><br />
The following information was sent as request:<br />
<%include:<%:modul%>/following_information%>
Contact name: <%:name%><br />
Phone: <%:contact_phone%><br />
E-Mail: <%:contact_email%><br />
Best way to contact: <%:best_way%><br />
<hr />
</td>
</tr>
<tr>
<td>
<b>Your request was registered</b><br />
<b>Message: </b><br />
<%parse_support_mail_message:%>

<hr />
</td>
</tr>

<tr>
<td>
<%include:<%:modul%>/you_are_welcome%>
</td>
</tr>
</table>

</body>
</html>
