<tr>
	<td colspan="2">
<script>
	var RecaptchaOptions = {theme: "custom",
				lang: "en",
				custom_theme_widget: "recaptcha_widget"};
</script>

<div id="recaptcha_widget" style="display:none">
	<div id="recaptcha_image"></div>
	<span class="recaptcha_only_if_image"><%cms:form_builder_captcha_%> <%text_edit_cms:form_builder_captcha_%><!--Enter the words above:--></span>
	<span class="recaptcha_only_if_audio"><%cms:form_builder_captcha_%> <%text_edit_cms:form_builder_captcha_%><!--Enter the numbers you hear:--></span>
	<input type="text" id="recaptcha_response_field" name="recaptcha_response_field" /> <span class="<%iif:<%:admin_template%>,,hide %>"><%cms:form_builder_captcha_error_%> <%text_edit_cms:form_builder_captcha_error_%></span><span class="form_div" id="captcha_error">&nbsp;</span><!--%iif:<%session:form_builder_form_captcha_error%>,1,<span class="form_div" id="captcha_error">CAPTCHA incorrect</span>%-->
	
	<div><a href="javascript:Recaptcha.reload()">Get another CAPTCHA</a></div>
	<div class="recaptcha_only_if_image"><a href="javascript:Recaptcha.switch_type('audio')">Get an audio CAPTCHA</a></div>
	<div class="recaptcha_only_if_audio"><a href="javascript:Recaptcha.switch_type('image')">Get an image CAPTCHA</a></div>
	<!--div><a href="javascript:Recaptcha.showhelp()">Help</a></div-->
</div>
<script type="text/javascript" src="http://api.recaptcha.net/challenge?k=<%:RE_CAPTCHA_PB_KEY%>"></script>

<noscript>
	<iframe src="http://api.recaptcha.net/noscript?k=<%:RE_CAPTCHA_PB_KEY%>" height="300" width="500" frameborder="0"></iframe><br />
	<textarea name="recaptcha_challenge_field" id="recaptcha_challenge_field" rows="3" cols="40"></textarea>
	<input type="hidden" name="recaptcha_response_field" value="manual_challenge" />
</noscript>
	</td>
</tr>