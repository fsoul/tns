<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="0">
	<tr >
		<td width="*" align="right"><nobr>Engine category</nobr></td>
		<td class="table_header" width="150px"><select name="engine_browsers" style="width:150px"><option value="">ALL</option><%engine_browsers%></select></td>
		<td class="table_header" colspan="2"><label for="aUnvisited">Hide unvisited pages</label><input type="checkbox" id="aUnvisited" name="aUnvisited" <%fUnvisitedCheck%>></td>
	</tr>
</table>
<table width="100%" cellpadding="2" style="border-style:none" cellspacing="0" border="1">
<tr height="30px" >	
	<td rowspan="2" align="center" width="10px" class="solidBorder">#</td>
	<td  rowspan="2" align="center" width="*" class="solidBorder">Pages</td>
	<td  rowspan="2" align="center" width="70px" class="solidBorderText">Last visited</td>
	<td  rowspan="2" align="center" width="50px" class="solidBorderText">Total</td>
	<td  rowspan="2" align="center" width="50px" class="solidBorderText">Total for previous period</td>
	<td  align="center" width="50px" colspan="2" class="solidBorderText">Comparison</td>
</tr>
<tr>
	<td align="center" class="solidBorderText">%</td>
	<td align="center" class="solidBorderText">hits</td>
</tr>
<%list_pages%>
</table>