var swfobjectlite = swfobjectlite || function () {
	var UNDEF = "undefined",
	SHOCKWAVE_FLASH = "Shockwave Flash",
	FLASH_MIME_TYPE = "application/x-shockwave-flash",
	SHOCKWAVE_FLASH_AX = "ShockwaveFlash.ShockwaveFlash",
	OBJECT = "object",
	objIdArr = [],
	ie = /MSIE/.test(navigator.userAgent),
	version = function() {
		var d = null;
		var result = [0, 0, 0];
		if (typeof navigator.plugins != UNDEF && typeof navigator.plugins[SHOCKWAVE_FLASH] == OBJECT) {
			d = navigator.plugins[SHOCKWAVE_FLASH].description;
			if (d && !(typeof navigator.mimeTypes != UNDEF && navigator.mimeTypes[FLASH_MIME_TYPE] && !navigator.mimeTypes[FLASH_MIME_TYPE].enabledPlugin)) {
				d = d.replace(/^.*\s+(\S+\s+\S+$)/, "$1");
				result[0] = parseInt(d.replace(/^(.*)\..*$/, "$1"), 10);
                result[1] = parseInt(d.replace(/^.*\.(.*)\s.*$/, "$1"), 10);
                result[2] = /[a-zA-Z]/.test(d) ? parseInt(d.replace(/^.*[a-zA-Z]+(.*)$/, "$1"), 10) : 0;
			}
        } else if (typeof window.ActiveXObject != UNDEF) {
			try {
				var a = new ActiveXObject(SHOCKWAVE_FLASH_AX);
				if (a) { // a will return null when ActiveX is disabled
					d = a.GetVariable("$version");
					if (d) {
						d = d.split(" ")[1].split(",");
                        result = [parseInt(d[0], 10), parseInt(d[1], 10), parseInt(d[2], 10)];
					}
				}
			}catch(e) {
            }
		}
        return result;
    }();

	function createObjParam(el, pName, pValue) {
		var p = document.createElement("param");
		p.setAttribute("name", pName);  
		p.setAttribute("value", pValue);
		el.appendChild(p);
    }

/*    
    function setVisibility(id, isVisible) {
        if (!autoHideShow) { return; }
        var v = isVisible ? "visible" : "hidden";
        if (isDomLoaded && getElementById(id)) {
            getElementById(id)["style"]["visibility"] = v;
        }
        else {
            createCSS("#" + id, "visibility:" + v);
        }
    }
*/
	function createSWF(attObj, parObj, id) {
		var r, el = document.getElementById(id);
		if (el) {
			if (typeof attObj["id"] == UNDEF) {
				attObj["id"] = id;
			}
			if (ie) { // Internet Explorer + the HTML object element + W3C DOM methods do not combine: fall back to outerHTML
			    var att = "";
                            for (var i in attObj) {
                                    if (attObj[i] != Object.prototype[i]) { // filter out prototype additions from other potential libraries
                                            if (i.toLowerCase() == "data") {
                                                    parObj.movie = attObj[i];
                                            }
                                            else if (i.toLowerCase() == "styleclass") { // 'class' is an ECMA4 reserved keyword
                                                    att += ' class="' + attObj[i] + '"';
                                            }
                                            else if (i.toLowerCase() != "classid") {
                                                    att += ' ' + i + '="' + attObj[i] + '"';
                                            }
                                    }
                            }
                            var par = "";
                            for (var j in parObj) {
                                    if (parObj[j] != Object.prototype[j]) { // filter out prototype additions from other potential libraries
                                            par += '<param name="' + j + '" value="' + parObj[j] + '" />';
                                    }
                            }
                            el.outerHTML = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"' + att + '>' + par + '</object>';
                            objIdArr[objIdArr.length] = attObj.id; // stored to fix object 'leaks' on unload (dynamic publishing only)
                            r = document.getElementById(attObj.id);
		} else {
				var o = document.createElement(OBJECT);
				o.setAttribute("type", FLASH_MIME_TYPE);
				for (var m in attObj) {
					if (attObj[m] != Object.prototype[m]) { // filter out prototype additions from other potential libraries
						if (m.toLowerCase() == "styleclass") { // 'class' is an ECMA4 reserved keyword
					        o.setAttribute("class", attObj[m]);
						}else if (m.toLowerCase() != "classid") { // filter out IE specific attribute
					        o.setAttribute(m, attObj[m]);
						}
					}
	            }
				for (var n in parObj) {
					if (parObj[n] != Object.prototype[n] && n.toLowerCase() != "movie") {
						createObjParam(o, n, parObj[n]);
					}
				}
				el.parentNode.replaceChild(o, el);
				r = o;
			}
		}
		return r;
	}

	function hasPlayerVersion(minVersion) {
		var pv = version, v = minVersion.split(".");
        v[0] = parseInt(v[0], 10);
        v[1] = parseInt(v[1], 10) || 0; // supports short notation, e.g. "9" instead of "9.0.0"
        v[2] = parseInt(v[2], 10) || 0;
        return (pv[0] > v[0] || (pv[0] == v[0] && pv[1] > v[1]) || (pv[0] == v[0] && pv[1] == v[1] && pv[2] >= v[2])) ? true : false;
	}

    return {
    	/**
		 * att.data = swfUrlStr;
		 * att.width = widthStr; // should be a string
		 * att.height = heightStr; // should be a string
		 * par.flashvars += "&" + k + "=" + flashvarsObj[k];
		 */
		  embedSWF : function(replaceElemIdStr, swfVersionStr, par, att, callbackFn) {
			var callbackObj = {success:false, id:replaceElemIdStr};
			if (att["data"] && replaceElemIdStr && att["width"] && att["height"] && swfVersionStr) {
			    if (hasPlayerVersion(swfVersionStr)) { // create SWF
			            callbackObj["ref"] = createSWF(att, par, replaceElemIdStr);
			            callbackObj["success"] = true;
			    }
			    if (callbackFn) { 
			    	callbackFn(callbackObj); 
			    }
			}else if (callbackFn) { 
				callbackFn(callbackObj); 
			}
        },

        hasFlashPlayerVersion : hasPlayerVersion,

        removeSWF : function(id) {
	        var obj = document.getElementById(id);
	        if (obj && obj["nodeName"] == "OBJECT") {
	            obj["parentNode"]["removeChild"](obj);
	        }
    	}
    }
}();

