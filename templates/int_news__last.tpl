
<div class="int">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Last news 36.6%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">
      <div>

<%row%
<div class="news_row_last">
  <!--<div class="news_img"><%iif:<%:news_img%>,,,<img width="146" src="<%:EE_HTTP_PREFIX%>usersimage/<%:news_img%>" alt="" title="" />%></div>
  -->

  <div class="news_content">
    <div class="date"><%date:d.m.Y,:news_date%></div>
    <div class="title"><a href="<%ap_news_detail_link::news_id%>"><%:news_title%></a></div>
    <div class="preview"><%:news_preview%></div>
  </div>

</div>
%row%>

      </div>
    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>

