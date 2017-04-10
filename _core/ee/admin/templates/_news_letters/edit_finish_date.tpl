<input
	readonly
	type="text"
	name="finish_date"
	value="<%iif:<%:op%>,3,<%iif:<%:finish_date%>,,<%date:Y-m-d,<%mktime:0,0,0,<%date:m%>,<%tpl_add:<%date:d%>,<%config_var:default_active_period%>%>,<%date:Y%>%>%>,<%:finish_date%>%>,<%:finish_date%>%>"
	size="8"
	id = "finish_date"
	style = "vertical-align:super;"
	datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"
>
<script language="JavaScript" type="text/javascript">
	var format = "<%:DATE_FORMAT_JS%>";
	var needReload = false;
	initCalendar("finish_date", format);
	var dpContainer = document.getElementById('dpContainer');
	dpContainer.firstChild.align = "";
	if ('<%get_newsletter_status:<%:email_id%>%>' == 'sent')
	{
		dpContainer.firstChild.style.display = "none";
	}
</script>
<a href="#" onclick = "document.getElementById('dpContainer').dateInput.value = null;return false;"><img src="<%:EE_HTTP%>img/del_btn.gif" width="24" height="24" alt="<%:DELETE_SEL_GRID_IMAGE_ALT%>" title="<%:DELETE_SEL_GRID_IMAGE_ALT%>" border="0"></a>
