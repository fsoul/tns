<%row%
	<option <%iif::op,1,<%iif:<%:lang_code%>,<%:language_code%>,selected="selected"%>,<%iif::default_language,1,selected="selected"%>%> value="<%:language_code%>"><%:language_name%> <%iif::default_language,1, (default)%></option>	
%row%>