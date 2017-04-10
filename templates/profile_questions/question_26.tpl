<ul>
<%ap_profile_anketa_multiple:4973%>
</ul>
<script type="text/javascript">
$('#profile_poll_form input[type=checkbox]').on('change',function(e){
    var obj = e.target;
    if (obj.checked) {
        if (obj.value == 4973) {
            $('#skip_to').val('29');
        } else {
            $('#skip_to').val(0);
        }
    }
});
</script>