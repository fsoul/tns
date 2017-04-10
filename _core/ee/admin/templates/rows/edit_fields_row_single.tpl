<tr bgcolor="#ededfd" style="<%:row_style%>">
	<td colspan="2" height="30" class="table_data"><%:caption%> <%iif::mandatory,,,*%> <%include:<%:modul%>/edit_fields_<%:type%>%></td>
	<td class="error">&nbsp;&nbsp;<%getError:<%:field_name%>%></td>
</tr>