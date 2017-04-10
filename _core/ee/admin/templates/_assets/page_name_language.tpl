<%row%
<%:language_name%>:<%iif::default_language,1,*%><br />
<input type="text" name="<%:field_name%>_<%:language_code%>" value="<%:<%:field_name%>_<%:language_code%>%>" size="<%:size%>" />
<span class="error"><%getError:<%:field_name%>_<%:language_code%>%></span>
<br />
%row%>