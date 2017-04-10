

<%row%
				<div id="page_header">
<%:news_title%>
				</div>
				
				<div id="main_internal_content_center_block_info">
					<div id="page_comment">
<%:news_preview%>
					</div>
		

<div class="news_detail_top">
  <div class="news_detail_bottom">
    <div class="news_detail_content">
<%iif:<%:news_img%>,,,<img align="left" src="<%:EE_HTTP_PREFIX%>usersimage/<%:news_img%>" />%>
      <div class="date">
        <%date:d.m.Y,:news_date%>
      </div>
      <%:news_content%>
    </div>
  </div>
</div>


%row%>