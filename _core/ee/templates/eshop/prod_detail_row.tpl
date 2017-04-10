<%row%
<div id="prod-detail2-content">
<a href="#"><img src="<%:img2%>" alt="<%:product_name%>" border="0" onclick="openWin('<%:img%>',500,600)"/></a>
<h3><span class="prodprice"><%iif:<%config_var:is_can_buy%>,1,<%:prod_price%>%></span><%getValueOf:product_name%></h3>
<%:prod_description%>&nbsp;
</div>
%row%>