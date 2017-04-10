
<%row%

<div class="news_row_other">

  <div class="news_content">
    <div class="date"><%date:d.m.Y,:investigation_date%></div>
    <div class="title"><a href="<%ap_investigation_detail_link::investigation_id%>"><%:investigation_title%></a></div>
    <div class="preview"><%:investigation_preview%></div>
  </div>

  <%iif::row_num,:rows_total,,<div class="separator"></div>%>

</div>

%row%>

