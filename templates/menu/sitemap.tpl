<div class="menu_sitemap code_<%:code%>">
  <div class="menu_level_1">
    <a href="<%getValueOf:link%>" <%getValueOf:open%>><%getValueOf:label%></a>
  </div>

  <div class="submenu_sitemap">
    <%get_menu_level:100,2,templates/menu/sitemap2.tpl,templates/menu/sitemap2.tpl,,<%ap_is_respondent_authorized%>,,,<%:sat%>%>
  </div>

</div>

<div class="menu_sitemap_bottom">
</div>
