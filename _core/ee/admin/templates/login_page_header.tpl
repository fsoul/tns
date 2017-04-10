<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
</head>
<body bgcolor="#ffffff">

<div id="admin_login_shadow_box" style="display:_none"></div>
<div id="admin_login_popup" style="display:_none">
	<div><strong>Load modules, please wait</strong></div>
	<div id="statusBar" style="width: 292px;">
		<div id="progress">0%</div>
		<div id="progressBar"></div>
	</div>
</div>

<table width="100%" height="100%">
<tr><td align="center" valign="bottom">

<form name="form1" method="post" action="" onsubmit="admin_login(); return false;">
<table width="200" border="0" cellspacing="0" cellpadding="4" class="tableborder">
<tr>
	<td colspan="3" class="table_header" bgcolor="#333333" style="color:#ffffff">Authorization</td>
</tr>
