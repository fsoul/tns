<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">
	<option value="0"></option>
	<%parse_enum_to_html:<%:enum_table%>,<%:enum_field%>,list_row_option,<%gethtmlof:<%:field_name%>%>%>
</select>
<%include:hidden_input_instead_of_disabled_select%>
