function LoadXML(uri,method,post_str)
{
	var request = null;

	// �������� ������� ������ ��� MSXML 2 � ������
	
	if (!request)
	{
		try
		{
			request = new ActiveXObject('Msxml2.XMLHTTP');
		}
		catch (e){}
	}

	// �� �����... ��������� ��� MSXML 1
	
	if (!request)
	{
		try
		{
			request = new ActiveXObject('Microsoft.XMLHTTP');
		}
		catch (e){}
	}

	// ��	�����... ��������� ��� Mozilla � Opera 7.60

	if (!request)
	{
		try
		{
			request = new XMLHttpRequest();
		}
		catch (e){}
	}

	if (!request)
	{
		// ������ �� ����������...
		
		return null;
	}
 
	// ������ ������
	
	request.open(method, uri, false);	
	if (method=='GET') {
		request.send(null);
	} else {
		request.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		request.send(post_str);
	}
//	if (request.responseXML.childNodes.length==0)
//		return null;//alert('xml �� ����������');
  
	//���������� XML

	return request.responseText;
		
}
function block_click() {
	return false;
}
function check_key(e) {
	e = (e)?e:window.event;
	if(e.keyCode == '27')
	{
		p2 = window.top.document.getElementById("popup_div_id2")
		if((p2!=undefined) && p2.style.display!="none") {
			window.top.closePopup2();
		} else {
			window.top.closePopup();
		}
	}
	return true;
}
function popup_form_submit(e) {
	e = (e)?e:window.event;
	form_obj = (e.target)?e.target:e.srcElement;
	page_popup = document.getElementById("admin_popup");

//	page_popup.innerHTML = LoadXML(url,'POST');
	var post_str = "";
	var url;
	form_children = new Array;
	form_children = form_obj.getElementsByTagName('input');
//	alert(form_obj.getElementsByTagName('input'));
	for (i=0;i<form_children.length;i++) {
		if (form_children[i].name == 'req_url') {
				url = form_children[i].value;
			} else	post_str += ((post_str == "")?"":"&")+form_children[i].name+"="+form_children[i].value;
	}
//	page_popup.innerHTML = url+"------"+post_str;
	page_popup.innerHTML = LoadXML(url,'POST',post_str);
	return false;
}

function closePopup_common(reload, arg_popup_level, arg_popup_div_id, reload_only) 
{
	var popup_div=document.getElementById(arg_popup_div_id);
	if (YAHOO.example.PanelFormatting.panel)
	{
		YAHOO.example.PanelFormatting.panel.hide();
	}
	if (popup_div)
	{
		document.body.scroll='yes';


		if(arg_popup_level == 1)
		{
			var page_content = document.getElementById("whole_page_content");	
			if (page_content)
			{
				page_content.style.overflow='';
				page_content.style.height = '';
				page_content.style.width = '';
				page_content.oncontextmenu = '';
			}
		}
		

		var sels = document.getElementsByTagName('select');
		for (i=0; i<sels.length; i++)
		{
			sels[i].disabled = false;
		}
	

		window.onresize = '';
		window.document.onkeypressed = '';
	

		if (reload=='yes')
		{
			if(arg_popup_level == 1)
			{
				if (window.top.YAHOO.example.CustomFormatting)
				{
					window.top.YAHOO.example.CustomFormatting.handleCookieNavigation();
				}
				else
				{
					window.top.location.replace(window.top.location);
				}
			}
			if(arg_popup_level == 2)
			{
				if (reload_only == 'true')
				{
					var tmp_url = window.iframe_popup.document.getElementById('iframe_preview').src;
					window.iframe_popup.document.getElementById('iframe_preview').src = null;
					window.iframe_popup.document.getElementById('iframe_preview').src = tmp_url;
				}
				else
				{
					window.iframe_popup.location.reload();
				}
			}
		}
	}

}
YAHOO.namespace("example.PanelFormatting");
var Dom = YAHOO.util.Dom;
var 	popupHeight,
	popupWidth,
	tmpPopupHeight,
	tmpPopupWidth;
