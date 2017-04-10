<%row% <li><input type="checkbox" name="<%:input_name%>" id="<%:option_id%>" value="<%:option_value%>" <%iif:<%:option_value%>,<%:option_value_test%>, checked="checked"%>><label for="<%:option_id%>" class="<%:label_class%>"><%:option_text%></label></li> %row%>
<script type="text/javascript">
    var other_option = $('#option_other');
    if(other_option.length > 0) {
        $('#profile_poll_form input[type=checkbox]').on('change',function(e){
            if(e.target.id == 'option_other') {
                $('#profile_poll_form input[type=checkbox]').each(function(ind,el){
                    if(el.id != 'option_other') el.checked = false;
                });
            } else {
                $('#option_other').attr('checked',false);
            }
        });
    }
</script>