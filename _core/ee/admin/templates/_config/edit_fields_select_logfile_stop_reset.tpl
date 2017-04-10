<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">

	<option value="<%:EE_LOG_STOP%>" <%iif:<%:<%:field_name%>%>,<%:EE_LOG_STOP%>,selected%>>Stop loging</option>
	<option value="<%:EE_LOG_RESET%>" <%iif:<%:<%:field_name%>%>,<%:EE_LOG_RESET%>,selected%>>Reset file</option>

</select>
<%include:hidden_input_instead_of_disabled_select%>
