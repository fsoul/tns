<tr bgcolor="#eeeeee">
<%row%	
<td style="<%:col_style%>">&nbsp;</td>
<td style="<%:col_style%>" height="30" align="<%:caption_align%>"><%decode::field_num%>&nbsp;<%iif::sorting,1,<a href="<%:modul%>.php?<%iif:<%:edit%>,,,edit=<%:edit%>&%>srt=<%getValueOf:srt%>&click=<%:field_num%>&op=0&load_cookie=true" class="table_header"><%:caption%></a>,<%:caption%>%></td>
%row%>
	<td>&nbsp;&nbsp;</td>
	<td width="10%" align="center" class="table_header"><%cons:Action%></td>
</tr>
