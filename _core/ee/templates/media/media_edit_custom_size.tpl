				<tr>
					<td colspan="2">
						<input id="size_custom_ch" onclick="javascrip:edit_size('custom')" type="radio" name="image_size" value="custom">
						Custom size
						<div id="customsize" style="display:none">
							: 
							<input type="text" style="width:30px; font-weight:bold;" name="f_size_x" value="<%:size_x%>">
							 X 
							<input type="text" style="width:30px; font-weight:bold;" name="f_size_y" value="<%:size_y%>">
							<select name="f_size_unit_type" id="size_unit_type_selector" style="width:40px; font-weight:bold;">
							<option value="px" selected>px</option>
							<option value="%">%</option>
							</select>
							<script type="text/javascript">
							<!--
							var selector = document.getElementById("size_unit_type_selector");
							for(i=0;i<selector.options.length;i++) {
								if (selector.options[i].value=="<%:size_unit_type%>") {
									selector.options[i].selected=true;
								}
							}
							//-->
							</script>
						</div>
					</td>
				</tr>
				<script>edit_size('<%:size_default%>');</script>
