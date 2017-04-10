<%include:header%>
<%parse_catalog_to_html:get_product_menu,templates/eshop/product_type_list_row%>
<%parse_catalog_to_html:<%iif::gid,,,get_subgroup_info%>,templates/eshop/product_list_row,sid => <%:gid%>,language => <%:language%>%>
<%include:footer%>