function init_yui_popup(resizablepanel_id, width, height, arg_popup_level)
{
	//If there is already exists one panel - "backup" it
	if (YAHOO.example.PanelFormatting.panel)
	{
		YAHOO.example.PanelFormatting.main_panel = YAHOO.example.PanelFormatting.panel;
	}
	YAHOO.example.PanelFormatting.panel = new YAHOO.widget.Panel(resizablepanel_id, {
		draggable: true,
		dragOnly: true,
		width: width + "px",
		height: height + "px",
		autofillheight: "body", // default value, specified here to highlight its use in the example
		constraintoviewport:true,
	  	context: ["showbtn", "tl", "bl"],
		close:true,
		visible:false,
		fixedcenter: true
	});
	var kl = new YAHOO.util.KeyListener(document,  { keys:27 },
						       {fn:YAHOO.example.PanelFormatting.panel.hide,
							scope:YAHOO.example.PanelFormatting.panel,
							correctScope:true }, "keyup" );
	YAHOO.example.PanelFormatting.panel.cfg.queueProperty("keylisteners", kl);
	YAHOO.example.PanelFormatting.panel.render();

	YAHOO.example.PanelFormatting.panel.hideEvent.subscribe(function () {
		page_mask = Dom.getPreviousSibling(YAHOO.example.PanelFormatting.panel.id+"_c");
		if (page_mask)
		{
			page_mask.parentNode.removeChild(page_mask);
		}
		if (YAHOO.example.PanelFormatting.main_panel)
		{
			tmp_panel = YAHOO.example.PanelFormatting.panel;
			YAHOO.example.PanelFormatting.panel = YAHOO.example.PanelFormatting.main_panel;
			YAHOO.example.PanelFormatting.main_panel = tmp_panel;
			popupWidth = tmpPopupWidth;
			popupHeight = tmpPopupHeight;
		}
	});
	
	YAHOO.util.Event.addListener(resizablepanel_id + "_h", "dblclick", function () {
		YAHOO.example.PanelFormatting.panel.doCenterOnDOMEvent();
	});

	YAHOO.widget.Overlay.windowResizeEvent.subscribe(function()
	{
		maxHeight = YAHOO.util.Dom.getViewportHeight() - 40;
		maxWidth = YAHOO.util.Dom.getViewportWidth() - 40;

		newHeight = Math.max(Math.min(parseInt(popupHeight), parseInt(maxHeight)), 200);
		newWidth = Math.max(Math.min(parseInt(popupWidth), parseInt(maxWidth)), 200);
		
		YAHOO.example.PanelFormatting.panel.cfg.setProperty("height", newHeight+"px");
		YAHOO.example.PanelFormatting.panel.cfg.setProperty("width", newWidth+"px");
		YAHOO.example.PanelFormatting.panel.doCenterOnDOMEvent();
	}, this, this);

	//Hide frame and make popup body "glassed"
	var popupFrame = Dom.getChildren(YAHOO.example.PanelFormatting.panel.body)[0];
	var hideFrame = function (x, y) {
		Dom.addClass(resizablepanel_id, "panel-on-move");
		Dom.setStyle(popupFrame, "visibility", "hidden");
	}
	//Show frame and make popup body
	var showFrame = function(x, y) {
		Dom.removeClass(resizablepanel_id, "panel-on-move");
		Dom.setStyle(popupFrame, "visibility", "inherit");
	}

	YAHOO.example.PanelFormatting.panel.dragEvent.subscribe(hideFrame);
	YAHOO.example.PanelFormatting.panel.moveEvent.subscribe(showFrame);

	// Create Resize instance, binding it to the 'resizablepanel' DIV 
	YAHOO.example.PanelFormatting.resize = new YAHOO.util.Resize(resizablepanel_id, {
		handles: ["br"],
		autoRatio: false,
		minWidth: 200,
		minHeight: 100,
		status: false
	});
	// Setup startResize handler, to constrain the resize width/height
	// if the constraintoviewport configuration property is enabled.
	YAHOO.example.PanelFormatting.resize.on("startResize", function(args) {
		if (this.cfg.getProperty("constraintoviewport")) {
			var clientRegion = Dom.getClientRegion();
			var elRegion = Dom.getRegion(this.element);
	
			resize.set("maxWidth", clientRegion.right - elRegion.left - YAHOO.widget.Overlay.VIEWPORT_OFFSET);
			resize.set("maxHeight", clientRegion.bottom - elRegion.top - YAHOO.widget.Overlay.VIEWPORT_OFFSET);
		} else {
			resize.set("maxWidth", null);
			resize.set("maxHeight", null);
		}
	}, YAHOO.example.PanelFormatting.panel, true);
	
	// Setup resize handler to update the Panel's 'height' configuration property 
	// whenever the size of the 'resizablepanel' DIV changes.
	
	// Setting the height configuration property will result in the 
	// body of the Panel being resized to fill the new height (based on the
	// autofillheight property introduced in 2.6.0) and the iframe shim and 
	// shadow being resized also if required (for IE6 and IE7 quirks mode).
	YAHOO.example.PanelFormatting.resize.on("resize", function(args) {
		popupHeight = args.height;
		popupWidth = args.width;
	    var panelHeight = args.height;
	    this.cfg.setProperty("height", panelHeight + "px");
	}, YAHOO.example.PanelFormatting.panel, true);
}

