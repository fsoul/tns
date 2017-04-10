<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
<%print_admin_js:0%>
<script src="<%:EE_HTTP%>js/calendar.js"></script>
	<style type="text/css">
		input
		{
			border:0px
		}
	</style>
</head>

<body>
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" class="tableborder" border="0">
<form name="fs" enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="refresh" value="true">
<input type="hidden" name="op" value="moduls_list_save">
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
<%row%	
	<%iif:<%:prev_section%>,,,<%iif:<%:section%>,<%:prev_section%>,,</fieldset>%>%>
	<%iif:<%:section%>,<%:prev_section%>,,<fieldset><legend><b><%:section%></b></legend>%>
	<div style="float:left; width:200px" title="<%:modul_name%>.php"><input type="checkbox" name="moduls_list[]" value="<%:modul_name%>" <%iif:<%:modul_is_allowed%>,1,checked%>>&nbsp;<%:modul_title%></div>	
	<%setValueOf:prev_section,<%:section%>%>
	
%row%>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</td></tr>
</table>
<br>
<table>
<tr <%tr_bgcolor%>>
	<td height="30" class="table_data" colspan="30">&nbsp;&nbsp;
		<%include:buttons/btn_cancel%>&nbsp;
		<%include:buttons/btn_save%>&nbsp;
	</td>
</tr>
</form>
</table>
<%get_popup_header_script:List of moduls allowed for user <span class="error"><%get_user_name_by_id::edit%></span>%>
</body>
</html>