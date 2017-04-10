<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title><%checkValueOf:type,edit,Edit,Add%> menu item</title>
    <link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript">
    function submit_cur(vr) {
        if (vr == 'delete') {
            this.document.current.type.value = 'delete';
            this.document.current.submit();
        } else {

            if (this.document.current.m_type[0].selected == true)
	    {
		if (this.document.current.url.checked && this.document.current.url_text.value.length < 1)
 		{
                    alert('<%:MENU_URL_EMPTY_ALERT_TEXT%>');
                    this.document.current.url_text.focus();
        	    return false;

		}
		else if(this.document.current.sat_page.checked && this.document.getElementById("sattelite_page_path").childNodes.length == 0)
		{
                    alert('<%:MENU_SAT_EMPTY_ALERT_TEXT%>');
                    this.document.getElementById("sattelite_page_path").focus();		
        	    return false;
		}

            }

            this.document.current.submit();
            
        }
    }

    function edit_current(vr) {
        if (vr == 'url') {
            this.document.current.url_text.disabled  = '';
			this.document.current.select_button.disabled    = 'disabled';
            this.document.current.sat_page.checked = '';
            this.document.current.url.checked = 'checked';
        } else {
            this.document.current.url_text.disabled  = 'disabled';
			this.document.current.select_button.disabled    = '';
            this.document.current.sat_page.checked = 'checked';
            this.document.current.url.checked = '';
        }
    }

    function separator_or() {
			elem = document.getElementById('main');
    	if (this.document.current.m_type[0].selected == true)
				elem.style.display = "block";
    	else
				elem.style.display = "none";
    }
</script>

<%print_admin_js:0%>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="2" rightmargin="0" topmargin="0" onLoad="<%getValueOf:load%>">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="10" class="tableborder" bordercolor="green" border="0">

    <form name="current" method="POST" enctype="multipart/form-data">

    <input type="hidden" name="nextlang" value="" />
    <input type="hidden" name="lang" value="<%getValueOf:lang%>" />
    <input type="hidden" name="nexttype" value="" />

    <tr>
        <td valign="top">
                <table width="100%" align="center" cellpadding="1" cellspacing="1" bordercolor="red" border="0">
		    <tr bgcolor="#eeeeee" class="table_header">
			<td align="center" height="30" colspan="10">Choose language:&nbsp;<%print_avail_languages%>
		    </tr>
                    <tr><td height="5"></td></tr>
                    <tr>
                        <td width="100">Menu type</td>
                        <td>
                        	<select name="m_type" size="1" onchange="separator_or();">
                        		<option value="" <%iif:<%:m_type%>,,selected%>>Menu item</option>
                        		<option value="separator" <%iif:<%:m_type%>,separator,selected%>>Separator</option>
                        	</select>
                        </td>
                    </tr>
                </table>
                <table id="main" width="100%" align="center" cellpadding="1" cellspacing="1" bordercolor="yellow" border="0">
                    <tr>
                        <td width="100">Menu code</td>
                        <td colspan="10">
				<input type="text" name="menu_code" value="<%:menu_code%>" style="width:200"  /> (<%cons:the same for all languages%>)
			</td>
                    </tr>
                    <tr>
                        <td width="100">Menu label</td>
                        <td colspan="10">
				<input type="text" name="menu_name" value="<%getValueOf:menu_label%>" style="width:360" />&nbsp;(<%getValueOf:lang%>)
                        </td>
                    </tr>
		    <tr>
			<td width="100">Menu title</td>
			<td colspan="10">
				<input type="text" name="menu_title" value="<%getValueOf:menu_title%>" style="width:360" />&nbsp;(<%getValueOf:lang%>)
			</td>
		    </tr>
                    <tr>
                        <td width="100" valign="top" colspan="20" bgcolor="#ebebeb">Menu image</td>
		    </tr>

<%setValueOf:im_type,inactive%>
<%include:<%:modul%>/menu_<%iif:<%cms:menu_<%get:menu_id%>_picture_inactive_<%:item_id%>,,<%getValueOf:lang%>%>,,upload_field,show%>%>

