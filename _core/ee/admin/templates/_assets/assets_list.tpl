<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%iif:<%config_var:use_draft_content%>,1,<%:DRAFT_MODE_TITLE%>,<%str_to_title::modul_title%> List%></title>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">

	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
    <script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/container_core.js"></script>
    <link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/menu/assets/skins/sam/menu.css">
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/menu/menu.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" />
	<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/treeview/assets/skins/sam/treeview.css" />
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo/yahoo-min.js"></script>
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/event/event-min.js"></script>
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/treeview/treeview-min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>css/tree.css">
	
	<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/datatable/assets/skins/sam/datatable.css" />
	<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script-->
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/dragdrop/dragdrop-min.js"></script>
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/element/element-beta-min.js"></script>
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/datasource/datasource-min.js"></script>
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/datatable/datatable-min.js"></script>
	
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/connection/connection-min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/assets/skins/sam/button.css" />
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/element/element-min.js"></script>
	<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/button/button-min.js"></script>

    <link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css" />
    <%iif:<%:show_admin_menu%>,1,<link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css" />%>
	
	<style type="text/css">
	body {margin: 0; padding: 0;}
	#expandcontractdiv {border:1px dotted #dedede; background-color:#EBE4F2; margin:0 0 .5em 0; padding:0.4em;}
	#treeDiv1 {background: #fff; padding:0 1em; margin-top:0;}
	.yui-skin-sam .yui-dt-liner {white-space:nowrap;}
	/*For what?*/
	#operainstructions li em {font-weight: bold;}
	#operainstructions {list-style-type: square; margin-left: 2em;}
	
	/*context menu*/
	.yuimenu {z-index: 12 !important;}
	#left_folders .yuimenu .bd .first-of-type,
	#right_pages .yuimenu .bd .first-of-type {
		margin: 5px;
		padding: 0;
	}
	.yuimenu .bd .first-of-type,
	.yuimenu .bd .first-of-type TD,
	.yuimenu .bd .first-of-type A {
		font: 10px Tahoma, Verdana, Geneva, Arial, Helvetica, sans-serif;
		color: #444;
	}
	.assets_header #draft_mode_buttons *,
	.assets_header #filter_buttons *,
	.assets_header #group_by_buttons * {
		font-size: 11px;
	}
	
	#left_folders .yuimenu .bd UL,
	#right_pages .yuimenu .bd UL {
		display: none;
		visibility: hidden;
	}
	
	div.yuimenu .bd {zoom: normal;}
	.yuimenu .bd .first-of-type TH,
	.yuimenu .bd .first-of-type TD {border: none;}
	
	#publish_button-button,
	#revert_button-button,
	#group_by_button-button,
	#filter_button-button {
		display: block;
	}
	
	/*small width overflow fix*/
	.ygtvspacer{margin-right: 5px; text-decoration: none !important;}
	
	.ygtvlp .ygtvspacer,
	.ygtvln .ygtvspacer,
	.ygtvlm .ygtvspacer,
	.ygtvlmh .ygtvspacer,
	.ygtvlph .ygtvspacer
	{width: 34px;}
	</style>
	
<script language="JavaScript" type="text/javascript">
var cur_folder_pos;//vartiable to pass to content menu function, consist position of current folder, we will set value of this varialbe in the end of the script then TreeView will be created, this value will be based on cur_folder value
var pagesLabelsNum = 0;//variable handle the number of content
var lastFolderPos = 0;//variable handle number of folders, then we recieve new folder we increment their positions ids in order to prevet errors
var cur_folder = '<%get_curr_folder_id%>';//variable handle id of current folder
var searchTimer;//variable handle timer to show search results then user end inputting serach query
//Текущая активная папка, нужна для функции makeFolderActive
var previouslyNodePos = getFromCookie('_assets_expand_folder_pos');
if(previouslyNodePos == '') previouslyNodePos = 1;//root
var tree; //TreeView object
var oContextMenu;//ContentMenu for TreeView
var dt = null;//DataTable object
var cm = null;//ContentMenu for DataTable

//function return link into FCK editor
function addLinkToFCK(id){
	window.top.opener.SetUrl('<%:EE_HTTP_PREFIX%>index.php?t='+id+'&language=<%_get:lang%>');
	window.top.close();
	window.top.opener.focus();
}

//function return id of media for media insert dialog
function insertMediaId(id, path){
	window.parent.iframe_popup.returnMediaId(id, path);//nickM changed
	window.top.closePopup2();
}

//function return PageId of page for menu edit dialog
function insertPageId(id, path, arg_sufix){
	if(arg_sufix == undefined) {
		arg_sufix = "";
	}
	if(window.parent.document.getElementById('sattelite_page_path')) {//значит мы открыли окно ассетс менеджера не из попап окна, а из главного окна
		window.parent.returnPageId(id, path, arg_sufix);
	} else {
		for(var i=0; i<10; i++) {
			if(window.parent.frames[i].document.title != '') {//ищем первое окно в котором указан заголовок, в окнах-затемнителях заголовка нет
				window.parent.frames[i].returnPageId(id, path, arg_sufix);
				break;
			}
		}
	}
	
	window.parent.closePopup2();
}

