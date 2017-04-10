<%include:header%>
<%iif:<%checkAdmin%>,,%>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr><td><H1><%e_cms:my_course_label%></H1></td></tr>
<tr><td><p><%e_cms:hello%> <%session:UserName%>!</p></td></tr>
<tr><td><p><%e_cms:last_visit_text%><%iif:<%session:UserLastTimeVisited%>,,,<%session:UserLastTimeVisited%>%></p></td></tr>
<tr><td><p><%edit_cms:for_contact_info%><%cms:for_contact_info%><%edit_cms:my_account%><a href="index.php?t=my_account"><%cms:my_account%></a>.</p></td></tr>
<tr><td><%inv:0,10%></td></tr>

<tr><td><H2><%e_cms:my_current_courses%></H2></td></tr>
<tr><td><p><%e_cms:click_my_current_courses_info%></p></td></tr>
<tr><td><%courses_of_user:01%></td></tr>
<tr><td><%inv:0,10%></td></tr>

<tr><td><H2><%e_cms:my_certificates%></H2></td></tr>
<tr><td><p><%e_cms:click_cert_for_info%></p></td></tr>
<tr><td><%courses_of_user:Yes,course_purchased_has_certificate%></td></tr>
<tr><td><%inv:0,10%></td></tr>

<tr><td><H2><%e_cms:all_my_course_label%></H2></td></tr>
<tr><td><p><%e_cms:click_all_my_course_label_info%></p></td></tr>
<tr><td><%courses_of_user:012%></td></tr>
</table>


<%include:footer%>
