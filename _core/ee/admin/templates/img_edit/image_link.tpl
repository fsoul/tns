				<tr bgcolor="#EFEFDE" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Image link:</b></td>
				</tr>
				<tr>
					<td aligh="right">
						<input type="radio" name="open_none" onClick="javascript:edit_current('open_none')"><label for="open_none">None</label>
					</td><td></td>
				</tr>
				<tr>
					<td aligh="right">
						<input type="radio" name="open_url" onClick="javascript:edit_current('open_url')"><label for="open_url">URL</label>
					</td><td>
						<input type="text" name="f_url_text" value="<%:url_text%>" style="width:272" size="50">
					</td>
				</tr>
				<tr>
					<td>
						<input type="radio" name="open_sat_page" onClick="javascrip:edit_current('open_sat_page')"><label for="open_sat_page"><%cons:SATELLITE_PAGE%></label>
					</td><td>
						<%get_satelite_list:272,<%:image_sat%>%>
						<script>edit_current('<%:image_link%>');</script>
					</td>
				</tr>
				<tr bgcolor="#ebebeb" class="table_header">
					<td colspan="2"><b>&nbsp;&nbsp;Open type</b></td>
				</tr>
				<tr>
					<td width="100"></td>
					<td>
						<select name="open_type" style="width:272">
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