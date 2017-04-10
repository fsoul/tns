<br />
<b>Access mode</b>
<br />
<%parse_sql_to_html:
	SELECT id as option_value\,
	access_mode_name as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM access_mode,templates/<%:modul%>/edit_fields_select_group_access_row%>
<%include:hidden_input_instead_of_disabled_select%>
