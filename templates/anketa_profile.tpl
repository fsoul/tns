<%set_allowed_uri_params_list:ID%>
<%set_allowed_uri_params_list:poll_id%>
<%set_allowed_uri_params_list:resp_id%>

<%ap_process_profile_pool%>
<%include:head%>
<div id="q_pages_wrapper">
<div id="q_pages" class="profile_poll">
    <div class="header"><%iif::percent,0,,<div class="pg_bar"><div class="pg"><div style="width:<%:percent%>%;"></div></div><div class="page_num"><%:cur_q%>/<%:q_total%></div></div>%></div>
    <h3><%:question_title%></h3>
    <form id="profile_poll_form" method="post">
    <input type="hidden" name="question_id" value="<%:question_code%>"/>
    <input type="hidden" name="skip_to" id="skip_to" value="0"/>
    <input type="hidden" name="login_cookie" id="login_cookie" value=""/>
    <%try_include:profile_questions/question_<%:question_code%>_<%:language%>,profile_questions/question_<%:question_code%>,profile_questions/question_default%>
    <div class="submit"><input type="submit" name="submit" value="<%cms_cons:poll next%>"></div>
    </form>
	<script type="text/javascript">
		$('#profile_poll_form').on('submit',function(){
			var mincnt = 1;
			if(this.elements.mincnt) mincnt = this.elements.mincnt.value;
			if(this.elements.question_id.value != 'invite' && this.elements.question_id.value != '0' && $(this).find(':checked').length < mincnt) {
				$("#profile_poll_form tr").each(function(){
					if ($(this).find('input').length>0 && $(this).find(':checked').length==0)
						$(this).addClass('error_row');
					else 
						$(this).removeClass('error_row');
				});
				alert("<%cms_cons:not all selected%>");
				return false;
			} else {
				return true;
			}
		});
		$('#profile_poll_form td').on('click',function(e){
			if($(e.target).find('input').length > 0) $(this).find('input').click();
		});
	</script>
</div>
</div>
<%include:foot%>
