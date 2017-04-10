<%include:header%>
<!--<%e_page_cms:archive_news%>
<%e_page_cms:draft_news%> -->
<br>
<br>
<%include_if:admin_template,yes,news_select_channel,%>
<%e_page_cms:rss_link%>
<%iif:<%:item%>,,<%get_news_published:<%:t%>,published_item%>,<%get_news_info:<%cms:page_channel_<%:t%>%>,<%:item%>,published_item_info%>%>
<%edit_page_cms:all_news_link%>
<%include:footer%>
