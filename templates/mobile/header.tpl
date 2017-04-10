<%include:head%>
<div id="iPageOutline">
<header>
    <div class="row">
        <div class="block90">
            <div class="lang">
                <span class="lang-item">
                    <%iif::language,UA,UA,RU%>
                </span>
                <div class="lang-drop">
                    <a class="lang-href" href="<%get_href::t,UA%>">UA</a>
                    <a class="lang-href" href="<%get_href::t,RU%>">RU</a>
                </div>
            </div>
            <h1 class="logo block25">
                <a href="/" title="TNS"><img src="/img/tns-logo.jpg" alt="TNS"></a>
            </h1>
            <!--<ul class="language block75">
                <li class="block50 right <%iif::language,UA,active%>"><a href="<%get_href::t,UA%>"><%e_cms_cons:Ukr%></a></li>
                <li class="seperator"></li>
                <li class="block50 <%iif::language,RU,active%>"><a href="<%get_href::t,RU%>"><%e_cms_cons:Rus%></a></li>
            </ul>-->
        </div>
        <!--<%*//fix_bug_opera_mini%>-->
        <!--<ul class="navigation">
            <%get_menu_level:10,1,templates/menu/top_active.tpl,templates/menu/top_inactive.tpl,templates/menu/top_separator.tpl,<%ap_is_respondent_authorized%>%>
            <%include:<%iif:<%ap_is_respondent_authorized%>,0,forgot_password_link%>%>
            <li>
                <form class="log-<%iif:<%ap_is_respondent_authorized%>,0,in,out%>" name="header_login" action="<%get_href:Authorization%>" method="post" autocomplete="off">
                    <%include:ap_respondent_log<%iif:<%ap_is_respondent_authorized%>,0,in,out%>_form%>
                </form>
            </li>
        </ul>-->

        <div class="block10">
            <div>
                <div id="menu-toggle-show"></div>
            </div>
        </div>
    </div>
    <div id="main-menu" class="clearfix">
        <div id="menu-toggle-hide"></div>
        <ul class="menu" id="nav1">
            <%get_menu_level:100,1,templates/menu/tabs_active.tpl,templates/menu/tabs_inactive.tpl,,<%ap_is_respondent_authorized%>%>
        </ul>
        <ul class="menu" id="nav2">
            <%get_menu_level:100,2,templates/menu/tabs_active.tpl,templates/menu/tabs_inactive.tpl,,<%ap_is_respondent_authorized%>%>
        </ul>
    </div>

    <script>
    (function(){
        $('#nav2').appendTo('#nav1 .here');

        var $toggleShow = $('#menu-toggle-show'),
                $menu = $('#main-menu'),
                 $toggleHide = $('#menu-toggle-hide');
        $toggleShow.on('click', function () {
            $toggleShow.hide();
            $menu.show();
            $toggleHide.show();
        });
        $('#menu-toggle-hide').on('click', function () {
            $toggleShow.show();
            $menu.hide();
            $toggleHide.hide();
        });
    })();

    </script>
</header>