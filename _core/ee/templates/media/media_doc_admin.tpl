<%media_manage:doc%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Document</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/style.css" type="text/css">
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv=pragma content=no-cache>
	<META HTTP-EQUIV="expires" CONTENT="0">
  <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
	<%print_admin_js%>
</head>

<body bottommargin="3" leftmargin="3" marginheight="0" marginwidth="0" rightmargin="3" topmargin="3" style="background: #fff;">
<%:admin_menu%>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<center>
<form name="current" action="" method="post" enctype="multipart/form-data" onKeyPress="return block_enter(event)">
<table width="100%" border=0>
	<tr>
		<td class="header" height="31">Edit document</td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr>
		<td bgcolor="#092869"><%inv:1,1%></td>
	</tr>
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="3" border="0">
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Documents:</b></td>
				</tr>
				<%try_include:media/media_manage_error_msg%>
				<%:media_image_lang_bar%>
				<tr>
					<td><%inv:1,5%></td>
				</tr>
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2" align="center" height="30"><b><input type="submit" value="Save" name="save" class="button">&nbsp;&nbsp;<input type="button" value="Cancel" class="button" onclick="javascript:history.back(-1);"></b></td>
				</tr>
			<table>
		</td>
	</tr>
</table>
</form></center>
</body>
</html>