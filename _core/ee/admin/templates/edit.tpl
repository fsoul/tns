<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
<%print_admin_js%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<%:admin_menu%>
<table width="100%" border=0>
	<tr>
		<td class="header" height="31"><%getValueOf:pageTitle%></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">

<tr <%tr_bgcolor%> >
	<td><%inv:200,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>

<%print_fields%>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include_if:modul,_mail_inbox,,buttons/btn_save%>&nbsp;
		<%include_if:op,3,buttons/btn_save_add_more%>&nbsp;
	</td>
</tr>
<tr>
	<td height="30" class="error" colspan="2">&nbsp;&nbsp;* - <%cons:Mandatory_Fields%></td>
	<td class="error">&nbsp;</td>

</tr>

</form>
</table>
</body>
</html>
