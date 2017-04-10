<%row%
        <div class="tns_news_block_body_content_date">
          <%date:d.m.Y,:news_date%>
        </div>
        <div class="tns_news_block_body_content_title">
          <a href="<%ap_news_detail_link::news_id%>"><%:news_title%></a>
        </div>
        <div class="tns_news_block_body_content_preview">
          <%:news_preview%>
        </div>
        <%iif::row_num,:rows_total,,<div class="tns_news_block_body_content_separator"></div>%>
%row%>