//function show all properies of object
function inspect(elm){
	var str = "";
	i=0;
	for (var i in elm){
		str += i + ": " + elm.getAttribute(i) + "\n";
	}
	alert(str);
	//alert(str.substring(0, 800));
	//alert(str.substring(800, 1600));
	//alert(str.substring(1600, 2400));
	//alert(str.substring(2400, 5000));
}

//function count substring matches in string 
function countMatches(whatFind, whereFind){
	var matches = 0;
	var lastIndex = 0;
	while(whereFind.indexOf(whatFind,lastIndex) != -1){
		lastIndex = whereFind.indexOf(whatFind,lastIndex)+1;
		matches++;
	}
	return matches;
}

//function show imahe in search field
function showSearchImage(name){
	//hide all
	document.getElementById('search_image_find').style.display = 'none';
	document.getElementById('search_image_busy').style.display = 'none';
	document.getElementById('search_image_reset').style.display = 'none';
	//show only one
	document.getElementById('search_image_'+name).style.display = 'block';
}

//function get and returns folders structure, may get only part of folders tree
function getFoldersList(folder_id, is_expanded, folder_active_id){
	var handleSuccess = function(o){
		if(o.responseText !== undefined){
			//alert(o.responseText);
			if(tree){
				//delete current childs of node
				tree_unsubscribe();
				var parent_folder = tree.getNodeByProperty('id', folder_id);
				tree.removeChildren(parent_folder);
				//add new data
				eval(o.responseText);
				//apply changes
				tree.draw();
				if(!is_expanded){
					parent_folder.expand();
				}
				tree_subscribe();
				makeFolderActive(tree.getNodeByProperty('id', folder_active_id).data.pos);
				lastFolderPos += countMatches("new YAHOO.widget.TextNode", o.responseText);
				
				//убиваем события иначе при удалении таблицы все папки сворачиваются, эти данные сохранятся в кукисах и новая папка будет свернута
				//tree.unsubscribe("expand");
				//tree.unsubscribe("collapse");
				
				//tree.removeChildren(tmpNode_0);
				//tree.destroy();
				//tree = null;
				//!!!
				//удаляем память строк дерева
				//YAHOO.widget.TreeView.nodeCount = 0;
				//эта зараза удалила мой treeDiv1
				//if(!document.getElementById('treeDiv1'))
				//{
				//	var parent = document.getElementById('left_folders_content');
				//	var treeDiv = document.createElement('div');
				//	treeDiv.setAttribute('id', 'treeDiv1');
				//	parent.appendChild(treeDiv);
				//}
				//tree = new YAHOO.widget.TreeView("treeDiv1");
				//eval(o.responseText);
				//treeInit();
			}
		}
	};
	var callback =
	{
  		success:handleSuccess
	};
	var sUrl = "<%:EE_ADMIN_URL%><%:modul%>.php";
	var postData = "op=get_folders_list&folder_id="+folder_id+"&startPosition="+lastFolderPos+"&rand="+Math.random()+"&return_pages_for_fck=<%:return_pages_for_fck%>&return_medias_for_insert=<%:return_medias_for_insert%>&return_pages_for_menu=<%:return_pages_for_menu%>";
	var request = YAHOO.util.Connect.asyncRequest('POST', sUrl, callback, postData);
}

//function return pages to datatable
var returnPages = function(o){
	if(o.responseXML !== undefined){
		//alert(o.responseText);
		var root = o.responseXML.documentElement;
		var pages = new Array();
		for(var i = 0; i<root.getElementsByTagName('pages').length; i++){
			pages[pages.length] = root.getElementsByTagName('pages')[i].firstChild.nodeValue;
		}
		pages = '{'+"\r\n"+'pages: ['+pages.join(",\r\n")+']'+"\r\n"+'};';
		YAHOO.example.Data.pages = eval(pages);
		
	if(<%:show_content_menu%>){
		var labels = new Array();
		//pageId обладают памятью
		pagesLabelsNum = pageLabelTexts.length;//сколько было
		if(typeof(pagesLabelsNum) != 'undefined'){
			pagesLabelsNum.length = 0;
		}
		for(var i = 0; i<root.getElementsByTagName('labels').length; i++){
			labels[i] = root.getElementsByTagName('labels')[i].firstChild.nodeValue;
			eval('pageLabelTexts[pagesLabelsNum+i] = '+labels[i]+';');//strip quotes .substr(1,labels[i].length-2)
		}
	}
		//if we show search results change image in search field
		if(o.argument.action == 'search'){
			showSearchImage('reset');
		}
		tableInit(cur_folder);
	}
};

