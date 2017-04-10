<html>
<style type="text/css">

body {
	background-color: #FFFFFF;
	color:#000000;
	font-family:verdana, arial, helvetica, sans serif;
}
</style>
<%iif::admin_template,yes,<link rel="stylesheet" href="<%:EE_HTTP%>css/common.css" type="text/css"/>%>
<%iif::admin_template,yes,<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"/>%>
<%print_admin_js%>
<body>
<%print_admin_head%>
<%:admin_menu%>
<%include_if:admin_template,yes,nl_notification_edit%>
<%page_cms_e:page_content%>
</body>
</html>