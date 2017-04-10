
<%row%

<div class="news_row_other">

  <div class="news_content">
    <div class="date"><%date:d.m.Y,:news_date%></div>
    <div class="title"><a href="<%ap_news_detail_link::news_id%>"><%:news_title%></a></div>
    <div class="preview"><%:news_preview%></div>
  </div>

  <%iif::row_num,:rows_total,,<div class="separator"></div>%>

</div>

%row%>
