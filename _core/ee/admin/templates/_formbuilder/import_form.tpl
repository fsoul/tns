<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,start_trace_time%>%>
<html>
<head>
	<title><%:FORMBUILDER_IMPORT_FORM_TITLE%></title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
<%iif:<%:modul%>,_tpl_folder,<script src="<%:EE_HTTP%>js/users.js"></script>,%>
</head>

<body>
<div id="dhtmltooltip2"></div>
<script language="JavaScript" type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<script language="JavaScript" type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
<style type="text/css">
.xml_import_table {margin: 15px 5px;}
.xml_import_table TD {padding: 3px 0px;}
.table_data {padding: 0px 5px;}
.form_name_input,
.file_input {width: 192px;}
.formbuilder_error, .formbuilder_success {margin: 5px; font-weight: bold;}
.formbuilder_error {color: #FF0000;}
.formbuilder_success {color: #00FF00;}
</style>
<script src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo/yahoo-min.js"></script> 
<script src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/event/event-min.js"></script> 
<script src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/connection/connection-min.js"></script> 
<script type="text/javascript">
function validateForm() {
	document.getElementById("formbuilder_error").innerHTML = "";
	document.getElementById("formbuilder_success").innerHTML = "";
	var ret = true;
	if(!checkFormName(document.getElementById("new_form_name"))) {
		ret = false;
	}
	if(!checkXmlFile(document.getElementById("xml_file"))) {
		ret = false;
	}
	return ret;
}

function checkFormName(field) {
	var ret = true;
	var newFormName = field.value;
	var newFormNameStatusObj = document.getElementById("new_form_name_status");
	var formbuilderErrorObj = document.getElementById("formbuilder_error");
	//check if field is empty
	if(newFormName == "") {
		newFormNameStatusObj.innerHTML = "&nbsp;<img src=\"<%:EE_HTTP%>img/not_ok.gif\" width=\"16\" height=\"16\" alt=\"\" title=\"\" border=\"0\">";
		ret = false;
	} else {
		newFormNameStatusObj.innerHTML = "&nbsp;<img src=\"<%:EE_HTTP%>img/ok.gif\" width=\"16\" height=\"16\" alt=\"\" title=\"\" border=\"0\">";
	}
	//check if field already exists
	if(ret) {
		sUrl = "<%:modul%>.php?op=check_form_name&new_form_name="+encodeURIComponent(field.value);
		var callback = { 
			success: function(o) {
				if(o.responseText == "") {
					//error
				} else if(parseInt(o.responseText) == 0) {
					//form not exists
					formbuilderErrorObj.innerHTML = "";
					newFormNameStatusObj.innerHTML = "&nbsp;<img src=\"<%:EE_HTTP%>img/ok.gif\" width=\"16\" height=\"16\" alt=\"\" title=\"\" border=\"0\">";
				} else if(parseInt(o.responseText) > 0) {
					//form exists
					formbuilderErrorObj.innerHTML = "<%:FORMBUILDER_FORM_ALREADY_EXISTS%>";
					newFormNameStatusObj.innerHTML = "&nbsp;<img src=\"<%:EE_HTTP%>img/warning.gif\" width=\"16\" height=\"16\" alt=\"\" title=\"\" border=\"0\">";
				}
			}, 
			failure: function(o) {
				
			}, 
			argument: [] 
		}
		var transaction = YAHOO.util.Connect.asyncRequest('GET', sUrl, callback, null);
	}
	return ret;
}

function checkXmlFile(field) {
	var ret = true;
	var xmlFile = field.value;
	var newXmlFileStatusObj = document.getElementById("xml_file_status");
	if(xmlFile == "") {
		newXmlFileStatusObj.innerHTML = "&nbsp;<img src=\"<%:EE_HTTP%>img/not_ok.gif\" width=\"16\" height=\"16\" alt=\"\" title=\"\" border=\"0\">";
		ret = false;
	} else {
		newXmlFileStatusObj.innerHTML = "&nbsp;<img src=\"<%:EE_HTTP%>img/ok.gif\" width=\"16\" height=\"16\" alt=\"\" title=\"\" border=\"0\">";
	}
	return ret;
}
</script>
<table width="100%" border=0 cellpadding="0" cellspacing="0">
	<tr>
		<td id="admin_popup_header"><div style="float:right;"><a style="text-decoration:none; color:#fff;" href="javascript:window.parent.closePopup();">X</a></div><%:FORMBUILDER_IMPORT_FORM_TITLE%></td>
	</tr>
</table>
<form action="" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr <%tr_bgcolor%> >
	<td><%inv:200,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>
<tr>
	<td colspan="3">
		<div class="formbuilder_error" id="formbuilder_error"><%:formbuilder_import_error%></div>
		<table cellpadding="0" cellspacing="0" border="0" class="xml_import_table">
		<tr>
			<td><%:FORMBUILDER_NEW_FORM_NAME%>&nbsp;</td>
			<td><input type="text" name="new_form_name" id="new_form_name" class="form_name_input" onchange="checkFormName(this);"></td>
			<td id="new_form_name_status">&nbsp;</td>
		</tr>
		<tr>
			<td><%:FORMBUILDER_FORM_FOR_IMPORT%>&nbsp;</td>
			<td><input type="file" name="xml_file" id="xml_file" class="file_input" size="22" onchange="checkXmlFile(this);"></td>
			<td id="xml_file_status">&nbsp;</td>
		</tr>
		</table>
		<div class="formbuilder_success" id="formbuilder_success"><%:formbuilder_import_result%></div>
	</td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">
		<%include:buttons/btn_import%>&nbsp;
		<%include:buttons/btn_close_popup%>&nbsp;
	</td>
</tr>
</table>
</form>
</body>
</html>
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,end_trace_time%>%>