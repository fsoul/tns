<%row%
	<li><input name="object_tpls[<%:object_id%>][]" type="checkbox" value="<%:tpl_id%>" onclick="select_object_by_tpl(this, '<%:object_id%>');" <%iif:<%check_exclude_object_by_tpl:<%:object_id%>,<%:tpl_id%>%>,1,checked%> /><%:file_name%></li>
%row%>