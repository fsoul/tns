<%include:test_cmeter_head%>

<!-- page_id: <%:t%> -->
<!-- page_template: <%:page_file%> -->


<div id="common">

  <div id="langs_list_block">
    <div id="langs_list">
<%text_edit_cms:display_header_langs_list%>
<%include:<%iif:<%cms:display_header_langs_list%>,disabled1,,header_langs_list%>%>
    </div>
  </div>

  <span id="header_forgot_password_link">
<%include:<%iif:<%ap_is_respondent_authorized%>,0,forgot_password_link%>%>&nbsp;
  </span>

  <div id="common1">


   <div id="header_bg">
    <div id="header">
      <div id="header_menu">
        <div id="header_menu_top_form_login">


<form name="header_login" action="<%get_href:Authorization%>" method="post" autocomplete="off">
<span id="menu_top_block">
<%get_menu_level:10,1,templates/menu/top_active.tpl,templates/menu/top_inactive.tpl,templates/menu/top_separator.tpl,<%ap_is_respondent_authorized%>%>
</span>

<%include:ap_respondent_log<%iif:<%ap_is_respondent_authorized%>,0,in,out%>_form%>

</form>


        </div><!-- id="header_menu_top_form_login" -->

        <div id="header_menu_tabs">
<%get_menu_level:100,1,templates/menu/tabs_active.tpl,templates/menu/tabs_inactive.tpl,,<%ap_is_respondent_authorized%>%>
        </div><!-- id="header_menu_tabs" -->

      </div><!-- id="header_menu" -->
<%text_edit_cms_cons:Go to Home page%>
      <%iif:<%:page_file%>,index,,<a id="a_logo" href="<%:EE_HTTP%>"><img src="<%:EE_HTTP%>img/inv.gif" width="70" height="70" id="header_logo" alt=""  title="<%cms_cons:Go to Home page%>" /></a>%>

    </div><!-- id="header" -->
   </div><!-- id="header_bg" -->

    <div id="common2">
    <div id="common3">

      <div id="main">
