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

<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="<%:modul%>.php?op=<%getValueOf:op%>&edit=<%getValueOf:edit%>&admin_template=<%:admin_template%><%iif::added,,,&added=<%:added%>%>" method="post">
<input type="hidden" name="refresh" value="true">
<tr <%tr_bgcolor%>>
	<td><img src="../img/inv.gif" width="200" height="1"></td>
	<td><img src="../img/inv.gif" width="1" height="1"></td>
	<td width="100%"><img src="../img/inv.gif" width="1" height="1"></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Id</td>
	<td><input readonly type="text" name="id" value="<%getValueOf:id%>" size="7"></td>
	<td class="error">&nbsp;&nbsp;<%getError:id%></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Group name *</td>
	<td><input type="text" name="group_name" value="<%getValueOf:group_name%>" size="70"></td>
	<td class="error">&nbsp;&nbsp;<%getError:group_name%></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Show on front</td>
	<td><input type="checkbox" name="show_on_front" <%iif::show_on_front,1,checked%> <%iif::op,3,checked%> value=1></td>
	<td class="error">&nbsp;&nbsp;<%getError:checkbox%></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_reset%>&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
		<%include_if:op,3,buttons/btn_save_add_more%>
	</td>
</tr>

</form>
</table>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>

