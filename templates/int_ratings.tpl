<%set_allowed_uri_params_list:id,section,page,load_cookie%>

<%include:header_internal%>
<%text_edit_page_cms:ratings_section%>
<div id="rating_detail">
<%ap_ratings_detail:<%get:id%>,<%page_cms:ratings_section%>%>
</div>
<div class="int">





                <%ap_ratings_list:<%iif:<%get:page%>,,1,<%get:page%>%>,<%page_cms:ratings_section%>%>


</div>

<%include:footer_internal%>

