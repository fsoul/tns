<script type="text/javascript">
function submit_survey_form(form_el)
{
	for(var i=0; i<form_el.elements["PollAnswer"].length; i++)
	{
		var radio = form_el.elements["PollAnswer"][i];
		if(radio.checked)
		{
			form_el.submit();
			return true;
		}
	}

	window.alert("Please, select an answer.");
	form_el.elements["PollAnswer"][0].focus();
}

</script>

<form id="pollform" name="pollform" action="" method="post">
<input type="hidden" name="action" value="answer_for_survey" />
<table>
	<tr>
		<td colspan="2">
		<%:question_text%>
		</td>
	</tr>
<%row%
	<tr>
		<td><input name="PollAnswer" value="<%:record_id%>" type="radio" /></td>
		<td><%:answer%></td>
	</tr>
%row%>
	<tr>
		<td colspan="2"><a class="button" href="javascript:submit_survey_form(document.getElementById('pollform'));">Vote</a>
		</td>
	</tr>
</table>
</form>
