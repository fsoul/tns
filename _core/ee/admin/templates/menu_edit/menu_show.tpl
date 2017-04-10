<tr><td><%:im_type%> image: </td>
<td><div style="width:272px; text-align:center;">
<input type="submit" name="delete_img_<%:im_type%>" value="." style="float:right; cursor:hand; background-image:url(<%:EE_HTTP%>img/delBt.gif);padding:0px;width:16px;margin:0px;border:0;color:#ffffff;" onclick="return confirm('Are You sure want to delete <%:im_type%> menu image?')"/>
<img src="<%:EE_HTTP%>img/camera.gif" onmouseover="ddrivetip('<img src=<%:EE_HTTP_SERVER%><%cms:menu_<%get:menu_id%>_picture_<%:im_type%>_<%:item_id%>,,<%getValueOf:lang%>%> />')" onmouseout="hideddrivetip()"/>
<input type="file" name="nfile_<%:im_type%>">
</div></td></tr>