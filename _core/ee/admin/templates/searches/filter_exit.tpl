<table cellpadding="2" style="border-style:none" cellspacing="0" border="0">
	<tr >
		<td width="*" align="right"><nobr>Engine category</nobr></td>
		<td class="table_header" width="150px"><select name="engine_browsers" style="width:150px"><option value="">ALL</option><%engine_browsers%></select></td>
		<td class="table_header" colspan="2"><label for="aUnvisited">Hide unvisited pages</label><input type="checkbox" id="aUnvisited" name="aUnvisited" <%fUnvisitedCheck%>></td>
	</tr>
</table><br>
<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px">	
	<td  align="center" width="10px" class="solidBorder">#</td>
	<td  align="center" width="*" class="solidBorder">Path</td>
	<td  align="center" width="70px" class="solidBorder">Total</td>
	<td  align="center" width="50px" class="solidBorder">Total for prev</td>
	<td  align="center" width="50px" colspan="2" class="solidBorder">Comparison</td>
</tr>
<%exit_pages%>
</table>