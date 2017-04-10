<%parse_sql_to_html:
	select * from (<%create_sql_view_by_name:<%:object_name%>,1%>) v where v.record_id = <%:object_id%> and v.gallery_id = <%get_image_gallery_id:<%:object_id%>,<%:object_name%>%>,gallery_view_image%>   

<%parse_sql_to_html:
	select * from (<%create_sql_view_by_name:<%:object_name%>,1%>) v where v.gallery_id = <%get_image_gallery_id:<%:object_id%>,<%:object_name%>%> limit <%gallery_get_image_page:<%getField:select * from (<%create_sql_view_by_name:<%:object_name%>,1%>) v where v.gallery_id = <%get_image_gallery_id:<%:object_id%>,<%:object_name%>%> limit 0\,1%>,<%:object_id%>, <%:gallery_id%>, 3%>\,3,gallery_navigator_images%>

<%gallery_navigator_links:
	<%getField:select * from (<%create_sql_view_by_name:<%:object_name%>,1%>) v where v.gallery_id = <%get_image_gallery_id:<%:object_id%>,<%:object_name%>%> limit 0\,1%>,
	<%getField:select * from (<%create_sql_view_by_name:<%:object_name%>,1%>) v where v.gallery_id = <%get_image_gallery_id:<%:object_id%>,<%:object_name%>%> limit <%getField:select count(*)-1 from (<%create_sql_view_by_name:<%:object_name%>,1%>) v%>\,1%>,
	<%:object_id%>,
	<%getField:select count(*) from (<%create_sql_view_by_name:<%:object_name%>,1%>) v where v.gallery_id = <%get_image_gallery_id:<%:object_id%>,<%:object_name%>%>%>,
3,
<%:record_id%>,
<%:gallery_id%>%>

