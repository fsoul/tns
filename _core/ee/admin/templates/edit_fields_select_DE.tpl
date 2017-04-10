<select style="width:100px" <%iif::readonly,,,disabled%> name="<%:field_name%>">
	<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>>Disabled
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>>Enabled
</select>
<%include:hidden_input_instead_of_disabled_select%>