var returnPagesForSearch = function(o){
	if(o.responseXML !== undefined){
		//update folders
		tree_unsubscribe();
		tree.removeChildren(tree.getNodeByProperty('id', 0));
		
		returnPages(o);
	}
	
}

//function indicate what something going wrong with AJAX request
var noReturnPages = function(o){
//if we show search results change image in search field
	if(o.argument.action == 'search'){
		showSearchImage('find');
	}
}

//function get pages and medias of folder
function getPagesContent(){
	var callback =
	{
  		success: returnPages,
		failure: noReturnPages,
		argument: {action: "get_content"},
		timeout: 30000
	};
	var sUrl = "<%:EE_ADMIN_URL%><%:modul%>.php";
	var postData = "op=get_folder_content&folder_id="+cur_folder+"&rand="+Math.random()+"&return_pages_for_fck=<%:return_pages_for_fck%>&return_medias_for_insert=<%:return_medias_for_insert%>&return_pages_for_menu=<%:return_pages_for_menu%>";
	var request = YAHOO.util.Connect.asyncRequest('POST', sUrl, callback, postData);
}

//function store assets manager column width, sort column and sort type in 1 cookie, values seperate with new lines \r\n
function addToCookieColumnParameter(name, value) {
	var data = getFromCookie('_assets_column_parameters');
	var parameters = data.split(';');
	params = new Array();
	is_param_present = false;
	for(var i=0; i<parameters.length; i++) {
		var params = parameters[i].split('=');
		if(params[0] == name) {//replace previous value with current
			params[1] = value;
			parameters[i] = params.join('=');
			is_param_present = true;
			break;
		}
	}
	if(!is_param_present) {//ad to the end of the list
		parameters[parameters.length] = ';'+name+'='+value;
	}
	data = parameters.join(';');
	addToCookie('_assets_column_parameters', data+';');
}

//function store assets manager column width, sort column and sort type in 1 cookie, values seperate with ;
function getFromCookieColumnParameter(name) {
	var data = getFromCookie('_assets_column_parameters');
	var parameters = data.split(';');
	//check if value exists
	var param_value = null,
	params = new Array();
	for(var i=0; i<parameters.length; i++) {
		params = parameters[i].split('=');
		if(params[0] == name) {
			param_value = params[1];
			break;
		}
	}
	return param_value;
}

//function add value to cookies
function addToCookie(name, value){
	var expDate = new Date();
	expDate.setTime(expDate.getTime() + 4 * 7 * 24 * 60 * 60 * 1000);//Месяц
	document.cookie = name + '=' + escape(value) + '; expires=' + expDate.toGMTString() + ';path=<%:EE_HTTP_PREFIX%>';
}

//function get value from cookies
function getFromCookie(name){
	var result = '';
	var myCookie = ' '+document.cookie+';';
	var searchName = ' '+name+'=';
	var startOfCookie = myCookie.indexOf(searchName);
	var endOfCookie;
	if(startOfCookie != -1){
		startOfCookie +=searchName.length;
		endOfCookie = myCookie.indexOf(';', startOfCookie);
		result = unescape(myCookie.substring(startOfCookie,endOfCookie))
	}
	return result;
}

//function set option to display folders in plain or as tree and necessity to display pages/medias
function setDisplayMedia(value){
	//value of "display_medias" stored in cookies
	//Если пользователь до этого смотрель assets manager в стандартном режиме
	//а потом переключился в просмотр в root папке то запоминаем страницу на которой он был
	
	if(getFromCookie('_assets_display_medias') == ''){
		addToCookie('_assets_original_page_id', cur_folder);
		addToCookie('_assets_expand_folder_id', 0);
	}
	if(value == ''){
		var original_page_id = getFromCookie('_assets_original_page_id');
		if(original_page_id != ''){
			addToCookie('_assets_expand_folder_id', original_page_id);
		}
	}
	addToCookie('_assets_display_medias', value);
	window.location.reload(true);
}

//function perform search then user end inputting search query
function performQuickSearch(){
	if(searchTimer != '') clearTimeout(searchTimer);
	searchTimer = setTimeout("performSearch()", 500);
}

function performSearch(){
	//clear all timers
	if(searchTimer != '') clearTimeout(searchTimer);
	//show necessary image in search field
	showSearchImage('busy');
	
	var searchField = document.getElementById('search_field').value.replace(/(^\s+)|(\s+$)/g, '');
	if(searchField == ''){
		performReset();
	}else{
		//update pages
		var callback =
		{
  			success:returnPagesForSearch,
			failure: noReturnPages,
			argument: {action: "search"},
			timeout: 10000
		};
		var sUrl = "<%:EE_ADMIN_URL%><%:modul%>.php";
		var postData = "op=search&search_query="+searchField+"&rand="+Math.random()+"&return_pages_for_fck=<%:return_pages_for_fck%>&return_medias_for_insert=<%:return_medias_for_insert%>&return_pages_for_menu=<%:return_pages_for_menu%>";
		var request = YAHOO.util.Connect.asyncRequest('POST', sUrl, callback, postData);
	}
}

