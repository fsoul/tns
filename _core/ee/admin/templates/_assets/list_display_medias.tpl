<td width="10">&nbsp;</td>
<td nowrap><%:ASSETS_GROUP_BY%>&nbsp;</td>
<td nowrap id="group_by_buttons">
<script type="text/javascript">
	//	"contentready" event handler for the "filter_buttons" container
	YAHOO.util.Event.onContentReady("filter_buttons", function () {

		// create buttons
		var groupByButton = new YAHOO.widget.Button("group_by_button", { type: "split", menu: "view_media_list" });
		var filterButton = new YAHOO.widget.Button("filter_button", { type: "split", menu: "filter_media_list" });

		// get userAgent and convert in to lowercase
		var ua = navigator.userAgent.toLowerCase();

		// click event listener for buttons
		var onGroupByButtonClick = function (p_sType, p_aArgs) {
			var oEvent = oMenuItem = p_aArgs[1];
			if (oMenuItem) {
				setDisplayMedia(oMenuItem.value);
			}
			if(ua.indexOf("safari") == -1)
				groupByButton.set("label", oMenuItem.cfg.getProperty("text"));
		};
		
		var onFilterButtonClick = function (p_sType, p_aArgs) {
			var oEvent = oMenuItem = p_aArgs[1];
			if (oMenuItem) {
				setDisplayMedia(oMenuItem.value);
			}
			if(ua.indexOf("safari") == -1)
				filterButton.set("label", oMenuItem.cfg.getProperty("text"));
		};
		
		//	Add a "click" event listener for the buttons
		groupByButton.getMenu().subscribe("click", onGroupByButtonClick);
		filterButton.getMenu().subscribe("click", onFilterButtonClick);
		
		//set selected values of buttons
		if("<%cookie:_assets_display_medias%>" == "") {
			groupByButton.set("label", "<%:ASSETS_GROUP_BY_TREE%>");
		} else {
			groupByButton.set("label", "<%:ASSETS_GROUP_BY_PLAIN%>");
		}
		switch ("<%cookie:_assets_display_medias%>") {
			case "pages":
				filterButton.set("label", "<%:ASSETS_FILTER_PAGES%>");
			break;
			case "medias":
				filterButton.set("label", "<%:ASSETS_FILTER_MEDIAS%>");
			break;
			case "all":
			default:
				filterButton.set("label", "<%:ASSETS_FILTER_ALL%>");
			break;
		}
	});
</script><input type="button" id="group_by_button" name="group_by_button" value="<%:ASSETS_GROUP_BY_TREE%>">
<select name="view_media_list" id="view_media_list">
	<option value=""><%:ASSETS_GROUP_BY_TREE%></option>
	<option value="all"><%:ASSETS_GROUP_BY_PLAIN%></option>
</select></td>
<td width="10">&nbsp;</td>
<td nowrap><%:ASSETS_FILTER%>&nbsp;</td>
<td nowrap id="filter_buttons"><input type="button" id="filter_button" name="filter_button" value="<%:ASSETS_FILTER_ALL%>">
<select name="filter_media_list" id="filter_media_list">
	<option value="all"><%:ASSETS_FILTER_ALL%></option>
	<option value="pages"><%:ASSETS_FILTER_PAGES%></option>
	<option value="medias"><%:ASSETS_FILTER_MEDIAS%></option>
</select></td>