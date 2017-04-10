<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Image</title>
	<link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
	<meta http-equiv="pragma" content="no-cache" />
	<META HTTP-EQUIV="expires" CONTENT="0" />

<script language="JavaScript"  type="text/javascript">
    function submit_cur(vr) {
        if (vr == 'delete') {
            this.document.current.type.value = 'delete';
            this.document.current.submit();
        } else {

            if (this.document.current.url.checked &&
                this.document.current.f_url_text.value.length < 4) {
                    alert('You must enter URL');
                    this.document.current.f_url_text.focus();
                    return false;
            }

            this.document.current.submit();

        }
    }

    function edit_current(vr) {
        if (vr == 'open_url') {
            this.document.current.f_url_text.disabled  = '';
			this.document.current.select_button.disabled = 'disabled';
            this.document.current.open_sat_page.checked = '';
            this.document.current.open_url.checked = 'checked';
            this.document.current.open_none.checked = '';
        } else if (vr == 'open_sat_page'){
            this.document.current.f_url_text.disabled  = 'disabled';
			this.document.current.select_button.disabled = '';
            this.document.current.open_sat_page.checked = 'checked';
            this.document.current.open_url.checked = '';
            this.document.current.open_none.checked = '';
        } else {
            this.document.current.open_none.checked = 'checked';
            this.document.current.f_url_text.disabled  = 'disabled';
			this.document.current.select_button.disabled = 'disabled';
            this.document.current.open_sat_page.checked = '';
            this.document.current.open_url.checked = '';
        }
    }

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
<%print_admin_js%>
</head>

<body bottommargin="3" leftmargin="3" marginheight="0" marginwidth="0" rightmargin="3" topmargin="3">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<center>
<form name="current" action="img_edit.php" method="post" enctype="multipart/form-data">
<input type="hidden" name="i_name" value="<%getValueOf:i_name%>">
<table width="100%" border="0">
	<tr>
		<td class="header" height="31">Image Management</td>
		<td align="right" valign="middle"></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
	<tr>
		<td bgcolor="#092869"><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="1"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="3" border="0">
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Image size:</b></td>
				</tr>
				<tr>
					<td colspan="2"><input id="size_default_ch" onClick="javascrip:edit_size('default')" type="radio" name="image_size" value="default">Default size<div id="defaultsize" style="display:inline">: <b><%:size_default_x%></b> X <b><%getValueOf:size_default_y%></b> pixels</div></td>
				</tr>
				<tr>
					<td colspan="2"><input id="size_custom_ch" onClick="javascrip:edit_size('custom')" type="radio" name="image_size" value="custom">Custom size<div id="customsize" style="display:none">: <input type="text" style="width:30px; font-weight:bold;" name="f_size_x" value="<%:size_x%>"> X <input type="text" style="width:30px; font-weight:bold;" name="f_size_y" value="<%getValueOf:size_y%>"> pixels</div></td>
				</tr>
				<script>edit_size('<%:size_default%>');</script>
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Images:</b></td>
				</tr>
				<%print_lang_bar%>
				<%include:<%iif:<%:i_type%>,show,img_edit/image_link,img_edit/image_predefined%>%>
				<tr>
					<td><img src="<%:EE_HTTP%>img/inv.gif" width="1" height="5"></td>
				</tr>
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2" align="center" height="30"><b><input type="button" value="Close window" class="button" onclick="window.parent.closePopup('yes');">&nbsp;&nbsp;<input type="submit" value="Save" name="save" class="button"></b></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form></center>
</body>
</html>
