<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title><%:pageTitle%></title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js:0%>
    <script type="text/javascript">

	function al_check_link_type(link_type)
	{
		if (link_type == 'url')
		{
			edit_current('open_url');			
		}
		else if(link_type == 'sat_page')
		{
			edit_current('open_sat_page');			
		}
		else
		{
			edit_current('open_none');
		}
	}

	function al_check(checkbox)
	{
		var al_maincontainer = document.getElementById('al_maincontainer');
		if (checkbox.checked)
		{
			al_maincontainer.style.display = 'block';
		}
		else
		{
			al_maincontainer.style.display = 'none';
		}
	}

	function edit_current(vr)
	{
		al_check(this.document.fs.absent_browser_language_autoforwarding);

        	if (vr == 'open_url')
		{
	     		this.document.fs.f_url_text.disabled  = '';
					this.document.fs.select_button.disabled = 'disabled';
            		this.document.fs.open_sat_page.checked = '';
            		this.document.fs.open_url.checked = 'checked';
            		this.document.fs.open_none.checked = '';
        	}
		else if (vr == 'open_sat_page')
		{
            		this.document.fs.f_url_text.disabled  = 'disabled';
					this.document.fs.f_url_text.value = '';
					this.document.fs.select_button.disabled = '';
            		this.document.fs.open_sat_page.checked = 'checked';
            		this.document.fs.open_url.checked = '';
            		this.document.fs.open_none.checked = '';
        	}
		else
		{
            		this.document.fs.open_none.checked = 'checked';
            		this.document.fs.f_url_text.disabled  = 'disabled';
					this.document.fs.f_url_text.value = '';
					this.document.fs.select_button.disabled = 'disabled';
            		this.document.fs.open_sat_page.checked = '';
            		this.document.fs.open_url.checked = '';
        	}
    	}


    </script>
</head>

<body>
<div id="dhtmltooltip2"></div>
<div id="whole_page_content">
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="<%:op%>">

<tr <%tr_bgcolor%>>
	<td><%inv:400,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>

<%row%
<tr <%tr_bgcolor%>>

	<td height="30" class="table_data">&nbsp;&nbsp;<%:field_title%>
	</td>
	<td><%try_include:<%:modul%>/edit_fields_<%:type%>,edit_fields_<%:type%>%></td>
	<td class="error">&nbsp;</td>
</tr>

<%iif:<%:field_name%>,absent_browser_language_autoforwarding,
<tr bgcolor="#ededfd">
	<td>
		<div id="al_maincontainer" style="display:none">
			<div>&nbsp;&nbsp;&nbsp;&nbsp;<b>Please\, select target link:</b></div>
			<div style="padding-left:20px">
				<table width="100%">
					<tr>
						<td aligh="right" valign="middle" style="height: 21px;">
							<input type="radio" name="open_none" onClick="javascript:edit_current('open_none')"><label for="open_none">None</label>
						</td><td></td>
					</tr>
					<tr>
						<td aligh="right" valign="middle" style="height: 21px;">
							<input type="radio" name="open_url" onClick="javascript:edit_current('open_url')"><label for="open_url">URL</label>
						</td><td>
							<input type="text" name="f_url_text" value="<%iif:<%:url_syntax_error%>,,<%:af_lang_link%>,<%:f_url_text%>%>" style="width:272" size="50">
							<%iif::url_syntax_error,,,<br/><span class="error"><%:URL_SYNTAX_WARNING%></span>%>
						</td>
					</tr>
					<tr>
						<td valign="middle" style="height: 21px;">
							<input type="radio" name="open_sat_page" onClick="javascrip:edit_current('open_sat_page')"><label for="open_sat_page"><%:SATELLITE_PAGE%></label>
						</td><td>
							<%get_satelite_list:272,<%:af_lang_link%>%>
							<script type="text/javascript">al_check_link_type('<%:af_lang_link_type%>');</script>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</td>
	<td></td>
	<td></td>
</tr>
	
%>		

%row%>

	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
	</td>
</tr>
</form>
</table>
</div>
<script type="text/javascript">set_sizes_by_content();</script>
</body>
</html>