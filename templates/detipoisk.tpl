<%ap_authorized_only%>


<%ap_process_points_convertion_form%>

<%include:header_internal%>

<script>
	ew = window.open("http://detipoisk.com/opros/<%get_current_user_name_for_detipoisk%>", "detipoisk");
	if(ew) ew.focus();
	window.location = '<%get_href:31%>?success=1';

</script>

<%include:int_points_convertion_form%>


<%include:footer_internal%>
