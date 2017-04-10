<%include_if:admin_template,yes,head,<%iif:<%:export_run%>,1,,sitemap_header%>%>
<urlset xmlns="http://www.google.com/schemas/sitemap/0.84" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:schemaLocation="http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/sitemap.xsd">
<%print_sitemap:sitemap_entry%>
</urlset>