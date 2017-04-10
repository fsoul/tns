<ul>
<%ap_profile_anketa_multiple:5294%>
</ul>
<script type="text/javascript">
$('#profile_poll_form input[type=checkbox]').on('change',function(e){
    var obj = e.target;
    if (obj.checked) {
        if (obj.value == 5294) {
            $('#skip_to').val('49');
        } else {
            $('#skip_to').val(0);
        }
    }
});
</script>