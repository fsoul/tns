<div style="padding:0px 0px 0px 30px; width:300px">
<fieldset id="bo_user_conf">
	<legend style="color:#00f; font-size:11px;">Backoffice user configuration</legend>
	Default content access:<br />
<%parse_sql_to_html:
 SELECT id as option_value\,
	content_access_name as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM content_access

,templates/<%:modul%>/content_access_option%>

<%include:hidden_input_instead_of_disabled_select%>

</fieldset>
</div>