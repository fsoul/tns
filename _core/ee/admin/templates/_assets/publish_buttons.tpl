<td width="10">&nbsp;</td>
<td nowrap><%:ASSETS_DRAFT_MODE%>:&nbsp;</td>
<td nowrap>
<script type="text/javascript">
	//	"contentready" event handler for the "draft_mode_buttons" container
	YAHOO.util.Event.onContentReady("draft_mode_buttons", function () {

		// create buttons
		var publishButton = new YAHOO.widget.Button("publish_button", { type: "split", menu: "publish_button_select" });
		var revertButton = new YAHOO.widget.Button("revert_button", { type: "split", menu: "revert_button_select" });

		// click event listener for buttons
		var onDraftButtonClick = function (p_sType, p_aArgs) {
			var oEvent = p_aArgs[0], // DOM event
			oMenuItem = p_aArgs[1];	// MenuItem instance that was the target of the event
			if (oMenuItem) {
				// sample
				//alert("[MenuItem Properties] text: " + oMenuItem.cfg.getProperty("text") + ", value: " + oMenuItem.value);
				switch(oMenuItem.value) {
				// Publish
					case "1"://All
						if(confirm("<%:ASSETS_PUBLISH_ALL_CAPTION%>")) {
							location.href = "<%:modul%>.php?op=publish_all";
						}
					break;
					case "2"://Page-independent
						if(confirm("<%:ASSETS_PUBLISH_INDEPENT_CAPTION%>")) {
							location.href = "<%:modul%>.php?op=publish_common";
						}
					break;
					case "3"://Selected
							selected_rows_submit('publish_sel_items','<%:ASSETS_PUBLISH_SELECTED_CAPTION%>');
					break;
				// Revert
					case "4"://All
						if(confirm("<%:ASSETS_REVERT_ALL_CAPTION%>")) {
							location.href = "<%:modul%>.php?op=revert_all";
						}
					break;
					case "5"://Page-independent
						if(confirm("<%:ASSETS_REVERT_INDEPENT_CAPTION%>")) {
							location.href = "<%:modul%>.php?op=revert_common";
						}
					break;
					case "6"://Selected
						selected_rows_submit('revert_sel_items','<%:ASSETS_REVERT_SELECTED_CAPTION%>');
					break;
				}
			}
		};
		
		//	Add a "click" event listener for the buttons
		publishButton.getMenu().subscribe("click", onDraftButtonClick);
		revertButton.getMenu().subscribe("click", onDraftButtonClick);
	});
</script>
<div id="draft_mode_buttons"><input type="button" id="publish_button" name="publish_button" value="Publish">
	<select id="publish_button_select" name="publish_button_select">
		<option value="1" title="<%:ASSETS_PUBLISH_ALL_TITLE%>"><%:ASSETS_DRAFT_ALL%></option>
		<option value="2" title="<%:ASSETS_PUBLISH_INDEPENT_TITLE%>"><%:ASSETS_DRAFT_INDEPENT%></option>
		<option value="3" title="<%:ASSETS_PUBLISH_SELECTED_TITLE%>"><%:ASSETS_DRAFT_SELECTED%></option>                
	</select><input type="button" id="revert_button" name="revert_button" value="Revert">
	<select id="revert_button_select" name="revert_button_select">
		<option value="4" title="<%:ASSETS_REVERT_ALL_TITLE%>"><%:ASSETS_DRAFT_ALL%></option>
		<option value="5" title="<%:ASSETS_REVERT_INDEPENT_TITLE%>"><%:ASSETS_DRAFT_INDEPENT%></option>
		<option value="6" title="<%:ASSETS_REVERT_SELECTED_TITLE%>"><%:ASSETS_DRAFT_SELECTED%></option>                
	</select></div>
</td>