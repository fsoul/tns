<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,start_trace_time%>%>
<html>
<head>
	<title>User info</title>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%include:_formbuilder/user_info_content%>
<br>
&nbsp;&nbsp;<%include:buttons/btn_close_popup%>
</body>
</html>
<%include:<%iif:<%:VIEW_TIME_TRACE_INFO%>,,,end_trace_time%>%>