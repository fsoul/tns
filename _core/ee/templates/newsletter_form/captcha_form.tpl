<table cellpadding="0" cellspacing="0" border="0" class="captcha_table">
	<tr>
		<td id="captcha_dynamic_text_box">
			<img  src="<%:SLAVE_MASTER_SITE%>/action.php?action=captcha_word&modul=captcha&cbg_color=<%:cbg_color%>&session_var_prefix=<%urldecode:p<%md5:<%_get:slave_server%>%>_%>" id="captcha_code" align="absmiddle" />

		</td>
	</tr>
	<tr>
		<td id="captcha_input_field_box">
			<div class="error" style="margin-left:42px;"><%iif::err,captcha_code,<%cms:blank_captha_code%>%></div>
			<div class="captcha_input_box">
				<input name="code" value=""  class="inputs"  size="70" type="text" />
			</div>
			<div class="captcha_input_box">
				<img src="<%:EE_HTTP%>img/RT_Captcha.jpg" onclick="document.getElementById('captcha_code').src = '<%:SLAVE_MASTER_SITE%>/_core/ee/action.php?'+ Math.random()+'sid=<%md5:<%uniqid:<%time:%>%>%>&action=captcha_word&modul=captcha&cbg_color=<%:cbg_color%>&session_var_prefix=<%urldecode:p<%md5:<%_get:slave_server%>%>_%>';return false;"></img>
			</div>
		</td>
	</tr>
</table>