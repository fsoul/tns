<%include:header%>
<p>
<table class="homeCard" cellspacing="6" bordercolor="red" border="0">
<form name="login_form" method="post" action="<%:EE_HTTP%>action.php?action=anketa_login&admin_template=<%:admin_template%>">
<tr>
<td>
    <table class="homeCardCaptionLogin" cellspacing="5" bordercolor="blue" border="0">
    <tr>
        <td><%e_cms:homeCardCaptionLogin_label%></td>
    </tr>
    </table>

    <table width="100%" border="0">
    <tr>
        <td><img src="img/inv.gif" width="0" height="7"></td>
    </tr>
    <tr>
        <td class="InputLabel"><div class="label"><%e_cms:login%>:</div></td> 
        <td align="right"><input type="text" style="width:210px" name="login"></td>
    </tr>
    <tr>
        <td class="InputLabel"><div class="label"><%e_cms:password%>:</div></td>
        <td align="right"><input type="password" style="width:210px" name="pass"></td>
    </tr>
    </table>
    <table>
    <tr>
        <td>
            <a class="comment" href="<%:EE_HTTP%>index.php?t=courses/my_account"><nobr><%cms:register_label%></nobr></a><%edit_cms:register_label%><br>
            <a class="comment" href="<%:EE_HTTP%>index.php?t=courses/forget_password"><nobr><%cms:forget_label%></nobr></a><%edit_cms:forget_label%>
        </td>
        <td width="100%">&nbsp;&nbsp;&nbsp;</td>
        <td>
            <input type="submit" class="button" value="<%cms:login_action%>"><%edit_cms:login_action%>
        </td>
    </tr>
    </table>
</td>
</tr>
</form>
</table>
</p>
<%include:footer%>