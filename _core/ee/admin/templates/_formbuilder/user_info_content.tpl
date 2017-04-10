<table border="0" cellpadding="2" cellspacing="1">
<tr>
	<td width="151" valign="top" style="border-bottom: 1px dotted black;">&nbsp;&nbsp;Id:</td>
	<td valign="top" width="201" style="border-bottom: 1px dotted black;"><%getfield:SELECT id FROM users WHERE id = <%sqlValue:<%:show%>%> LIMIT 0\,1%></td>
</tr>
<tr>
	<td width="151" valign="top" style="border-bottom: 1px dotted black;">&nbsp;&nbsp;Name:</td>
	<td valign="top" width="201" style="border-bottom: 1px dotted black;"><%getfield:SELECT name FROM users WHERE id = <%sqlValue:<%:show%>%> LIMIT 0\,1%></td>
</tr>
<tr>
	<td width="151" valign="top" style="border-bottom: 1px dotted black;">&nbsp;&nbsp;Login:</td>
	<td valign="top" width="201" style="border-bottom: 1px dotted black;"><%getfield:SELECT login FROM users WHERE id = <%sqlValue:<%:show%>%> LIMIT 0\,1%></td>
</tr>
<tr>
	<td width="151" valign="top" style="border-bottom: 1px dotted black;">&nbsp;&nbsp;Email:</td>
	<td valign="top" width="201" style="border-bottom: 1px dotted black;"><%getfield:SELECT email FROM users WHERE id = <%sqlValue:<%:show%>%> LIMIT 0\,1%></td>
</tr>
</table>