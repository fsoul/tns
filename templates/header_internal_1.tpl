<%include:header%>
<div class="nav-bg">
    <nav  id="nav1" class="primary secondary-nav-active grid-12">
        <div>
            <ul class="menu">
                <%get_menu_level:100,1,templates/menu/tabs_active.tpl,templates/menu/tabs_inactive.tpl,,<%ap_is_respondent_authorized%>%>
            </ul>
        </div>
    </nav>
    <nav id="nav2" class="secondary grid-12">
        <div>
            <ul class="menu">
                <%get_menu_level:100,2,templates/menu/tabs_active.tpl,templates/menu/tabs_inactive.tpl,,<%ap_is_respondent_authorized%>%>
            </ul>
        </div>
    </nav>
</div>
            <div id="main">

		<div id="main_internal_content_" class="grid-8">


