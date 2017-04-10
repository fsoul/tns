<select <%iif::readonly,,,disabled%> name="filter_<%:field_name%>">
	<option value="">All</option>
	<option value="0" <%iif:<%:filter_<%:field_name%>%>,0,selected%>><%cons:draft%></option>
	<option value="1" <%iif:<%:filter_<%:field_name%>%>,1,selected%>><%cons:published%></option>
	<option value="2" <%iif:<%:filter_<%:field_name%>%>,2,selected%>><%cons:archive%></option>
</select>
<%include:hidden_input_instead_of_disabled_select%>
