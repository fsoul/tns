<%row%
<div class="news_row">
  <!--<div class="news_img"><%iif:<%:news_img%>,,,<img width="50" src="<%:EE_HTTP_PREFIX%>usersimage/<%:news_img%>" alt="" title="" />%></div>
  -->

  <div class="news_content">
    <div class="date"><%date:d.m.Y,:news_date%></div>
    <div class="title"><a href="<%ap_news_detail_link::news_id%>"><%:news_title%></a></div>
    <div class="preview"><%:news_preview%></div>
  </div>

</div>
%row%>

