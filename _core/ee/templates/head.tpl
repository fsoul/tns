<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<%print_page_commentary%>

     <title><%get_page_title%></title>


<%print_page_meta_tags%>

     <meta http-equiv="Content-Language" content="<%getValueOf:language%>" />

     <meta http-equiv="Content-Type" content="text/html; charset=<%getCharset%>" />

<%iif::dns_draft_status,1,
     <meta name="content" content="draft">

%>

     <link rel="shortcut icon" href="/favicon.ico" />


     <link rel="stylesheet" href="<%:EE_HTTP%>css/style.css" type="text/css" />

     <%iif::admin_template,yes,<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />%>

<%print_admin_js:1,0%>

</head>

<body>

<%iif::dns_draft_status,1,
<div id ="draft_div">DRAFT MODE</div>
%>

<%iif:<%config_var:use_draft_content%>,1,<%iif:<%checkAdmin%>,1,<div id ="draft_div">DRAFT MODE</div>%>%>


<%print_admin_head%>
<%:admin_menu%>

<%edit_cms:html_comments_between_page_head_and_title%>

<!--p>head.tpl</p-->