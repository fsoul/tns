<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
<script src="<%:EE_HTTP%>js/users.js"></script>
</head>

<body onload="hideDiv('user_groups', 'sl_unselect'); hideDiv('backoffice_access', 'sl_unselect');">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post" onsubmit="return submit_edit_form('user_groups_sel', 'available_groups_sel');">
<input type="hidden" name="refresh" value="true">
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr><td colspan="3">
<br />
<ul class="ul_sl">
	<li class="sl" id="general_sl"><a href="#" onclick="hideDiv('user_groups', 'sl_unselect'); hideDiv('backoffice_access', 'sl_unselect'); showDiv('general', 'sl'); return false;">General</a></li>
	<li class="sl" id="user_groups_sl"><a href="#" onclick="hideDiv('general', 'sl_unselect'); hideDiv('backoffice_access', 'sl_unselect'); showDiv('user_groups', 'sl'); return false;">User Groups</a></li>
	<li class="sl" id="backoffice_access_sl"><a href="#" onclick="hideDiv('general', 'sl_unselect'); hideDiv('user_groups', 'sl_unselect'); showDiv('backoffice_access','sl'); return false;">Backoffice Access</a></li>
</ul>
</td></tr>

<%print_fields_by_group%>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include_if:modul,_mail_inbox,,buttons/btn_save%>&nbsp;
		<%include_if:op,3,buttons/btn_save_add_more%>&nbsp;
	</td>
</tr>
<%include_if:modul,_mail_inbox,,edit_mandatory_message%>
</table>
</form>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>