<!-- </div> -->
<div id="navigation">
<table width="100%" cellspacing="0" cellpadding="3" border="0">
<tr>
	<td nowrap="1"><%words:<%cons:Displayed%>%>: <%:first_displayed%><%iif:<%:first_displayed%>,<%:last_displayed%>,,-<%:last_displayed%>%> record(s)</td>
	<td align="center" width="100%">
	<%iif::page_url_prev,,,<a title="<%words:<%cons:First_page%>%>" href="<%:page_url_first%>">&lt&lt%><%iif::page_url_prev,,,</a>%>&nbsp;&nbsp;
	<%iif::page_url_prev,,,<a title="<%words:<%cons:Previous_page%>%>" href="<%:page_url_prev%>">&lt%><%iif::page_url_prev,,,</a>%>&nbsp;&nbsp;
	<%iif::page_url_prev_block,,,<a title="<%words:<%cons:Previous_pages_block%>%>" href="<%:page_url_prev_block%>">...</a>&nbsp;&nbsp;%>
<%row%
	<%iif::page_url,,<b>,<a href="<%:page_url%>">%><%:page_number%><%iif::page_url,,</b>,</a>
	%>&nbsp;
%row%>
	<%iif::page_url_next_block,,,<a title="<%words:<%cons:Next_pages_block%>%>" href="<%:page_url_next_block%>">...</a>&nbsp;&nbsp;%>
	<%iif::page_url_next,,,<a title="<%words:<%cons:Next_page%>%>" href="<%:page_url_next%>">&gt%><%iif::page_url_next,,,</a>%>&nbsp;&nbsp;
	<%iif::page_url_next,,,<a title="<%words:<%cons:Last_page%>%>" href="<%:page_url_last%>">&gt&gt%><%iif::page_url_next,,,</a>%>&nbsp;
	</td>
	<td colspan="2">&nbsp;</td>
</tr>
<tr>
	<td colspan="1">
		<%cons:Total%>:&nbsp;<%:rows_total%>&nbsp;<%cons:record(s)%>
	</td>
	<td align="center">
		<%cons:Total%>:&nbsp;<%:pages_total%>&nbsp;<%cons:page(s)%>
	</td>
	<td align="right" nowrap="1"><%words:<%cons:Rows_on_page:%>%></td>
	<td align="right"><%include:<%:EE_CORE_PATH%>templates/navigation/rows_on_page%></td>
</tr>

</table>
</div>
<!-- <div> -->
