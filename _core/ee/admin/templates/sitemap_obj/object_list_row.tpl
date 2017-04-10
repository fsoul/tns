<%row%
	<li id="object_<%:id%>" onclick="select_obj(this);"><input id="object_checkbox_<%:id%>" name="object_<%:id%>" type="checkbox" value="<%:id%>" onclick="select_object_tpl(this, '<%:id%>');" <%iif:<%check_exclude_object:<%:id%>%>,1,checked%> /><%str_to_title:<%:name%>%></li>
%row%>