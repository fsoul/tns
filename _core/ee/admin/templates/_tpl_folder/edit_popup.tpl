<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
<%iif:<%:modul%>,_tpl_folder,<script src="<%:EE_HTTP%>js/users.js"></script>,%>
</head>

<body onload="hideDiv('group_access', 'sl_unselect');">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post" onsubmit="submit_edit_form('access_groups', 'no_access_groups')">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="auto_redirect_add" value="true" />
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr><td colspan="3">
<br />
<ul class="ul_sl">
	<li class="sl" id="general_sl"><a href="#" onclick="hideDiv('group_access', 'sl_unselect'); showDiv('general', 'sl'); return false;">General</a></li>
	<li class="sl" id="group_access_sl"><a href="#" onclick="hideDiv('general', 'sl_unselect'); showDiv('group_access', 'sl'); return false;">User Groups</a></li>
	<!--<li class="sl" id="backoffice_access_sl"><a href="#" onclick="hideDiv('general', 'sl_unselect'); hideDiv('group_access', 'sl_unselect'); showDiv('backoffice_access','sl'); return false;">Backoffice Access</a></li>-->
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
</form>
</table>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>

<script type="text/javascript">
        <!--
	var page_renamed = false;

	function permanentRedirectHandler()
	{
		if(page_renamed &&
		   '<%get_config_var:confirm_add_redirect_on_page%>' == '1')
		{
			if(!confirm('Add permanent redirect for pages in this folder automatically ?'))
			{
				document.fs.auto_redirect_add.value = 'false';
			}
		}
	}

	if (typeof document.fs.save != 'undefined') {
		document.fs.save.onclick = permanentRedirectHandler;
	}
	//-->      
</script>

</body>
</html>