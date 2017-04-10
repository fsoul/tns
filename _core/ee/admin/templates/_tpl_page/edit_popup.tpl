<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
<script src="<%:EE_HTTP%>js/users.js"></script>
<script src="<%:EE_HTTP%>js/ajax-son.js"></script>

<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/assets/skins/sam/container.css" />

<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/container-min.js"></script>

</head>

<body class="yui-skin-sam">

<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post" onsubmit="">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="auto_redirect_add" value="true" />
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr><td colspan="3">
<br />

<%print_popup_header:%>

</td></tr>

<%print_fields_by_group:%>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include_if:modul,_mail_inbox,,buttons/btn_save%>&nbsp;
		<%include_if:op,3,buttons/btn_save_add_more%>
<%print_next_previous_buttons%>
	</td>
</tr>
<%include_if:modul,_mail_inbox,,edit_mandatory_message%>
</table>
</form>

<script type="text/javascript">

	var page_renamed = false;

	function permanentRedirectHandler()
	{
		if(page_renamed &&
		   '<%get_config_var:confirm_add_redirect_on_page%>' == '1')
		{
			if(!confirm('Add permanent redirect for this page automatically ?'))
			{
				document.fs.auto_redirect_add.value = 'false';
			}
		}
	}

	if (typeof document.fs.save != 'undefined') {
		document.fs.save.onclick = permanentRedirectHandler;
	}

	if (typeof document.fs.previous != 'undefined') {
		document.fs.previous.onclick = permanentRedirectHandler;
	}

	if (typeof document.fs.next != 'undefined') {
		document.fs.next.onclick = permanentRedirectHandler;
	}

</script>

