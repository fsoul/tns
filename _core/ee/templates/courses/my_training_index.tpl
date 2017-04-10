<%include:header%>
<table width="100%" cellspacing="0" cellpadding="0" border="0">

<%parse_soap_to_html:ei_cm_getCoursePurchasedInfo,templates/courses/course_purchased,<%:id%>,ei_gf_createSystemInfo%>

<tr><td>
	<H2><%e_cms:course_label%></H2>
</td></tr>
<tr><td align="left">
<%parse_soap_to_html_filtered:ei_cm_listCoursePurchasedChapters,templates/courses/course_purchased_chapters,check_chapter_type,1,course_purchased_id => <%:id%>,ei_gf_createSystemInfo,,0%>
</td></tr>
<tr><td><%inv:0,10%></td></tr>

<tr><td>
	<H2><%e_cms:test_label%></H2>
</td></tr>
<tr><td align="left">
<%parse_soap_to_html_filtered:ei_cm_listCoursePurchasedChapters,templates/courses/course_purchased_chapters,check_chapter_type,2,course_purchased_id => <%:id%>,ei_gf_createSystemInfo,,0%>
</td></tr>
<tr><td><%inv:0,10%></td></tr>


</table>


<%include:footer%>
