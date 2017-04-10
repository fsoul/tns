<select <%iif::readonly,,,disabled%> name="<%:field_name%>">
	<option value="0" <%iif:<%:<%:field_name%>%>,,selected%> <%iif:<%:<%:field_name%>%>,0,selected%>><%cons:draft%>
	<option value="1" <%iif:<%:<%:field_name%>%>,1,selected%>><%cons:published%>
	<option value="2" <%iif:<%:<%:field_name%>%>,2,selected%>><%cons:archive%>
</select>
<%include:hidden_input_instead_of_disabled_select%>
