<%row%
	<table class="homeCardCaption" cellspacing="5" bordercolor="blue" border="0">
	<tr>
		<td align="left">&gt;&nbsp;<%:product_name%></td>
		<td align="right"><%:product_original_price%>&nbsp;<%:currency%>Euro</td>
	</tr>
	</table>

	<table width="100%" border="0">
	<tr>
		<td><p><%:product_short_description%></p></td>
	</tr>
	</table>
	
	<table>
	<tr>
		<td width="100%">&nbsp;&nbsp;&nbsp;</td>
		<td>
			<input onclick="window.location.href='<%:EE_HTTP%>index.php?t=courses/course_details&product_id=<%:product_id%>&id=<%:product_id%>';" type="button" class="button" border="0" value="<%cons:More%>">
		</td>
		<td>
			<%include:<%iif::product_original_price,0.00,courses/get_now,courses/buy_btn%>%>
		</td>
	</tr>
	</table>
%row%>