//function reset search values and return folders and content as it was before search
function performReset(){
	//show necessary image in search field
	showSearchImage('find');
	//update folders
	getFoldersList(0, 0, cur_folder);
	//update pages
	getPagesContent();
}

//function mark current folder bold
function makeFolderActive(pos) {
	//alert(pos);
	if(previouslyNodePos != '' && document.getElementById('ygtvlabelel'+previouslyNodePos)){
		document.getElementById('ygtvlabelel'+previouslyNodePos).style.fontWeight = 'normal';
	}
	if(document.getElementById('ygtvlabelel'+pos)){
		document.getElementById('ygtvlabelel'+pos).style.fontWeight = 'bold';
	}
	previouslyNodePos = pos;
	addToCookie('_assets_expand_folder_pos', pos);
}

function selected_rows_switch(switcher_value)
{
	var checkboxobject = document.checkbox_form;
	for(i = 0; i < checkboxobject.length; i++)
	{
		if(checkboxobject.elements[i].type == 'checkbox')
		{
			checkboxobject.elements[i].checked = switcher_value;
		}
	}
}

function selected_rows_submit(operation, confirm_msg, option)
{
	var result;
	var checkboxobject = document.checkbox_form;
	var hidden_input_val = checkboxobject.op;
	for(i = 0; i < checkboxobject.length; i++)
	{
		if(checkboxobject.elements[i].type == 'checkbox')
		{
			if(checkboxobject.elements[i].checked == true)
			{
				result = true;
			}
		}
	}
	if(result == true)
	{
		if(confirm(confirm_msg))
		{
			hidden_input_val.value = operation;
			checkboxobject.submit();
		}
	}
	else
	{      
		if(option == null)
		{
			alert('<%:SEL_GRID_ITEM_WARNING%>');		
		}
		else if(confirm('<%:SEL_GRID_ITEM_EXTEND_WARNING%>'))
		{
			for(i = 0; i < checkboxobject.length; i++)
			{
				if(checkboxobject.elements[i].type == 'checkbox')
				{
					checkboxobject.elements[i].checked = true;
				}
			}
			hidden_input_val.value = operation;
			checkboxobject.submit();	          			
		}	
	}
}

function openWinMetaTitle(text) {
	meta_text = text;
	openPopup('<%:EE_ADMIN_URL%>seo_meta_title_edit.php?admit_template=yes&meta_tag_name='+text,400,500,true);
}

function copy(op, code, type, name, add_url){
	var url='';
	if(confirm(name)) {
			url='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op='+op+'&copypage='+code+'&type='+type;
		if (add_url){
			url+=('&'+add_url);
		}
		document.location.href=url;
	} else return false;
}

function del(op, code, name, add_url) {
	var url='';
       if(confirm(name)) {
			url='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op='+op+'&del='+code;
		if (add_url){
			url+=('&'+add_url);
		}
		document.location.href=url;
	} else return false;
}

function delete_page_cache(code, name, add_url) {
	var url='';
    	if(confirm('Are you sure to clear the cache of '+name+'?')) {
			url='<%:modul%>.php?page=<%:page%>&srt=<%get:srt%>&click=<%:click%>&op=delete_page_cache_for_all_lng&t='+code+'&admin_template=yes';
		if (add_url){
			url+=('&'+add_url);
		}
		document.location.href=url;
    } else return false;
}

