<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%:pageTitle%></title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js:0%>
    <script type="text/javascript" language="JavaScript">
    	function check_permanent_redirect_state()
	{
		if(document.fs.auto_add_redirect_on_page.checked == true)
		{
			document.fs.confirm_add_redirect_on_page.disabled = false;
		}
		else
		{
			document.fs.confirm_add_redirect_on_page.disabled = true;
			document.fs.confirm_add_redirect_on_page.checked = false;
		}

		if(document.fs.auto_add_redirect_on_language.checked == true)
		{
			document.fs.confirm_add_redirect_on_language.disabled = false;
		}
		else
		{
			document.fs.confirm_add_redirect_on_language.disabled = true;
			document.fs.confirm_add_redirect_on_language.checked = false;
		}
	}
    </script>
</head>

<body onload="check_permanent_redirect_state();">
<div id="dhtmltooltip2"></div>
<div id="whole_page_content" style="width:100%">
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="<%:op%>">

<%row%
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;<%:field_title%></td>
	<td><%try_include:<%:modul%>/edit_fields_<%:type%>,edit_fields_<%:type%>%></td>
	<td class="error">&nbsp;</td>	
</tr>
%row%>
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