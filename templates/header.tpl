<%include:head%>

<!-- page_id: <%:t%> -->
<!-- page_template: <%:page_file%> -->
<!--<%ap_get_respondent_id%> -->
<div id="iPageOutline" class="container container-12">
    <header class="primary grid-12">
        <h1 class="logo">
            <a href="/" title="TNS"><img src="/img/tns-logo.jpg" alt="TNS"></a>
        </h1>
        <ul class="navigation">
            <%get_menu_level:10,1,templates/menu/top_active.tpl,templates/menu/top_inactive.tpl,templates/menu/top_separator.tpl,<%ap_is_respondent_authorized%>%>
            <%include:<%iif:<%ap_is_respondent_authorized%>,0,forgot_password_link%>%>
            <li>
                <form class="log-<%iif:<%ap_is_respondent_authorized%>,0,in,out%>" name="header_login" action="<%get_href:Authorization%>" method="post" autocomplete="off">
                    <%include:ap_respondent_log<%iif:<%ap_is_respondent_authorized%>,0,in,out%>_form%>
                </form>
            </li>
        </ul>
        <ul class="navigation">
            <li class="<%iif::language,UA,active%>"><a href="<%get_href::t,UA%>"><%e_cms_cons:Ukr%></a></li>
            <li class="seperator"></li>
            <li class="<%iif::language,RU,active%>"><a href="<%get_href::t,RU%>"><%e_cms_cons:Rus%></a></li>
        </ul>
        <%fix_bug_opera_mini%>
    </header>

