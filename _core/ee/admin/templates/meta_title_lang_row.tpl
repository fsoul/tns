<%iif:<%:object%>,1,<%setValueOf:meta_var,obj_%>%>
<%row%
	<br />
	<br/>
	Default value (<%:r_lang%>):
	<br/>
	<textarea style="width:300px" name="meta_tag_name_new_value_<%:r_lang%>"><%iif::meta_tag_name_new_value_<%:r_lang%>,,<%tpl_escape_coma:<%cms:default_<%:meta_var%><%:meta_tag_name%>,,<%:r_lang%>,1,1,0,0%>%>%></textarea>
%row%>