<%row%
	<tr>
	<td width="4" <%iif::pos,1,bgcolor="#FFFFFF",%>>&nbsp;</td>
	<td <%iif::pos,1,bgcolor="#FFFFFF",%>><table width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td valign="top" width="26%" align="left"><span class="Date_agenda"><%:DisplayDate%>:</span></td>
	      <td valign="top"  width="74%" align="left"><a href="<%:EE_HTTP%>?t=20&id_news=<%getValueOf:id_news%>" class="agenda-item" target="_blank"><%:news_title%></a></td>
	    </tr>
	</table></td>
	</tr>
%row%>
