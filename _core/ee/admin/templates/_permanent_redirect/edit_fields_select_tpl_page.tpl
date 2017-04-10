<%get_satelite_list:368,<%:page_id%>%>
<script type="text/javascript">
//emulate select onchange to hidden field
var oldHiddenValue = document.getElementById('satelit').value;
var newHiddenValue;
function is_hidden_value_changed() {
	newHiddenValue = document.getElementById('satelit').value;
	if(oldHiddenValue != newHiddenValue) {
		change_target_url('target_url');//was on select onchange
		oldHiddenValue = newHiddenValue;
	}
}
var intervalId = setInterval('is_hidden_value_changed()', 500);
</script>