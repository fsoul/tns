<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,start_trace_time%>%>
<html>
<head>
	<title><%iif:<%config_var:use_draft_content%>,1,<%:DRAFT_MODE_TITLE%>,<%str_to_title::modul_title%> List%></title>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
	<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
	<script src="<%:EE_HTTP%>js/calendar.js"></script>
<script language="JavaScript" type="text/javascript">


function selected_rows_switch(switcher_value)
{
	var checkboxobject = document.checkbox_form;
	for(i = 0;i < checkboxobject.length; i++)
	{
		if(checkboxobject.elements[i].type == 'checkbox')
		{
			checkboxobject.elements[i].checked = switcher_value;
		}
	}
}

function selected_rows_submit(operation, confirm_msg, option)
{
	var result;
	var checkboxobject = document.checkbox_form;
	var hidden_input_val = checkboxobject.op;
	var hidden_input_redir = checkboxobject.auto_redirect_add;

	for(i = 0;i < checkboxobject.length; i++)
	{
		if(checkboxobject.elements[i].type == 'checkbox')
		{
			if(checkboxobject.elements[i].checked == true)
			{
				result = true;
			}
		}
	}
	if(result == true)
	{
		if(confirm(confirm_msg))
		{
			hidden_input_val.value = operation;
			checkboxobject.submit();
		}

		if('<%:modul%>' == '_lang' && 
	   	   '<%get_config_var:confirm_add_redirect_on_language%>' == '1')
		{
			if(confirm('Add permanent redirect for all page automatically ?'))
			{
				hidden_input_redir.value = 'true';
			}
		}
		else if('<%:modul%>' == '_lang' && 
			'<%get_config_var:auto_add_redirect_on_language%>' == '1' &&
			'<%get_config_var:confirm_add_redirect_on_language%>' == '')
		{
			hidden_input_redir.value = 'true';
		}
	}
	else
	{      
		if(option == null)
		{
			alert('<%:SEL_GRID_ITEM_WARNING%>');		
		}
		else if(confirm('<%:SEL_GRID_ITEM_EXTEND_WARNING%>'))
		{
			for(i = 0;i < checkboxobject.length; i++)
			{
				if(checkboxobject.elements[i].type == 'checkbox')
				{
					checkboxobject.elements[i].checked = true;
				}
			}
			hidden_input_val.value = operation;
			checkboxobject.submit();	          			
		}	
	}
}


function openWinMetaTitle(text, object) {
	meta_text = text;
	openPopup('<%:EE_ADMIN_URL%>seo_meta_title_edit.php?admit_template=yes&meta_tag_name=' + text + '&object=' + object,400,500,true);/*Object.toString(),400,500,true);*/
}

function copy(code, name, add_url){
	frm=document.forms[0];

        if(confirm('Copy page '+name+'?')) {
                frm.action='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op=copy&copy='+code;
		if (add_url) frm.action+=('&'+add_url);
                frm.submit();
        } else return false;
}

function del(code, name, add_url) {
	var msg = '';
	var add_permant_redirect_auto = 'false';

	if('<%:modul%>' == '_lang' && 
	   '<%get_config_var:confirm_add_redirect_on_language%>' == '1')
	{
		if(confirm('Add permanent redirect for all page automatically ?'))
		{
			add_permant_redirect_auto = 'true';
		}
	}
	else if('<%:modul%>' == '_lang' && 
		'<%get_config_var:auto_add_redirect_on_language%>' == '1' &&
		'<%get_config_var:confirm_add_redirect_on_language%>' == '')
	{
		add_permant_redirect_auto = 'true';
	}
	
	if('<%:modul%>' == '_user')
	{
		var loginedUserId = <%:UserId%>;
		if(loginedUserId == code)
		{
			msg = 	'You are trying to remove yourself form a list of users. ' +
				'If you agree your information will be deleted from database, you will be logged off form a system and could not login back. ' +
				'Are you sure to continue?';
		}
	}
	if(msg == '')
	{
		msg = 'Delete <%str_to_title::modul_title%> '+name+'?';
	}
        frm=document.forms[0];

        if(confirm(msg)) {
                frm.action='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op=2&del='+code + '&auto_redirect_add=' + add_permant_redirect_auto;
		if (add_url) frm.action+=('&'+add_url);
                frm.submit();
        } else return false;
}
</script>
<%print_admin_js%>
</head>

<body>
<div id="whole_page_content">
<div id="dhtmltooltip2" onMouseOver="clearTimeout(tm1)" onMouseOut="tm1=setTimeout('hideddrivetip()',500)"></div>
<%iif:<%config_var:use_draft_content%>,1,<%iif:<%checkAdmin%>,1,<div id ="draft_div">DRAFT MODE</div>%>%>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>

<%:admin_menu%>

<%try_include:<%:modul%>/js_onChange%>
<%try_include:<%:modul%>/print_channel_info%>
<table width="100%" border="0">
	<tr>
		<td class="header" height="31" nowrap="1"><%str_to_title::modul_title%> Management</td>
		<td width="100%" align="left" style="padding-left:30px;" valign="middle">
			<%try_include:<%iif:<%config_var:use_draft_content%>,1,<%:modul%>/publish_buttons%>%>
			<%try_include:<%iif:<%config_var:ee_cache_html%>,1,<%:modul%>/delete_cache_buttons%>,<%:modul%>/cache_disabled%>
			<%try_include:<%:modul%>/list_export_excel_button%>
			<%try_include:<%:modul%>/import_export%>
			<%try_include:<%:modul%>/list_modul_config_button%>
			<%try_include:list_self_test_button%>
			<%try_include:<%:modul%>/additional_buttons_list%>
			<%try_include:<%:modul%>/list_yui_refresh_cookie_button%>
		</td>
		<td align="right" valign="middle" nowrap="1">
			<%include:<%iif:<%file_exists:<%:EE_CORE_ADMIN_PATH%>templates/<%:modul%>/list_add_button.tpl%>,,<%iif:<%file_exists:<%:EE_ADMIN_PATH%>templates/<%:modul%>/list_add_button.tpl%>,,,<%:modul%>/%>,<%:modul%>/%>list_add_button%>
		</td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
	<%print_captions%>
	<%print_filters%>
        <tr style="background-color:#000;"><td colspan="119"><%inv:1,1%></td></tr>
	<form action="#" name="checkbox_form" method = "POST">
        	<%print_list%>
		<input type = "hidden" name = "op" value = ""/>
        </form>
        <tr style="background-color:#000;"><td colspan="119"><%inv:1,1%></td></tr>
</table><br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td align="left" width="100%"><%:navigation%></td>
	<td><%inv:20,1%></td>
</tr>
<!--	</form> -->
</table>
<br>

<%include:<%iif:<%file_exists:<%:EE_PATH%><%:EE_HELP_DIR%><%:modul%>.html%>,,,help_note%>%>

</div>
<iframe style="display:none" id="iframe1" height="250" width="400" src="about:blank"></iframe>
</body>
</html>
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,end_trace_time%>%>