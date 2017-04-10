<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Page properties</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js%>
</head>

<body>
<table border="0">
	<tr><td class="header" height="31">Properties of page "<%getBigValueOf:page_name%>" for language </td>
	<td><select onchange="javascript:document.fd.reload.value='false'; document.fd.lang.value=this.value; document.fd.language.value=this.value; document.fd.save.click();" name="language"><%:lang_select%>
        </select></td></tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="30">Name</td>
		<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;Value</td>
		<td width="100%">&nbsp;</td>
	</tr>
<form name="fd" method="POST">
<input type="hidden" name="reload" value="true">
<input type="hidden" name="newlang" value="<%getValueOf:lang%>">
<input type="hidden" name="t" value="<%getValueOf:t%>">
<input type="hidden" name="language" value="<%getValueOf:language%>">
<input type="hidden" name="lang" value="<%getValueOf:lang%>">
	<tr bgcolor="#092869"><td colspan="3"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td></tr>
	<tr <%tr_bgcolor%>>
		<td><img src="<%:EE_HTTP%>img/inv.gif" width="250" height="1"></td>
		<td><img src="<%:EE_HTTP%>img/inv.gif" width="150" height="1"></td>
		<td><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<%:page_meta_cont%>
        <tr <%tr_bgcolor%>>
		<td height="30" class="table_data">&nbsp;&nbsp;Page Created</td>
		<td><%:create_date%></td>
		<td class="error">&nbsp;</td>
	</tr>
	<tr <%tr_bgcolor%>>
		<td height="30" class="table_data">&nbsp;&nbsp;Page Modified</td>
		<td><%:edit_date%></td>
		<td class="error">&nbsp;</td>
	</tr>
	<tr bgcolor="#092869"><td colspan="3"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td></tr>
</table><br>
&nbsp;&nbsp;<%include:buttons/btn_reset%>&nbsp;&nbsp;<%include:buttons/btn_close_popup%>&nbsp;&nbsp;<%include:buttons/btn_save%>
</form>
</body>
</html>