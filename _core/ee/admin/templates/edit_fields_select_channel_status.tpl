<select <%iif::readonly,,,disabled%> name="<%:field_name%>">
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>><%cons:active%>
	<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>><%cons:inactive%>
</select>
<%include:hidden_input_instead_of_disabled_select%>
