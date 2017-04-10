<%row%
	<option <%iif::sel_t_view,:id,selected="selected",,%><%iif::sel_t_view,,<%iif::view_folder,<%db_constant:DEFAULT_TPL_VIEW_FOLDER%>,selected="selected",%>%> value="<%:id%>"><%:view_name%> <%iif::view_folder,<%db_constant:DEFAULT_TPL_VIEW_FOLDER%>, (default)%></option>
%row%>