var TUtility = TUtility || {};

TUtility.delegate = function(fn, scope){
	return function() {
		return fn.apply((scope || window), Array.prototype.slice.call(arguments));
	};
};

TUtility.createUUID = function () {
	var s = [];
	var hexDigits = "0123456789ABCDEF";
	for (var i = 0; i < 32; i++) {
		s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
	}
	s[12] = "4";
	s[16] = hexDigits.substr((s[16] & 0x3) | 0x8, 1);
    return s.join("");
};

(function(){
	var holder = "div_holder";

	 var protocol = "http:";
         
         if(location.protocol == "https:"){
             protocol = location.protocol;
         }else{
             protocol = "http:";
         }
	
	var flashId = "id_" + Math.floor(Math.random() * 1000000);
	var params = {};
	params["menu"] = "false";
	params["quality"] = "low";
	params["scale"] = "noscale";
	params["salign"] = "tl";

	params["bgcolor"] = "#CCCCCC";
	params["devicefont"] = "false";
	params["swliveconnect"] = "false";
	params["allowfullscreen"] = "false";
	params["allowscriptaccess"] = "always";
	params["allownetworking"] = "yes";

	if(window["tns_uid"]){
		params["flashvars"] = "uid=" + window["tns_uid"];
	}

	var attributes = {};
	attributes["id"] = flashId;
	attributes["align"] = "middle";
	attributes["name"] = flashId;
	attributes["data"] = protocol + "//source.mmi.bemobile.ua/id-core/1.83-r68654/lso.swf";
	attributes["width"] = 1;
	attributes["height"] = 1;

	var div = document.getElementById(holder);
	if(null == div || undefined == div){
		div = document.createElement("div");
		div["id"] = "div_holder";
		div["style"]["position"] =  "absolute";
		var body;
		try {
		    body = document.getElementsByTagName("body")[0];
		}catch(e){
		}
		if(body){
		    if(typeof document.body != "undefined"){
			body = document.body;
		    }
		}
		if(body && typeof body.appendChild != "undefined"){
		    body.appendChild(div);
		}else{
		    try{
			//colsole.error("body is not available ;(");
		    }catch(e){
		    }
		}
	}

	var flashdiv = document.createElement("div");
	flashdiv["id"] = flashId;
	div.appendChild(flashdiv);

	function onLoaded(e) {
		if(e["success"]){
			if(window.opera){
				try {
					e["ref"]["SetVariable"]("dummy", "dummy");
				}catch(error){
					window["idCoreOnReady"](TUtility.createUUID());
				}
			}
		}else{
			try{
				console.error("onLoaded: error " + e);
			}catch(er){
				//TODO handle it
			}
			window["idCoreOnReady"](TUtility.createUUID());
		}
	};

	if(swfobjectlite.hasFlashPlayerVersion("10.0.0")){
		swfobjectlite.embedSWF(flashId, "10.0.0", params, attributes, onLoaded);
	}else{
		window["idCoreOnReady"](TUtility.createUUID());
	}

})();