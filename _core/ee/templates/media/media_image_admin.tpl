<%media_manage:images%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Image</title>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<%:EE_HTTP%>css/style.css" type="text/css">
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv=pragma content=no-cache>
	<META HTTP-EQUIV="expires" CONTENT="0">
  <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
	<%print_admin_js%>

<script language="JavaScript">
    function edit_size(vr) {
        if (vr == 'default') {
            this.document.current.f_size_x.disabled  = 'disabled';
            this.document.current.f_size_y.disabled    = 'disabled';
            this.document.current.image_size.checked = 'default';
            customsize.style.display = 'none';
            defaultsize.style.display = 'inline';
            this.document.getElementById('size_custom_ch').checked = "";
            this.document.getElementById('size_default_ch').checked = "checked";
        } else {
            this.document.current.f_size_x.disabled  = '';
            this.document.current.f_size_y.disabled    = '';
            customsize.style.display = 'inline';
            defaultsize.style.display = 'none';
            this.document.getElementById('size_custom_ch').checked = "checked";
            this.document.getElementById('size_default_ch').checked = "";
        }
    }

</script>
</head>

<body bottommargin="3" leftmargin="3" marginheight="0" marginwidth="0" rightmargin="3" topmargin="3" style="background: #fff;">
<%:admin_menu%>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<center>
<form name="current" action="" method="post" enctype="multipart/form-data" onKeyPress="return block_enter(event)">
<table width="100%" border=0>
	<tr>
		<td class="header" height="31">Edit image</td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
	<tr>
		<td bgcolor="#092869"><%inv:1,1%></td>
	</tr>
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="3" border="0">
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Image size:</b></td>
				</tr>
				<tr>
					<td colspan="2"><input id="size_default_ch" onClick="javascrip:edit_size('default')" type="radio" name="image_size" value="default">Original size<div id="defaultsize" style="display:inline">: <b><%:size_default_x%></b> X <b><%:size_default_y%></b> pixels</div></td>
				</tr>
				<%include:media/media_edit_custom_size%>
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Images:</b></td>
				</tr>
				<%try_include:media/media_manage_error_msg%>
				<%:media_image_lang_bar,0,0%>
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