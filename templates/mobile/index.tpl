<%include:header%>
<div role="main">
    <div>

      <div class="c-feature entry-point home grid-4">
          <img alt="" src="/img/c-feature-icon-crowd.jpg"/>
    <%text_edit_page_cms:index_block_1_title%>
    <%text_edit_page_cms:index_block_1_title_for_authorized%>
        <h2>
        <%page_cms:index_block_1_title<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
    </h2>

    <div class="top">

      <div class="content">
<%longtext_edit_cms:index_block_1_top<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
<%cms:index_block_1_top<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
      </div>
    </div>

    <div class="bottom">
      <div class="content" style="overflow: hidden;">
<%include:<%iif:<%ap_is_respondent_authorized%>,1,ap_account_state_on_index%>%>
<%e_cms:index_block_1_bottom<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
      </div>
    </div>

  </div>



  <div class="c-feature entry-point home grid-4">
      <img alt="" src="/img/c-feature-icon-globe-wireframe.jpg"/>
      <%text_edit_page_cms:index_block_2_title%>
    <h2>
        <%page_cms:index_block_2_title%>
    </h2>

    <div class="top">
      <div class="content">
<%longtext_edit_cms:index_block_2_top%>
<%cms:index_block_2_top%>
      </div>
    </div>

    <div class="bottom">
      <div class="content" style="overflow: hidden;">
<%ap_homepage_news_list:2%>
<%text_edit_cms_cons:Read all last news%>
        <a href="<%get_href:news%>" class="system_button"><%cms_cons:Read all last news%></a>
      </div>
    </div>

  </div>



  <div  class="c-feature entry-point home grid-4">
      <img alt="" src="/img/c-feature-icon-cubes-growth.jpg"/>
      <%text_edit_page_cms:index_block_3_title%>
      <%text_edit_page_cms:index_block_3_title_for_authorized%>
    <h2>
        <%page_cms:index_block_3_title<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
    </h2>

    <div class="top">
      <div class="content">
<%longtext_edit_cms:index_block_3_top<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
<%cms:index_block_3_top<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
      </div>
    </div>

    <div class="bottom">
      <div class="content" style="overflow: hidden;">
<%include:<%iif:<%ap_is_respondent_authorized%>,1,last_projects_on_homepage%>%>
<%e_cms:index_block_3_bottom<%iif:<%ap_is_respondent_authorized%>,1,_for_authorized%>%>
      </div>
    </div>

  </div>

</div>


<div class="a-feature entry-point grid-12">
    <%text_edit_page_cms:index_block_4_title%>
<h2>
    <%page_cms:index_block_4_title%>
</h2>
<%e_cms:index_block_4%>
</div>

</div>


<%include:footer%>
