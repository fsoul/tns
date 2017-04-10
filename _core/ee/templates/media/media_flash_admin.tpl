<%media_manage:flash%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Image</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/style.css" type="text/css">
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="pragma" content="no-cache">
	<META HTTP-EQUIV="expires" CONTENT="0">
  <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
	<%print_admin_js%>

<script language="JavaScript">
    function edit_size(vr) {
        if (vr == 'default') {
            this.document.current.f_size_x.disabled  = 'disabled';
            this.document.current.f_size_y.disabled    = 'disabled';
            this.document.current.f_size_unit_type.disabled    = 'disabled';
            this.document.current.image_size.checked = 'default';
            customsize.style.display = 'none';
            defaultsize.style.display = 'inline';
            this.document.getElementById('size_custom_ch').checked = "";
            this.document.getElementById('size_default_ch').checked = "checked";
        } else {
            this.document.current.f_size_x.disabled  = '';
            this.document.current.f_size_y.disabled    = '';
            this.document.current.f_size_unit_type.disabled    = '';
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
		<td class="header" height="31">Edit flash movie</td>
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
					<td colspan="2"><b>&nbsp;&nbsp;Movie size:</b></td>
				</tr>
				<tr>
					<td colspan="2"><input id="size_default_ch" onClick="javascrip:edit_size('default')" type="radio" name="image_size" value="default">Original size<div id="defaultsize" style="display:inline"></div></td>
				</tr>
				<%include:media/media_edit_custom_size%>
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Movie params:</b></td>
				</tr>
				<tr>
					<td>Movie background color: </td>
					<td><input style="width:272px;" type="text" value="<%:media_bgcolor%>" name="media_bgcolor"></td>
				</tr>
				<tr>
					<td>Movie quality: </td>
					<td>
						<select name="media_quality">
							<option value="high" <%iif::media_quality,high,selected%>>High</option>
							<option value="medium" <%iif::media_quality,medium,selected%>>Medium</option>
							<option value="low" <%iif::media_quality,low,selected%>>Low</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Show menu: </td>
					<td>
						<select name="media_show_menu">
							<option value="yes" <%iif::media_show_menu,yes,selected%>>Yes</option>
							<option value="no" <%iif::media_show_menu,no,selected%>>No</option>
						</select>
					</td>
				</tr>


				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Movies:</b></td>
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