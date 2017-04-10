<select name="filter_<%:field_name%>">
	<option value=""><%cons:All%>
	<option value="0" <%iif:<%:filter_<%:field_name%>%>,<%cons:GRID_DISABLED%>,selected%>><%cons:GRID_DISABLED%>
	<option value="1" <%iif:<%:filter_<%:field_name%>%>,<%cons:GRID_ENABLED%>,selected%>><%cons:GRID_ENABLED%>
</select>

