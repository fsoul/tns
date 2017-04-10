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
	<td><%inv:200,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>

<%row%
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;<%:field_title%></td>
	<td><%try_include:<%:modul%>/edit_fields_<%:type%>,edit_fields_<%:type%>%></td>
	<td class="error">&nbsp;</td>
</tr>
<%iif:<%getError:<%:field_name%>%>,,,<tr><td></td><td colspan='2' class="error"><%getError:<%:field_name%>%></td></tr>%>
%row%>

    <tr bgcolor="#ededfd">
        <td height="30" class="table_data">&nbsp;&nbsp;Default alias for default page</td>
        <td>&nbsp;<%get_default_aliase_for_page:<%getField:select id from tpl_pages where default_page=1 limit 0\,1%>%></td>
        <td class="error">&nbsp;</td>
    </tr>
    <tr>
        <td height="30" class="table_data">&nbsp;&nbsp;Alias rule example</td>
        <td colspan="2"><%htmlentities:<%getField:SELECT val FROM config WHERE var='alias_rule_example'%>%></td>
    </tr>
    <tr>
        <td height="30" class="table_data">&nbsp;&nbsp;Alias example for default page</td>
        <td>&nbsp;<%get_default_aliase_for_page:<%getField:select id from tpl_pages where default_page=1 limit 0\,1%>,<%getField:SELECT val FROM config WHERE var='alias_rule_example'%>%></td>
        <td class="error">&nbsp;</td>
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