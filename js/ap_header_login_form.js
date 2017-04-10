
function checkEnter(e){ //e is event object passed from function invocation
	var characterCode //literal character code will be stored in this variable

	if(e && e.which){ //if which property of event object is supported (NN4)
		e = e;
		characterCode = e.which; //character code is contained in NN4's which property
	}
	else{
		e = event||window.event;
		characterCode = e.keyCode; //character code is contained in IE's keyCode property
	}

	if (characterCode == 13){ //if generated character code is equal to ascii 13 (if enter key)
		return true;
	}
	else{
		return false;
	}
}


function isIE()
{
	// Получим userAgent браузера и переведем его в нижний регистр 
	var ua = navigator.userAgent.toLowerCase(); 

	// Определим Internet Explorer 
	var is_ie = (ua.indexOf("msie") != -1 && ua.indexOf("opera") == -1 && ua.indexOf("webtv") == -1);

	return is_ie;
}

function isGoogleChrome()
{
	// Получим userAgent браузера и переведем его в нижний регистр 
	var ua = navigator.userAgent.toLowerCase(); 

	// GoogleChrome
	isChrome = (ua.indexOf("chrome") != -1); 

	return isChrome;
}

//alert(isGoogleChrome());

/*
// Opera 
isOpera = (ua.indexOf("opera") != -1);
// Safari, используется в MAC OS 
isSafari = (ua.indexOf("safari") != -1 && ua.indexOf("chrome") == -1); 
// Konqueror
isKonqueror = (ua.indexOf("konqueror") != -1); 

isMozila = (ua.indexOf("firefox") != -1); 
// Простая проверка с помощью document.write 
document.write( 
    "userAgent = " + ua + "<br /><br />" + 
    "isIE = " + isIE + "<br />" + 
    "isMozila = " + isMozila + "<br />" + 
    "isOpera = " + isOpera + "<br />" + 
    "isSafari = " + isSafari + "<br />" + 
    "isChrome = " + isChrome + "<br />" + 
    "isKonqueror = " + isKonqueror + "<br />" 
); 
*/

//alert(isIE());
