<%row%&nbsp;<input id="content_access_<%:option_value%>" type="radio" name="content_access" value="<%:option_value%>" <%iif:<%:option_value%>,<%:option_value_test%>,checked="checked"%> <%iif::op,3,<%iif::option_value,1,checked="checked"%>%>  <%iif:<%:role%>,2,,disabled="disabled"%> /><%:option_text%><br />
%row%>