<?xml version="1.0" encoding="<%getCharset%>"?>
<rss version="2.0">    

<channel>
<%parse_sql_to_html:   SELECT 
				FROM_UNIXTIME(news_channels.channel_pubDate\,\'%d-%m-%Y\') as channel_pubDate\,
				FROM_UNIXTIME(news_channels.channel_lastBuildDate\,\'%d-%m-%Y\') as channel_lastBuildDate\,
				news_channels.channel_title as channel_title\,
				news_channels.channel_webMaster as channel_webMaster\,
				news_channels.channel_link as channel_link\,
				news_channels.channel_managingEditor as channel_managingEditor\,
				news_channels.channel_generator as channel_generator\,
				news_channels.channel_docs as channel_docs\,
				news_channels.channel_description as channel_description\,
				news_channels.channel_language as channel_language				
				
			FROM			
                                (<%create_sql_view_by_name:news_channels,1%>) as news_channels 	
			WHERE news_channels.record_id = <%:channel_id%>,<%:EE_EXPORT_DIR%>export_channels_rss_2_0%>
<%row% 
    <item>
      <title><%:title%></title>
      <link><%:link%></link>
      <description><%:description%></description>
      <pubDate><%:pubDate%></pubDate>
      <guid><%:guid%></guid>
    </item>
%row%>
  </channel>
</rss>

