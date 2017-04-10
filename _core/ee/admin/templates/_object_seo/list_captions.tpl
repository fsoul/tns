<tr bgcolor="#eeeeee">
<%row%	
<td style="<%:col_style%>">&nbsp;</td>
<td style="<%:col_style%>" height="30" align="<%:caption_align%>"><%decode::field_num%>&nbsp;<a href="<%:modul%>.php?<%iif:<%:edit%>,,,edit=<%:edit%>&%>srt=<%getValueOf:srt%>&click=<%:field_num%>&op=0&load_cookie=true" class="table_header">
<span onMouseOver="clearTimeout(tm1); ddrivetip('<a href=\'#\' onclick=\'openWinMetaTitle(&quot;<%:field_name%>&quot;,true);return false;\' class=\'a_image\' style=\'display:inline;padding:0px; background-image:url();\'><img src=\'<%:EE_HTTP%>img/edit/doc_edit.gif\' alt=\'Edit meta title\' border=\'0\' ></a>&nbsp;<a href=\'#\' onclick=\'<%iif:<%tpl_in_array:<%:field_name%>,ar_meta_fixed%>,1,alert(&quot;Tag \&amp;#39;\&amp;#39;<%:caption%>\&amp;#39;\&amp;#39; is mandatory and could not be deleted&quot;); return false;%> if(confirm(confirm_del_msg)){ window.location = &quot;<%:EE_ADMIN_URL%><%:modul%>.php?op=meta_del&meta_del=<%:field_name%>&quot;;} else {return false;}\' style=\'display:inline;padding:0px; background-image:url();\' class=\'a_image\'><img src=\'<%:EE_HTTP%>img/edit/doc_delete.gif\' alt=\'<%iif:<%tpl_in_array:<%:field_name%>,ar_meta_fixed%>,1,Remove meta tag,Tag &quot;<%:caption%>&quot; is mandatory and could not be deleted%>\' border=\'0\'></a>&nbsp;<a href=\'#\' onclick=\'openWinMetaTitle(&quot;&quot;,true);return false;\' style=\'display:inline;;padding:0px; background-image:url();\' class=\'a_image\'><img src=\'<%:EE_HTTP%>img/edit/doc_add.gif\' alt=\'Add meta title\' border=\'0\' class=\'a_image\'></a>')" onMouseOut="tm1 = setTimeout('hideddrivetip()',500)"><%:caption%></span></a></td>
%row%>

	<td>&nbsp;</td>
	<td width="10%" align="center" class="table_header"><%cons:Action%></td>
</tr>
