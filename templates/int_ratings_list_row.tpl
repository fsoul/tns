<!--
<%text_edit_page_cms:int_h_class%>
<div class="int_h color_<%page_cms:int_h_class%>">
    <%text_edit_cms_cons:list%>
    <a name="<%cms_cons:list%>" >
        <div class="int_h_text">
            <%e_cms_cons:Ratings%>
        </div>
    </a>
</div>
-->
<div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
        <div>
<%row%

<div class="news_row_other">

  <div class="news_content">
    <div class="date"><%date:d.m.Y,:investigation_date%></div>
    <div class="title"><a href="<%ap_ratings_detail_link::investigation_id,<%page_cms:ratings_section%>%>"><%:investigation_title%></a></div>
    <div class="preview"><%:investigation_preview%></div>
  </div>

  <%iif::row_num,:rows_total,,<div class="separator"></div>%>

</div>

%row%>

        </div>
    </div>
</div>
<%text_edit_page_cms:int_b_class%>
