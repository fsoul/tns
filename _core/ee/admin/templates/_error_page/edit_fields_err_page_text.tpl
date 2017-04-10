<div id="err_page_0">
<%get_satelite_list:370,<%get_current_page:<%:edit%>%>%>
</div>

<input id="err_page_1" <%iif::readonly,,,readonly%> type="text" name="" value="<%iif::page_type,1,<%gethtmlof:<%:field_name%>%>%>" size="<%:size%>" style="display:none">

<textarea id="err_page_2" <%iif::readonly,,,readonly%> name="" cols="<%:size%>" rows="5" style="display:none"><%iif::page_type,2,<%gethtmlof:<%:field_name%>%>%></textarea>
<script type="text/javascript" language="JavaScript">
<!--
change_err_page_type(type)
-->
</script>