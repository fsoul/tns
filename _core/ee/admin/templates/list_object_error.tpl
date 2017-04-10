<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul_title%> List</title>
        <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
<script language="JavaScript" type="text/javascript">

function openWinMetaTitle(text) {
	meta_text = text;
	openPopup('<%:EE_ADMIN_URL%>seo_meta_title_edit.php?admit_template=yes&meta_tag_name='+text,400,500,true);
}

function del(code, name, add_url) {
        frm=document.forms[0];

        if(confirm('Delete <%str_to_title::modul_title%> '+name+'?')) {
                frm.action='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op=2&del='+code;
		if (add_url) frm.action+=('&'+add_url);
                frm.submit();
        } else return false;
}
</script>
<%print_admin_js%>
</head>

<body>
<div id="whole_page_content">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>

<%:admin_menu%>

<%include:<%iif::modul,_seo,_seo/js_meta_tag_onChange%>%>
<%include:<%iif::modul,_alt_tags,_alt_tags/js_onChange%>%>
<%try_include:<%:modul%>/print_channel_info%>
<table width="100%" border="0">
	<tr>
		<td class="header" height="31"><%str_to_title::modul_title%> Management</td>
		<td align="right" valign="middle">
		</td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
        <tr style="background-color:#000;"><td colspan="119"><%inv:1,1%></td></tr>
        <%:error_message%>
        <tr style="background-color:#000;"><td colspan="119"><%inv:1,1%></td></tr>
</table><br>
<br>

<%include:<%iif:<%file_exists:<%:path%><%:helpDir%><%:modul%>.html%>,,,help_note%>%>
</div>
<iframe style="display:none" id="iframe1" height="250" width="400" src="about:blank"></iframe>
</body>
</html>
