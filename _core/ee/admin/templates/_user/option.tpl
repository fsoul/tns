<%row%
<%setValueOf:user_temp_role,<%:option_value_test%>%>
<input type="radio" name="role" value="<%:option_value%>" <%iif:<%:option_value%>,<%:option_value_test%>,checked="checked"%> <%iif::op,3,<%iif::option_value,0,checked="checked"%>%> onclick="check_role('<%:option_value%>');<%iif:<%:option_value%>,3, storeValues('yes'); i_move('user_groups_sel'\, 'available_groups_sel'); changeSelectState('hide');, storeValues(); changeSelectState('show'); restoreValues();%>" /><%:option_text%><br />
<%iif::option_value,3,<br />%>
%row%>