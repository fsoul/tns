	YAHOO.example.DDRows = function(id, sGroup, config)
	{
            YAHOO.example.DDRows.superclass.constructor.call(this, id, sGroup, config);
            Dom.addClass(this.getDragEl(),"custom-class");
        };

	YAHOO.extend(YAHOO.example.DDRows, YAHOO.util.DDProxy,
	{
        	proxyEl: null,
		srcEl:null,
		startDrag: function(x, y) {
				var proxyEl = this.proxyEl = this.getDragEl(),
				srcEl = this.srcEl = this.getEl();
		                // Make the proxy look like the source element
                		proxyEl.innerHTML = "<table width=\"100%\"><tbody>"+srcEl.innerHTML+"</tbody></table>";
		        },
		endDrag: function(x,y) {
			Dom.setStyle(this.proxyEl, "visibility", "hidden");
			},
            onDragDrop: function(e, id) {
                var destDD = YAHOO.util.DragDropMgr.getDDById(id);
                // Only if dropping on a valid target
                if (destDD && destDD.isTarget && this.srcEl) {
                         var	srcEl = this.srcEl,
                        srcIndex = srcEl.sectionRowIndex,
                    	destEl = Dom.get(id),
                    	destIndex = destEl.sectionRowIndex,
                        srcData = myDataTable.getRecord(srcEl).getData();
			var src_order = myDataTable.getRecord(srcIndex).getData('item_order');
			var dest_order = myDataTable.getRecord(destIndex).getData('item_order');
			var gallery_id = myDataTable.getRecord(destIndex).getData('gallery_id');
                    this.srcEl = null;

                    // Cleanup existing Drag instance
                    myDTDrags[srcEl.id].unreg();
                    delete myDTDrags[srcEl.id];

                    // Move the row to its new position
                	myDataTable.deleteRow(srcIndex);
                    myDataTable.addRow(srcData, destIndex);
                	YAHOO.util.DragDropMgr.refreshCache();
			YAHOO.example.CustomFormatting.handleCookieNavigation('set_order','&set_order='+src_order+'_'+dest_order+'&gallery_id='+gallery_id,'no');
		}}});

        /* Create DDRows instances when DataTable is initialized */
        myDataTable.subscribe("initEvent", function() {
		var i, id,
                allRows = this.getTbodyEl().rows;
		for(var j=0; j<allRows.length; j++)
		{
                	id = allRows[j].id;
			// Clean up any existing Drag instances
			if (myDTDrags[id])
			{
				myDTDrags[id].unreg();
				delete myDTDrags[id];
			}
			// Create a Drag instance for each row
		        myDTDrags[id] = new YAHOO.example.DDRows(id);
		}
        });

	function reinitDD()
	{
		var i, id,
                allRows = myDataTable.getTbodyEl().rows;

		for(var j=0; j<allRows.length; j++)
		{
                	id = allRows[j].id;
			// Clean up any existing Drag instances
			if (myDTDrags[id])
			{
				myDTDrags[id].unreg();
				delete myDTDrags[id];
			}
			// Create a Drag instance for each row
		        myDTDrags[id] = new YAHOO.example.DDRows(id);
		}

	}

	myDataTable.subscribe("rowAddEvent",function(e){
			var id = e.record.getId();
			myDTDrags[id] = new YAHOO.example.DDRows(id);
			reinitDD();
		});