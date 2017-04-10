function strrev( string )
{
	var ret = '', i = 0;
	for ( i = string.length-1; i >= 0; i-- )
	{
		ret += string.charAt(i);
	}
	return ret;
}

function __unmt(__mt)
{
	if (__mt.indexOf('#') == -1)
	{
		return __mt;
	}

	var __hidden_mt = __mt;
	var __good_mt = '';
        for (var i = 0; i < __hidden_mt.length; i += 2)
	{
		var __lchar = __hidden_mt.substr(i+1,1) == '#' ? '@' : __hidden_mt.substr(i+1,1);
		var __hchar = __hidden_mt.substr(i,1) == '#' ? '@' : __hidden_mt.substr(i,1);
		__good_mt += __lchar + __hchar;
	}
        __good_mt = strrev(__good_mt.replace(/(^[\s\xA0]+|[\s\xA0]+$)/g, ''));

	return __good_mt;
}

function __show_mt()
{
	if (__hm_data == undefined || __hm_data.count == undefined)
	{
		return;
	}
	for (var j = 0; j < __hm_data.count; j++) 
	{
		if(document.getElementById('ee-hm-'+j) !== null)
		document.getElementById('ee-hm-'+j).innerHTML = '<a' + __hm_data[j].prefix + strrev(':otliam"=ferh') + __unmt(__hm_data[j].mt) + '"'  + __hm_data[j].postfix + '>' + __unmt(__hm_data[j].title) + '</' + 'a>';
	}
}

function email_decode_ajax_code(response) {
	//delete all ids of old email containers
	var i = 0;
	while(document.getElementById('ee-hm-'+i) != null) {
		document.getElementById('ee-hm-'+i).removeAttribute('id');
		i++;
	}
	//delete json array with old emails
	if(__hm_data != null) {
		__hm_data = null;
	}
	//now we ready to add new email to page
	//find in response text commentary with json array
	var re = /<!-- var (.*) -->/g;//because variable __hm_data already defined we must del 'var' declaration
	re.lastIndex = 0;//reset previous search values
	var matches = re.exec(response);
	if(matches != null && matches.length>=2) {
		//apply new emails decode source
		eval(matches[1]);
		//delete commentary from source response text
		response = response.replace(matches[0], '');
	}
	return response;
}

