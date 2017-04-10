<script>

function PrintSert(id) {
	x=640;
	y=480;
	openWin('?t=print_sert&id='+id,x,y);
}

</script >
<%print_admin_js%>
<%row%

<tr><td>
<table width="100%" bordercolor="green" border="0">
<tr>
<td width="60%">
	<H1><%e_cms:training%> # <%:course_purchased_id%> <%:course_name%></H1>
	<p><span style="text-transform:uppercase"><%session:UserName%></span>, last time you visited this training <%date:d-M-Y,<%strtotime::course_purchase_update_date%>%></p>
	<p><u><%e_cms:course_info%> </u></p>
	<p><%e_cms:date_start%>&nbsp;<%dt:<%:course_purchased_start_date%>%> </p>
	<p><%e_cms:purchase_date%> <%date:<%constant:DATE_FORMAT_PHP%>,<%strtotime::course_purchased_purchase_date%>%></p>
	<p><%e_cms:current_status%> <%:course_purchased_user_status_name%></p>
	<p><%e_cms:due_date%> <%date:<%constant:DATE_FORMAT_PHP%>,<%strtotime::course_purchased_end_date%>%> (Note: <%DaysDifference:<%time%>,<%strtotime::course_purchased_end_date%>%> days left)</p>
	<p><%e_cms:course_cost%> <%:course_original_price%> <%Euro%></p>
	<p><%e_cms:has_certificate%><%:course_purchased_has_certificate%></p>

</td>
<td valign="bottom" width="40%">
	<%inv:0,140%>
	<input class="button_dark" type="<%iif:<%:course_purchased_has_certificate%>,Yes,button,hidden%>" onclick="PrintSert(<%:id%>)" value="<%cons:PRINT_CERTIFICATE_TO_PDF%>">
</td>
<tr>
</table>
</td></tr>
<tr><td><%inv:0,10%></td></tr>


<tr><td>
	<H2>Course introduction:</H2>
	<p><%:course_short_description%></p>
</td></tr>
<tr><td><%inv:0,10%></td></tr>

%row%>

