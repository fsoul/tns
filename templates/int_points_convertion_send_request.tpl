<script>
    function on_submit_points_convertion(){
        jQuery('#district_').val( jQuery('#selector_district_id option:selected').html() );
        jQuery('#region_').val( jQuery('#selector_region option:selected').html() );
        jQuery('#city_').val( jQuery('#selector_city option:selected').html() );
        document.forms['points_convertion'].submit();
    }
</script>
<div class="form_row">
    <%text_edit_cms_cons:Send request%>
    <a class="button link" href="<%get_href::t%>" onclick="on_submit_points_convertion(); return false;"><%cms_cons:Send request%></a>
</div>
