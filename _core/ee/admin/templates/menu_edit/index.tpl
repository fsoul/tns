<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>CMS</title>
	<meta http-equiv="Content-Language" content="<%getValueOf:language%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
    function submit_cur(vr) {
        if (vr == 'delete') {
            this.document.current.type.value = 'delete';
            this.document.current.submit();
        } else {
            
            if (this.document.current.url.checked &&
                this.document.current.url_text.value.length < 1) {
                    alert('You must enter URL');
            }

            this.document.current.type.value = 'save';
            this.document.current.submit();
            
        }
    }

    function submit_new() {
    }

    function edit_current(vr) {
        if (vr == 'url') {
            this.document.current.url_text.disabled  = '';
            this.document.current.sat_id.disabled    = 'disabled';
            this.document.current.sat_page.checked = '';
            this.document.current.url.checked = 'checked';
        } else {
            this.document.current.url_text.disabled  = 'disabled';
            this.document.current.sat_id.disabled    = '';
            this.document.current.sat_page.checked = 'checked';
            this.document.current.url.checked = '';
        }
    }

    function add_new (vr) {
        if (vr == 'url') {
            this.document.dnew.url_text.disabled  = '';
            this.document.dnew.sat_id.disabled    = 'disabled';
            this.document.dnew.sat_page.checked = '';
            this.document.dnew.url.checked = 'checked';
        } else {
            this.document.dnew.url_text.disabled  = 'disabled';
            this.document.dnew.sat_id.disabled    = '';
            this.document.dnew.sat_page.checked = 'checked';
            this.document.dnew.url.checked = '';
        }
    }

</script>
</head>

<body bottommargin="0" leftmargin="0" marginheight="10" marginwidth="2" rightmargin="0" topmargin="0" onLoad="javascript:edit_current('url');add_new('url');">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
    <tr>
        <td width="25%" valign="top">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><a href="" class="link">Root</a>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:10px;"><a href="" class="link">index</a>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:20px;"><a href="" class="link">index/index</a>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:10px;"><a href="" class="link">index2</a>
                    </td>
                </tr>
            </table>
        </td>
        <td style="background:black;" width="1">
        </td>
        <td valign="top">
            <form name="current" action="" method="POST"><br>
                <input type="hidden" name="type" value="">
                <input type="hidden" name="menu_var" value="">
                <table align="center" width="98%" cellpadding="0" cellspacing="0" border="0"class="tableborder">
                    <tr>
                        <td colspan="2" height="30" valign="top"><u>Current menu item (index)</u>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">Menu name(EN)
                        </td>
                        <td><input type="text" name="" value="" size=30>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">Menu name(FR)
                        </td>
                        <td><input type="text" name="" value="" size=30>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">Menu name(DE)
                        </td>
                        <td><input type="text" name="" value="" size=30>
                        </td>
                    </tr>
                    <tr>
                        <td width="200" valign="top">Menu link
                        </td>
                        <td>
                            <div>
                                <input type="radio" name="url" onClick="javascript:edit_current('url')"><label for="url">URL</label>                                
                                &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="url_text" size="50">
                            </div>
                            <div>
                                <input type="radio" name="sat_page" onClick="javascrip:edit_current('sat_page')"><label for="sat_page"><%cons:SATELLITE_PAGE%></label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <select name="sat_id" style="width:150">
                                    <option value="">Asyst</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">After
                        </td>
                        <td>
                                <select name="sat_id" style="width:150">
                                    <option value="">Top</option>
                                </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" height="30" valign="bottom">
                            <input type="button" accessKey="<%CONSTANT:BUT_ACCESS_KEY_SAVE%>" value="<%CONSTANT:BUT_LABEL_SAVE%>"  class="button" onClick="submit_cur('save')">
                            <input type="button" accessKey="<%CONSTANT:BUT_ACCESS_KEY_DELETE%>" value="<%CONSTANT:BUT_LABEL_DELETE%>" value="Delete" class="button" onClick="submit_cur('delete')">
                           <%include:buttons/btn_reset%>&nbsp;
                        </td>
                    </tr>
                </table>
            </form>
            
            <form name="dnew" action="" method="POST"><br>
                <table align="center" width="98%" cellpadding="0" cellspacing="0" border="0"class="tableborder">
                    <tr>
                        <td colspan="2" height="30" valign="top"><u>New menu item (index)</u>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">Menu name(EN)
                        </td>
                        <td><input type="text" name="" value="" size=30>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">Menu name(FR)
                        </td>
                        <td><input type="text" name="" value="" size=30>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">Menu name(DE)
                        </td>
                        <td><input type="text" name="" value="" size=30>
                        </td>
                    </tr>
                    <tr>
                        <td width="200" valign="top">Menu link
                        </td>
                        <td>
                            <div>
                                <input type="radio" name="url" onClick="javascript:add_new('url')"><label for="url">URL</label>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="url_text" size="50">
                            </div>
                            <div>
                                <input type="radio" name="sat_page" onClick="javascript:add_new('sat_page')"><label for="sat_page"><%cons:SATELLITE_PAGE%></label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <select name="sat_id" style="width:150">
                                    <option value="">Asyst</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="200">After
                        </td>
                        <td>
                                <select name="sat_id" style="width:150">
                                    <option value="">Top</option>
                                </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" height="30" valign="bottom">
                            <input type="button" value="Save" class="button">
                            <input type="reset" value="Reset" class="button">
                        </td>
                    </tr>
                </table>
            </form><br>
        </td>
    </tr>
</table>
</body>
</html>
