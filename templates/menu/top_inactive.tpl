<li>
<%iif:<%getValueOf:menu_item_code%>,you_are_logged_as,<span>,<a href="<%getValueOf:link%>" <%getValueOf:open%>>%><%getValueOf:label%><%iif:<%getValueOf:menu_item_code%>,you_are_logged_as,</span>,</a>%>

<%iif:<%getValueOf:menu_item_code%>,you_are_logged_as,&nbsp;&nbsp;<a href="<%get_href:37%>"><%ap_get_respondent_email%></a>%>
</li>