function openFolderPopup(id, parent_id){
	openPopup('_tpl_folder.php?op=1&edit='+id+'&admin_template=yes&folder_id='+parent_id,<%:popup_width%>,<%:folder_popup_height%>,<%:popup_scroll%>);
}
function openPagePopup(id, for_search){
	openPopup('_tpl_page.php?op=1&edit='+id+'&admin_template=yes&prev_next=1&for_search='+for_search,<%:popup_width%>,<%:page_popup_height%>,<%:popup_scroll%>);//add 20px to height due to previous/next items
}
function openMediaPopup(id, for_search){
	openPopup('_media.php?op=1&edit='+id+'&admin_template=yes&prev_next=1&for_search='+for_search,<%:popup_width%>,<%:media_popup_height%>,<%:popup_scroll%>);//add 20px to height due to previous/next items
}
function deleteFolder(id, name){
	del('delete_folder',id,'Folder \''+name+'\' will be deleted. Are you sure to continue?','');
}
function cannotDeleteFolder(name){
	alert('Can\'t delete folder \''+name+'\'. Folder is not empty');
}
function deletePage(id, name, type){
	var delete_what = 'delete_page';
	if(type.toLowerCase() == 'media') delete_what = 'delete_media';
	del(delete_what,id,type+' \''+name+'\' will be deleted. Are you sure to continue?','');
}
function deleteMedia(id, name, type){
	del('delete_media',id,type+' \''+name+'\' will be deleted. Are you sure to continue?','');
}
function copyPage(id, name, type){
	copy('copy_page',id,type,'Copy '+type+' \''+name+'\'?','');
}
function add_folder(){
	var folder_id = getCurrentFolderId();
	openPopup('_tpl_folder.php?op=3&admin_template=yes&folder_id='+folder_id,<%:popup_width%>,<%:folder_popup_height%>,<%:popup_scroll%>);
}
function add_page(){
	var folder_id = getCurrentFolderId();
	openPopup('_tpl_page.php?op=3&admin_template=yes&folder='+folder_id,<%:popup_width%>,<%:page_popup_height%>,<%:popup_scroll%>);
}
function add_media(){
	var folder_id = getCurrentFolderId();
	openPopup('_media.php?op=3&admin_template=yes&from=assets&folder='+folder_id,<%:popup_width%>,<%:media_popup_height%>,<%:popup_scroll%>);
}
function deletePageCache(id){
	delete_page_cache(id,'Page id='+id,'');
}
function getCurrentFolderId(){
	var folder_id = '';
	folder_id = getFromCookie('_assets_expand_folder_id');
	if(folder_id == ''){
		folder_id = '<%get_curr_folder_id%>';
	}
	return folder_id;
}
function moveFiles(){
	var folder_id = getCurrentFolderId();
	var result = new Array();
	var checkboxobject = document.checkbox_form;
	var j = 0;
	for(i = 0; i < checkboxobject.length; i++)
	{
		if(checkboxobject.elements[i].type == 'checkbox')
		{
			if(checkboxobject.elements[i].checked == true)
			{
				result[j++] = checkboxobject.elements[i].title+'='+checkboxobject.elements[i].value;
			}
		}
	}
	if(result.length > 0)
	{
		openPopup('_assets.php?op=move_files&admin_template=yes&folder='+folder_id+'&selected_files='+result.join(','),500,180+result.length*16,<%:popup_scroll%>);
	}
}

function onWindowResize(){
	var wheight = (window.innerHeight)?window.innerHeight:((document.all)?document.body.offsetHeight-4:null);
	wheight -= <%:assets_lists_padding_top%>;
	document.getElementById('left_folders_content').style.height = wheight+'px';
	document.getElementById('right_pages_content_inner').style.height = wheight+'px';
}

function tree_subscribe(){
	tree.subscribe("labelClick", function(node) {
		//заново создаем таблицу
		/////tableInit(node.data.id);
		//запоминаем текущую папку
		addToCookie('_assets_expand_folder_id', node.data.id);
		cur_folder = node.data.id;
		addToCookie('_assets_expand_folder_pos', node.data.pos);
		cur_folder_pos = node.data.pos;
		//if(node.expanded){
		//	addToCookie('_assets_expand_folder_' + node.data.id, 0);
		//}else{
		//	addToCookie('_assets_expand_folder_' + node.data.id, 1);
		//}
		//TESTING
		makeFolderActive(cur_folder_pos);
		getFoldersList(cur_folder, node.expanded, cur_folder);
		getPagesContent();
		//alert(node.data.id + " label was clicked");
	});
		
	tree.subscribe("expand", function(node) {
		//запоминаем открытые узлы
		addToCookie('_assets_expand_folder_' + node.data.id, 1);
		/////cur_folder = node.data.id;
		//TESTING
		/////makeFolderActive(node.data.pos);
		//alert(node.data.id + " was expanded");
	});

	tree.subscribe("collapse", function(node) {
		//запоминаем закрытые узлы
		addToCookie('_assets_expand_folder_' + node.data.id, 0);
		/////cur_folder = node.data.id;
		//TESTING
		/////makeFolderActive(node.data.pos);
		//alert(node.data.id + " was collapsed");
	});
}

function tree_unsubscribe(){
	tree.unsubscribe("labelClick");
	tree.unsubscribe("collapse");
	tree.unsubscribe("expand");
}
</script>
<style type="text/css">
#left_folders, #right_pages {
	position: absolute;
	top: <%:assets_lists_padding_top%>px;
}
#left_folders {
	background-color: #FFF;
	width: 250px;
	z-index: 10;
	_z-index: 8;
}
#left_folders_content {overflow-y: auto;}
#right_pages {
	width: 100%;
	z-index: 9;
}
#right_pages_content {
	padding-left: 252px;
}
#right_pages_content_inner {overflow-y: auto;}
body {overflow-y: hidden;/*for opera*/}
</style>
<%print_admin_js%>
</head>
<body class=" yui-skin-sam" onresize="onWindowResize();">
<div id="whole_page_content">
<div id="dhtmltooltip2" onMouseOver="clearTimeout(tm1)" onMouseOut="tm1=setTimeout('hideddrivetip()',500)"></div>
<%iif:<%config_var:use_draft_content%>,1,<%iif:<%checkAdmin%>,1,<div id="draft_div">DRAFT MODE</div>%>%>
<SCRIPT language="JavaScript"  type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>

