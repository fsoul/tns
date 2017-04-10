<select name="filter_<%:field_name%>">
	<option value=""><%cons:All%>
	<option value="<%cons:GRID_DISABLED%>" <%iif:<%:filter_<%:field_name%>%>,<%cons:GRID_DISABLED%>,selected%>><%cons:GRID_DISABLED%>
	<option value="<%cons:GRID_ENABLED%>" <%iif:<%:filter_<%:field_name%>%>,<%cons:GRID_ENABLED%>,selected%>><%cons:GRID_ENABLED%>
</select>
