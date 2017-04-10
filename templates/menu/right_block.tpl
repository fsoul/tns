
<%setValueOf:color_code_h,<%<%iif:<%:title%>,,,page_%>cms:right_block_h_class_<%:code%>%>%>
<%setValueOf:color_code_b,<%<%iif:<%:title%>,,,page_%>cms:right_block_b_class_<%:code%>%>%>
<%setValueOf:menu_code,<%:code%>%>
<%setValueOf:menu_title,<%:title%>%>

<div class="container module">
      <h2><a href="<%getValueOf:link%>" <%getValueOf:open%>><%getValueOf:label%></a></h2>
      <div>
<%include:menu/right_block_<%iif:<%:menu_code%>,news,news,<%iif:<%:menu_code%>,plugin,<%iif:<%ap_pugin_may_download%>,1,plugin,content%>,content%>%>%>
      </div>

</div>

