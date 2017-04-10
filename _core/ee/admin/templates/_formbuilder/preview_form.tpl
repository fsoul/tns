<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,start_trace_time%>%>
<html>
<head>
	<title><%str_to_title::modul%> Preview</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
<%iif:<%:modul%>,_tpl_folder,<script src="<%:EE_HTTP%>js/users.js"></script>,%>
</head>

<body>
<div id="dhtmltooltip2"></div>
<script language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<script language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/dns_js.js"></SCRIPT>
<style type="text/css">
.clearLeft {clear: left;}
.clearRight {clear: right;}
.floatRight {float: right;}
.formbuilder_row_outer {
	padding: 19px 0px 15px 41px;
	border-bottom: 4px solid #666;
	overflow: hidden; zoom: 1;
}
.formbuilder_row {
	float: left;
	width: 420px;
	padding-top: 5px;
	overflow: hidden; zoom: 1;
}
.formbuilder_row INPUT, .formbuilder_row SELECT {
	margin: 0px;
	padding: 0px;
}
.formbuilder_first_left_row,
.formbuilder_first_right_row,
.formbuilder_second_left_row,
.formbuilder_second_right_row {float: left;}
.formbuilder_first_left_row {width: 150px;}
.formbuilder_second_left_row {width: 138px;}
.formbuilder_form_object {width: 261px;}
.formbuilder_button {padding: 0 12px 5px 12px;}
</style>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<tr <%tr_bgcolor%> >
	<td><%inv:200,1%></td>
	<td><%inv:1,1%></td>
	<td width="100%"><%inv:1,1%></td>
</tr>
<tr>
	<td colspan="3">
	<%fb_restore_values:1%>
	<form method="post">
	<div class="formbuilder_row_outer">
		<input type="hidden" name="fb_form_id" value="<%_get:edit%>">
		<div class="formbuilder_row clearLeft">
			<div class="formbuilder_first_left_row"><%:FORMBUILDER_FORM_NAME%></div>
			<div class="formbuilder_first_right_row"><input type="text" name="fb_form_name" class="formbuilder_form_object" value="<%:fb_form_name%>" readonly></div>	
		</div>
		<div class="formbuilder_row clearRight floatRight" style="display: <%iif:<%:fb_send_to_email%>,1,block,none%>;" id="fb_mail_title">
			<div class="formbuilder_second_left_row"><%:FORMBUILDER_EMAIL_TITLE%></div>
			<div class="formbuilder_second_right_row"><input type="text" name="fb_mail_title" class="formbuilder_form_object" value="<%cms:fb_mail_title_<%_get:edit%>a%>" readonly></div>	
		</div>
		<div class="formbuilder_row clearLeft">
			<div class="formbuilder_first_left_row"><%:FORMBUILDER_SEND_TO_EMAIL%></div>
			<div class="formbuilder_first_right_row"><input type="checkbox" name="fb_send_to_email" id="fb_send_to_email" value="1" onclick="showOrHideEmailFields();"<%iif:<%:fb_send_to_email%>,1, checked%> disabled></div>	
		</div>
		<div class="formbuilder_row clearRight floatRight" style="display: <%iif:<%:fb_send_to_email%>,1,block,none%>;">
			<div class="formbuilder_second_left_row"><%:FORMBUILDER_EMAIL_CHARSET%></div>
			<div class="formbuilder_second_right_row"><input type="text" name="fb_email_charset" class="formbuilder_form_object" value="<%:fb_email_charset%>" readonly></div>	
		</div>
		<div class="formbuilder_row clearLeft">
			<div class="formbuilder_first_left_row"><%:FORMBUILDER_STORE_IN_DB%></div>
			<div class="formbuilder_first_right_row"><input type="checkbox" name="fb_store_in_db" value="1"<%iif:<%:fb_store_in_db%>,1, checked%> disabled></div>	
		</div>
		<div class="formbuilder_row clearRight floatRight" style="display: <%iif:<%:fb_send_to_email%>,1,block,none%>;">
			<div class="formbuilder_second_left_row"><%:FORMBUILDER_DEST_EMAIL%></div>
			<div class="formbuilder_second_right_row"><input type="text" name="fb_dest_email" class="formbuilder_form_object" value="<%:fb_dest_email%>" readonly></div>	
		</div>
		<div class="formbuilder_row clearLeft">
			<div class="formbuilder_first_left_row"><%:FORMBUILDER_THANKYOU_URL%></div>
			<div class="formbuilder_first_right_row"><%print_formbuilder_thankyou_url:<%:fb_thanks_page%>%></div>	
		</div>
		<div class="formbuilder_row clearRight floatRight" style="display: <%iif:<%:fb_send_to_email%>,1,block,none%>;">
			<div class="formbuilder_second_left_row"><%:FORMBUILDER_FROM_EMAIL%></div>
			<div class="formbuilder_second_right_row"><input type="text" name="fb_from_email" class="formbuilder_form_object" value="<%:fb_from_email%>" readonly></div>	
		</div>
	</div>
	</form>
	</td>
</tr>
<tr>
	<td colspan="3"><div style=" overflow: hidden; zoom: 1; margin: 5px;"><%create_formbuilder_form:<%_get:edit%>%></div></td>
</tr>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="3">&nbsp;&nbsp;
		<form name="fs" enctype="multipart/form-data" action="" method="post">
		<div class="formbuilder_button">
		<%include:buttons/btn_cancel%>&nbsp;
		</div>
		</form>
	</td>
</tr>
</table>
<%get_popup_header_script:<%str_to_title::modul%> Preview%>
</body>
</html>
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,end_trace_time%>%>