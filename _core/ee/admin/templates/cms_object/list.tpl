<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>CMS</title>
	<meta http-equiv="Content-Language" content="<%getValueOf:language%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" onload="window.frames[0].FCKConfig.lang = document.fd.lang.value">
<div></div>
<form name="fd" method="post">
<input type="hidden" name="cms_name" value="<%getValueOf:cms_name%>">
<input type="hidden" name="lang" value="<%getValueOf:lang%>">
<input type="hidden" name="nextlang" value="">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr bgcolor="#eeeeee" class="table_header">
		<td align="center" height="40">Choose language:&nbsp;<%print_avail_languages%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
	</tr>
	<tr>
		<td bgcolor="#092869"><%inv:1,1%></td>
	</tr>
	<tr bgcolor="#EFEFDE" class="table_header">
		<td align="center"><%print_big_cms_field%></td>
	</tr>
	<tr>
		<td bgcolor="#EFEFDE"><%inv:1,5%></td>
	</tr>
</table><br>
&nbsp;&nbsp;<input type="submit" value="Save" name="save" class="button">&nbsp;&nbsp;<input type="button" value="Cancel" class="button" onclick="window.parent.closePopup()">
</form>
</body>
</html>
