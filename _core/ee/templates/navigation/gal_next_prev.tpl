<div id="navigation">
  <div id="prev">
    <%iif::is_gallery_first_item,1,&lt;&nbsp;Previous&nbsp;,<a href="<%:gallery_prev_item_link%>">&lt;&nbsp;Previous&nbsp;</a>%>|<%iif::is_gallery_last_item,1,&nbsp;Next&nbsp;&gt;,<a href ="<%:gallery_next_item_link%>">&nbsp;Next&nbsp;&gt;</a>%>
   </div>
</div>