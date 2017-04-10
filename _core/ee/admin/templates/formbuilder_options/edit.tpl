<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title><%checkValueOf:type,edit,Edit,Add%> menu item</title>
    <link rel=stylesheet href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
input, select {margin-top: 0px; margin-bottom: 0px;}
-->
</style>
<%print_admin_js:0%>
</head>
<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="2" rightmargin="0" topmargin="0">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript" type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<table width="100%" cellpadding="0" cellspacing="10" class="tableborder" border="0">
    <form name="fd" method="POST">
    <tr>
        <td valign="top">
                <table width="100%" align="center" cellpadding="1" cellspacing="1" border="0" id="main">
					
                    <tr>
                        <td width="100">
						Text (<%getValueOf:lang%>)
                        </td>
                        <td>
							<input type="text" name="option_text" value="<%:option_text%>" style="width: 400px;"/>
                        </td>
                    </tr>
					<tr>
                        <td width="100">
						Caption (<%getValueOf:lang%>)
                        </td>
                        <td>
							<input type="text" name="option_title" value="<%:option_title%>" style="width: 400px;"/>
                        </td>
                    </tr>
					<tr>
                        <td width="100">
						Value (<%getValueOf:lang%>)
                        </td>
                        <td>
							<input type="text" name="option_value" value="<%:option_value%>" style="width: 400px;"/>
                        </td>
                    </tr>
					<tr>
                        <td width="100">
						Is default
                        </td>
                        <td>
							<input type="checkbox" name="option_selected" value="<%:option_id%>"<%iif:<%:is_selected%>,<%:option_id%>, checked%>/>
                        </td>
                    </tr>
					<tr>
                        <td width="100">
						Is empty
                        </td>
                        <td>
							<input type="checkbox" name="option_empty" value="<%:option_id%>"<%iif:<%:is_empty%>,<%:option_id%>, checked%>/>
                        </td>
                    </tr>
					<tr>
                        <td colspan="2" height="30" valign="bottom">
							<input type="hidden" name="lang" value="<%getValueOf:lang%>">
                            <input type="button" value="Close" accessKey="C" class="button" onClick="window.parent.closePopup();">&nbsp;&nbsp;<input type="submit" name="save" value="Save" accessKey="S" class="button">
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
</form>
</table>
</body>
</html>
