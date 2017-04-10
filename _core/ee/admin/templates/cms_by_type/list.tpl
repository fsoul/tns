<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>CMS</title>
	<meta http-equiv="Content-Language" content="<%getValueOf:language%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />

<script type="text/javascript">
function openEditor(f_name, t, type) {
	x=800;
	y=670;
	URL="<%:EE_ADMIN_URL%>cms.php?cms_name="+f_name+"&t="+t+"&lang=<%:language%>";
	window.parent.openPopup2(URL,x,y);
}

</script>

</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0">
<form name="fd" action="cms_by_type.php" method="post" enctype="multipart/form-data">
<input type="hidden" name="cms_name" value="<%getValueOf:cms_name%>">
<input type="hidden" name="lang" value="<%getValueOf:lang%>">
<br>
<table align="center" cellpadding="0" cellspacing="4" class="tableborder" border="0">
	<tr bgcolor="#eeeeee" class="table_header">
		<td colspan="3" align="center" height="20">Field (language <%getValueOf:lang%>):</td>
	</tr>
	<tr bgcolor="#eeeeee" class="table_header">
		<td colspan="3" align="center" height="30"><input type="text" value="<%getValueOf:aFieldName%>" name="aFieldName" size="20"></td>
	</tr>

	<tr><td colspan="3" bgcolor="#092869"><%inv:1,1%></td></tr>

	<tr>
		<td height="30"><input type="radio" name="op" value="txt" <%test_checked:txt%>></td>
		<td align="right" class="table_data">Text</td><td valign="middle">&nbsp;<%getValueOf:fText%> <%getValueOf:edit_cms_fText%></td>
	</tr>

	<tr><td colspan="3" bgcolor="#092869"><%inv:1,1%></td></tr>

	<tr>
		<td height="30"><input type="radio" name="op" value="img" <%test_checked:img%>></td>
		<td align="right" class="table_data">Image</td>
		<td><%getValueOf:fImage%></td>
	</tr>
	<tr>
		<td colspan="2" align="right" class="table_data">URL :</td><td><input size="70" type="text" name="fImageSrc" value="<%getValueOf:src%>"></td>
	</tr>
	<tr>
		<td align="right" colspan="2" class="table_data">File :</td>
		<td class="table_data"><input size="56" type="file" name="nfile"></td>
	</tr>
	<tr>
		<td align="right" colspan="2" class="table_data">Width :</td><td>
		<table cellpadding="0" cellspacing="0"><tr>
			<td><input size="3" type="text" name="fImageWidth" value="<%getValueOf:width%>"></td>
			<td class="table_data">&nbsp;&nbsp;&nbsp;Height :&nbsp;</td><td><input size="3" type="text" name="fImageHeight" value="<%getValueOf:height%>"></td>
		</tr></table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right" class="table_data">Alt :</td><td><input size="70" type="text" name="fImageAlt" value="<%getValueOf:alt%>"></td>
	</tr>
	<tr><td colspan="3" bgcolor="#092869"><%inv:1,1%></td></tr>
	<tr>
		<td colspan="3" class="table_data"><input type="button" value="Cancel" class="button" onclick="window.parent.closePopup()">&nbsp;&nbsp;<input type="submit" value="Save" name="save" class="button"></td>
	</tr>
</table><br>
</form>
</body>
</html>
