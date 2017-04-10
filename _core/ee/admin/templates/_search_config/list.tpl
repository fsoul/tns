<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%:pageTitle%></title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=<%getValueOf:characterSet%>">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
</head>

<body>
<div id="dhtmltooltip2"></div>
<div id="whole_page_content">
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="<%:op%>">
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr>
<td><strong>Server search option</strong></td>
<tr><td><input type=checkbox value=1 name="search_enable_search_for_website" id="search_enable_search_for_website" <%iif:<%get_config_var:search_enable_search_for_website%>,1,checked%>><label for="search_enable_search_for_website">Enable search for website</label></tr>
<tr><td><input type=checkbox value=1 name="search_exclude_html_tags" id="search_exclude_html_tags" <%iif:<%get_config_var:search_exclude_html_tags%>,1,checked%>><label for="search_exclude_html_tags">Exclude HTML tags from search result</label></td>
<tr><td>
	<table cellpadding="2" cellspacing="0" style="border:1px solid #999">
	<tr  bgcolor="#eeeeee">
		<td colspan=2><b>Data type</b></td>
		<td><b>Rate per hint</b></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_page_name id=search_page_name <%iif:<%get_config_var:search_page_name%>,1,checked%>></td>
		<td><label for=search_page_name>Page name</label></td>
		<td><input type=text name=search_rate_page_name  value="<%get_config_var:search_rate_page_name%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_page_title id=search_page_title <%iif:<%get_config_var:search_page_title%>,1,checked%>></td>
		<td><label for=search_page_title>Page title</label></td>
		<td><input type=text name=search_rate_page_title  value="<%get_config_var:search_rate_page_title%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_page_keywords id=search_page_keywords <%iif:<%get_config_var:search_page_keywords%>,1,checked%>></td>
		<td><label for=search_page_keywords>Page keywords</label></td>
		<td><input type=text name=search_rate_page_keywords  value="<%get_config_var:search_rate_page_keywords%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_page_content id=search_page_content <%iif:<%get_config_var:search_page_content%>,1,checked%>></td>
		<td><label for=search_page_content>Page content</label></td>
		<td><input type=text name=search_rate_page_content  value="<%get_config_var:search_rate_page_content%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_media_library id=search_media_library <%iif:<%get_config_var:search_media_library%>,1,checked%>></td>
		<td><label for=search_media_library>Media library</label></td>
		<td><input type=text name=search_rate_media_library  value="<%get_config_var:search_rate_media_library%>"></td>
	</tr>
	</table>

<tr><td><strong>Look and feel</strong></td>
<tr><td>Select data displayed on a result page</td>
<tr><td>
	<table cellpadding="2" cellspacing="0" style="border:1px solid #999">
	<tr  bgcolor="#eeeeee">
		<td colspan=2><b>Data type</b></td>
		<td><b>Max chars</b></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_show_page_name id=search_show_page_name <%iif:<%get_config_var:search_show_page_name%>,1,checked%>></td>
		<td><label for=search_show_page_name>Page name</label></td>
		<td><input type=text name=search_max_chars_page_name  value="<%get_config_var:search_max_chars_page_name%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_show_page_url id=search_show_page_url <%iif:<%get_config_var:search_show_page_url%>,1,checked%>></td>
		<td><label for=search_show_page_url>Page Url</label></td>
		<td><input type=text name=search_max_chars_page_url  value="<%get_config_var:search_max_chars_page_url%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_show_page_keywords id=search_show_page_keywords <%iif:<%get_config_var:search_show_page_keywords%>,1,checked%>></td>
		<td><label for=search_show_page_keywords>Page keywords</label></td>
		<td><input type=text name=search_max_chars_page_keywords  value="<%get_config_var:search_max_chars_page_keywords%>"></td>
	</tr>
	<tr>
		<td><input type=checkbox value=1 name=search_show_page_content id=search_show_page_content <%iif:<%get_config_var:search_show_page_content%>,1,checked%>></td>
		<td><label for=search_show_page_content>Page content</label></td>
		<td><input type=text name=search_max_chars_page_content  value="<%get_config_var:search_max_chars_page_content%>"></td>
	</tr>
	</table>
	<tr>
		<td>Minimal characters to search <input type=text name=search_minimal_characters_to_search value="<%get_config_var:search_minimal_characters_to_search%>"></td>
	</tr>

<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
	</td>
</tr>
</table>
</form>
</div>
<script type="text/javascript">set_sizes_by_content();</script>
<%get_popup_header_script:<%getValueOf:pageTitle%>%>
</body>
</html>