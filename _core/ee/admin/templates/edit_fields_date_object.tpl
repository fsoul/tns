<input
	<%iif::readonly,,,readonly%>
	type="text"
	name="<%:field_name%>"
	value="<%iif:<%post:refresh%>,true,<%:<%:field_name%>%>,<%date:d-m-Y,<%iif::<%:field_name%>,,<%time%>,:<%:field_name%>%>%>%>"
	size="<%:size%>"
	id="<%:field_name%>"
	datepickerIcon="<%:EE_HTTP%>img/calendar24.gif"
>

<%include:script_initCalendar%>
