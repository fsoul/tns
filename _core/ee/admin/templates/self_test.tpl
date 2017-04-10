<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
</head>


<body>

<table width="100%" cellpadding="4" cellspacing="4" border="0" class="tableborder">
<form name="fd" action="?page_id=<%getValueOf:page_id%>" method="post">
    <tr bgcolor="#eeeeee" class="table_header">
        <th align="center" height="30">Module name</th>
        <th align="center">Status</th>
        <th align="center">Test result</th>
        <th align="center">Action</th>
    </tr>

    <%paste:<%:EE_ADMIN_PATH%>templates/self_test_row%>
	
	<tr>
		<td colspan="4"><br />
		&nbsp;&nbsp;<%include:buttons/btn_close_popup%>
		</td>
	</tr>

</table>

</form>
<%get_popup_header_script:Self check%>
</body>


</html>
