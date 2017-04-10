<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js%>

<script type="text/javascript">
function openEditor(f_name, t) {
	x=800;
	y=670;
	URL="<%:EE_ADMIN_URL%>cms.php?cms_name="+f_name+"&t="+t+"&lang=<%:language%>";
	window.parent.openPopup2(URL,x,y);
}
</script>

<script type="text/javascript">
function openEditorObject(r_id, id) {
	x=800;
	y=670;
	URL="<%:EE_ADMIN_URL%>cms_object.php?record_id="+r_id+"&id="+id+"&lang=<%:language%>";
	window.parent.openPopup2(URL,x,y);
}
</script>

<script src="<%:EE_HTTP%>js/calendar.js"></script>

</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="<%:EE_ADMIN_URL%><%:modul%>.php?op=<%:op%>&edit=<%:edit%>&admin_template=yes" method="post">
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
		<%include_if:op,3,buttons/btn_save_add_more%>&nbsp;
		<%include:buttons/btn_save_continue%>&nbsp;
	</td>
</tr>
<%include_if:modul,_mail_inbox,,edit_mandatory_message%>
</form>
</table>
</body>
</html>
