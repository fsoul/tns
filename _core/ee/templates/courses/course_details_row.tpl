<%row%
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td>
	<table width="100%" bordercolor="green" border="0">
	<tr>
		<td width="60%">
		<H1><%e_cms:training_course_info%> "<%:course_name%>"</H1>
		<p><%e_cms:course_original_price%><%:course_original_price%> <%Euro%></p>
		<p><%e_cms:course_duration%><%:course_time_limit%> days</p>
		<p><%inv:0,10%></p>
		<p><%:course_full_description%></p>
		</td>
	</tr>
	</table>
	</td>
</tr>
<tr><td><%inv:0,10%></td></tr>
<tr>
	<td align="left">
	<table class="Card" width="100%" cellspacing="5" cellpadding="0" bordercolor="green" border="0">
	<tr>
		<td><%inv:20%></td>
		<td>
			<input class="button" type="button" value="&lt;&nbsp;<%cons:Back%>" onclick="window.location.href='<%:EE_HTTP%>index.php?t=courses/products&language=<%:language%>'">
		</td>
		<td><%inv:20%></td>
		<td>
			<%include:courses/buy_btn%>
		</td>
		<td width="100%">
		</td>
	</tr>
	</table>
	</td>
</tr>
</table>
%row%>