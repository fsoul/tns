<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul_title%> List</title>
        <META http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
<script language="JavaScript" type="text/javascript">

function selected_rows_submit(operation, confirm_msg, option)
{
	var result;
	var checkboxobject = document.checkbox_form;
	var hidden_input_val = checkboxobject.op;
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


function openWinMetaTitle(text) {
	meta_text = text;
	openPopup('<%:EE_ADMIN_URL%>seo_meta_title_edit.php?admit_template=yes&meta_tag_name='+text,400,500,true);
}

function del(code, name, add_url) {
        frm=document.forms[0];

        if(confirm('Delete <%str_to_title::modul_title%> '+name+'?')) {
                frm.action='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op=2&del='+code;
		if (add_url) frm.action+=('&'+add_url);
                frm.submit();
        } else return false;
}
</script>
<%print_admin_js%>
</head>

<body>
<div id="whole_page_content">
<div id="dhtmltooltip2" onMouseOver="clearTimeout(tm1)" onmouseout="tm1=setTimeout('hideddrivetip()',500)"></div>
<script language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></script>

<%:admin_menu%>

<%try_include:<%:modul%>/js_onChange%>
<%try_include:<%:modul%>/print_channel_info%>

<div style="padding:10px;">
	<span class="header"><%str_to_title::modul_title%></span>

	<form action="" method="post">
	<br/>
	Please, enter the URL to sitemap in XML format:
	<input type="text" name="input_url" value="<%iif:<%post:input_url%>,,<%:EE_HTTP%>sitemap.xml,<%post:input_url%>%>" size="80" />
	<input type="submit" value="Check" />             
	</form>
	<br/>
	<%HV_run_test%>
	<%getError:validator%>
</div>

<%include:<%iif:<%file_exists:<%:EE_PATH%><%:EE_HELP_DIR%><%:modul%>.html%>,,,help_note%>%>

</div>
<iframe style="display:none" id="iframe1" height="250" width="400" src="about:blank"></iframe>
</body>
</html>
