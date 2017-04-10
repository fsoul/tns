<select name="filter_<%:field_name%>">
	<option value="">All</option>
	<option value="Draft" <%iif:<%:filter_<%:field_name%>%>,Draft,selected%>>Draft</option>
	<option value="Published" <%iif:<%:filter_<%:field_name%>%>,Published,selected%>>Published</option>
	<option value="Archive" <%iif:<%:filter_<%:field_name%>%>,Archive,selected%>>Archive</option>
</select>
