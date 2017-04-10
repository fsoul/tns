<%parse_sql_to_html:
SELECT distinct v1.gallery_title\, (SELECT v2.record_id FROM (<%create_sql_view_by_name:gallery_image,1%>) as v2 WHERE v2.gallery_id = v1.gallery_id limit 0\,1) as image_id 
FROM (<%create_sql_view_by_name:gallery,1%>) as v1,gallery_list%>