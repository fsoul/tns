<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
<META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
    
    <%print_admin_js%>
</head>

<body>
<%:admin_menu%>
<p>&nbsp;</p><p>&nbsp;</p>
<p style="text-align:center;">New user added successfully, login and password were sent by email<br><br>
<a href="<%:modul%>.php?admin_template=<%get:admin_template%>"><%include:buttons/btn_back%></a></p>

</body>
</html>
