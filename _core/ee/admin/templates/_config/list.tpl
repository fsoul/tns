<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>Config</title>
    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />
<%print_admin_js%>
</head>

<body>
<div id="whole_page_content">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<%:admin_menu%>
<table border=0>
    <tr><td class="header" width="300" height="31">Configuration</td></tr>
</table>
<form name="fd" action="#" method="post">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableborder">
    <tr bgcolor="#eeeeee" class="table_header">
        <td align="center" height="30">Name</td>
        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;Value</td>
        <td width="100%">&nbsp;</td>
    </tr>
    <tr bgcolor="#092869"><td colspan="3"><%inv:1,1%></td></tr>
    <tr>
        <td><%inv:250,1%></td>
        <td><%inv:150,1%></td>
        <td><%inv:1,1%></td>
    </tr>
    <tr bgcolor="#ededfd">
        <td height="30" class="table_data">&nbsp;&nbsp;Max chars in short description</td>
        <td><input type="text" name="mc" value="<%getValueOf:mc%>" size="50"></td>
        <td class="error">&nbsp;<%getError:mc%></td>
    </tr>
    <tr>
        <td height="30" class="table_data">&nbsp;&nbsp;Max rows in lists</td>
        <td><input type="text" name="mr" value="<%getValueOf:mr%>" size="50"></td>
        <td class="error">&nbsp;<%getError:mr%></td>
    </tr>
    <tr bgcolor="#ededfd">
        <td height="30" class="table_data">&nbsp;&nbsp;Timeout for login users (in sec.)</td>
        <td><input type="text" name="clive" value="<%getValueOf:clive%>" size="50"></td>
        <td class="error">&nbsp;<%getError:clive%></td>
    </tr>
    <tr>
        <td height="30" class="table_data">&nbsp;&nbsp;Site Copyright</td>
        <td><input type="text" name="scopy" value="<%getValueOf:s_copyright%>" maxlength="255" size="50"></td>
        <td class="error">&nbsp;</td>
    </tr>
</table><br>
&nbsp;&nbsp;<%include:buttons/btn_save%>&nbsp;&nbsp;<%include:buttons/btn_reset%>&nbsp;&nbsp;<%include:buttons/btn_check_modules%>
</form>
</div>
</body>
</html>
