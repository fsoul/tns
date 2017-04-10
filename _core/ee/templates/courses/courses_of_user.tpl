<table align="left" cellspacing="2" cellpadding="7" border="0">
<tr class="homeCardCaption">
	<td class="courses" align="left" width="250">Course name</td>
	<td class="courses" width="70">Begin date</td>
	<td class="courses" width="70">End date</td>
	<td class="courses" width="70">Result</td>
</tr>

<%row%

<tr class="Card">
	<td align="left"><a href="?t=courses/my_training_index&id=<%:course_purchased_id%>"><%:course_name%></a></td>
	<td><%date:<%:DATE_FORMAT_PHP%>,<%strtotime::course_purchased_start_date%>%></td>
	<td><%date:<%:DATE_FORMAT_PHP%>,<%strtotime::course_purchased_end_date%>%></td>
	<td><%:course_purchased_user_status_name%></td>

</tr>

%row%>

<!--
<%row_empty%
<tr bgcolor="#eeeeee"><td align="center" colspan="4"><%cons:no_records_found%></td></tr>
%row_empty%>
-->

</table>