<%iif:<%:show_admin_menu%>,1,<%:admin_menu%>%>

<%try_include:<%:modul%>/js_onChange%>
<%try_include:<%:modul%>/print_channel_info%>

<table border="0" class="assets_header">
<tr>
	<%include:<%iif:<%:show_module_title_and_options%>,1,<%:modul%>/module_title_and_options%>%>
	<td nowrap>
		<div style="float: left;">
			<%include:<%iif:<%:show_big_options%>,1,<%:modul%>/big_options%>%>
			<%try_include:<%:modul%>/list_refresh_button%>
		</div>
	</td>
	<%try_include:<%iif:<%config_var:use_draft_content%>,1,<%:modul%>/publish_buttons%>%>
	<%try_include:<%iif:<%:show_group_by_options%>,1,<%:modul%>/list_display_medias%>%>
	<%try_include:<%:modul%>/list_search_field%>
</tr>
</table>

<div id="left_folders"><div id="left_folders_content">

<div id="treeDiv1"></div>

<script type="text/javascript">
//an anonymous function wraps our code to keep our variables
//in function scope rather than in the global namespace:
tree = new YAHOO.widget.TreeView("treeDiv1");
		
<%print_folders%>

//(function() {
	function treeInit() {
		
		if(oContextMenu)
		{
			oContextMenu.destroy();
			oContextMenu=null;
		}
		
		var oTextNodeMap = {};
		
		//moved up
		//tree = new YAHOO.widget.TreeView("treeDiv1");

		tree_subscribe();

		//once it's all built out, we need to render
		//our TreeView instance:
		tree.draw();
		
		//Выделяем текущую папку
		makeFolderActive(previouslyNodePos);
		lastFolderPos = tree.getNodeCount();
		
		//set value of cur_folder_pos based on cur_folder
		cur_folder_pos = tree.getNodeByProperty('id', cur_folder).data.pos;
		
		//not in use
		//handler for expanding all nodes
		//YAHOO.util.Event.on("expand", "click", function(e) {
		//	tree.expandAll();
		//	YAHOO.util.Event.preventDefault(e);
		//});
		
		//handler for collapsing all nodes
		//YAHOO.util.Event.on("collapse", "click", function(e) {
		//	tree.collapseAll();
		//	YAHOO.util.Event.preventDefault(e);
		//});
		////////////////CONTEX MENU
if(<%:show_folder_menu%>){
		var oCurrentTextNode = null;
		
		var nodeId = '';//deviant add
	
		function onTriggerContextMenu(p_oEvent) {
			
			var nodeId = tree.getNodeByElement(this.contextEventTarget).data.id;
			//var oTarget = this.contextEventTarget,
			//Dom = YAHOO.util.Dom;
			
			//var oTextNode = Dom.hasClass(oTarget, "ygtvlabel") ? 
			//	oTarget : Dom.getAncestorByClassName(oTarget, "ygtvlabel");
			//if (oTextNode) {
			//	oCurrentTextNode = oTextNodeMap[oTarget.id];
			//}
			//else {
			//	this.cancel();
			//}

			//Начинаем подсовывать в контекстное меню тот текст что нам надо
			//nodeId = oTextNode.id;//ygtvlabelN
			//nodeId = nodeId.substr(11);//удаляем "ygtvlabel" и остается ID узла
			
			//Сперва была идея заменять содержимое пункта меню на нашу подсказку
			//Но поскольку YUI перехватывает события елементов меню ссылки работать не будут
			//Сейчас мы засовываем подсказку в caption к елементу меню
			
			//Изменяем значение
			//oContextMenu.clearContent();
			//oContextMenu.addItems([{text: ""+eval('nodeText_'+nodeId)+"" }]);
			
			//устанавливаем новое значение, для root папки ничего не делаем
			if(nodeId == '0'){
				this.cancel();
			}else{
				oContextMenu.setItemGroupTitle(""+eval('nodeText_'+nodeId)+"", 0);
				oContextMenu.render(document.body);
			}
		}

		oContextMenu = new YAHOO.widget.ContextMenu("mytreecontextmenu", { trigger: "treeDiv1" });

		//Функция не дает меню закрытся
			
		function voidClick(){
			this.show();
		}
		//Привязываем клик в меню к событию
		oContextMenu.subscribe("click", voidClick);
		
		//Привязываем открытие меню по щелчку правой кнопкой к функции
    	oContextMenu.subscribe("triggerContextMenu", onTriggerContextMenu);
	
		// Первое значение
		oContextMenu.addItems([{ text: " " }]); 
		oContextMenu.render(document.body);
}
	}
	
	//When the DOM is done loading, we can initialize our TreeView
	//instance:
	YAHOO.util.Event.onDOMReady(treeInit);
	
