<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
    <!--- link rel="stylesheet" href="<%:EE_HTTP%>css/main.css" type="text/css" --->
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js%>
</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post" onsubmit="return checkErrors();">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr bgcolor="#ededfd"><td>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">

<input type="hidden" name="refresh" value="true">

<tr <%tr_bgcolor%> >
	<td><img src="<%:EE_HTTP%>img/inv.gif" width="200" height="1"></td>
	<td><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	<td width="100%"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
</tr>

<%print_fields%>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
		<%include:buttons/btn_save_continue%>&nbsp;
	</td>
</tr>
<tr>
	<td height="30" class="error" colspan="2">&nbsp;&nbsp;* - <%cons:Mandatory_Fields%></td>
	<td class="error">&nbsp;</td>

</tr>

</table>
</td>
<%include_if:edit,,,<%:modul%>/sample_text%>
</tr>
</table>
</form>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>