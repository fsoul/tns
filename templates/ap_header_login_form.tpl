
<script type="text/javascript">

function try_login(p_email, p_form)
{
    document.forms[p_form].submit();
}


</script>
	<input type="hidden" name="page_from" value="<%get_href:<%:t%>%>" />
	<input type="hidden" name="action" value="access_package.authorize" />
	<input type="hidden" name="login_cookie" id="login_cookie" value="" />
	<input type="hidden" name="login_plid" id="login_plid" value="" />
	<input
		class="loginTxt"
		type="text"
		id="header_login_form_login"
		name="login"
        placeholder="E-mail"
		onkeypress="if(checkEnter(event)) {try_login(document.getElementById('header_login_form_login').value, 0); return false;}"
	/>

	<input	class="loginTxt"
		type="password" name="passw"
		id="header_login_form_password"
        placeholder="Password"
		onkeypress="if(checkEnter(event)) {try_login(document.getElementById('header_login_form_login').value, 0); return false;}"
		autocomplete="off"
	/>

<script type="text/javascript">

var psw = document.getElementById('header_login_form_password');

if (psw.value != '')
{
	psw.style.background = '#fff';
}

</script>

<%text_edit_cms_cons:Your account is blocked%>
<%text_edit_cms_cons:Email not confirmed%>
<%text_edit_cms_cons:Unknown reason%>

        <span id="btnLogin"><a class="" href="<%get_href::t%>" onclick="try_login(document.getElementById('header_login_form_login').value, 0); return false;"><%cms_cons:Enter%></a></span><%text_edit_cms_cons:Enter%>


  