function setPopupHeight(height)
{
	if (YAHOO.example.PanelFormatting.panel) {
		popupHeight = height;
		YAHOO.widget.Overlay.windowResizeEvent.fire();	
	}
}
function setPopupWidth(width)
{
	if (YAHOO.example.PanelFormatting.panel) {
		popupWidth = width;
		YAHOO.widget.Overlay.windowResizeEvent.fire();
	}
}

function openPopup_common(url, width, height, scroll, arg_height_top_margin, arg_popup_div_id, arg_admin_mask_id, arg_admin_popup_id, arg_iframe_popup_id, arg_popup_level)
{
	if (YAHOO.example.PanelFormatting.panel) {
		tmpPopupWidth = popupWidth;
		tmpPopupHeight = popupHeight;
	}
	if (	YAHOO.example.PanelFormatting.panel
		&& YAHOO.example.PanelFormatting.main_panel
		&& YAHOO.example.PanelFormatting.panel.id != arg_admin_popup_id+"_resizablepanel"
	)
	{
		tmp_panel = YAHOO.example.PanelFormatting.main_panel;
		YAHOO.example.PanelFormatting.main_panel = YAHOO.example.PanelFormatting.panel;
		YAHOO.example.PanelFormatting.panel = tmp_panel;
	}
	//if "height" more then max "browserHeight" then "height" must be equal "browserHeight"
	var current_page_height = pageHeight();
	if ((height+arg_height_top_margin+40) > current_page_height)
	{
		height = current_page_height-arg_height_top_margin-40;
		scroll = true;	
	}
	scroll = scroll==true ? "yes" : "no";

	var page_frame	= document.getElementById(arg_iframe_popup_id);
	page_frame.setAttribute("scrolling", scroll);
	page_frame.style.visibility = 'hidden';
	YAHOO.util.Event.addListener(page_frame, "load", function () {
		this.style.visibility = 'inherit';
		YAHOO.widget.Overlay.windowResizeEvent.fire();
	});
	
	popupHeight = height;
	popupWidth = width;

	if(page_frame.src=='')
	{
		document.getElementById(arg_popup_div_id).style.display = 'block';
		init_yui_popup(arg_admin_popup_id+"_resizablepanel", width, height, arg_popup_level);
	}
	else
	{
		YAHOO.example.PanelFormatting.panel.cfg.setProperty("width", width + "px");
		YAHOO.example.PanelFormatting.panel.cfg.setProperty("height", height + "px");
	}
	if (!Dom.inDocument(arg_admin_mask_id))
	{
		var page_mask = document.createElement("div");
		page_mask.setAttribute("id", arg_admin_mask_id);
		Dom.insertBefore(page_mask,arg_admin_popup_id+"_resizablepanel_c");
	}
	YAHOO.example.PanelFormatting.panel.show();
	YAHOO.example.PanelFormatting.panel.setHeader("Loading data, please wait...");
	page_frame.setAttribute("src",url+((arg_popup_level==2)?"&popup2=true":""));
        
	setSizes();
}

