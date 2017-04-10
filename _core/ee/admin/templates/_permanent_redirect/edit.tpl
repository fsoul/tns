<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
	<script src="<%:EE_HTTP%>js/calendar.js"></script>
	<script src="<%:EE_HTTP%>js/ajax-son.js"></script>

<script type="text/javascript">

	var pr_target_url_mode = 'target_url';
	var errors = 1;
	var i_edit = "<%:edit%>";

	function edit_current(vr)
	{
		if (vr == 'open_url')
		{
	        this.document.fs.url.disabled = '';
			this.document.fs.select_button.disabled = 'disabled';
	        this.document.fs.open_sat_page.checked = '';
	        this.document.fs.open_url.checked = 'checked';
			this.document.fs.lang_code.disabled	= 'disabled';
			this.document.fs.tpl_view.disabled = 'disabled';
			pr_target_url_mode = 'url';
			//document.getElementById('target_url').innerHTML = '';
	        }
		else if (vr == 'open_sat_page')
		{
			this.document.fs.url.disabled = 'disabled';
			this.document.fs.select_button.disabled = '';
	        this.document.fs.open_sat_page.checked = 'checked';
	        this.document.fs.open_url.checked = '';
			pr_target_url_mode = 'target_url';
			//
			this.document.fs.lang_code.disabled	= '';
			this.document.fs.tpl_view.disabled = '';		
			document.getElementById('target_url_error').innerHTML = '';
			this.document.fs.url.value = '';
			errors = 0;			
	        }
		else
		{
	        this.document.fs.url.disabled = 'disabled';
			this.document.fs.select_button.disabled = 'disabled';
	        this.document.fs.open_sat_page.checked = '';
	        this.document.fs.open_url.checked = '';
	    }
	}

	<%include:permanent_redir%>

	function check_target_url()
	{
		if(pr_target_url_mode == 'url')
		{
		var obj = new ajax_son("_permanent_redirect.php");

		var target_url_error = document.getElementById('target_url_error');

		obj.onComplete = function()
		{
			if(obj.response == -1)
			{
				target_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Target URL could not be empty!';
				errors = 1;
			}
			else if(obj.response == -2)
			{
				target_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Target URL could be applied for existed page!';
				errors = 1;
			}
			else if(obj.response)
			{
				target_url_error.innerHTML = '';
				errors = 0;
			}
			//alert(obj.response);
		}
		obj.run("op=check_target_url&target_url=" + document.getElementById('url').value);
		}
		                                           
	}

	function submit_form()
	{
		//
		var url = document.getElementById('url').value;
		var source_url = document.getElementById('source_url').value;
		var target_url_error = document.getElementById('target_url_error');
		var source_url_errors = document.getElementById('source_url_errors').innerHTML;

		if(url == source_url)
		{
			target_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Target URL could not match with Source URL!';
			errors = 1;
		}
		if(url == '' && document.fs.open_url.checked)
		{
			target_url_error.innerHTML = '<img src="<%:EE_HTTP%>img/warning.gif" align="left" /> Target URL can not be empty!';
			errors = 1;
		}
		if(source_url_errors != '')
		{			
			errors = 1;
		}
		if(errors == 0)
		{		
			document.fs.submit();
		}
	}
       		
</script>

</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="" method="post" onsubmit="setTimeout('submit_form()',1000); return false;">
<input type="hidden" name="refresh" value="true">
<input type="hidden" id="save_add_more" name="save_add_more" value="" />

<tr <%tr_bgcolor%> >
	<td><%inv:200,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>

<%print_fields%>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
		<%include_if:modul,_mail_inbox,,buttons/btn_save%>&nbsp;
		<%include_if:op,3,<%:modul%>/btn_save_add_more%>&nbsp;
	</td>
</tr>
<%include_if:modul,_mail_inbox,,edit_mandatory_message%>
</form>
</table>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>