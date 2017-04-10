<script type="text/javascript">
function check_box(obj)
{
	if (obj.checked==true)
	{
//		if (!confirm('')) obj.checked=false;
	} else {
		if (!confirm('This will publish all your draft content. Are you sure?')) obj.checked=true;
	}
}
</script>
<input <%iif::readonly,,,readonly%> type="checkbox" name="<%:field_name%>" <%iif:<%:<%:field_name%>%>,1,checked%> value="1" onchange="check_box(this)">