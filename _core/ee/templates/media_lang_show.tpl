<tr><td>URL: </td>
<td><div style="width:272px;">
<input type="submit" name="delete_img_<%:media_lang_code%>" value="." style="float:right; cursor:hand; background-image:url(<%:EE_HTTP%>img/delBt.gif);padding:0px;width:16px;margin:0px;border:0;color:#ffffff;" onclick="return confirm('Are You sure want to delete this media content?')"/>
<%include:media_lang_show_<%iif:<%:media_type%>,images,images,file%>%>
</div></td></tr>