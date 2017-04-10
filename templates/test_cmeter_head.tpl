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

     <link rel="shortcut icon" href="<%:EE_HTTP%>favicon.ico" type="image/x-icon" />

     <link href="<%:EE_HTTP%>css/style.css" rel="stylesheet" type="text/css" />


     <!--[if IE]>  <link href="<%:EE_HTTP%>css/ie.css"  rel="stylesheet" type="text/css" /><![endif]-->
     <!--[if IE 6]><link href="<%:EE_HTTP%>css/ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
     <!--[if IE 7]><link href="<%:EE_HTTP%>css/ie7.css" rel="stylesheet" type="text/css" /><![endif]-->

     <!--[if IE 6]>
          <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/DD_belatedPNG.js"></script>
          <script type="text/javascript" language="JavaScript">
              DD_belatedPNG.fix('.transparent');
          </script>
     <![endif]-->


     <%iif::admin_template,yes,<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />%>

<%print_admin_js:1,0%>

<script type="text/javascript" language="JavaScript">

function getXmlHttp(){
  var xmlhttp;
  try {
    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  } catch (e) {
    try {
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (E) {
      xmlhttp = false;
    }
  }
  if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
    xmlhttp = new XMLHttpRequest();
  }

  return xmlhttp;
}



function set_background(field)
{
//alert(field);
	var id = 'header_login_form_'+field;
//alert(id);
	var el = document.getElementById(id);
//alert(el);
//alert(el.value);

	if (el.value!='')
	{
		var background = '#fff';
		el.style.background = background;
	}
	else
	{
		var background = '#fff url(\'<%:EE_HTTP_PREFIX%>css/images/bg_'+field+'_<%:language%>.png\') no-repeat left top';
		el.style.background = background;
	}
//alert(background);
}

</script>


<script type="text/javascript" src="<%:EE_HTTP%>js/ap_header_login_form.js"></script>

<%include:ap_registration_form_js%>

  </head>

  <body id="iRoot" class="page">

<%include:<%iif:1,1,cmeter%>%>

<%iif::dns_draft_status,1,
<div id ="draft_div">DRAFT MODE</div>
%>

<%iif:<%config_var:use_draft_content%>,1,<%iif:<%checkAdmin%>,1,<div id ="draft_div">DRAFT MODE</div>%>%>

<%print_admin_head%>
<%:admin_menu%>

<%edit_cms:html_comments_between_page_head_and_title%>

<!--p>head.tpl</p-->
