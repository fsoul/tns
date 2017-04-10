<div id="points_on_account"><%include:ap_account_state%></div>

<br/><%text_edit_cms_cons:Conversion successful%>
<div style="color:#00A600;"><%iif::error,,<%iif:<%get:success%>,1,<%cms_cons:Conversion successful%><br/><br/>%>%></div>
<%include:page_error%>
<%text_edit_cms_cons:Your account %s points%>

<script type="text/javascript" language="JavaScript">

function start_convertion(p_id)
{
	var f_ar = new Array ("post_order", "replenishment_mobile", "replenishment_webmoney", "project_help");

	var i;

	if (p_id == "")
	{
//		alert('<%cms_cons:Select convertion type%>');
		document.getElementById('points_convertion_type').focus();

		for(i=0; i<f_ar.length; i++)
		{
			f = document.getElementById(f_ar[i]);
			
			if (f.style.display != "none")
			{
				document.getElementById('pass_' + f_ar[i]).value = '';

				f.style.display = "none";
			}
		}
	}
	else
	{
		var f = document.getElementById(p_id);

		if (f.style.display == "none")
		{
			f.style.display = "";
		}

		for(i=0; i<f_ar.length; i++)
		{
			if (f_ar[i] != p_id)
			{
				document.getElementById('pass_' + f_ar[i]).value = '';

				f = document.getElementById(f_ar[i]);
			
				f.style.display = "none";
			}
		}
	}
}
</script>


<form name="points_convertion" id="points_convertion" method="post" action="<%get_href::t%>">
<div class="form-item">
<%include:int_points_convertion_points_using_form%>

<%include:int_points_convertion_post_order_form%>

<%include:int_points_convertion_repl_mobile_form%>

<%include:int_points_convertion_repl_webmoney_form%>

<%include:int_points_convertion_project_help_form%>
</div>
</form>

