<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%getValueOf:pageTitle%></title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js:0%>
</head>

<body>
<div id="dhtmltooltip2"></div>
<div id="whole_page_content">
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="<%:op%>">
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr style="background-color:#fff;">
	<td width="100%"><%inv:1,30%></td>
</tr>
<tr>
	<td style="text-align:center; font-weight:bold; font-size:120%;">
You should re-login for the changes take effect.<br/> Do you want to logout now?
</td>
</tr>
<tr style="background-color:#fff;">
	<td width="100%"><%inv:1,20%></td>
</tr>
<tr>
	<td height="30" class="table_data" align="center">&nbsp;&nbsp;
<input style="cursor: hand" type="submit" accessKey="<%CONSTANT:BUT_ACCESS_KEY_SAVE%>" value="<%CONSTANT:BUT_LABEL_YES%>" name="confirm_yes" class="button">&nbsp;&nbsp;
<input style="cursor: hand" type="submit" accessKey="<%CONSTANT:BUT_ACCESS_KEY_CANCEL%>" value="<%CONSTANT:BUT_LABEL_NO%>" name="confirm_no" class="button">&nbsp;
	</td>
</tr>
</table>
</form>
</div>
</body>
</html>