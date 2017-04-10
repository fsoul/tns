<tr bgcolor="#F0F0F0"><td colspan="2" align="center">
<br />
Conditions which satisfy the password were changed.<br />
Please, change your password.<br />
</td></tr>

<tr bgcolor="#F0F0F0"><td colspan="2" align="left">
<br />
<b>New conditions:</b>
<ol type="-" style="margin-top:0px;">
	<%iif:<%get_config_var:pass_min_8_symbol%>,1,<li><%:PASSWORD_TOO_SHORT%>;%>
	<%iif:<%get_config_var:pass_contain_letters%>,1,<li><%:PASSWORD_MUST_CONTAIN_LETTERS%>;%>
	<%iif:<%get_config_var:pass_contain_letters_with_diff_case%>,1,<li><%:PASSWORD_MUST_CONTAIN_LETTERS_WITH_DIFF_CASE%>;%>
	<%iif:<%get_config_var:pass_contain_numbers%>,1,<li><%:PASSWORD_MUST_CONTAIN_NUMBER%>;%>
	<%iif:<%get_config_var:pass_not_have_login_inside%>,1,<li><%:PASSWORD_NOT_HAVE_LOGIN_INSIDE%>;%>
</ol>
</td></tr>