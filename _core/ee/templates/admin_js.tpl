<%header:Content-type: text/javascript%>

function openWin2(url,x,y) {
	ew=window.open(url,"Edit2","width="+x+",height="+y+",status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
	ew.focus();
}

function openWin(url,x,y) {
	ew=window.open(url,"Edit","width="+x+",height="+y+",status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
	ew.focus();
}

function openEditorHTML(f_name, t, language)
{
	openEditor(f_name, t, "html", language);
}

<%include:admin_js_openEditor%>

function openPageMeta(f_name) {
	if (page_name)
	{
		x=720;
		y=244+62*<%getField:SELECT COUNT(*) FROM (SELECT DISTINCT var FROM content WHERE var REGEXP "^meta_") AS result%>;//400
		URL="<%:EE_ADMIN_URL%>page_meta.php?lang=<%:language%>&t="+f_name+"&language=<%:language%>";
		openPopup(URL,x,y);
	}
}
function openTypeSelector(f_name) {
	x=480;
	y=320;
	URL="<%:EE_ADMIN_URL%>cms_by_type.php?lang=<%:language%>&cms_name="+f_name+"";
	openPopup(URL,x,y,true);
}
function addMenu(menu_id, parent) {
	x=550;
	y=400;
	URL="<%:EE_ADMIN_URL%>menu_edit.php?lang=<%:language%>&menu_id="+menu_id+"&parent="+parent+"&type=add&admin_template=<%:admin_template%>";
	openPopup(URL,x,y,true);
}
function editMenu(menu_id, menu_item_id) {
	x=550;
	y=400;
	URL="<%:EE_ADMIN_URL%>menu_edit.php?lang=<%:language%>&menu_id="+menu_id+"&edit="+menu_item_id+"&type=edit&admin_template=<%:admin_template%>";
	openPopup(URL,x,y,true);
}
function deleteMenu(menu_id, menu_item_id) {
	x=700;
	y=255;
	URL="<%:EE_ADMIN_URL%>menu_edit.php?lang=<%:language%>&menu_id="+menu_id+"&delete="+menu_item_id+"&type=delete&admin_template=<%:admin_template%>";
	openPopup(URL,x,y);
}
function edit_img(i_name) {
	x=450;
	y=150;
	URL="<%:EE_ADMIN_URL%>img.php?i_name="+i_name;
	openPopup(URL,x,y);
}

function edit_img_lang(i_name, i_type) {
	x=470;
	y=550;
	URL="<%:EE_ADMIN_URL%>img_edit.php?i_name="+i_name+"&i_type="+i_type;
	openPopup(URL,x,y, true);
}
function publish_confirm(href)
{
	if (confirm('Are you shure whant to publish this page?')) 
	{
		if (confirm('Publish all changes to media content on page?')) href += '&media=true'; 
		location.href = href;
	} 
	return false
}
function revert_confirm(href)
{
	if (confirm('Are you shure whant to revert back all changes on this page?')) 
	{
		if (confirm('Revert all changes to media content on page?')) href += '&media=true'; 
		location.href = href;
	} 
	return false	
}
function block_enter(e) {
	e = (e)?e:window.event;
	if(e.keyCode == '13') return false;
		else return true;
}
function selectSattelitePage(arg_sufix) {
	if(arg_sufix==undefined) {
		arg_sufix = "";
	}
	URL="<%:EE_ADMIN_URL%>_assets.php?return_pages_for_menu=1&show_admin_menu=0&module_title_and_options=0&big_options=0&folder_menu=0&content_menu=0&group_by_options=0&hide_checkbox=1&hide_page_action=1&hide_checkbox=1&hide_page_edit=1&hide_page_autor=1&hide_view=1&hide_index=1&hide_cachable=1&arg_sufix="+arg_sufix;
	// Set the browser window feature.
	var iWidth	= 800;
	var iHeight	= 600;
	window.parent.openPopup2(URL,iWidth,iHeight);
}
function returnPageId(id, path, arg_sufix) {
	if(arg_sufix == undefined) {
		arg_sufix = "";
	}
	document.getElementById('satelit'+arg_sufix).value = id;
	document.getElementById('sattelite_page_path'+arg_sufix).innerHTML = path;
}
function view_full_descr_tip(cms_name)
{
	ddrivetip("<span></span><textarea style='display: none' name='aFieldFullDesc[]' cols='60' rows='5'></textarea>"<%iif:<%show_admin_panel%>,,,+"<br/><img height='24' width='24' border='0' align='top' alt='' style='cursor: pointer' onclick='edit_full_descr(this.parentNode\,\""+cms_name+"\")' src='<%:EE_HTTP%>img/pen24.gif'/><input type='button' value='Save' size='30' class='button' style='display: none' onclick='edit_full_descr(this.parentNode\,\""+cms_name+"\"\,1)'>&nbsp;<input type='button' value='Cancel' size='30' class='button' style='display: none' onclick='edit_full_descr(this.parentNode\,\""+cms_name+"\"\,0)'>"%>); 
	set_full_descr_in_tip(cms_name);
}
function edit_short_descr(element,action)
{
	if (element)
	{
		short_descr = element.childNodes[1];
		if (action == 1)
		{
			element.childNodes[1].innerHTML = element.childNodes[3].value;
			element.childNodes[3].style.display="none";
			element.childNodes[3].value = element.childNodes[1].innerHTML;
			element.childNodes[5].style.display="none";
			element.childNodes[7].style.display='';
		}
		else
		{
			element.childNodes[1].innerHTML = '';
			element.childNodes[3].style.display="";
			element.childNodes[5].style.display="";
			element.childNodes[7].style.display='none';
		}
	}
}
function set_full_descr_in_tip(cms_name, from_tip)
{
	full_desc_text = document.getElementById(cms_name+'_full_desc');
	tip = document.getElementById('dhtmltooltip2');
	if (from_tip == 1)
	{
		full_desc_text.value = replaceString(tip.childNodes[1].value,'\n',"<br/>");
	}
	else
	{
		tip.childNodes[0].innerHTML=full_desc_text.value;
	}
}
function edit_full_descr(element,cms_name,action)
{
	if (element)
	{
		if (action == 1)
		{
			set_full_descr_in_tip(cms_name,1);
			element.childNodes[0].innerHTML=replaceString(element.childNodes[1].value,'\n',"<br/>");
			element.childNodes[1].style.display="none";
			element.childNodes[4].style.display="none";
			element.childNodes[6].style.display="none";
			element.childNodes[3].style.display='';
		}
		else if (action == 0)
		{
			set_full_descr_in_tip(cms_name);
			element.childNodes[1].style.display="none";
			element.childNodes[4].style.display="none";
			element.childNodes[6].style.display="none";
			element.childNodes[3].style.display='';
		}
		else
		{
			element.childNodes[1].value=replaceString(element.childNodes[0].innerHTML,"<br>",'\n');
			element.childNodes[0].innerHTML='';
			element.childNodes[1].style.display='';
			element.childNodes[4].style.display='';
			element.childNodes[6].style.display='';
			element.childNodes[3].style.display="none";
		}
	}
}
function replaceString(haystack, needle, replacement)
{
	var newText = "";
	var i= -1;
	var temp_needle = needle.toLowerCase();
	while(haystack.length > 0) 
	{
		var temp_haystack = haystack.toLowerCase();
		i = temp_haystack.indexOf(temp_needle);
		//if not found, add whole string
		if(i == -1) 
		{
			newText += haystack;
			haystack = "";
			break;
		}
		// make a temporary copy of replacement word
		repWord = haystack.substr(i-1, temp_needle.length);
		// Assume replacement always start with same character as needle
		temp_rep = repWord.charAt(0)+replacement.substr(0);
		// ensure the case of the replacement matches the case of the original
		newText += haystack.substr(0, i-1) + temp_rep;
		haystack = haystack.substr(i+temp_needle.length);
	}
	return newText;	
}