<script type="text/javascript" language="JavaScript">
	var i_edit = '<%:edit%>';
	var redir_win_body;

	YAHOO.namespace("example.container");

	function init()
	{
		// Instantiate a Panel from script
		YAHOO.example.container.panel2 = new YAHOO.widget.Panel("panel2", { width:"520px", visible:false, draggable:true, close:true } );
		YAHOO.example.container.panel2.setHeader("Panel #2 from Script &mdash; This Panel Isn't Draggable");
		YAHOO.example.container.panel2.setBody("This is a dynamically generated Panel.");
		YAHOO.example.container.panel2.render("container");
	}

	YAHOO.util.Event.addListener(window, "load", init);

	function add_redirect()
	{		
		opt = 'add';

		redir_win_body = '<table width="100%" cellpadding="5" cellspacing="0" border="0">' +
					'<tr><td width="100px">Source URL: </td><td><input id="source_url" type="text" value="" onblur="check_source_url();" /></td></tr>' +
					'<tr><td></td><td><span id="source_url_errors" class="error"></span></td><tr>' + 
					'<tr><td>Target URL: </td><td><span id="target_url"></span>&nbsp;<a id="target_url_link" href="#" target="_blank"><img src="<%:EE_HTTP%>img/published_page.gif" border="0" title="View page" /></a></td></tr>' +
					'<tr><td>Language: </td><td><%include:<%:modul%>/edit_fields_select_lang_code%></td></tr>' +
					'<tr><td>View: </td><td><%include:<%:modul%>/edit_fields_select_tpl_view%></td></tr>' +
					'<tr><td><input id="satelite" type="hidden" value="' + i_edit + '"  /></td></tr>' +
					'<tr><td colspan="2" align="left"><input id="cancel" type="button" class="button" value="Cancel" />&nbsp;<input id="save" type="button" class="button" value="Save" onclick="save_redirect();" />&nbsp;<input type="button" class="button" value="Save adn Add more" onclick="save_redirect(); clear_popup_win();" /><td></tr>' +
				'</table>';

		YAHOO.example.container.panel2.setBody(redir_win_body);
		YAHOO.example.container.panel2.setHeader("Add redirect");

		YAHOO.util.Event.addListener("cancel", "click", YAHOO.example.container.panel2.hide, YAHOO.example.container.panel2, true);
		YAHOO.util.Event.addListener("save", "click", YAHOO.example.container.panel2.hide, YAHOO.example.container.panel2, true);
		YAHOO.example.container.panel2.cfg.setProperty("visible", true);
		// save and add more

		change_target_url('target_url');
	}

	function edit_redirect(redirect_id)
	{
		opt = 'edit';
		var ajax = new ajax_son("_tpl_page.php");

		var response_obj;
		

		ajax.onComplete = function()
		{
			eval("response_obj =" + ajax.response);
			
			redir_win_body = '<table width="100%" cellpadding="5" cellspacing="0" border="0">' +
						'<tr><td width="100px">Source URL: </td><td><input id="source_url" type="text" value="' + response_obj.source_url + '" onblur="check_source_url();" /></td></tr>' +
						'<tr><td></td><td><span id="source_url_errors" class="error"></span></td><tr>' + 
						'<tr><td>Target URL: </td><td><span id="target_url">' + response_obj.target_url + '</span>&nbsp;<a id="target_url_link" href="' + response_obj.target_url + '" target="_blank"><img src="<%:EE_HTTP%>img/published_page.gif" border="0" title="View page" /></a></td></tr>' +
						'<tr><td>Language: </td><td><%include:<%:modul%>/edit_fields_select_lang_code%></td></tr>' +
						'<tr><td>View: </td><td><%include:<%:modul%>/edit_fields_select_tpl_view%></td></tr>' +
						'<tr><td><input id="satelite" type="hidden" value="' + response_obj.page_id + '"  /><input type="hidden" id="redirect_id" value="' + redirect_id + '" /></td></tr>' +
						'<tr><td colspan="2" align="left"><input id="cancel" type="button" class="button" value="Cancel" />&nbsp;<input id="save" type="button" class="button" value="Save" onclick="save_redirect();" /><td></tr>' +
					'</table>';

			YAHOO.example.container.panel2.setBody(redir_win_body);
			YAHOO.example.container.panel2.setHeader("Edit redirect");
                        YAHOO.util.Event.addListener("cancel", "click", YAHOO.example.container.panel2.hide, YAHOO.example.container.panel2, true);
			YAHOO.util.Event.addListener("save", "click", YAHOO.example.container.panel2.hide, YAHOO.example.container.panel2, true);			

			document.getElementById('tpl_view').value = response_obj.t_view;
			document.getElementById('lang_code').value = response_obj.lang_code;

			YAHOO.example.container.panel2.cfg.setProperty("visible", true);
		}

		ajax.run("op=get_edit_redirect_data&redirect_id=" + redirect_id);
	}

	function delete_redirect(redirect_id)
	{
		var ajax = new ajax_son("_tpl_page.php");

		ajax.onComplete = function()
		{
			load_redirect_list();
		}
		
		ajax.run("op=delete_redirect&item=" + redirect_id);

	}

	function delete_selected_items()
	{
		var checkboxobject = document.fs;

		var idArray = new Array();
		for(i = 0;i < checkboxobject.length; i++)
		{
			if(checkboxobject.elements[i].type == 'checkbox')
			{
				if(checkboxobject.elements[i].checked == true && checkboxobject.elements[i].value != 1)
				{
					idArray.push(checkboxobject.elements[i].value);
				}
			}
		}
		var selected_items = idArray.join(";");

                var ajax = new ajax_son("_tpl_page.php");

		ajax.onComplete = function()
		{
			load_redirect_list();
		}
		
		ajax.run("op=delete_selected_items&items=" + selected_items);
	}

	function save_redirect()
	{
		var error = false;
		check_source_url();		
		var source_url 	= $$("source_url");
		var target_url 	= $$("target_url");
		if(opt == 'edit')
		{
			var op = 'upd_redirect';
			var redirect_id = $$("redirect_id");
		}
		else if(opt == 'add')
		{
			var op = 'add_redirect';
			var redirect_id = '';
		}
		if(typeof target_url == 'undefined')
		{
			target_url = '';
		}
		var page_id 	= $$("satelite");
		var lang_code 	= $$("lang_code");
		var view 	= $$("tpl_view");

		var ajax = new ajax_son("_tpl_page.php");
		ajax.onComplete = function()
		{

			load_redirect_list();
		}

		if(!error)
		{
			ajax.run("op=" 		+ op +
				"&id=" 		+ redirect_id  + 
				"&source_url=" 	+ source_url + 
				"&target_url=" 	+ target_url + 
				"&page_id=" 	+ page_id +
				"&lang_code=" 	+ lang_code +
				"&view=" 	+ view);
		}
	}

	function $(id)
	{
		return this.document.getElementById(id);
	}

	function $$(id)
	{
		return $(id).value;
	}

	function load_redirect_list()
	{
		var ajax = new ajax_son("_tpl_page.php");
		ajax.onComplete = function()
		{
			var html = '<table width="100%" border="0"><tr align="center"><th width="10px"><input type="checkbox" onclick="selected_rows_switch(this.checked);" /></th><th>Source URL:</th><th>Target URL:</th><th width="40px"><a id="add_redirect" href="#"><img src="<%:EE_HTTP%>img/edit/doc_add.gif" border="0" title="Add redirect link" onclick="add_redirect(); return false;" /></a></th></tr>' + ajax.response + '</table>';
			redirect_list = $("redirect_list");
			redirect_list.innerHTML = html;
			YAHOO.util.Event.addListener("add_redirect", "click", YAHOO.example.container.panel2.show, YAHOO.example.container.panel2, true);
		}

		ajax.run("op=get_redirect_list&edit=" + i_edit);		
	}

	function selected_rows_switch(switcher_value)
	{
		var checkboxobject = document.fs;
		for(i = 0;i < checkboxobject.length; i++)
		{
			if(checkboxobject.elements[i].type == 'checkbox')
			{
				if(checkboxobject.elements[i].value != 1)
				{
					checkboxobject.elements[i].checked = switcher_value;
				}
			}
		}
	}

	function clear_popup_win()
	{
		add_redirect();
	}

	function check_cachable_page(tpl_id)
	{
		var ajax = new ajax_son("_tpl_page.php");

		ajax.onComplete = function()
		{
			if (ajax.response == '1')
			{
				document.fs.cachable.disabled = '';
				document.fs.cachable.checked = 'checked';
			}
			else
			{
				document.fs.cachable.disabled = 'disabled';
				document.fs.cachable.checked = '';
			}
		}

		ajax.run("op=is_tpl_cachable&tpl_id=" + tpl_id);
	}

	function publishPageHandler(el)
	{
		if (el.checked == true)
		{
			document.fs.page_locked.disabled = false;
		}
		else
		{
			document.fs.page_locked.disabled = 'disabled';
			document.fs.page_locked.checked = true;
		}
	}

	<%include:permanent_redir%>

</script>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>