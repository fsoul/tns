<input <%iif::readonly,,,readonly%> 

<%iif:<%:field_name%>,cachable,
	<%iif:<%is_tpl_cachable_by_page::id%>,,<%iif::op,3,,disabled="disabled"%>%>

%>
 type="checkbox" id="<%:field_name%>" name="<%:field_name%>" <%iif:<%:<%:field_name%>%>,1,checked,<%iif:<%:op%>,3,<%iif:<%:field_name%>,search,checked,cachable,checked%>%>%> value="1" />