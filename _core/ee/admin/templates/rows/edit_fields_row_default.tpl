<tr bgcolor="#ededfd" style="<%:row_style%>">
	<td height="30" class="table_data">&nbsp;&nbsp;<%:caption%> <%iif::mandatory,,,*%></td>
	<td><%include:<%:modul%>/edit_fields_<%:type%>%></td>
	<td class="error">&nbsp;&nbsp;<%getError:<%:field_name%>%></td>
</tr>