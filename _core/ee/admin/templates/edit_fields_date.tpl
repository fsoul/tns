<input
	<%iif::readonly,,,readonly%>
	type="text"
	name="<%:field_name%>"
	value="<%GetDateFromSQL::<%:field_name%>%>"
	size="<%:size%>"
	id="<%:field_name%>"
	datepickerIcon="../img/calendar24.gif"
>

<%include:script_initCalendar%>
