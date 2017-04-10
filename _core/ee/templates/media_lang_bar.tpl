<%row%
<tr><td bgcolor="#ebebeb" colspan="2" height="5">&nbsp;&nbsp;<b>Language: <%:lang_name%> <%iif:<%:lang_defalut%>,1,(default)%></b></td></tr>
<%include:media_lang_<%iif:<%:image_name%>,0,upload_field,show%>%>
<%include:<%iif:<%:media_type%>,images,media_lang_img_row%>%>
%row%>