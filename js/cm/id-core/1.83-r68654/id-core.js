/* head.js v0.99 */
(function(f,w){function m(){}function g(a,b){if(a){"object"===typeof a&&(a=[].slice.call(a));for(var c=0,d=a.length;c<d;c++)b.call(a,a[c],c)}}function v(a,b){var c=Object.prototype.toString.call(b).slice(8,-1);return b!==w&&null!==b&&c===a}function k(a){return v("Function",a)}function h(a){a=a||m;a._done||(a(),a._done=1)}function n(a){var b={};if("object"===typeof a)for(var c in a)a[c]&&(b={name:c,url:a[c]});else b=a.split("/"),b=b[b.length-1],c=b.indexOf("?"),b={name:-1!==c?b.substring(0,c):b,url:a};
return(a=p[b.name])&&a.url===b.url?a:p[b.name]=b}function q(a){var a=a||p,b;for(b in a)if(a.hasOwnProperty(b)&&a[b].state!==r)return!1;return!0}function s(a,b){b=b||m;a.state===r?b():a.state===x?d.ready(a.name,b):a.state===y?a.onpreload.push(function(){s(a,b)}):(a.state=x,z(a,function(){a.state=r;b();g(l[a.name],function(a){h(a)});j&&q()&&g(l.ALL,function(a){h(a)})}))}function z(a,b){var b=b||m,c;/\.css[^\.]*$/.test(a.url)?(c=e.createElement("link"),c.type="text/"+(a.type||"css"),c.rel="stylesheet",
c.href=a.url):(c=e.createElement("script"),c.type="text/"+(a.type||"javascript"),c.src=a.url);c.onload=c.onreadystatechange=function(a){a=a||f.event;if("load"===a.type||/loaded|complete/.test(c.readyState)&&(!e.documentMode||9>e.documentMode))c.onload=c.onreadystatechange=c.onerror=null,b()};c.onerror=function(){c.onload=c.onreadystatechange=c.onerror=null;b()};c.async=!1;c.defer=!1;var d=e.head||e.getElementsByTagName("head")[0];d.insertBefore(c,d.lastChild)}function i(){e.body?j||(j=!0,g(A,function(a){h(a)})):
(f.clearTimeout(d.readyTimeout),d.readyTimeout=f.setTimeout(i,50))}function t(){e.addEventListener?(e.removeEventListener("DOMContentLoaded",t,!1),i()):"complete"===e.readyState&&(e.detachEvent("onreadystatechange",t),i())}var e=f.document,A=[],B=[],l={},p={},E="async"in e.createElement("script")||"MozAppearance"in e.documentElement.style||f.opera,C,j,D=f.head_conf&&f.head_conf.head||"head",d=f[D]=f[D]||function(){d.ready.apply(null,arguments)},y=1,x=3,r=4;d.load=E?function(){var a=arguments,b=a[a.length-
1],c={};k(b)||(b=null);g(a,function(d,e){d!==b&&(d=n(d),c[d.name]=d,s(d,b&&e===a.length-2?function(){q(c)&&h(b)}:null))});return d}:function(){var a=arguments,b=[].slice.call(a,1),c=b[0];if(!C)return B.push(function(){d.load.apply(null,a)}),d;c?(g(b,function(a){if(!k(a)){var b=n(a);b.state===w&&(b.state=y,b.onpreload=[],z({url:b.url,type:"cache"},function(){b.state=2;g(b.onpreload,function(a){a.call()})}))}}),s(n(a[0]),k(c)?c:function(){d.load.apply(null,b)})):s(n(a[0]));return d};d.js=d.load;d.test=
function(a,b,c,e){a="object"===typeof a?a:{test:a,success:b?v("Array",b)?b:[b]:!1,failure:c?v("Array",c)?c:[c]:!1,callback:e||m};(b=!!a.test)&&a.success?(a.success.push(a.callback),d.load.apply(null,a.success)):!b&&a.failure?(a.failure.push(a.callback),d.load.apply(null,a.failure)):e();return d};d.ready=function(a,b){if(a===e)return j?h(b):A.push(b),d;k(a)&&(b=a,a="ALL");if("string"!==typeof a||!k(b))return d;var c=p[a];if(c&&c.state===r||"ALL"===a&&q()&&j)return h(b),d;(c=l[a])?c.push(b):l[a]=[b];
return d};d.ready(e,function(){q()&&g(l.ALL,function(a){h(a)});d.feature&&d.feature("domloaded",!0)});if("complete"===e.readyState)i();else if(e.addEventListener)e.addEventListener("DOMContentLoaded",t,!1),f.addEventListener("load",i,!1);else{e.attachEvent("onreadystatechange",t);f.attachEvent("onload",i);var u=!1;try{u=null==f.frameElement&&e.documentElement}catch(F){}u&&u.doScroll&&function b(){if(!j){try{u.doScroll("left")}catch(c){f.clearTimeout(d.readyTimeout);d.readyTimeout=f.setTimeout(b,50);
return}i()}}()}setTimeout(function(){C=!0;g(B,function(b){b()})},300)})(window);

