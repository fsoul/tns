<%row%
<div class="product-list-box">
	<a href="<%:EE_HTTP%>index.php?t=eshop/prod_detail&pid=<%:id%>&language=<%:language%>">
        <img src="<%:img3%>" alt="<%:product_name%>" border="0" class="thumb"/>
	</a>
        <span>
	<strong class="rating">
	<%include:<%iif:<%config_var:is_can_buy%>,1,eshop/minicart%>%>
	</strong>
	<a href="<%:EE_HTTP%>index.php?t=eshop/prod_detail&pid=<%:product_id%>&language=<%:language%>" class="more">
		<%edit_cms:cms_prod_more%><%cms:cms_prod_more%>
	</a>
	<%include:<%iif:<%config_var:is_can_buy%>,1,eshop/price%>%>
	<strong><%:product_name%></strong>
	<br /><%:article%><br />
        </span>
</div>
%row%>
