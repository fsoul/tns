<br />
<b>Back office access for <span style="color:#f00"><%getField:SELECT login FROM users WHERE id=<%sqlValue:<%:edit%>%>,0%></span></b>
<div style="padding:10px 0px 0px 15px">
<%parse_sql_to_html:

 SELECT id as option_value\,
	role_name as option_text\,
	"<%:<%:field_name%>%>" as option_value_test
   FROM role ORDER BY sort_order ASC

,templates/<%:modul%>/option%>
<%iif:<%:user_temp_role%>,3,<script type="text/javascript">i_move('user_groups_sel'\, 'available_groups_sel'); storeValues(); changeSelectState('hide');</script>%>
<%include:hidden_input_instead_of_disabled_select%>
</div>