if(typeof console == "undefined") {
    var console = console || {};
    console.log = console.log || function(a, b){
    };
    console.warn = console.warn || function(a, b){
    };
    console.error = console.error || function(a, b){
    };
    console.info = console.info || function(a, b){
    };
    console.debug = console.debug || console.log;
}

window["idCoreOnReady"] = function(id){
    window["IDCore"]["onFlashReady"](id);
};

window["tnsOnStatResult"] = function(e){
    console.log("result:" + e.result + " pid:" + e.pid + " e.id: " + e.id);
    if(e.result != "success") {
    }
};

var TUtility = TUtility || {};
TUtility.random = function(){
    var d = new Date().valueOf().toString();
    return parseInt(d.substr(d.length - 8, d.length))
	    + Math.round(Math.random() * Math.pow(10, 9));
};
TUtility.getUrl = function(host, sslhost, path){
    var url = "";
    if(location.protocol == "https:"){
        url = location.protocol + "//" + sslhost;
    }else{
        url = "http://" + host;
    }
    return url + path;
};
TUtility.delegate = function(fn, scope){
    return function(){
	return fn.apply((scope || window), Array.prototype.slice
		.call(arguments));
    };
};
TUtility.time = function(){
    return new Date().getTime();
};
TUtility.cors = function(errorHandler){
    var cors;
    try {
	if(window.XDomainRequest) {
    	  cors = new window.XDomainRequest();
    	  if(errorHandler){
    	    cors.onerror = function(){
    	      errorHandler.call(null, cors);
    	    };
    	  }
	} else {
	    cors = new XMLHttpRequest();
	    if(errorHandler){
	        cors.onreadystatechange = function (e) {
	            if (cors.readyState == 4) {
	                if(cors.status == 200){
	                }else{
	                    errorHandler.call(null, cors);
	                }
	            }
	        };
	    }
	}
    } catch(e) {
	console.error("cors:" + e);
    }
    return cors;
};
TUtility.isMobile = function(){
    return /Mobi|Mini|Symbian|SAMSUNG|Nokia|BlackBerry|Series|Bada|SymbOS|PLAYSTATION/g
	    .test(navigator.userAgent.toString());
};

