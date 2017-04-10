
function getCookie(name) {
	var result = '';
	var myCookie = ' '+document.cookie+';';
	var searchName = ' '+name+'=';
	var startOfCookie = myCookie.indexOf(searchName);
	var endOfCookie;
	if(startOfCookie != -1) {
		startOfCookie += searchName.length;
		endOfCookie = myCookie.indexOf(';', startOfCookie);
		result = unescape(myCookie.substring(startOfCookie,endOfCookie))
	}
	return result;
}

function setCookie(name, value, path) {
	var expDate = new Date();
	if (typeof path == 'undefined') {
		path = '/';
	}
	expDate.setTime(expDate.getTime() + 4 * 7 * 24 * 60 * 60 * 1000);//Μερÿφ
	document.cookie = name + '=' + escape(value) + '; expires=' + expDate.toGMTString() + ';path=' + path;
}
