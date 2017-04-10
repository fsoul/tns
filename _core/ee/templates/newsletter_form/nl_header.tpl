<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%getCharset%>" />
<title><%get_page_title%></title>
<link href="<%urldecode:<%_get:slave_server%><%_get:slave_prefix%>%>css/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
//<!--
function subscribe_to_all(){
	if(document.nl_form.option_1.checked){
		change_checkbox_state('checked', true);
		change_checkbox_state('disabled', true);
	}else{
		change_checkbox_state('checked', false);
		change_checkbox_state('disabled', false);
	}
}
function subscribe_to_current(){
	change_checkbox_state('checked', false);
	var site_name = '<%urldecode:<%_get:slave_server%>%>'.toLowerCase();
	if(site_name.indexOf('http:\/\/') != -1) site_name=site_name.substr(7);
	if(site_name.indexOf('https:\/\/') != -1) site_name=site_name.substr(8);
	if(site_name.indexOf('www.') != -1) site_name=site_name.substr(4);
	document.getElementById(site_name).checked = true;
	change_checkbox_state('disabled', true);
}
function subscribe_below(){
	change_checkbox_state('checked', false);
	change_checkbox_state('disabled', false);
}
function change_checkbox_state(state, value){
	var checkboxobject = document.nl_form;
	for(i=0; i<checkboxobject.length; i++){
		if(checkboxobject.elements[i].type == 'checkbox' && checkboxobject.elements[i].name.search('group_') != -1){
			eval('checkboxobject.elements[i].'+state+' = '+value+';');
		}
	}
}
function submit_form(){
	change_checkbox_state('disabled', false);
	return true;
}
//-->
</script>
</head>
<body>
<div id="blmain" style="height: 500px; padding: 0px !important;">
<%print_admin_js%>
