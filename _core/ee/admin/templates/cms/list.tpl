<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>CMS <%get_title_cms%></title>
	<meta http-equiv="Content-Language" content="<%getValueOf:language%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<%print_admin_js%>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" onload="if (window.frames[0].FCKConfig) window.frames[0].FCKConfig.lang = document.fd.lang.value">
<div id="dhtmltooltip2" onMouseOver="clearTimeout(tm1)" onMouseOut="tm1=setTimeout('hideddrivetip()',1000)"></div>
<script language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></script>
<form name="fd" method="post">
<input type="hidden" name="save_content_cancel" value="">
<input type="hidden" name="lang" value="<%getValueOf:lang%>">
<input type="hidden" name="nextlang" value="">

<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">

	<tr bgcolor="#eeeeee" class="table_header">
		<td align="left" height="40" colspan="2">&nbsp;<%include:<%:modul%>/<%iif:<%strtolower:<%get:use_languages_list%>%>,no,no_%>languages_list%></td>
		<td align="left" height="40">&nbsp;<%include:<%iif:<%strtolower:<%get:use_languages_list%>%>,no,,<%:modul%>/checkbox_use_default_language%>%></td>
	</tr>

<%:list_rows%>

</table>
<br/>

<input type="hidden" name="type" value="<%:type%>" />
&nbsp;&nbsp;<input type="submit" value="Save" name="save" class="button">&nbsp;&nbsp;<input type="button" value="Close" class="button" onclick="window.parent.closePopup()">
</form>
</body>
</html>
