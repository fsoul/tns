<select name="filter_<%:field_name%>">
	<option value="">All
	<option value="Yes" <%iif:<%strtolower:<%:filter_<%:field_name%>%>%>,yes,selected%>>Yes
	<option value="No" <%iif:<%strtolower:<%:filter_<%:field_name%>%>%>,no,selected%>>No
</select>
