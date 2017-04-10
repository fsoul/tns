<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js%>
	<script src="<%:EE_HTTP%>js/calendar.js"></script>
	<script type="text/javascript">
	function openEditor(f_name, t, type, language) {
		language = (language) ? language : '<%:language%>';
		if (type=="text") {
			x=600;
			y=200;
		} else {
			x=800;
			y=710;
		}
		URL="<%:EE_ADMIN_URL%>cms.php?cms_name="+f_name+"&t="+t+"&lang="+language+"&admin_template=<%get:admin_template%>&type="+type;
		window.parent.openPopup2(URL,x,y);
	}
	</script>
</head>
<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="<%:modul%>.php?op=<%getValueOf:op%>&edit=<%getValueOf:edit%>&admin_template=<%:admin_template%>" method="post">
<input type="hidden" name="refresh" value="true">
<tr <%tr_bgcolor%>>
	<td><img src="../img/inv.gif" width="200" height="1" alt=""/></td>
	<td><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
	<td width="100%"><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Id</td>
	<td><%iif:<%:edit%>,,,<input readonly type="text" name="email_id" value="<%getValueOf:email_id%>" size="7">%></td>
	<td class="error">&nbsp;&nbsp;<%getError:email_id%></td>
</tr>
<!--
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Group *</td>
	<td>
		<select name="nl_group_id">
			<%nl_groups_list%>
		</select>
	</td>
	<td class="error">&nbsp;&nbsp;<%getError:nl_group_id%></td>
</tr>
-->
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;From Name *</td>
	<td><input <%iif::email_id,,,<%iif::email_status,draft,,readonly%>%> type="text" name="email_from_name" value="<%getValueOf:email_from_name%>" size="70"></td>
	<td class="error">&nbsp;&nbsp;<%getError:email_from_name%></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;From Email *</td>
	<td><input <%iif::email_id,,,<%iif::email_status,draft,,readonly%>%> type="text" name="email_from_email" value="<%getValueOf:email_from_email%>" size="70"></td>
	<td class="error">&nbsp;&nbsp;<%getError:email_from_email%></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Subject *</td>
	<td><%include:<%iif::email_status,draft,<%:modul%>/edit_subject_edit_cms%>%><%cms:<%iif:<%:edit%>,,,news_letter_subject_<%:email_id%>%>%><%iif:<%:edit%>,,<input <%iif::email_id,,,<%iif::email_status,draft,,readonly%>%> type="text" name="email_subject" value="<%getValueOf:email_subject%>" size="70">,<input type="hidden" name="email_subject" value="<%getValueOf:email_subject%>" size="70">%></td>
	<td class="error">&nbsp;&nbsp;<%getError:email_subject%></td>
</tr>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Finish date</td>
	<td><%include:<%:modul%>/edit_finish_date%></td>
</tr>


<!--<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Header *</td>
	<td><textarea <%iif::email_id,,,<%iif::email_status,draft,,readonly%>%> name="email_header" rows="5" cols="50"><%getValueOf:email_header%></textarea></td>
	<td class="error">&nbsp;&nbsp;<%getError:email_header%></td>
</tr>
-->


<tr <%tr_bgcolor%>>
	<td height="30" class="table_data">&nbsp;&nbsp;Template</td>
	<td>
		<%include:<%iif::email_id,,<%:modul%>/select_tpl,<%iif::email_status,draft,<%:modul%>/select_tpl%>%>%>
		<%iif::email_id,,,<%iif::email_status,draft,,<%iif::email_tpl,,No template,:email_tpl%>%>%>
	</td>
	<td class="error">&nbsp;&nbsp;<%getError:email_tpl%></td>
</tr>



<%include:<%iif:<%:edit%>,,,<%:modul%>/edit_body%>%>
<tr <%tr_bgcolor%>>
<td colspan="10">
	<table border="0">
	<tr><td><%inv:50,0%></td><td><%inv:50,0%></td><td><%inv:50,0%></td><td><%inv:50,0%></td></tr>
	<tr>
	<%include:<%iif::email_id,,<%:modul%>/btn_back,<%iif::email_status,outbox,<%:modul%>/btn_back,draft,<%:modul%>/btn_back%>%>%>
	<%include:<%iif::email_id,,<%:modul%>/btn_save,<%iif::email_status,draft,<%:modul%>/btn_save%>%>%>
	<%include:<%iif:<%:email_transaction_id%>,,,<%:modul%>/btn_history%>%>
	</tr>
	<tr><td><%inv:50,0%></td><td><%inv:50,0%></td><td><%inv:50,0%></td><td><%inv:50,0%></td></tr>
	</table>
</td>
</tr>
</form>
<%include:<%iif:<%:email_id%>,,,<%:modul%>/edit_ext%>%>
<tr <%tr_bgcolor%>>
	<td><img src="../img/inv.gif" width="200" height="10" alt=""/></td>
	<td><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
	<td width="100%"><img src="../img/inv.gif" width="1" height="1" alt=""/></td>
</tr>

</table>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>