TUtility.escape = function(str){
    return encodeURIComponent(str);
};
TUtility.addParam = function(url, param, value){
    var newurl = url;
    var delimiter = "&";
    if(newurl.indexOf("?") == -1) {
	delimiter = "?";
    }
	if(param == 'vw' || param == 'vh') {
		value = escape(value);
	}
    newurl += delimiter + param + "=" + value;
    return newurl;
};
TUtility.createUUID = function(){
    var s = [];
    var hexDigits = "0123456789ABCDEF";
    for( var i = 0; i < 32; i++) {
	s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[12] = "4";
    s[16] = hexDigits.substr((s[16] & 0x3) | 0x8, 1);
    return s.join("");
};

TUtility.setCookie = function(name, value, expires, path, domain, secure){
    document.cookie = name + "=" + escape(value)
	    + ((expires) ? "; expires=" + expires : "")
	    + ((path) ? "; path=" + path : "")
	    + ((domain) ? "; domain=" + domain : "")
	    + ((secure) ? "; secure" : "");
};

TUtility.getCookie = function(name){
    var cookie = " " + document.cookie;
    var search = " " + name + "=";
    var setStr = null;
    var offset = 0;
    var end = 0;
    if(cookie.length > 0) {
	offset = cookie.indexOf(search);
	if(offset != -1) {
	    offset += search.length;
	    end = cookie.indexOf(";", offset)
	    if(end == -1) {
		end = cookie.length;
	    }
	    setStr = unescape(cookie.substring(offset, end));
	}
    }
    return (setStr);
};

TUtility.hasLocalStorage = function(){
    try {
	return "localStorage" in window && window["localStorage"] !== null;
    } catch(e) {
	return false;
    }
}();

TUtility.hasFlash = function(){
    if(typeof navigator.plugins == "undefined" || navigator.plugins.length == 0) {
	try {
	    return !!(new ActiveXObject("ShockwaveFlash.ShockwaveFlash"));
	} catch(er) {
	    return false;
	}
    } else {
	return navigator.plugins["Shockwave Flash"];
    }
}();

TUtility.isIE = function(){
    return /MSIE/.test(navigator.userAgent);
}();

TUtility.isIE7 = function(){
    return /MSIE\ 7/.test(navigator.userAgent);
}();

TUtility.deleteCookie = function(name){
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
};
TUtility.getBody = function(){
    var body;
    try {
	body = document.getElementsByTagName("body")[0];
    } catch(e) {
    }
    if(typeof body == "undefined" || body == null) {
	if(typeof document.body != "undefined") {
	    body = document.body;
	    if(!body) {
		// console.warn("body is not availible");
	    }
	}
    }
    return body;
};
TUtility.isCookieEnabled = function(){
    var cookieEnabled = (navigator.cookieEnabled) ? true : false;

    if(typeof navigator.cookieEnabled == "undefined" && !cookieEnabled) {
	document.cookie = "testcookie";
	cookieEnabled = (document.cookie.indexOf("testcookie") != -1) ? true
		: false;
	TUtility.deleteCookie("testcookie");
    }
    return (cookieEnabled);
}();
TUtility.isNotEmpty = function(str){
    return undefined !== str && null != str && str.replace(/\s/g, "") != "";
};
TUtility.getPath = function(str, root){
    var path = str;
    if(path.toLowerCase().indexOf("/") == 0) {
	if(root) {
	    path = root + path;
	} else {
	    var location = window.location.protocol.toString() + "//"
		    + window.location.hostname.toString()
		    + window.location.port.toString();
	    if(location != "") {
		path = location + path;
	    }
	}
    }
    return TUtility.escape(path);
};
TUtility.round = function(n){
    return Math.floor(n * 100) / 100;
};
TUtility.makeArray = function(items){
    try {
	return Array.prototype.slice.call(items);
    } catch(ex) {
	var i = 0, len = items.length, result = Array(len);
	while(i < len) {
	    result[i] = items[i];
	    i++;
	}
	return result;

    }
};

TUtility.idScope = function(){
    var scope = "l";
    if(TUtility.hasFlash){
	scope = "b";
    }else if(window.postMessage && (TUtility.hasLocalStorage  || TUtility.isCookieEnabled)){
	scope = "d";
    }else if(TUtility.hasLocalStorage == false && TUtility.isCookieEnabled == false){
	scope = "g";
    }
    try {
	if(window.chrome){
	    for(var i in navigator.plugins){ 
		if(/PepperFlashPlayer/gi.test(navigator.plugins[i].filename)){ 
		    scope = "c";
		    break;
		}
	    }
	}
    }catch(e){
	console.warn("chrome : PepperFlashPlayer - has some error");
    }
    return scope;
}();

window["IDCore"] = window["IDCore"] || (function(){

    var isReady = false;
    var protocol = "http:";

    if(location.protocol == "https:"){
        protocol = location.protocol;
    }else{
        protocol = "http:";
    }

    var host = window.addonCMeter && addonCMeter.host || protocol + "//source.mmi.bemobile.ua";
    var version = "1.83-r68654";
    var short_version = version.replace(/-r\d+$/, "");
    var juke_host = 'juke.mmi.bemobile.ua/bug/pic.gif';

    try {
        if(CONFIG && CONFIG.juke_host){
            juke_host = CONFIG.juke_host;
        }
    }catch(e){
// console.warn(e);
    }

    var cookie = {};
    cookie["id"] = "vplayer_user_id";
    cookie["wasInitialized"] = "tns_was_initialized";
    cookie["wasMigrated"] = "tns_was_migrated";
    cookie["flag"] = "flag";
    var wasInitialized = false;
    var holder = "div_holder";
    var buffer = new Array();

    var uid = "";
    var refs = new Array();

    function cds(){
	head.js(host + "/id-core/" + version + "/cds.js", function(){
	    try {
		var remoteStorage = new CrossDomainStorage(host, "/id-core/"
			+ version + "/id.html");
		remoteStorage["requestValue"](cookie["id"], function(key, id){
		    onLocalReady(id);
		});
	    } catch(e) {
		console.error("cds.js:" + e);
		uid = TUtility.createUUID();
		onLocalReady(uid);
	    }
	});
    }

    function setMigrate(){
	var expirationDate = new Date();
	expirationDate.setFullYear(expirationDate.getFullYear() + 1);
	TUtility.setCookie(cookie["wasMigrated"], true, expirationDate
		.toGMTString(), "/", "");
	// when everything is okay
	onLocalReady(uid);
    }

    function migrate(){
	if(TUtility.getCookie(cookie["wasMigrated"])) {
	    return false;
	}
	if(TUtility.isCookieEnabled) {
	    var initialized = TUtility.getCookie(cookie["wasInitialized"]);
	    if(initialized) {
		uid = TUtility.getCookie(cookie["id"]);

		if(TUtility.hasLocalStorage) {
		    head.js(host + "/id-core/" + version + "/cds.js",
			    function(){
				try {
				    var remoteStorage = new CrossDomainStorage(
					    host, "/id-core/" + version
						    + "/id.html");
				    remoteStorage["requestValue"](cookie["id"]
					    + ":" + uid, function(key, id){
					if(id != uid) {
					    console.error("id: " + id + " != "
						    + uid);
					} else {
					    setMigrate();
					}
				    });
				} catch(e) {
				    console.error("migrate:" + e);
				}
			    });
		    TUtility.deleteCookie(cookie["id"]);
		    TUtility.deleteCookie(cookie["wasInitialized"]);
		} else if(TUtility.hasFlash) {
		    window["tns_uid"] = uid;
		    head.js(host + "/id-core/" + version + "/flash.js",
			    function(){
				setMigrate();
				// delete window["tns_uid"];
			    });
		}
		return true;
	    }
	}
	return false;
    }

    function init(){
	wasInitialized = true;
	if(migrate()) {
	    return;
	}
	if(TUtility.hasLocalStorage) {
	    uid = localStorage.getItem(cookie["id"]);
	    if(uid) {
		onLocalReady(uid);
	    } else {
		if(window.postMessage && !window.JSON && window.localStorage) {
		    head.js(host + "/json2.min.js", function(){
			if(TUtility.getBody()) {
			    cds();
			} else {
			    head.ready(function(){
				cds();
			    });
			}
		    });
		} else if(window.postMessage && window.JSON
			&& window.localStorage) {
		    if(TUtility.getBody()) {
			cds();
		    } else {
			head.ready(function(){
			    cds();
			});
		    }
		} else {
		    onLocalReady(TUtility.createUUID());
		}
	    }
	} else {
	    if(TUtility.hasFlash) {
		if(TUtility.getBody()) {
		    head.js(host + "/id-core/" + version + "/flash.js");
		} else {
		    head.ready(function(){
			head.js(host + "/id-core/" + version + "/flash.js");
		    });
		}
	    } else {
		uid = TUtility.getCookie(cookie["id"]);
		if(!uid) {
		    uid = TUtility.createUUID();
		}
		onLocalReady(uid);
	    }
	}
    }

    function flushOnReady(){
	var i;
	for(i in buffer) {
	    if(buffer.hasOwnProperty(i)) {
		var url = buffer[i]["url"];
		var params = buffer[i]["params"];
		var time = buffer[i]["time"];
		var type = buffer[i]["type"];
		var onError = buffer[i]["onError"];

		if(/^POST$/ig.test(type)) {
		    sendPost(url, params, time, onError);
		} else {
		    sendGet(url, params, time, type, onError);
		}
	    }
	}
	buffer = Array();
	var ref;
	for(ref in refs) {
	    if(refs.hasOwnProperty(ref)) {
		refs[ref].call(this, uid);
	    }
	}
	refs = new Array();
    }

    function onLocalReady(id){
	saveId(id);
	isReady = true;
	flushOnReady();
	if(TUtility.hasLocalStorage){
	    if(!localStorage.getItem(cookie["flag"])) {
	        (new Image).src = protocol + "//" + juke_host + "?uid=" + id + "&time=" + new Date().valueOf(); 
    	    	localStorage.setItem(cookie["flag"], "true");
	    }
	} else if(TUtility.isCookieEnabled) {
	    if(!TUtility.getCookie(cookie["flag"])){
		var expirationDate = new Date();
		expirationDate.setFullYear(expirationDate.getFullYear() + 1);
		TUtility.setCookie(cookie["flag"], "true", expirationDate.toGMTString(), "/", "");
		(new Image).src = protocol + "//" + juke_host + "?uid=" + id + "&time=" + new Date().valueOf();
	    }
	}
    }

    function saveId(id){
	uid = id;
	if(TUtility.hasLocalStorage) {
	    localStorage.setItem(cookie["id"], id);
	} else if(TUtility.isCookieEnabled) {
	    var expirationDate = new Date();
	    expirationDate.setFullYear(expirationDate.getFullYear() + 1);

	    TUtility.setCookie(cookie["id"], id, expirationDate.toGMTString(),
		    "/", "");
	    TUtility.setCookie(cookie["wasInitialized"], true, expirationDate
		    .toGMTString(), "/", "");
	}
    }

    function addParams(url, params){
	var i, key;
	if(params instanceof Array) {
	    for(i in params) {
		url = TUtility.addParam(url, params[i]["key"],
			params[i]["value"]);
	    }
	} else {
	    for(key in params) {
		url = TUtility.addParam(url, key, params[key]);
	    }
	}
	return url;
    }

    function onFlashReady(id){
	try {
	    var div = document.getElementById(holder);
	    div.parentNode.removeChild(div);
	} catch(e) {

	}
	swfobjectlite = null;
	onLocalReady(id);
    }

    function getVersion(){
	return short_version;
    }

    function sendPost(url, params, time, onError){
	try {
	    var cors = TUtility.cors(onError);
	    
	    cors.open("POST", url, true);
	    
	    if(!params) {
	        params = {};
	    }
	    if(params instanceof Array) {
	        params.push({
	            "key" : "cookie",
	            "value" : uid
	        });
	        params.push({
	            "key" : "time",
	            "value" : time ? time : new Date().valueOf()
	        });
	    } else {
	        params["cookie"] = uid;
	        params["time"] = time ? time : new Date().valueOf();
	    }
	    
	    if(TUtility.isIE) {
	        cors.contentType = "text/plain";
	    } else {
	        cors.setRequestHeader("Content-type",
	        "application/x-www-form-urlencoded;charset=UTF-8");
	    }
	    
	    var postParams = addParams("?", params).replace(/^\?/, "");
	    
	    cors.send(postParams);
	}catch(e){
	    console.error(e);
	}
    }

    function sendGet(url, params, time, type, onError){
	if(!params) {
	    params = {};
	}
	url = TUtility.addParam(url, "cookie", uid);
	url = TUtility
		.addParam(url, "time", time ? time : new Date().valueOf());

	url = addParams(url, params);

	try {
	    if((type && type == "JSONP") || window.opera || TUtility.isIE7) {
		var script = document.createElement("script");
		script.setAttribute("src", url);
		document.getElementsByTagName("head")[0].appendChild(script);
	    } else {
		var cors = TUtility.cors(onError);

		cors.open("GET", url, true);

		if(TUtility.isIE == false) {
		    cors.setRequestHeader("Accept", "application/json");
		}

		cors.send();
	    }
	} catch(e) {
	    console.error(e);
	}
    }

    return {
	"init" : function(){
	    if(wasInitialized == false) {
		if(TUtility.isCookieEnabled && !TUtility.getCookie(cookie["wasMigrated"])){
		    if(TUtility.getBody()){
			init();
		    }else{
			head.ready(function(){
			    init();
			});
		    }
		}else{
		    init();
		}
	    } else if(isReady) {
		flushOnReady();
	    }
	},
	"send" : function(url, params, type, onError){
	    if(!params){
		params = {};
	    }
	    params["vt"] = TUtility.idScope;
	    var now = new Date().valueOf();
	    if(isReady) {
		if(/^POST$/ig.test(type)) {
		    sendPost(url, params, now, onError);
		} else {
		    sendGet(url, params, now, type, onError);
		}
	    } else {
		buffer.push({
		    "url" : url,
		    "params" : params,
		    "type" : type,
		    "time" : now,
		    "onError": onError
		});
	    }
	},
	"onFlashReady" : function(id){
	    onFlashReady(id);
	},
	"addOnReadyListener" : function(ref){
	    refs.push(ref);
	},
	"isReady" : function(){
	    return isReady;
	},
	"getId" : function(){
	    return uid;
	},
	"version" : function(){
	    return getVersion();
	}
    };
})();