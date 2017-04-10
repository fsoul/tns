<tr><td colspan="2">
<%row%
<div style="width: 50%; margin-right: -1px; float: left; padding-bottom: 10px;">
<input type="checkbox" name="group_<%:id%>" id="<%getClearUrl:<%:group_name%>%>" value="1" <%iif::group_1,1,checked="1",%> /> <%:group_name%>
</div>
%row%>
</td></tr>