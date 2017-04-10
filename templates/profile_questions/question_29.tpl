<ul>
<%ap_profile_anketa_multiple:5055%>
</ul>
<script type="text/javascript">
$('#profile_poll_form input[type=checkbox]').on('change',function(e){
    var obj = e.target;
    if (obj.checked) {
        if (obj.value == 5055) {
            $('#skip_to').val('end');
        } else {
            $('#skip_to').val(0);
        }
    }
});
</script>