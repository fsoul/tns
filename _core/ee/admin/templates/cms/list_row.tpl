<%row%
<input type="hidden" name="cms_name[]" value="<%getValueOf:cms_name%>">
	<tr>
		<td align="left" width="50%" height="30" colspan="2">
			&nbsp;&nbsp;
			<span><%:short_desc%></span>
			<input type="text" style="display: none" value="<%:short_desc%>" name="aFieldShortDesc[]" id="aFieldShortDesc" size="30">
			<%iif:<%show_admin_panel%>,,,
				<input type="button" value="Save" size="30" class="button" style="display: none" onclick="edit_short_descr(this.parentNode\,1)">
				<img height="24" width="24" border="0" align="top" alt="" onclick="edit_short_descr(this.parentNode)" style="cursor: pointer" src="<%:EE_HTTP%>img/pen24.gif"/>
			%>
			<img onMouseOver="clearTimeout(tm1); view_full_descr_tip('<%getValueOf:cms_name%>')" onMouseOut="tm1 = setTimeout('hideddrivetip()',600)" height="24" width="24" border="0" align="top" alt="" src="<%:EE_HTTP%>img/help24.gif"/>
			<input type="hidden" value="<%:full_desc%>" name="aFieldFullDesc[]" id="<%getValueOf:cms_name%>_full_desc" size="30">
		</td>
	</tr>
	<tr>
		<td colspan="3" bgcolor="#092869"><%inv:1,1%></td>
	</tr>
	<tr bgcolor="#EFEFDE" class="table_header">
		<td colspan="3" align="center">
<div
	id="fck_current_language"
	<%iif:<%:lang%>,<%:default_language%>,,<%iif:<%:not_null_current_language_content_var_count%>,1,,style="display:none"%>%>
>
	<%:big_cms_field%>
</div>

<%iif:<%:lang%>,<%:default_language%>,,<div
	id="fck_default_language"
	<%iif:<%:not_null_current_language_content_var_count%>,1,style="display:none",%>
>
	<%:big_cms_field_for_default_language%>
</div>%>
		</td>
	</tr>
	<tr>
		<td colspan="3" bgcolor="#EFEFDE"><%inv:1,5%></td>
	</tr>
%row%>

