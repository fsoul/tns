				<tr bgcolor="#ebebeb" class="table_header">
					<td colspan="2">&nbsp;&nbsp;XITI attributes</td>
				</tr>
				<tr>
					<td width="100">Xiti&nbsp;Click&nbsp;Type:
					</td>
					<td>
					<select name="xitiClickType" id="xitiClickType" style="width:100px;">
						<option value="">(none)</option>
						<option value="E">Exit</option>
						<option value="N">Navigation</option>
						<option value="T">Download</option>
					</select>
					<script type="text/javascript">
						var selector = document.getElementById("xitiClickType");
						for(i=0;i<selector.options.length;i++)
							if (selector.options[i].value=="<%:xitiClickType%>")
								selector.options[i].selected=true;
					</script>
					</td>
				</tr>
				<tr>
					<td width="100">Xiti&nbsp;S2:
					</td>
					<td>
						<input id="xitiS2" name="xitiS2" style="width:100%;" value="<%:xitiS2%>" type="text" />
					</td>
				</tr>
				<tr>
					<td width="100">Xiti&nbsp;Label:
					</td>
					<td>
						<input id="xitiLabel" name="xitiLabel" style="width:100%;" value="<%:xitiLabel%>" type="text" />
					</td>
				</tr>
