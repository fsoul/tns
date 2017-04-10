<%row%
<input type="radio" name="group_access" value="<%:option_value%>" <%iif:<%:option_value%>,<%:option_value_test%>,checked="checked"%> <%iif::op,3,<%iif::option_value,1,checked="checked"%>,%> onclick="check_access_mode('<%:option_value%>')" /><%:option_text%><br />
%row%>