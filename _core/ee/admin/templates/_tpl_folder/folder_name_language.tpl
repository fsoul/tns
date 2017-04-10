<%row%
<%:language_name%>:<%iif::default_language,1,*%><br />
<input type="text" name="<%:field_name%>_<%:language_code%>" value="<%:<%:field_name%>_<%:language_code%>%>" size="<%:size%>" <%iif::op,3,,onchange="page_renamed = true;%>" /><br />
%row%>