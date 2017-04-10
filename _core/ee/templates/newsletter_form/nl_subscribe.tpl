<%include:<%:MASTER_NL_TEMPLATES_FOLDER%>nl_header%>
<form action="<%:EE_HTTP%>action.php" method="post" name="nl_form" onsubmit="javascript: return submit_form();">
<input type="hidden" name="action" value="newsletter_slave_subscribe"/>
<input type="hidden" name="site_name" value="<%_get:site_name%>"/>
<input type="hidden" name="confirm_page" value="<%_get:confirm_page%>"/>
<input type="hidden" name="slave_server" value="<%urldecode:<%_get:slave_server%>%>"/>
<input type="hidden" name="slave_prefix" value="<%urldecode:<%_get:slave_prefix%>%>"/>
<!--input type="hidden" name="request_uri" value="<%server:REQUEST_URI%>"/-->
<input type="hidden" name="slave_subscribe_page" value="<%_get:slave_subscribe_page%>"/>
<!--input type="hidden" name="language" value="<%_get:language%>"/-->
<!--input type="hidden" name="t" value="<%:t%>"/-->
	<table cellpadding="0" cellspacing="0" border="0" style="text-align: left;" class="subscribe_table" width="100%">
		<tr><td colspan=3>
			<div style="padding-bottom: 20px;"><%e_page_cms:text%></div>
		</td></tr>

		<tr><td style="width: 102px;"><%text_edit_page_cms:your_name_text%><%page_cms:your_name_text%><span style="color:#FF0000;">*</span></td><td><input type="text" name="name" size="40" value="<%urldecode:<%_get:name%>%>" style="border: 1px solid #43534A; width: 219px;" /></td><td style="color:#FF0000;"><%cms:<%iif:<%_get:result%>,err_blank_name,blank_name,1%>%></td></tr>
		<tr><td style="width: 102px;"><%text_edit_page_cms:your_lname_text%><%page_cms:your_lname_text%><span style="color:#FF0000;">*</span></td><td><input type="text" name="lname" size="40" value="<%urldecode:<%_get:lname%>%>" style="border: 1px solid #43534A; width: 219px;" /></td><td style="color:#FF0000;"><%cms:<%iif:<%_get:result%>,err_blank_lname,blank_last_name,1%>%></td></tr>
		<tr><td style="width: 102px;"><%text_edit_page_cms:your_email_text%><%page_cms:your_email_text%><span style="color:#FF0000;">*</span></td><td><input type="text" name="email" size="40" value="<%urldecode:<%_get:email%>%>" class="red_input" style="border: 1px solid #43534A; width: 219px;" /></td><td style="color:#FF0000;"><%cms:<%iif:<%_get:result%>,err_invalid_email_format,invalid_email_format,1%>%></td></tr>
		<tr><td style="width: 102px;"><%text_edit_page_cms:language_text%><%page_cms:language_text%></td><td><%parse_sql_to_html:SELECT `language_name` AS `lang`\, `language_code` AS `lang_code` FROM `language` WHERE `language_code`<>"" AND `status`=1,templates/<%:MASTER_NL_TEMPLATES_FOLDER%>languages_list%></td><td>&nbsp;</td></tr>
		
		<tr><td colspan="2"><div style="padding-top: 20px;"><%text_edit_page_cms:bottom_text%><%page_cms:bottom_text%><span style="color:#FF0000;">*</span></div></td><td>&nbsp;</td></tr>
		<%iif:<%_get:result%>,err_at_least_one_group,<tr><td colspan="2" style="color:#FF0000;"><%cms:at_least_one_group%></td><td>&nbsp;</td></tr>%>
		<tr><td colspan="2"><%text_edit_page_cms:subscribe_to_all%><%iif:<%getField:SELECT COUNT(*) FROM v_nl_group WHERE show_on_front=1%>,0,,<input type="checkbox" name="option_1" value="all" onclick="javascript:subscribe_to_all();"> <%page_cms:subscribe_to_all%>%><td>&nbsp;</td></tr>
		<!--tr><td><input type="radio" name="option_1" value="current"  onclick="javascript:subscribe_to_current();"></td><td><%e_page_cms:subscribe_to_current%></td></tr>
		<tr><td><input type="radio" name="option_1" value="below" onclick="javascript:subscribe_below();" checked></td><td><%e_page_cms:subscribe_below%></td></tr-->
		
		<%parse_sql_to_html:SELECT * FROM v_nl_group WHERE show_on_front=1,templates/<%:MASTER_NL_TEMPLATES_FOLDER%>nl_groups_row%>
		
		<tr><td colspan=2 align="center"><input type="submit" size="5" value="<%page_cms:subscribe_text%>" class="red_button" style="width: 72px; height: 19px; line-height: 19px; background-color: #43534A; color: #FFF; font-weight: bold; font-family: Tahoma, Helvetica, Sans Serif, sans-serif; font-size: 10px; margin-top: 20px;" /><%text_edit_page_cms:subscribe_text%></td><td>&nbsp;</td></tr>
	</table>
	<%include_if:admin_template,yes,<%:MASTER_NL_TEMPLATES_FOLDER%>subscription_edit%>
</form>
<%include:<%:MASTER_NL_TEMPLATES_FOLDER%>nl_footer%>
