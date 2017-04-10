<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,start_trace_time%>%>
<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%print_admin_js:0%>

	<script type="text/javascript">
	<%include:<%:EE_CORE_PATH%>templates/admin_js_openEditor%>
	</script>


<script src="<%:EE_HTTP%>js/calendar.js"></script>
<%iif:<%:modul%>,_tpl_folder,<script src="<%:EE_HTTP%>js/users.js"></script>,%>
</head>

<body>
<div id="dhtmltooltip2" onmouseout="tm1=setTimeout('hideddrivetip()',500)" onmouseover="clearTimeout(tm1)"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
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
		<%include_if:op,3,buttons/btn_save_add_more%>
<%print_next_previous_buttons%>
	</td>
</tr>
<%include_if:modul,_mail_inbox,,edit_mandatory_message%>
<input type="hidden" name="from" value="<%:from%>">
</form>
</table>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,end_trace_time%>%>