<%setValueOf:im_type,active%>
<%include:<%:modul%>/menu_<%iif:<%cms:menu_<%get:menu_id%>_picture_active_<%:item_id%>,,<%getValueOf:lang%>%>,,upload_field,show%>%>

                    <tr><td height="5" colspan="10"></td></tr>
                    <tr>
                        <td width="100" valign="top" colspan="20" bgcolor="#ebebeb">
				Menu link
                        </td>
		    </tr>
		    <tr>
                        <td aligh="right">
                                <input type="radio" name="url" onClick="javascript:edit_current('url')"><label for="url">URL</label>
                        </td>
			<td colspan="10">
				<input type="text" name="url_text" value="<%getValueOf:url_text%>" style="width:360px;">&nbsp;(<%getValueOf:lang%>)
			</td>
		    </tr>
		    <tr>
		        <td>
                                <input type="radio" name="sat_page" onClick="javascrip:edit_current('sat_page')"><label for="sat_page"><%:SATELLITE_PAGE%></label>
                        </td>
			<td colspan="10">
							<table border="0" cellpadding="0" cellspacing="0" width="400">
							<tr>
								<td width="100%">
								<div id="sattelite_page_path" style="overflow: hidden;"><%iif:<%:sattelite_page_id%>,,,<%getField:SELECT CONCAT_WS('/'\,IF(`folder` = '/'\, ''\, `folder`)\,`page_name`) AS page_name FROM v_tpl_page_grid WHERE id=<%sqlValue:<%:sattelite_page_id%>%> AND language=<%sqlValue:<%:language%>%> LIMIT 0\,1%>%></div>
								</td>
								<td align="right">
								<input type="hidden" name="satelit" id="satelit" value="<%:sattelite_page_id%>">
								<span style="white-space: nowrap;">&nbsp;<input type="button" name="select_button" onclick="selectSattelitePage();" value="<%:SELECT_BUTTON%>"></span>
								</td>
							</tr>
							</table>
                        </td>
                    </tr>
                    <tr>
                        <td width="100">
				Open type
                        </td>
                        <td colspan="10">
                                <select name="open_type" style="width:400">
                                    <option value="self" <%getValueOf:open_same%>>Same window</option>
                                    <option value="_blank" <%getValueOf:open_new%>>New window</option>
                                </select>
                        </td>
                    </tr>

<%include:<%iif:<%:EE_LINK_XITI_ENABLE%>,1,xiti_form_attributes_rows%>%>

                </table>


                <table width="100%" cellpadding="1" cellspacing="1" bordercolor="blue" border="0">
                    <tr>
                        <td width="100" valign="top" colspan="20" bgcolor="#ebebeb">&nbsp;</td>
		    </tr>
                    <tr>
                        <td width="100">Order</td>
                        <td>
                                <input type="text" name="order" value="<%getValueOf:order%>" size="4">
                        </td>

                        <td width="100">Visibility level</td>
                        <td>
                                <select name="shadow">
					<option value="-1">...</option>
					<option <%iif::shadow,:VISIBLE_FOR_ALL,selected%> value="<%:VISIBLE_FOR_ALL%>"><%cons:For all%></option>
					<option <%iif::shadow,:VISIBLE_FOR_NOT_AUTHORIZED,selected%> value="<%:VISIBLE_FOR_NOT_AUTHORIZED%>"><%cons:For not authorized%></option>
					<option <%iif::shadow,:VISIBLE_FOR_AUTHORIZED,selected%> value="<%:VISIBLE_FOR_AUTHORIZED%>"><%cons:For authorized%></option>
					<option <%iif::shadow,:VISIBLE_FOR_BACKOFFICE,selected%> value="<%:VISIBLE_FOR_BACKOFFICE%>"><%cons:For Back-office%></option>
                                </select>
				<img align="bottom" src="<%:EE_HTTP%>img/help.gif" alt="Display this menu item only to selected visitors type" title="Display this menu item only to selected visitors type">
                        </td>
                    </tr>
		    <tr>
                        <td height="30" valign="bottom">
                            <input type="button" value="Close" accessKey="C" class="button" onClick="window.parent.closePopup();">
                        </td>
                        <td height="30" valign="bottom">
                            <input type="button" name="save" value="Save"  accessKey="S" class="button" onClick="submit_cur('save')">
                        </td>
			
                    </tr>
                </table>
        </td>
    </tr>
</form>
</table>
<script>separator_or();</script>
</body>
</html>