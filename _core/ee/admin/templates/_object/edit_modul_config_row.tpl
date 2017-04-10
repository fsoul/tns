<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%:pageTitle%></title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js:0%>
</head>

<body>
<div id="dhtmltooltip2"></div>
<div id="whole_page_content">
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="<%:op%>">

<tr <%tr_bgcolor%>>
	<td><%inv:170,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>

<%row%
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;<%:field_title%></td>
	<td><%try_include:<%:modul%>/edit_fields_<%:type%>,edit_fields_<%:type%>%></td>
	<td></td>
</tr>
<%iif:<%getError:<%:field_name%>%>,,,<tr><td></td><td colspan='2' class="error"><%getError:<%:field_name%>%></td></tr>%>
%row%>

    <tr>
        <td height="30" class="table_data">&nbsp;&nbsp;Object alias rule example</td>
        <td colspan="3"><%htmlentities:<%getField:SELECT val FROM config WHERE var='object_alias_rule_example'%>%></td>
    </tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
	</td>
</tr>
</form>
</table>
</div>
<script type="text/javascript">set_sizes_by_content();</script>
</body>
</html>