//})();//anonymous function wrapper closed; () notation executes function

</script>

</div></div>
<div id="right_pages"><div id="right_pages_content"><div id="right_pages_content_inner">

	<form action="#" name="checkbox_form" method="post">
	<div id="basic"></div>
	<input type = "hidden" name = "op" value = ""/>
	</form>
	
<script type="text/javascript">
//YAHOO.example.Data = {
		<%print_pages%>
//};

// http://developer.yahoo.com/yui/docs/YAHOO.widget.ContextMenu.html
// void cancel ( ) - Cancels the display of the context menu. 
// void destroy ( ) - Removes the context menu's <div> element (and accompanying child nodes) from the document.
// void init ( p_oElement , p_oConfig ) - The ContextMenu class's initialization method. This method is automatically called by the constructor, and sets up all DOM references for pre-existing markup, and creates required markup if it is not already present. 
function tableInit(tableId) {
	if(cm){
		cm.destroy();
		cm=null;
	}
	
	if(dt){
		dt.destroy();
		dt=null;
	}
	
	//получаем размеры колонок и вписываем их в таблицу
    YAHOO.example.Basic = new function() {//ContextMenu
		for(var i=0; i<10+1; i++){
			/////eval("var column_width_"+i+" = +getFromCookie('_assets_column_"+i+"');");
			eval("var column_width_"+i+" = +getFromCookieColumnParameter('_assets<%:cookies_prepend%>_column_"+i+"');");
			eval("column_width_"+i+" = (column_width_"+i+" == 0)?'':', width:'+column_width_"+i+";");
		}
		
		var checkboxValue = '{key:"checkbox", label:"<input title=\'All rows check/uncheck\' name=\'selected_rows_switcher\' onclick=\'selected_rows_switch(this.checked);\' type=\'checkbox\'>", sortable:false, resizeable:true'+column_width_0+'},';
		if(<%:hide_checkbox%>){checkboxValue = '';}
		var pageEditValue = ',{key:"pageEdit", label:"Date modified", sortable:true, resizeable:true'+column_width_5+'}';
		if(<%:hide_page_edit%>){pageEditValue = '';}
		var pageAutorValue = ',{key:"pageAutor", label:"Author", sortable:true, resizeable:true'+column_width_6+'}';
		if(<%:hide_page_autor%>){pageAutorValue = '';}
		var viewValue = ',{key:"view", label:"View", sortable:true, resizeable:true'+column_width_7+'}';
		if(<%:hide_view%>){viewValue = '';}
		var indexValue = ',{key:"index", label:"Index", sortable:true, resizeable:true'+column_width_8+'}';
		if(<%:hide_index%>){indexValue = '';}
		var cachableValue = ',{key:"cachable", label:"Cachable", sortable:true, resizeable:true' + column_width_9 + '}';
		if(<%:hide_cachable%>){cachableValue = '';}
		var previewValue = ',{key:"preview", label:"Preview", sortable:true, resizeable:true'+column_width_9+'}';
		if(<%:hide_preview%>){previewValue = '';}
		var pageActionValue = ',{key:"pageAction", label:"", sortable:false, resizeable:true'+column_width_10+'}';
		if(<%:hide_page_action%>){pageActionValue = '';}

		var draftModeValue = ',{key:"pageDraftMode", label:"Draf Mode", sortable:true}';
		if('<%config_var:use_draft_content%>' == '0'){ draftModeValue = ''; }
		
        eval('var myColumnDefs = ['+//, width:200
            checkboxValue+
            '{key:"pageName", label:"Page name", sortable:true, resizeable:true'+column_width_1+'},'+
			'{key:"pageDescription", label:"Description", sortable:true, resizeable:true'+column_width_2+'},'+
			'{key:"pageType", label:"Type", sortable:true, resizeable:true'+column_width_3+'}'+
			',{key:"pageTemplate", label:"Template", sortable:true, resizeable:true'+column_width_4+'}'+
			pageEditValue+
			pageAutorValue+
			viewValue+
			indexValue+
			cachableValue+
			previewValue+
			draftModeValue+
			pageActionValue+
        '];');

        eval('this.myDataSource = new YAHOO.util.DataSource(YAHOO.example.Data.pages);');
        this.myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        this.myDataSource.responseSchema = {
            fields: ["checkbox","pageName","pageDescription","pageType","pageTemplate","pageEdit","quantity","amount","title","pageAutor","view","index", "cachable", "preview", "pageDraftMode", "pageAction"]
        };

		YAHOO.widget.DataTable.MSG_ERROR = "This folder not contain pages.";
		YAHOO.widget.DataTable.MSG_EMPTY = "This folder not contain pages.";
        this.myDataTable = new YAHOO.widget.DataTable("basic", myColumnDefs, this.myDataSource, {scrollable: false});
		
		//CONTEXT MENU begin
		
		function onRightClick(p_sType, p_aArgs, p_myDataTable){
			//var pageId = dt.getRecordIndex(dt.getTdEl(this.contextEventTarget));//OLD
			var pageId = dt.getRecord(dt.getTdEl(this.contextEventTarget))._sId.substring(7);//NEW
			//Проблема в том, что когда мы меняем папку, тоесть вписываем новое содержимое в DataTable то нумерация строк не начинается заново а продолжается
			//alert(pageId);
			cm.setItemGroupTitle(""+eval('pageLabelTexts['+pageId+']')+"", 0);
			cm.render("basic");
		};
		
		//Функция не дает меню закрытся
		
		function voidClick(){
			this.show();
		}
		
if(<%:show_content_menu%>){
        this.myContextMenu = new YAHOO.widget.ContextMenu("mycontextmenu",
                {trigger:this.myDataTable.getTbodyEl()});//Прикрутить сюда вместо всей таблицы только нужную строку!!!//getColumn(1)
        this.myContextMenu.addItem(" ");
        // Render the ContextMenu instance to the parent container of the DataTable
        this.myContextMenu.render("basic");
		
		//Привязываем открытие меню по щелчку правой кнопкой к функции
    	this.myContextMenu.subscribe("triggerContextMenu", onRightClick);
		
		//Узнаем на каком елементы был совершен клик
		
		dt = this.myDataTable;//deviant add
		cm = this.myContextMenu;//deviant add
		
		//Привязываем клик в меню к событию
		this.myContextMenu.subscribe("click", voidClick);
}
		//TESTING
		this.myDataTable.subscribe("columnResizeEvent", myNewFunction); 
		function myNewFunction(oArgs){
			//alert(oArgs.column['_nKeyIndex']);
			//alert(oArgs.column['width']);
			//alert(oArgs.width);
			//fnShowProps(oArgs.column, 'oArgs.column');
			//запоминаем новую ширину колонки
			/////addToCookie('_assets_column_' + oArgs.column['_nKeyIndex'], oArgs.column['width']);
			addToCookieColumnParameter('_assets<%:cookies_prepend%>_column_' + oArgs.column['_nKeyIndex'], oArgs.column['width']);
		}

		//Сортируем таблицу
		/////sortedColumnDir = getFromCookie('_assets_sorted_column_dir');
		sortedColumnDir = getFromCookieColumnParameter('_assets<%:cookies_prepend%>_sorted_column_dir');
		sortedColumnDir = (sortedColumnDir === null)?YAHOO.widget.DataTable.CLASS_ASC:(sortedColumnDir == 'asc')?YAHOO.widget.DataTable.CLASS_ASC:YAHOO.widget.DataTable.CLASS_DESC;
		/////sortedColumnIndex = getFromCookie('_assets_sorted_column_index');
		sortedColumnIndex = getFromCookieColumnParameter('_assets<%:cookies_prepend%>_sorted_column_index');
		sortedColumnIndex = (sortedColumnIndex === null)?<%iif:<%:cookies_prepend%>,,1,0%>:sortedColumnIndex-0;
		this.myDataTable.sortColumn(this.myDataTable.getColumn(sortedColumnIndex), sortedColumnDir);

		this.myDataTable.subscribe("columnSortEvent", function(oArgs) {
			var newDir = (oArgs.dir === YAHOO.widget.DataTable.CLASS_ASC)?'asc':'desc';
			var newCol = oArgs.column.getKeyIndex();
			/////addToCookie('_assets_sorted_column_dir', newDir);
			addToCookieColumnParameter('_assets<%:cookies_prepend%>_sorted_column_dir', newDir);
			/////addToCookie('_assets_sorted_column_index', newCol);
			addToCookieColumnParameter('_assets<%:cookies_prepend%>_sorted_column_index', newCol);
		});
		//CONTEXT MENU end
    };
}

YAHOO.util.Event.addListener(window, "load", tableInit('<%get_curr_folder_id%>'));

</script>

</div></div></div>
<script type="text/javascript">
onWindowResize();
</script>

<br>

<%include:<%iif:<%file_exists:<%:EE_PATH%><%:EE_HELP_DIR%><%:modul%>.html%>,,,help_note%>%>

</div>
<iframe style="display:none" id="iframe1" height="250" width="400" src="about:blank"></iframe>
<%get_popup_header_script:<%iif:<%config_var:use_draft_content%>,1,<%:DRAFT_MODE_TITLE%>,<%str_to_title::modul_title%> List%>%>
</body>
</html>