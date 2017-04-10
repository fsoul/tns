<script>
YAHOO.namespace("example.CustomFormatting");
YAHOO.util.Event.addListener(window, "load", init_yui_grid);
function init_yui_grid() {

	var Dom = YAHOO.util.Dom;
	var Cookie = YAHOO.util.Cookie;
	var additional_params = '';
	
	//Initializing container with loading message
	var myLoadingBar = new YAHOO.widget.Panel("wait", {width: "240px", fixedcenter: true, close: false, draggable: false, zindex:4, modal: true, visible: false});
	myLoadingBar.setHeader("Loading data, please wait...");
	myLoadingBar.setBody("<img src=\"<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>img/rel_interstitial_loading.gif\"/>");
	myLoadingBar.render(document.body);
	
	//Formatters of specific (action) columns
	<%paste:templates/yui/formatters/checkbox%>
	<%include:<%:modul%>/yui/formatters/edit_btn%>
	<%include:<%:modul%>/yui/formatters/del_btn%>
	<%include:<%:modul%>/yui/formatters/view_btn%>
	<%include:<%:modul%>/yui/formatters/image_preview_btn%>
	<%include:<%iif::modul,_user,yui/formatters/modules_list_btn,_tpl_folder,yui/formatters/modules_list_btn%>%>
	<%include:<%iif::modul,_user,yui/formatters/folder_access_btn%>%>
	<%include:<%iif::modul,_seo,yui/formatters/seo_preview_btn,_object_seo,yui/formatters/seo_preview_btn%>%>
	<%include:<%iif::modul,_object_seo,yui/formatters/object_link_btn%>%>
	<%include:<%iif::modul,_tpl_file,yui/formatters/tpl_preview_btn%>%>
	<%include:<%iif::modul,_formbuilder,yui/formatters/export_form_btn%>%>
	<%include:<%iif::modul,_formbuilder,yui/formatters/export_form_data_btn%>%>
	<%include:<%iif::modul,_formbuilder,yui/formatters/copy_form_btn%>%>
	<%include:<%iif::modul,_dns,yui/formatters/dns_cdn_server%>%>
	<%try_include:<%:modul%>/yui/formatters/custom_formatters%>
	
	// Column definitions
	var myColumnDefs = [
<%print_yui_captions:yes%>
		{key:"hidden_id",hidden:true}
	];
    
	// DataSource instance
	var myDataSource = new YAHOO.util.DataSource("<%:EE_HTTP%><%:EE_ADMIN_SECTION_IN_HTACCESS%><%:modul%>.php?"), myDTDrags = {};
	myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
	myDataSource.responseSchema = {
		resultsList: "records",
		fields: [
<%print_yui_captions%>
			{key:"hidden_id"}
		],
		metaFields: {
			totalRecords: "totalRecords",
			paginationRecordOffset : "startIndex",
			paginationRowsPerPage : "pageSize",
			sortKey: "sort",
			sortDir: "dir"
			}
	};
	
	//Paginator instance
	var myPaginator = new YAHOO.widget.Paginator({ 
		containers: "yui-dt0-paginator",
		template : "<table width='100%' cellspacing='0' cellpadding='3' border='0'><tr><td nowrap='1'>{CurrentPageReport}</td><td width='100%' align='center'>{FirstPageLink} {PreviousPageLink} {PageLinks} {NextPageLink} {LastPageLink}</td><td nowrap='1'>Rows on page:</td><td>{RowsPerPageDropdown}</td></tr></table>",
		rowsPerPageOptions: [10,20,50,70,100],
		pageReportTemplate : "Showing items {startRecord} - {endRecord} of {totalRecords}",
		pageLinks: 10
	});
	
	// DataTable configuration
	var myConfigs = {
		paginator : myPaginator,
		dynamicData : true,
		initialLoad : false
	};
	
	// DataTable instance
	var myDataTable = new YAHOO.widget.DataTable("dynamicdata", myColumnDefs, myDataSource, myConfigs);
	//var myDataTable = new YAHOO.widget.ScrollingDataTable("xyscrolling", myColumnDefs, myDataSource, {});
	
	//Hiding row with filters
	myDataTable.getTheadEl().childNodes[0].style.display='none';
	//Disable showing default DataTable loading message
	myDataTable.showTableMessage('', YAHOO.widget.DataTable.CLASS_LOADING);
	
	//Highlighting rows on mouse over event
	<%iif::modul,_object_seo,,_seo,,_alt_tags,,
		myDataTable.subscribe("rowMouseoverEvent"\, myDataTable.onEventHighlightRow);
		myDataTable.subscribe("rowMouseoutEvent"\, myDataTable.onEventUnhighlightRow);
	%>

	<%include:<%iif::modul,_gallery_image,yui/list_yui_dd_script%>%>
	
	//Handler of event when click on thead checkbox
	myDataTable.subscribe("theadCheckboxClickEvent", function(oArgs){
		var checkbox = myDataTable.getThLinerEl(oArgs.target).childNodes[0].childNodes[0];
		var oRecordSet = myDataTable.getRecordSet(oArgs.target);
		for (recordId=0; recordId<oRecordSet.getLength(); recordId++)
		{
			rowCheckbox = myDataTable.getPreviousTdEl(myDataTable.getLastTdEl(recordId)).childNodes[0].childNodes[0];
			if (!checkbox.checked || rowCheckbox.disabled == true)
			{
				myDataTable.unselectRow(recordId);
				rowCheckbox.checked = false;
			}
			else
			{
				myDataTable.selectRow(recordId);
				rowCheckbox.checked = true;
			}
		}
	});
	
	//Handler of event when click on checkbox of table row
	myDataTable.subscribe("checkboxClickEvent", function(oArgs){
		var oRecord = this.getRecord(oArgs.target);
		var checkbox = this.getTdLinerEl(oArgs.target).childNodes[0];
		if (!checkbox.checked)
		{
			myDataTable.unselectRow(oRecord.getId());
			myDataTable.getThLinerEl(myDataTable.getColumn('checkbox')).childNodes[0].childNodes[0].checked = false;
		}
		else
		{
			myDataTable.selectRow(oRecord.getId());
		}
	});	
	
	//Handler of event when click on thead action buttons
	myDataTable.subscribe("theadButtonClickEvent", function(oArgs){
		var action = this.getColumn(oArgs.target).getField();	
		if (action == 'del')
		{
			rows = this.getSelectedRows();
			del_rows(rows);
		}
		else if (action == 'edit')
		{
			var firstTr = this.getTheadEl().childNodes[0];
			showButton = this.getThLinerEl(oArgs.target).childNodes[0].childNodes[0];
			hideButton = this.getThLinerEl(oArgs.target).childNodes[0].childNodes[1];
			if (hideButton.style.display == 'none')
			{
				TableColumns = myDataTable.getColumnSet().keys;
				form_elements = document.checkbox_form.elements;
				var columns_width = new Array();
				for (i=0; i<TableColumns.length; i++)
				{
					//var j = search_in_form_elements('filter_'+TableColumns[i].key,form_elements);
					//if (j != -1)
					//{
						//old_width = parseInt(Dom.getStyle(form_elements[j],'width'));
						new_width = parseInt(Dom.getStyle(TableColumns[i].getThLinerEl(),'width'));	
						columns_width[i] = new_width;
						/*if (old_width > new_width)
						{
							form_elements[j].size = '';
						}
						else
						{
							new_width = old_width;
						}
						new_width = new_width > 300 ? 300 : new_width;
						Dom.setStyle(form_elements[j], 'width', new_width);*/
					//}
				}
				hideButton.style.display = 'inline';
				showButton.style.display = 'none';
				firstTr.style.display = '';
				for (i=0; i<TableColumns.length; i++)
				{
					var j = search_in_form_elements('filter_'+TableColumns[i].key,form_elements);
					if (j != -1)
					{
						old_width = parseInt(Dom.getStyle(form_elements[j],'width'));
						new_width = columns_width[i];	
						if (old_width > new_width)
						{
							form_elements[j].size = '';
						}
						else
						{
							new_width = old_width;
						}
						new_width = new_width > 300 ? 300 : new_width;
						Dom.setStyle(form_elements[j], 'width', new_width);
					}
				}
			}
			else
			{
				showButton.style.display = 'inline';
				hideButton.style.display = 'none';
				firstTr.style.display = 'none';
				document.checkbox_form.reset();
			}
		}
	});
	
	//Handler of event when click on action button of row
	myDataTable.subscribe("buttonClickEvent", function(oArgs){
		var oRecord = myDataTable.getRecord(oArgs.target); 
		var action = myDataTable.getColumn(oArgs.target).getField();
		if ('<%:modul%>' == '_object_content')
		{
			edit = '&edit='+oRecord.getData('object_field_id')+'&edit2='+oRecord.getData('object_record_id')+'&lang='+oRecord.getData('language');
		}
		else
		{
			edit = '&edit='+oRecord.getData('hidden_id');
		}
//TODO: Переделать на YAHOO.util.Connect		
		if (action == 'del')
		{
			del_rows(new Array(oRecord.getId()));
		}
		else if (action == 'edit')
		{
			openPopup("<%iif::modul,_object_seo,_"+oRecord.getData('object_name').toLowerCase()+",<%:modul%>%>.php?op=<%iif::modul,_mailing,4,1%>"+edit+"&admin_template=yes",<%:popup_width%>,<%:popup_height%>,<%:popup_scroll%>);
		}
		else if (action == 'folder_access')
		{
			openPopup("<%:modul%>.php?op=<%iif::modul,_tpl_folder,users_list,_user,set_dir_permissions%>"+edit+"&admin_template=yes",900,500,1);
		}
		else if (action == 'modules_list')
		{
			openPopup("<%:modul%>.php?op=moduls_list"+edit+"&admin_template=yes",900,<%:popup_height%>,1)
		}
		else if (action == 'image_preview')
		{
			var image_src = ('<%:modul%>' == '_gallery_image' ? '<%:EE_GALLERY_HTTP%>'+oRecord.getData('gallery_id')+'/'+oRecord.getData('image_filename') : oRecord.getData('image_preview'));
			openWin(image_src, 900, 700);
		}
	});
	
	//Handler of event when submit main form
	YAHOO.util.Event.on("checkbox_form", "submit", function(e) {
		add_param = '';
		myLoadingBar.setHeader("Applying filter, please wait...");
		YAHOO.util.Event.preventDefault(e);
		form = YAHOO.util.Event.getTarget(e);
		for (i=0; i<form.length; i++)
		{
			if (((form.elements[i].tagName == 'INPUT' && form.elements[i].type == 'text') || (form.elements[i].tagName == 'SELECT')) && form.elements[i].value != '' && form.elements[i].name.substring(0,7) == 'filter_')
			{
				add_param = add_param + '&' + form.elements[i].name + '=' + form.elements[i].value;
			}
		}
		
		additional_params = add_param;
		var newState = generateRequest(0, myDataTable.get("sortedBy").key, myDataTable.get("sortedBy").dir, myDataTable.get("paginator").getRowsPerPage());
		Cookie.set("<%:modul%>_DataTableState", newState);
		YAHOO.example.CustomFormatting.handleCookieNavigation('get_list');
	});
	
	//Handler of event when reset main form
	YAHOO.util.Event.on("checkbox_form", "reset", function(e) {
		YAHOO.util.Event.preventDefault(e);
		form = YAHOO.util.Event.getTarget(e);
		for (i=0; i<form.length; i++)
		{
			if ((form.elements[i].tagName == 'INPUT' && form.elements[i].type == 'text') && form.elements[i].name.substring(0,7) == 'filter_')
			{
				form.elements[i].value = '';
			}
			if (form.elements[i].tagName == 'SELECT' && form.elements[i].name.substring(0,7) == 'filter_')
			{
				form.elements[i].selectedIndex = 0;
			}
		}
		additional_params = '';
		YAHOO.example.CustomFormatting.handleCookieNavigation('get_list','')
	});
	
	YAHOO.example.CustomFormatting.DynamicData = {
		myPaginator  : myPaginator,
		myDataSource : myDataSource,
		myDataTable  : myDataTable
	};
	
	var generateRequest = function(startIndex,sortKey,dir,results,operation) {
		GridFields = myDataSource.responseSchema.fields;
		sortKeyNum = 0; sortDir = 'asc';
		for (i=0; i<GridFields.length; i++)
		{
			GridFields[i].sortBy;
			if (GridFields[i].sortBy)
			{
				sortKeyNum = i;
				sortDir = GridFields[i].sortDir;
			}
		}
		startIndex = startIndex || 0;
		sortKey = sortKey || myDataSource.responseSchema.fields[sortKeyNum].key;
		dir = (dir) ? dir.substring(7) : sortDir; // Converts from DataTable format "yui-dt-[dir]" to server value "[dir]"
		results = results || 20;
		operation = operation || 'get_list';
		return "results="+results+"&startIndex="+startIndex+"&sort="+sortKey+"&dir="+dir;
	};
	
	// Define a custom function to sort datatable through the Cookie
	var handleSorting = function (oColumn) {
		// Calculate next sort direction for given Column
		myLoadingBar.setHeader("Sorting, please wait...");
		var sDir = this.getColumnSortDir(oColumn);
		// The next state will reflect the new sort values
		// while preserving existing pagination rows-per-page
		// As a best practice, a new sort will reset to page 0
		var newState = generateRequest(0, oColumn.key, sDir, this.get("paginator").getRowsPerPage());
		Cookie.set("<%:modul%>_DataTableState", newState);
		YAHOO.example.CustomFormatting.handleCookieNavigation('get_list',additional_params);
	};
	myDataTable.sortColumn = handleSorting;

	// Define a custom function to route pagination through the Cookie
	var handlePagination = function(state) {
		// The next state will reflect the new pagination values
		// while preserving existing sort values
		// Note that the sort direction needs to be converted from DataTable format to server value
		var sortedBy  = this.get("sortedBy"),
		newState = generateRequest(state.recordOffset, sortedBy.key, sortedBy.dir, state.rowsPerPage);

		Cookie.set("<%:modul%>_DataTableState", newState);
		YAHOO.example.CustomFormatting.handleCookieNavigation('get_list',additional_params);
	};
    // First we must unhook the built-in mechanism...
	myPaginator.unsubscribe("changeRequest", myDataTable.onPaginatorChangeRequest);
	// ...then we hook up our custom function
	myPaginator.subscribe("changeRequest", handlePagination, myDataTable, true);
	
	myDataTable.doBeforeLoadData = function(oRequest, oResponse, oPayload) {
		myLoadingBar.hide();
		myLoadingBar.setHeader("Loading data, please wait...");
		myDataTable.initializeTable(oResponse);
		var meta = oResponse.meta;
		oPayload.totalRecords = meta.totalRecords || oPayload.totalRecords;
		oPayload.pagination = {
			rowsPerPage: meta.paginationRowsPerPage || 25,
			recordOffset: meta.paginationRecordOffset || 0
		};
		oPayload.sortedBy = {
			key: meta.sortKey || "<%iif::object_id,,<%iif::modul,_lang,language_code,id%>,record_id%>",
			dir: (meta.sortDir) ? "yui-dt-" + meta.sortDir : "yui-dt-asc" // Convert from server value to DataTable format
		};
		return true;
	};
	
	YAHOO.example.CustomFormatting.handleCookieNavigation = function (operation,add_params,show_loading) {
		// Sends a new request to the DataSource
		operation = operation || 'get_list';
		add_params = add_params || "";
		show_loading = show_loading || '1';
		if (get_url_parameter('gallery_id') != '')
		{
			add_params = add_params+'&filter_gallery_id='+get_url_parameter('gallery_id');
		}
		var request = "op="+operation+"&"+Cookie.get("<%:modul%>_DataTableState")+add_params+additional_params;
		if (show_loading == '1')
		{
			myLoadingBar.show();
		}
		myDataSource.sendRequest(request,{
			success : function (oRequest , oResponse , oPayload) { 
				myDataTable.onDataReturnSetRows(oRequest , oResponse , oPayload);
				if (Dom.inDocument("draft_mode_buttons") && document.getElementsByClassName("seoInDraft").length == 0) {
					Dom.setStyle("draft_mode_buttons", "display", "none");
				} else {
					Dom.setStyle("draft_mode_buttons", "display", "block");
				}
			},
			failure : function (oRequest , oResponse , oPayload) { 
				if (!Dom.inDocument("errorPanel"))
				{
					var myErrorWindow = document.createElement('div');
					myErrorWindow.id = "errorPanel";
					Dom.insertAfter(myErrorWindow, "yui-dt0-paginator");
				}
				YAHOO.example.errorDialog = new YAHOO.widget.SimpleDialog("errorPanel", {
					width: "250px",
					fixedcenter: true,
					visible: false,
					draggable: false,
					close: true,
					text: "The data for table is incorrect!",
					icon: YAHOO.widget.SimpleDialog.ICON_BLOCK,
					constraintoviewport: true,
					buttons: [{
						text:"Ok", 
						handler: function() {this.hide();} 
					}]
				});
				YAHOO.example.errorDialog.setHeader("Error");
	
				// Render the Dialog
				YAHOO.example.errorDialog.render();
				YAHOO.example.errorDialog.show();
				paginator = myDataTable.getState().pagination;
				if (paginator.records)
				{
					myDataTable.deleteRows(0, paginator.records[1]-paginator.records[0]+1);
				}
				myDataTable.onDataReturnReplaceRows(oRequest , oResponse , oPayload)
			},
			scope : myDataTable,
			argument : {} // Pass in container for population at runtime via doBeforeLoadData
		});
	};
	
	var initialRequest = Cookie.get("<%:modul%>_DataTableState") || // Passed in via URL
		generateRequest(); // Get default values

	// Register the module
	Cookie.set("<%:modul%>_DataTableState",initialRequest);
	 
	// Current state after Cookie is initialized is the source of truth for what state to render
	YAHOO.example.CustomFormatting.handleCookieNavigation();

	/*
	var onContextMenuClick = function(p_sType, p_aArgs, p_myDataTable) {
		var task = p_aArgs[1];
		if(task) 
		{
			// Extract which TD element triggered the context menu
			var elRow = this.contextEventTarget;
			elRow = p_myDataTable.getTdEl(elRow);
			var oRecord = p_myDataTable.getRecord(elRow);
			if(elRow)
			{
				switch(task.index) 
				{
					case 0:     // Delete row upon confirmation
						openPopup("<%iif::modul,_object_seo,_"+oRecord.getData('object_name')+",<%:modul%>%>.php?op=<%iif::modul,_mailing,4,1%>&edit="+oRecord.getData('hidden_id')+"&admin_template=yes",<%:popup_width%>,<%:popup_height%>,<%:popup_scroll%>);
						break;
					case 1:
						//del_rows(new Array(oRecord.getId()));
						break;
					case 2:
						//openWinMetaTitle("",flag);
						break;
				}
			}
		}
	};
	*/
	
	//For _seo and _object_seo define function for handling right-click on thead element
	var onTHeadContextMenuClick = function(p_sType, p_aArgs, p_myDataTable) {
		var task = p_aArgs[1];
		if(task) 
		{
			// Extract which TH element triggered the context menu
			var elRow = this.contextEventTarget;
			elRow = p_myDataTable.getThEl(elRow);
			elRow = p_myDataTable.getColumn(elRow);
			if(elRow)
			{
				flag = ('<%:modul%>' == '_seo' ? false : true);
				switch(task.index) 
				{
					case 0:						
						openWinMetaTitle(elRow.getField(),flag);
						break;
					case 1:
						if (elRow.fixed)
						{
							alert("Tag \""+elRow.label+"\" is mandatory and could not be deleted"); 
						}
						else if(confirm(confirm_del_msg))
						{
							window.location = "<%:EE_ADMIN_URL%><%:modul%>.php?op=meta_del&meta_del="+elRow.getField();
						} 
						break;
					case 2:
						openWinMetaTitle("",flag);
						break;
				}
			}
		}
	};
	
	if ('<%:modul%>' == '_seo' || '<%:modul%>' == '_object_seo')
	{
		var TableColumns = myDataTable.getColumnSet().keys;
		var ColumsForMenu = new Array();
		for (i=0; i<TableColumns.length; i++)
		{
			if (	TableColumns[i].key != 'id' 
					&& 
					TableColumns[i].key != 'edit' 
					&& 
					TableColumns[i].key != 'empty' 
					&& 
					TableColumns[i].key != 'hidden_id'
					&&
					TableColumns[i].key != 'obj_link'
					&&
					TableColumns[i].key != 'seo_preview'
				)
			{
				ColumsForMenu[ColumsForMenu.length] = TableColumns[i].getThEl();
			}
		}
		var myTHeadContextMenu = new YAHOO.widget.ContextMenu("mytheadcontextmenu",{trigger:ColumsForMenu});
		myTHeadContextMenu.addItem("Edit meta title");
		myTHeadContextMenu.addItem("Remove meta tag");
		myTHeadContextMenu.addItem("Add meta title");
		// Render the ContextMenu instance to the parent container of the DataTable
		myTHeadContextMenu.render("dynamicdata");
		myTHeadContextMenu.clickEvent.subscribe(onTHeadContextMenuClick, myDataTable);
	}
	/*
	var myContextMenu = new YAHOO.widget.ContextMenu("mycontextmenu",{trigger:myDataTable.getTbodyEl()});
	myContextMenu.addItem("Edit record");
	myContextMenu.addItem("Delete record");
	//myContextMenu.addItem("Find other similar values");
	// Render the ContextMenu instance to the parent container of the DataTable
	myContextMenu.render("dynamicdata");
	myContextMenu.clickEvent.subscribe(onContextMenuClick, myDataTable);
	*/
	
	//Function returns get parameter from url by name
	function get_url_parameter(name)
	{
		name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
		var regexS = "[\\?&]"+name+"=([^&#]*)";
		var regex = new RegExp( regexS );
		var results = regex.exec( window.location.href );
		if( results == null )
		{
			return "";
		}
		else
		{
			return results[1];
		}
	}
	
	//Function send to server request of deleting chosen rows and delete them from Dom of table
	function del_rows(rows)
	{
		add_params = '';
		if(rows.length > 0)
		{
			var loginedUserId = <%:UserId%>;
			if (rows.length > 1)
			{
				msg = 'Do you really want to delete selected items?';
			}
			else
			{
				var id = myDataTable.getRecord(rows[0]).getData('hidden_id');
				fields_array = myDataSource.responseSchema.fields;
				if ('<%:modul%>'=='_object_content')
				{
					id_array = id.split(':');
					id_text = fields_array[0].key+'='+id_array[0]+", "+fields_array[1].key+'='+id_array[1]+', '+fields_array[3].key+'='+id_array[2];
				}
				else if ('<%:modul%>'=='_gallery')
				{
					id_text = 'gallery_id='+id;
				}
				else if ('<%:modul%>'=='_nl_notification')
				{
					id_text = fields_array[0].key+'='+myDataTable.getRecord(rows[0]).getData(fields_array[0].key);
					id_text = id_text.replace(/(<([^>]+)>)/ig,"");
				}
				else
				{
					id_text = fields_array[0].key+'='+myDataTable.getRecord(rows[0]).getData(fields_array[0].key);
				}
				msg = 'Delete <%str_to_title::modul_title%> ('+id_text+')?';
			}			
			if(confirm(msg))
			{
				myDataTable.getThLinerEl(myDataTable.getColumn('checkbox')).childNodes[0].childNodes[0].checked = false;
				rows_for_del = new Array();
				for (i=0; i<rows.length; i++)
				{
					row = myDataTable.getRecord(rows[i]);
					if('<%:modul%>' == '_user' && loginedUserId == row.getData('hidden_id'))
					{
						if (confirm('You are trying to remove yourself form a list of users. \n' +
						'If you agree your information will be deleted from database, you will be logged off form a system and could not login back. \n' +
						'Are you sure you want to remove yourself?'))
						{
							myDataTable.deleteRow(row);
							rows_for_del[i] = row.getData('hidden_id');
							logout = true;
						}
						else
						{
							myDataTable.unselectRow(row);
						}
					}
					else
					{
						myDataTable.deleteRow(row);
						rows_for_del[i] = row.getData('hidden_id');
					}
				}
				if (rows_for_del.length > 0)
				{
					add_params = '&del='+rows_for_del.join('|');
					if('<%:modul%>' == '_lang' && '<%get_config_var:confirm_add_redirect_on_language%>' == '1')
					{
						if(confirm('Add permanent redirect for all page automatically ?'))
						{
							add_params = add_params + '&auto_redirect_add=true';
						}
					}
					else if('<%:modul%>' == '_lang' && 
						'<%get_config_var:auto_add_redirect_on_language%>' == '1' &&
						'<%get_config_var:confirm_add_redirect_on_language%>' == '')
					{
						add_params = add_params + '&auto_redirect_add=true';
					}
					YAHOO.example.CustomFormatting.handleCookieNavigation('del_rows',add_params,'0');
				}
				if (logout)
				{
					window.location = '<%:EE_ADMIN_URL%>logout.php';
				}
			}
		}
		else
		{      
			alert('<%:SEL_GRID_ITEM_WARNING%>');	
		}
	}
	function search_in_form_elements(what, where) 
	{
		var index = -1;
		for(var i=0; i<where.length; i++) 
		{
			if(where[i].name == what) 
			{
				index = i;
				break;
			}
		}
		return index;
	}
};
</script>