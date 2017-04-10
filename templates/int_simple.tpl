<%include:header_internal%>

<%edit_page_cms:internal_page_content%>
<%iif:<%page_cms:internal_page_content%>,,,
<div class="simple_top">
  <div class="simple_bottom">
    <div class="simple_content">%>
<%page_cms:internal_page_content%>
<%iif:<%page_cms:internal_page_content%>,,,
    </div>
  </div>
</div>
%>


<%include:footer_internal%>
