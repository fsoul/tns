<tr bgcolor="#ededfd" style="<%:row_style%>">
	<td colspan="2" height="30" valign="top" class="table_data"><%:caption%> <%iif::mandatory,,,*%><br>
	<br><%include:<%:modul%>/edit_fields_<%:type%>%></td>
	<td class="error">&nbsp;&nbsp;<%getError:<%:field_name%>%></td>
</tr>
