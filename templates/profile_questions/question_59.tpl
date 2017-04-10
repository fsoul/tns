<ul>
<%ap_profile_anketa_answers%>
</ul>
<script type="text/javascript">
$('#profile_poll_form input[type=radio]').on('change',function(e){
    var obj = e.target;
    if (obj.checked) {
        if (obj.value == 6135) {
            $('#skip_to').val('61');
        } else {
            $('#skip_to').val(0);
        }
    }
});
</script>