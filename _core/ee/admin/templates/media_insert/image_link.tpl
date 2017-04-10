			<!--table width = "434" border="0" cellpadding="0" cellspacing="0"-->
				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Images:</b></td>
				</tr>
				<tr>
					<td style="height: 21px;">&nbsp;Title&nbsp;(<%:language%>):</td>
					<td colspan="2">
						<input type="text" name="media_title" value="<%getValueOf:media_title%>" />
					</td>
				</tr>

				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Image link:</b></td>
				</tr>
				<tr>
					<td colspan="2" aligh="right" valign="middle" style="height: 21px;">
						<input type="radio" name="open_none" onClick="javascript:edit_current('open_none')"><label for="open_none">None</label>
					</td>
				</tr>
				<tr>
					<td aligh="right" valign="middle" style="height: 21px;">
						<input type="radio" name="open_url" onClick="javascript:edit_current('open_url')"><label for="open_url">URL</label>
					</td>
					<td>
						<input type="text" name="f_url_text" value="<%iif:<%:url_syntax_error%>,,<%:url_text%>,<%:f_url_text%>%>" style="width:272" size="50">
						<%iif::url_syntax_error,,,<br/><span class="error"><%:URL_SYNTAX_WARNING%></span>%>
					</td>
				</tr>
				<tr>
					<td valign="middle" style="height: 21px;">
						<input type="radio" name="open_sat_page" onClick="javascrip:edit_current('open_sat_page')"><label for="open_sat_page"><%:SATELLITE_PAGE%></label>
					</td>
					<td>
						<%get_satelite_list:330,<%:image_sat%>%>
						<script>edit_current('<%:image_link%>');</script>
					</td>
				</tr>
				<tr bgcolor="#ebebeb" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Open type</b></td>
				</tr>
				<tr>
					<td width="100">&nbsp;</td>
					<td>
						<select name="open_type" style="width:272px;">
							<option value="self" <%getValueOf:open_same%>>Same window</option>
							<option value="_blank" <%getValueOf:open_new%>>New window</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<%include:<%iif:<%constant:EE_LINK_XITI_ENABLE%>,1,xiti_form_attributes,%>%>
					</td>
				</tr>
			<!--/table-->
