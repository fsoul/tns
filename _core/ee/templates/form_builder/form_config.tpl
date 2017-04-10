<table border="0" cellpadding="4" cellspacing="0" class="form_config_table">
<form name="form_config" method="post" action="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>action.php?action=save_form_config&t=<%:t%>&admin_template=yes">
<tr bgcolor="#ededfd">
	<td>Form name: </td>
	<td><%page_cms:form_builder_form_name_%> <%text_edit_page_cms:form_builder_form_name_%></td>
</tr>
<tr>
	<td width="200">Display email field?</td>
	<td><input type="checkbox" name="form_builder_display_email" value="1"<%iif:<%page_cms:form_builder_display_email_%>,1, checked%>></td>
</tr>
<tr bgcolor="#ededfd">
	<td width="200">Display captcha?</td>
	<td><input type="checkbox" name="form_builder_form_disp_captcha" value="1"<%iif:<%page_cms:form_builder_form_disp_captcha_%>,1, checked%>></td>
</tr>
<tr bgcolor="#ededfd" bgcolor="#ededfd">
	<td>Store information in database?</td>
	<td><input type="checkbox" name="form_builder_store_in_db" value="1"<%iif:<%page_cms:form_builder_store_in_db_%>,1, checked%>></td>
</tr>
<tr>
	<td>Send information to specified email?</td>
	<td><input type="checkbox" id="form_send_email" name="form_builder_send_email" value="1" onclick="show_fields('form_send_email','toemail','fromemail','emailsubj');"<%iif:<%page_cms:form_builder_send_email_%>,1, checked%>></td>
</tr>
<tr bgcolor="#ededfd" id="toemail"<%iif:<%page_cms:form_builder_send_email_%>,, class="hide"%>>
	<td width="200">Send to email:</td>
	<td><%page_cms:form_builder_to_email_%> <%text_edit_page_cms:form_builder_to_email_%></td>
</tr>
<tr id="fromemail"<%iif:<%page_cms:form_builder_send_email_%>,, class="hide"%>>
	<td>Send from email:</td>
	<td><%page_cms:form_builder_from_email_%> <%text_edit_page_cms:form_builder_from_email_%></td>
</tr>
<tr bgcolor="#ededfd" id="emailsubj"<%iif:<%page_cms:form_builder_send_email_%>,, class="hide"%>>
	<td>Mail subject:</td>
	<td><%page_cms:form_builder_mail_subject_%> <%text_edit_page_cms:form_builder_mail_subject_%></td>
</tr>
<tr>
	<td><input type="submit" value="Save" name="save" accesskey="S" class="save_button"><input type="hidden" name="page_id" value="<%:t%>"></td>
	<td>&nbsp;</td>
</tr>
</form>
</table>