function openPopup(url, width, height, scroll)
{
	openPopup_common(url, width, height, scroll, 5, "popup_div_id", "admin_mask", "admin_popup", "iframe_popup", 1);
}

function closePopup(reload) 
{
	closePopup_common(reload, 1, "popup_div_id", ""); 
}

function openPopup2(url, width, height, scroll)
{
	openPopup_common(url, width, height, scroll, 20, "popup_div_id2", "admin_mask2", "admin_popup2", "iframe_popup2", 2);
}  

function closePopup2(reload, reload_only) 
{
	closePopup_common(reload, 2, "popup_div_id2", reload_only);
}

function setSizes_common(arg_page_mask_id, arg_page_popup_id, arg_height_top_margin)
{
	var page_mask = document.getElementById(arg_page_mask_id);
	var page_popup = document.getElementById(arg_page_popup_id);

	if (page_mask)
	{
		// Shrink mask first, so it doesn't affect the document size.
		viewWidth = Dom.getViewportWidth(),
		viewHeight = Dom.getViewportHeight();
		if (page_mask.offsetHeight > viewHeight) {
			page_mask.style.height = viewHeight + "px";
		}

		if (page_mask.offsetWidth > viewWidth) {
			page_mask.style.width = viewWidth + "px";
		}

		// Then size it to the document
		page_mask.style.height = pageHeight() + "px";
		page_mask.style.width = pageWidth() + "px";
	}
	if (page_popup)
	{
		var top = parseInt((pageHeight()-parseInt(page_popup.style.height))/2);
		var left = parseInt((pageWidth()-parseInt(page_popup.style.width))/2);
		if (top<arg_height_top_margin) top = arg_height_top_margin;
		if (left<arg_height_top_margin) left = arg_height_top_margin;
	}
}

function setSizes()
{
	var page_content = document.getElementById("whole_page_content");
	if (page_content)
	{
		page_content.style.height = pageHeight()+'px';
		page_content.style.width = pageWidth()+'px';
	}
	
	setSizes_common("admin_mask", "admin_popup", 5);
	setSizes_common("admin_mask2", "admin_popup2", 20);
}

function set_sizes_by_content()
{
	var page_content = document.getElementById("whole_page_content");
	var page_popup = window.top.document.getElementById("admin_popup");
	if (page_popup)
	{
		page_popup.style.height = (parseInt(page_content.offsetHeight)+20)+'px';
	}

	var popup_frame = window.top.document.getElementById("iframe_popup");

	if (parseInt(page_popup.offsetHeight) > parseInt((parseInt(page_popup.offsetWidth)*64/38)))
	{
		popup_frame.setAttribute("scrolling",'yes');
		page_popup.style.height = parseInt((parseInt(page_popup.offsetWidth)*64/38));
	}
	if (parseInt(page_popup.offsetHeight) > window.top.pageHeight()*0.8)
	{
		popup_frame.setAttribute("scrolling",'yes');
		page_popup.style.height = (window.top.pageHeight()*0.8) + 'px';
	}
	window.top.setPopupHeight(parseInt(page_popup.offsetHeight + 40));
	window.top.setSizes();
}

function pageWidth() 
{
	return Dom.getDocumentWidth();
}
function pageHeight() 
{
	return Dom.getDocumentHeight();
}
if (window != window.top) 
{
	window.document.onkeypress = check_key;
}
