<%set_allowed_uri_params_list:reffer_email_%>

<%ap_process_registration_form%>

<%include:header_internal_1%>

<div class="textBlock clearfix">
    <img src="/img/social.png" class="mainPageImg">
    <%longtext_edit_page_cms:join_us%>
    <%nl2br_page_cms:join_us%>
</div>


<a href="<%get_href:Authorization%>" class="button"><%e_cms_cons:Enter%></a>
<div class="center"> <%e_cms_cons:Or%> </div>
<a href="/<%iif::language,UA,UA,RU%>/registration.html" class="button"><%iif::language,UA,Реєстрація, Регистрация%> </a>


<div id="main_internal_content_center_block_info">
    <%include:page_error%>

    <%include:ap_ajax_selectors%>

    <script type="text/javascript" src="<%:EE_HTTP%>js/respondent.js"></script>


    <div class="flash">
        <%media_insert:flash,registration_form%>
    </div>


