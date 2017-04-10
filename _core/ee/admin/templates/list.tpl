<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,start_trace_time%>%>
<html>
<head>
	<title><%iif:<%config_var:use_draft_content%>,1,<%:DRAFT_MODE_TITLE%>,<%str_to_title::modul_title%> List%></title>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>css/yui_grids_style.css" />
	<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
	<script src="<%:EE_HTTP%>js/calendar.js"></script>
	<%include:<%:modul%>/yui/list_yui_head_scripts%>
	<%include:<%:modul%>/yui/list_yui_script%>

	<script language="JavaScript" type="text/javascript">

		document.getElementsByClassName = function(cl) {
			var retnode = [];
			var myclass = new RegExp('\\b'+cl+'\\b');
			var elem = this.getElementsByTagName('*');
			for (var i = 0; i < elem.length; i++) {
				var classes = elem[i].className;
				if (myclass.test(classes)) retnode.push(elem[i]);
			}
			return retnode;
		}; 

		function openWinMetaTitle(text, object) 
		{
			meta_text = text;
			openPopup('<%:EE_ADMIN_URL%>seo_meta_title_edit.php?admit_template=yes&meta_tag_name=' + text + '&object=' + object,400,500,true);/*Object.toString(),400,500,true);*/
		}
		function copy(code, name, add_url)
		{
			frm=document.forms[0];
			if(confirm('Copy page '+name+'?')) 
			{
				frm.action='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op=copy&copy='+code;
				if (add_url)
				{
					frm.action+=('&'+add_url);
				}
				frm.submit();
			} 
			else
			{
				return false;
			}
		}
	</script>

	<style type="text/css">
		.seoInDraft,
		textarea.seoEdit {
			border: 1px solid #FFCC00;
			background: #FFFFCC;
		}

		textarea.seoEdit {
			margin: 0;
		}
		
		.iSEOError,
                a.seoError {
			color: #CC0000;
			text-decoration: none;
		}		
		
		a.seoError {
                	font-weigth: bold;
			font-size: 14px;
		}
		
		.iSEOError {
			background-color: #FFCCCC;
                	border: 1px solid #CC0000;
			vertical-align: middle;
		}
		
		#draft_mode_buttons {
			float: right;
                	font-size: 11px;
			border: 1px solid #FFCC00;
			background: #FFFFCC;
			padding: 0 5px 0 5px;
		}
	</style>
                	
<%print_admin_js%>
</head>

<body class="yui-skin-sam">
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
					<%include:yui/list_yui_refresh_table_button%>
				</td>
				<td align="right" valign="middle" nowrap="1">
				<%include:<%iif:<%file_exists:<%:EE_CORE_ADMIN_PATH%>templates/<%:modul%>/list_add_button.tpl%>,,<%iif:<%file_exists:<%:EE_ADMIN_PATH%>templates/<%:modul%>/list_add_button.tpl%>,,,<%:modul%>/%>,<%:modul%>/%>list_add_button%>
				</td>
			</tr>
		</table>
		<form id="checkbox_form" action="" name="checkbox_form" method = "POST">
			<div id="dynamicdata"></div>
			<input type = "hidden" name = "op" value = ""/>
		</form>
		<div id="yui-dt0-paginator" class="yui-dt-paginator yui-pg-container" style=""></div>

<%include:<%iif:<%file_exists:<%:EE_PATH%><%:EE_HELP_DIR%><%:modul%>.html%>,,,help_note%>%>
	</div>
	<iframe style="display:none" id="iframe1" height="250" width="400" src="about:blank"></iframe>
</body>
</html>
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,end_trace_time%>%>