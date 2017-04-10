<script language="javascript">

function openChapter(url) {
	x=800;
	y=600;
	openWin(url,x,y);
}

function openWin(url,x,y) {
	ew=window.open(url,"Edit","width="+x+",height="+y+",status=no,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
	ew.focus();
}

</script>

<table width="100%" align="left" cellspacing="2" cellpadding="7" border="0">
<tr class="homeCardCaption">
	<td valign="middle" class="courses"><%:survey_type%> Name</td>
	<td class="courses">First&nbsp;visit</td>
	<td class="courses">Last&nbsp;visit</td>
	<td class="courses">Status</td>
	<td class="courses">Certificate</td>
	<td class="courses"><%iif::survey_type,Exam,Answers<br><span class="comment">total/correct/incorrect,Pages<br><span class="comment">total/viewed%></span></td>
	<td class="courses">Action</td>

</tr>

<%row%

<tr class="Card">
	<td width="100%"><a href="javascript:openChapter('?t=introduction&s_id=<%:course_chapter_id%>&ankId=<%:ankId%>&a_id=<%:account_id%>&course_chapter_type_id=<%:course_chapter_type_id%>&isRestartable=<%:course_chapter_is_restartable%>')"><%:course_chapter_name%></a></td>
	<td><nobr><%iif::course_purchased_chapter_begin_date,,N/A,<%date:<%constant:DATE_FORMAT_PHP%>,<%strtotime::course_purchased_chapter_begin_date%>%>%></nobr></td>
	<td><nobr><%iif::course_purchased_chapter_last_date,,N/A,<%date:<%constant:DATE_FORMAT_PHP%>,<%strtotime::course_purchased_chapter_last_date%>%>%></nobr></td>
	<td><%:course_purchased_chapter_status_name%><%checkValueOf:course_purchased_chapter_status,1,&nbsp;(<%:course_purchased_chapter_progress%> completed)%></nobr></td>
	<td><%iif::has_certificate,1,Yes,No%></td>
	<td align="right">
	<%iif::survey_type,Exam,
		<%:correct_answers_count%>&nbsp;/&nbsp;<%:result_correct_answers_count%>&nbsp;/&nbsp;<%:result_incorrect_answers_count%>
		,<%:correct_answers_count%>&nbsp;/&nbsp;<%:result_correct_answers_count%>&nbsp;
		%>
	</td>
	<td><nobr>
	<input class="button"
	type="<%iif::course_purchased_chapter_status,0,button,hidden%>"
	title="Start" alt="Start" value="<%cons:Start%>"
	onclick="openChapter('?t=introduction&popup=1&s_id=<%:course_chapter_id%>&ankId=<%:ankId%>&a_id=<%:account_id%>&course_chapter_type_id=<%:course_chapter_type_id%>')"
	>
	<input class="button"
	type="<%iif::course_chapter_is_restartable,1,button,hidden%>"
	title="Restart" alt="Restart" value="<%cons:Restart%>"
	onclick="openChapter('?t=introduction&popup=1&s_id=<%:course_chapter_id%>&ankId=<%:ankId%>&a_id=<%:account_id%>&course_chapter_type_id=<%:course_chapter_type_id%>')"
	>
	<input class="button"
	type="<%iif::course_purchased_chapter_status,1,button,hidden%>"
	title="Continue" alt="Continue" value="<%cons:Continue%>"
	onclick="openChapter('?t=question&popup=1&s_id=<%:course_chapter_id%>&ankId=<%:ankId%>&a_id=<%:account_id%>&course_chapter_type_id=<%:course_chapter_type_id%>')"
	>
</nobr>
	</td>
</tr>

%row%>
<!--
<%row_empty%
<tr bgcolor="#eeeeee"><td align="center" colspan="10">No <%:survey_type%>s Found</td></tr>
%row_empty%>
-->
</table>
