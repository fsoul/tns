<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
	<title><%str_to_title::modul%> Edit</title>
    <!--link rel="stylesheet" href="<%:EE_HTTP%>css/admin_panel_style.css" type="text/css"-->
	<link rel="stylesheet" href="<%:EE_HTTP%>css/common.css" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<%:EE_HTTP%>css/menu_<%iif::menuType,DOM,dom,old%>.css" type="text/css"></link>
	<%print_admin_js%>
	<script type="text/javascript" src="<%:EE_HTTP%>js/ajax-son.js"></script>
	
<script type="text/javascript">
var interval = '';
var interval2 = '';
function fbOpenEditor(f_name, t, type, language) {
	language = (language) ? language : 'EN';

	if (type=="text") {
		x=600;
		y=200;//160
	} else if (type=="textarea") {
		x=800;
		y=520;//480
	} else if (type=="select" || type=="select_gallery" || type=="select_survey") {
		x=600;
		y=200;//160
	} else if (type=="link") {
		x=800;
		y=240;//200
	}	
	 else {
		x=800;
		y=710;//670
	}

	URL="<%:EE_ADMIN_URL%>cms.php?cms_name="+f_name+"&t="+t+"&lang="+language+"&admin_template=yes&type="+type+"&reload=no";
	openPopup(URL,x,y);
	interval = setInterval("popupIsClose('"+f_name+"', '"+language+"')", 500);
}
function editOptions(select_id, option_id, lang) {
	x=550;
	y=230;
	URL="<%:EE_ADMIN_URL%>_formbuilder/formbuilder_options.php?select_id="+select_id+"&option_id="+option_id+"&lang="+lang+"&type=edit&admin_template=<%:admin_template%>";
	openPopup(URL,x,y);
	var f_name = 'fb_opt_text'+option_id+'a';
	var language = lang;//'<%:language%>';
	interval = setInterval("returnOptionsValues('"+option_id+"', '"+select_id+"', '"+language+"')", 500);
}
function returnOptionsValues(option_id, select_id, language){
	//возвращаем текст для опшина
	popupIsClose('fb_opt_text'+option_id+'a', language);//config fields
	popupIsClose2('fb_opt_text'+option_id+'a', 'field_id'+option_id+'_2', 'text', language);//design field
	//и его значение
	popupIsClose('fb_opt_value'+option_id+'a', language);//config fields
	popupIsClose2('fb_opt_text'+option_id+'a', 'field_id'+option_id+'_2', 'value', language);//design field
	//пихаем в скрытое поле значения дефолтного и пустого опшина
	//пробегаемся по полям отображения дефолтных и пустых опшинов и обнуляем их значения
	//вписываем звездочки в поле отображения установленного опшина
	returnOptionProperty('fb_sel_opt', select_id, option_id, language);
	returnOptionProperty('fb_emp_opt', select_id, option_id, language);
}
//function to return change values for options in config fields
function popupIsClose(f_name, language) {
	if(document.getElementById('popup_div_id') == null) {
		clearInterval(interval);
		//get text with ajax		
		// Create XMLHTTPRequest Object
		var ajax = new ajax_son('<%:EE_HTTP%>action.php');
		ajax.method = 'get';
		ajax.onComplete = function() {
			//пихаем полученный текст обратно
			//alert(ajax.response);
			document.getElementById(f_name).innerHTML = ajax.response.replace(/\r\n|\n|\r/g, '<br />');
			if(f_name.indexOf('fb_value')>=0){
				document.getElementById('field_id'+f_name.substr(8,14)).value = ajax.response.replace(/\r\n|\n|\r/g, '<br />');
			}
		}
		ajax.run('action=fb_get_cms&field='+f_name+'&t=0&admin_template=yes&rand='+Math.random());
	}
}
//function to return change values for options in design fields
function popupIsClose2(f_name, f_id, returnProperty, language) {//return value for select list in design field
	if(document.getElementById('popup_div_id') == null) {
		clearInterval(interval);
		var ajax = new ajax_son('<%:EE_HTTP%>action.php');
		ajax.method = 'get';
		ajax.onComplete = function() {
			if(document.getElementById(f_id) != null){
				eval('document.getElementById(f_id).'+returnProperty+' = ajax.response;');
			}
		}
		ajax.run('action=fb_get_cms&field='+f_name+'&t=0&rand='+Math.random());
	}
}
function returnOptionProperty(what, select_id, option_id, language) {
	if(document.getElementById('popup_div_id') == null) {
		clearInterval(interval);
		var ajax = new ajax_son('<%:EE_HTTP%>action.php');
		ajax.method = 'get';
		ajax.onComplete = function() {
			//clear all filed
			var selectOptionsTbody = document.getElementById('options_tbody_'+language+select_id);//tbody таблицы опшинов
			optionsIds = getOptionsIds(selectOptionsTbody);
			//alert(optionsIds+' -=- '+'options_tbody_'+language+select_id);//returnOptionsValues
			for(var i=0; i<optionsIds.length; i++){
				document.getElementById(what+optionsIds[i]+'a').innerHTML = '';
			}
			//set field of selected field
			if(ajax.response !== ''){
				if(document.getElementById(what+ajax.response+'a')){//if we set default value, save it but dont save the form and reload it
					document.getElementById(what+ajax.response+'a').innerHTML = '*';
				}
			}
		}
		ajax.run('action=fb_get_cms&field='+what+'_'+language+select_id+'a'+'&t=0&rand='+Math.random());
	}
}
</script>
	
<style type="text/css">
/*margin and padding on body element
  can introduce errors in determining
  element position and are not recommended;
  we turn them off as a foundation for YUI
  CSS treatments. */
body {
	margin:0;
	padding:0;
}
</style>
<!-- tabview begin -->
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/tabview/assets/skins/sam/tabview.css" />
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/connection/connection-min.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/element/element-beta-min.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/tabview/tabview-min.js"></script>
<!-- tabview end -->

<!-- buttons begin -->
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" /-->
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/menu/assets/skins/sam/menu.css" />
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/button/assets/skins/sam/button.css" />
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script-->
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/container_core-min.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/menu/menu-min.js"></script>
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/element/element-beta-min.js"></script-->
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/button/button-min.js"></script>
<!-- buttons end -->
<!-- drag & drop begin -->
<!-- drag & drop begin -->

<!-- texteditor begin -->
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" /-->
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/assets/skins/sam/container.css" />
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/menu/assets/skins/sam/menu.css" /-->
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/button/assets/skins/sam/button.css" /-->
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/editor/assets/skins/sam/editor.css" />
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/utilities/utilities.js"></script>
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/container_core-min.js"></script-->
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/menu/menu-min.js"></script-->
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/button/button-min.js"></script-->
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/editor/editor-min.js"></script>
<!-- texteditor end -->

<!-- container begin -->
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" /-->
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/assets/skins/sam/container.css" /-->
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script-->
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/container-min.js"></script>
<!-- container end -->

<!-- drag & drop begin -->
<!--link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" /-->
<!--script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script-->
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/animation/animation-min.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/dragdrop/dragdrop-min.js"></script>
<!-- drag & drop end -->

<style type="text/css">
#container {
	margin-top:10px;
}
.active_field {
	background-color: #ECECD2 !important;
}
#preview_block .active_field {
	background-color: transparent !important;
}
#design_block {
	overflow: hidden; zoom: 1;
}
#design_fields {
	margin: 0px;
	padding-right: 290px;
	padding-left: 0px;
}
UL#design_fields LI {
	display: block;
	list-style-type: none;
}
#config_fields {
	clear: both;
}
#config_fields FIELDSET {
	padding: 3px;
}
.fb_input, .fb_textarea, .fb_select2, .fb_options_list {
	width: 263px;
	border: 1px solid #808080;
}
.fb_select2 {
	width: 265px;
}
.fb_options_list {
	overflow: scroll;
	height: 150px;
}
#config_block {
	position: absolute;
	/*position: fixed;*/
	top: 35px;
	right: 5px;
	width: 290px;
}
.operations {
	position: absolute;
	right: 310px;
}
.fb_cms {
	margin-right: 4px;
}
#preview_block .operations, #preview_block .error_field, #preview_block .fb_cms, #preview_block .hidden_field_message {
	display: none;
}
#save_form {
	text-align: center;
	margin-top: 5px;
	margin-bottom: 5px;
}
#submit_button {
	clear: both;
}
/*tabview begin */
.yui-navset div.loading div {
    background:url(<%:EE_HTTP%>img/formbuilder/loading.gif) no-repeat center center;
    height: 8em; /* hold some space while loading */
}
.yui-content {
    min-height: 600px;
	_height: 600px;
}
.options_list .yui-content {
	min-height: 150px;
	_height: 150px;
	height: 150px;
	overflow: scroll;
}
/*tabview end */

/* buttons begin*/
#add_fields_buttons .yui-button {
	float: left;
	clear: left;
	margin: 2px 5px;
}
#add_fields_buttons BUTTON {
	/*background: url(<%:EE_HTTP%>img/formbuilder/add.gif) 3px 50% no-repeat;*/
	width: 280px;
	text-align: left;
	padding-left: 5px;
}
/* buttons end*/

/* fields begin */
.form_field {
	background-color: #DEDEDE;
	border: 1px dashed #999;
	margin: 2px;
	padding: 3px;
	padding-right: 101px;
}
#preview_block .form_field {
	background-color: transparent;
	border: 0px none;
	margin: 0;
	padding: 0;
}
.field_config {
	overflow: hidden; zoom: 1;
	margin: 0 5px;
}
.noOverflow {
	overflow: hidden; zoom: 1;
}
.floatLeft {
	float: left;
}
/* fields end */

/* form config begin */
#form_config DIV {
	margin: 0; padding: 0;
}
#form_config INPUT, #form_config SELECT, #form_config TEXTAREA {
	margin: 0;
}
.fb_form_row {
	overflow: hidden; zoom: 1;
	padding-top: 5px !important;
}
.fb_label {
	float: left;
	width: 200px;
}
.fb_field {
	float: left;
	width: 400px;/*300*/
}
.fb_text {
	width: 300px;
	border: 1px solid #999;
}
.fb_select {
	width: 300px;
}
.action_ico {
	margin-right: 5px;
}
.option_action_ico {
	margin-right: 2px;
}
/* form config end */

/* drag & drop begin */
/* drag & drop end */

/* texteditor begin */
.yui-editor-container {
	position: absolute;
	top: -9999px;
	left: -9999px;
	z-index: 999;
}
#editor {
	visibility: hidden;
	position: absolute;
}
.editable {
	/*border: 1px solid black;
	margin: .25em;
	float: left;
	width: 350px;
	height: 100px;
	overflow: auto;*/
}
/* texteditor end */

/* contaiber begin */
.yui-module {}
.yui-module .hd {}
.yui-module .bd {}
.yui-module .ft {}

.remove_button {
	position: absolute;
    top: 0;
    right: 0;
}
TABLE.select_list_table {
	width: 235px;
	background-color: #A3A3A3;
}
TABLE.select_list_table TH, TABLE.select_list_table TD {
	padding: 2px;
}
TABLE.select_list_table TH {
	background-color: #ccc;
}
TABLE.select_list_table TD {
	background-color: #eee;
}
/* contaiber end */

/* drag & drop begin */
	/*nothing necessary*/
/* drag & drop begin */
.no_overlow {
	overflow: hidden; zoom: 1;
}
.config_sub_left_row {
	float: left; width: 125px; line-height: 21px;
}
.config_sub_right_row {
	float: left;
	width: 177px;
}
.config_sub_right_row_select {
	width: 177px;
}
</style>
</head>

<body class=" yui-skin-sam">
<div id="dhtmltooltip2"></div>
<SCRIPT language="JavaScript" type="text/javascript" src="<%:EE_HTTP%>js/bar_js.js"></SCRIPT>
<%:admin_menu%>

<!-- editor begin -->
	<!--textarea id="editor"></textarea-->
<!-- editor end -->
<form name="formbuilder_form" id="formbuilder_form" method="post">
<div id="container"></div>
<div id="save_form"><!--input type="submit" name="submit" value="submit" onclick="return onSumitForm();" /--></div>
</form>

<script type="text/javascript">
<!-- get from object save values -->
<%fb_restore_values%>

function makeActive(divObj)
{
	//make inactive previous item
	if(document.getElementById('fb_active_element')){
		document.getElementById('fb_active_element').className = 'form_field noOverflow';
		document.getElementById('fb_active_element').removeAttribute('id');
	}
	divObj.className = 'form_field noOverflow active_field';
	divObj.setAttribute('id', 'fb_active_element');
}
//testing
function inspect(elm){
	var str = "";
	for (var i in elm){
		str += i + ": " + elm.getAttribute(i) + "\n";
	}
	alert(str);
}

function addToCookie(name, value){
	var expDate = new Date();
	expDate.setTime(expDate.getTime() + 4 * 7 * 24 * 60 * 60 * 1000);//Месяц
	document.cookie = name + '=' + escape(value) + '; expires=' + expDate.toGMTString() + ';path=<%:EE_HTTP_PREFIX%>';
}

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

//find id of form
<%setValueOf:form_id,<%get:edit%>%>
var formId = '<%:form_id%>';

var cmsTextField = '<%fb_print_edit_cms:{field_id}a,0,,text%>';
var cmsTextareaField = '<%fb_print_edit_cms:{field_id}a,0,,textarea%>';
var cmsHtmlField = '<%fb_print_edit_cms:{field_id}a,0%>';

function optionsListRow(select_id, option_id, lang)
{
	var optionValue = (eval('typeof(option_value'+option_id+') == "undefined"'))?'':eval('option_value'+option_id);
	var optionText = (eval('typeof(option_text'+option_id+') == "undefined"'))?'':eval('option_text'+option_id);
	var optionSelected = (eval('typeof(selected_option_'+lang+select_id+') == "undefined"'))?'':eval('selected_option_'+lang+select_id);
	optionSelected = (optionSelected == option_id)?'*':'';
	var optionEmpty = (eval('typeof(empty_option_'+lang+select_id+') == "undefined"'))?'':eval('empty_option_'+lang+select_id);
	optionEmpty = (optionEmpty == option_id)?'*':'';
	
	//add option to select list on design filed
	if(lang == '<%:language%>'){//по умолчанию выводим опшины для дефолтного языка
		var optionItem = document.createElement('option');
		optionItem.setAttribute('value', optionValue);
		optionItem.setAttribute('id', 'field_id'+option_id+'_2');
		var optionItemText = document.createTextNode(optionValue);
		optionItem.appendChild(optionItemText);
		document.getElementById('field_id'+select_id).appendChild(optionItem);
		//do not work in IE
		//document.getElementById('field_id'+select_id).innerHTML = '<option value="'+optionValue+'" id="field_id'+option_id+'_2">'+optionValue+'</option>';
	}
	
	return '<tr id="option_line'+option_id+'">'+
		'<td align="center"><span id="fb_sel_opt'+option_id+'a">'+optionSelected+'</span></td>'+
		'<td align="center"><span id="fb_emp_opt'+option_id+'a">'+optionEmpty+'</span></td>'+
		'<td><span id="fb_opt_text'+option_id+'a">'+optionText+'</span></td>'+//option_value_1226591960440
		'<td><span id="fb_opt_value'+option_id+'a">'+optionValue+'</span></td>'+
		'<td align="center">'+
			'<a href="#" onclick="editOptions(\''+select_id+'\', \''+option_id+'\', \''+lang+'\'); return false;"><img src="<%:EE_HTTP%>img/formbuilder/edit.gif" width="16" height="16" border="0" alt="" class="option_action_ico"></a><span id="fb_opt_text'+option_id+'a"></span>'+
			'<a href="#" onclick="optionDo(\''+select_id+'\', \''+option_id+'\', \'up\', \''+lang+'\'); return false;"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="option_action_ico"></a>'+
			'<a href="#" onclick="optionDo(\''+select_id+'\', \''+option_id+'\', \'down\', \''+lang+'\'); return false;"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="option_action_ico"></a>'+
			'<a href="#" onclick="optionDo(\''+select_id+'\', \''+option_id+'\', \'add\', \''+lang+'\'); return false;"><img src="<%:EE_HTTP%>img/formbuilder/add.gif" width="16" height="16" border="0" alt="" class="option_action_ico"></a>'+
			'<a href="#" onclick="optionDo(\''+select_id+'\', \''+option_id+'\', \'delete\', \''+lang+'\'); return false;"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="option_action_ico"></a>'+
		'</td>'+
		'</tr>';
}

function doUp(currentObj, parentObj){
	var prevObj = currentObj.previousSibling;
	if(prevObj){ parentObj.insertBefore(currentObj, prevObj); }
}
function doDown(currentObj, parentObj){
	var nextObj = currentObj.nextSibling;
	if(nextObj){ parentObj.insertBefore(nextObj, currentObj); }
}

function optionDo(select_id, option_id, action, lang){
	//config fields
	var currentObj = document.getElementById('option_line'+option_id);//option_line_1226418662163
	var parentObj = currentObj.parentNode;
	//design fields
	var makeChangesToSelectList = 0;
	if(lang == '<%:language%>'){//меняем расположение опшинов в списке только на текущем языке
		makeChangesToSelectList = 1;
		var currentObj2 = document.getElementById('field_id'+option_id+'_2');//field_id_1226650621406_2
		var parentObj2 = currentObj2.parentNode;
	}
	if(action == 'up'){
		doUp(currentObj, parentObj);//config fields
		if(makeChangesToSelectList) doUp(currentObj2, parentObj2);//design fields
	} else if(action == 'down'){
		doDown(currentObj, parentObj);//config fields
		if(makeChangesToSelectList) doDown(currentObj2, parentObj2);//design fields
	} else if(action == 'add'){
		//config fields
		var d = new Date();
		var tmpOptionId = '_'+d.getTime();
		optionsList = optionsListRow(select_id, tmpOptionId, lang);
		//parentObj.innerHTML += optionsList;//dont works in IE, need to use DOM
		//The property is read/write for all objects except the following, for which it is read-only: COL, COLGROUP, FRAMESET, HEAD, HTML, STYLE, TABLE, TBODY, TFOOT, THEAD, TITLE, TR. The property has no default value.
		insertDiv = parentObj.parentNode.parentNode;
		insertDiv.innerHTML = insertDiv.innerHTML.replace(/<\/tbody>/i, optionsList+'</tbody>');
		//design fields
		//do the same in function optionsListRow()
		//if(makeChangesToSelectList){
		//	var optionItem = document.createElement('option');
		//	optionItem.setAttribute('value', '');
		//	optionItem.setAttribute('id', 'field_id'+tmpOptionId+'_2');
		//	var optionItemText = document.createTextNode('');
		//	optionItem.appendChild(optionItemText);
		//	parentObj2.appendChild(optionItem);
			//dont works on IE
			//parentObj2.innerHTML += '<option value="" id="field_id'+tmpOptionId+'_2"></option>';
		//}
	} else if(action == 'delete'){
		//config fields
		//если в спике всего 1 елемент мы его не удаляем
		if(parentObj.childNodes.length > 2){//считаем заголовок тожк дитем
			parentObj.removeChild(currentObj);
			//design fields
			if(makeChangesToSelectList) parentObj2.removeChild(currentObj2);
		}
	}
	//обновлем содержимое скрытого поля
	var selectOptionsIds = document.getElementById('options_ids_'+lang+select_id);//скрытое поле
	var selectOptionsTbody = document.getElementById('options_tbody_'+lang+select_id);//tbody таблицы опшинов
	selectOptionsIds.value = getOptionsIds(selectOptionsTbody);
}

function getOptionsIds(pNode) {
	//пробегаемся по дереву DOM и ищем елементы tr
	var fieldsIds = new Array();
	for (var i=0; i<pNode.childNodes.length; i++) {
		if (pNode.childNodes[i].nodeType==1) {
			fieldsIds[fieldsIds.length] = pNode.childNodes[i].getAttribute('id');
			fieldsIds[fieldsIds.length-1] = fieldsIds[fieldsIds.length-1].replace(/option_line/i,'');
		}
	}
	return fieldsIds;
}
//function get Dom element and returns ids of its first childs
function getFieldsIds() {
	var fieldsIds = new Array();
	var designFields = document.getElementById('design_fields');
	//find childs of this element
	for (var i=0; i<designFields.childNodes.length; i++) {
		if (designFields.childNodes[i].nodeType==1) {
			fieldsIds[fieldsIds.length] = designFields.childNodes[i].getAttribute('id');
		}
	}
	return fieldsIds;
}

function showOrHideEmailFields() {
	var rowsIds = new Array('fb_dest_email_row', 'fb_from_email_row', 'fb_email_title_row', 'fb_email_charset_row');//, 'fb_send_to_user_row'
	for(var i=0; i<rowsIds.length; i++) {
		if(document.getElementById('fb_send_to_email').checked) {
			document.getElementById(rowsIds[i]).style.display = 'block';
		} else {
			document.getElementById(rowsIds[i]).style.display = 'none';
		}
	}
}

function showOrHideMessageType(type) {
	var rowsIds = new Array(type+'_html', type+'_template');
	for(var i=0; i<rowsIds.length; i++) {
		if(getRadioValue(eval('document.formbuilder_form.fb_'+type+'_message_type')) == i+1) {
			document.getElementById(rowsIds[i]).style.visibility = 'visible';
		} else {
			document.getElementById(rowsIds[i]).style.visibility = 'hidden';
		}
	}
}

function getRadioValue(radioObj) {
	for(var i=0; i<radioObj.length; i++) {
		if(radioObj[i].checked)  {
			return radioObj[i].value;
		}
	}
	return null;
}

function showOrHideForRegistered() {
	var rowsIds = new Array('fb_for_registered_text_row', 'fb_submit_once_row', 'fb_submit_once_text_row');
	for(var i=0; i<rowsIds.length; i++) {
		if(document.getElementById('fb_for_registered').checked) {
			document.getElementById(rowsIds[i]).style.display = 'block';
			document.getElementById('fb_submit_once').checked = true;
		} else {
			document.getElementById(rowsIds[i]).style.display = 'none';
			document.getElementById('fb_submit_once').checked = false;
		}
	}
}

function showOrHideSubmitOnce() {
	if(document.getElementById('fb_submit_once').checked) {
		document.getElementById('fb_submit_once_text_row').style.display = 'block';
	} else {
		document.getElementById('fb_submit_once_text_row').style.display = 'none';
	}
}

function js_array_to_php_serialized_array(a)
{
    var a_php = "";
    var total = 0;
    for (var key in a)
    {
        ++ total;
        a_php = a_php + "s:" +
                String(key).length + ":\"" + String(key) + "\";s:" +
                String(a[key]).length + ":\"" + String(a[key]) + "\";";
    }
    a_php = "a:" + total + ":{" + a_php + "}";
    return a_php;
}

//function save form
function onSaveForm(p_oEvent) {
	//YAHOO.util.Event.preventDefault(p_oEvent);//disable submit
	var fieldsIds = getFieldsIds();
	//insert text label to hidden fields
	//for(var i=0; i<fieldsIds.length; i++) {
	//	var labelText = document.getElementById('label'+fieldsIds[i]+'').innerHTML;
	//	document.getElementById('text_label'+fieldsIds[i]+'').value = labelText;
	//}
	var ids = document.getElementById('ids');//field for serialized array with containrs ids
	//insert serialized array with ids to hidden field
	ids.value = js_array_to_php_serialized_array(fieldsIds);
	//submit form
	//document.formbuilder_form.submit();
}

//function save form
//use if YUI button doesnt works
/*function onSumitForm() {
	var fieldsIds = getFieldsIds();
	var ids = document.getElementById('ids');
	ids.value = js_array_to_php_serialized_array(fieldsIds);
	return true;
}*/

/*** drag & drop begin ***/
(function() {

var Dom = YAHOO.util.Dom;
var Event = YAHOO.util.Event;
var DDM = YAHOO.util.DragDropMgr;

//////////////////////////////////////////////////////////////////////////////
// example app
//////////////////////////////////////////////////////////////////////////////
YAHOO.example.DDApp = {
    init: function() {
		
		//объявляем список по #id
        new YAHOO.util.DDTarget("design_fields");
        
		//объявляем елементы списка #id
        //for (i=1;i<cols+1;i=i+1) {
            //for (j=1;j<rows+1;j=j+1) {
                //new YAHOO.example.DDList("li" + i + "_" + j);
            //}
        //}
    }
};

//////////////////////////////////////////////////////////////////////////////
// custom drag and drop implementation
//////////////////////////////////////////////////////////////////////////////

YAHOO.example.DDList = function(id, sGroup, config) {

    YAHOO.example.DDList.superclass.constructor.call(this, id, sGroup, config);

    ///this.logger = this.logger || YAHOO;
    var el = this.getDragEl();
    Dom.setStyle(el, "opacity", 0.67); // The proxy is slightly transparent

    this.goingUp = false;
    this.lastY = 0;
};

YAHOO.extend(YAHOO.example.DDList, YAHOO.util.DDProxy, {
	
    startDrag: function(x, y) {
        ///this.logger.log(this.id + " startDrag");

        // make the proxy look like the source element
        var dragEl = this.getDragEl();
        var clickEl = this.getEl();
        Dom.setStyle(clickEl, "visibility", "hidden");

        dragEl.innerHTML = clickEl.innerHTML;

        //Dom.setStyle(dragEl, "color", Dom.getStyle(clickEl, "color"));
        //Dom.setStyle(dragEl, "backgroundColor", Dom.getStyle(clickEl, "backgroundColor"));
        //Dom.setStyle(dragEl, "border", "2px solid gray");
		Dom.setStyle(dragEl, "margin", "0px");
		Dom.setStyle(dragEl, "border", "0px none");
		Dom.setStyle(dragEl, "backgroundColor", "transparent");
		
		//on drag operation controlls will move right
		Dom.setStyle(dragEl.firstChild.firstChild.firstChild, "right", "10px");//<div class="operations">
    },

    endDrag: function(e) {

        var srcEl = this.getEl();
        var proxy = this.getDragEl();

        // Show the proxy element and animate it to the src element's location
        Dom.setStyle(proxy, "visibility", "");
        var a = new YAHOO.util.Motion( 
            proxy, { 
                points: { 
                    to: Dom.getXY(srcEl)
                }
            }, 
            0.2, 
            YAHOO.util.Easing.easeOut 
        )
        var proxyid = proxy.id;
        var thisid = this.id;

        // Hide the proxy and show the source element when finished with the animation
        a.onComplete.subscribe(function() {
                Dom.setStyle(proxyid, "visibility", "hidden");
                Dom.setStyle(thisid, "visibility", "");
            });
        a.animate();
    },

    onDragDrop: function(e, id) {

        // If there is one drop interaction, the li was dropped either on the list,
        // or it was dropped on the current location of the source element.
        if (DDM.interactionInfo.drop.length === 1) {

            // The position of the cursor at the time of the drop (YAHOO.util.Point)
            var pt = DDM.interactionInfo.point; 

            // The region occupied by the source element at the time of the drop
            var region = DDM.interactionInfo.sourceRegion; 

            // Check to see if we are over the source element's location.  We will
            // append to the bottom of the list once we are sure it was a drop in
            // the negative space (the area of the list without any list items)
            if (!region.intersect(pt)) {
                var destEl = Dom.get(id);
                var destDD = DDM.getDDById(id);
                destEl.appendChild(this.getEl());
                destDD.isEmpty = false;
                DDM.refreshCache();
            }

        }
    },

    onDrag: function(e) {

        // Keep track of the direction of the drag for use during onDragOver
        var y = Event.getPageY(e);

        if (y < this.lastY) {
            this.goingUp = true;
        } else if (y > this.lastY) {
            this.goingUp = false;
        }

        this.lastY = y;
    },

    onDragOver: function(e, id) {
    
        var srcEl = this.getEl();
        var destEl = Dom.get(id);

        // We are only concerned with list items, we ignore the dragover
        // notifications for the list.
        if (destEl.nodeName.toLowerCase() == "li") {
            var orig_p = srcEl.parentNode;
            var p = destEl.parentNode;

            if (this.goingUp) {
                p.insertBefore(srcEl, destEl); // insert above
            } else {
                p.insertBefore(srcEl, destEl.nextSibling); // insert below
            }

            DDM.refreshCache();
        }
    }
});

Event.onDOMReady(YAHOO.example.DDApp.init, YAHOO.example.DDApp, true);

})();
/*** drag & drop begin ***/

/*** tabview begin ***/
(function() {

    var tabView = new YAHOO.widget.TabView();
    
    tabView.addTab( new YAHOO.widget.Tab({
        label: 'Form configuration', 
		content: '<div id="form_config">'+
			'<div class="fb_form_row"><div class="fb_label"><%:FORMBUILDER_FORM_NAME%></div><div class="fb_field"><input type="text" name="fb_form_name" class="fb_text" value="<%:fb_form_name%>"></div></div>'+
			'<div class="fb_form_row"><div class="fb_label"><%:FORMBUILDER_FORM_ACTION%></div><div class="fb_field"><input type="text" name="fb_form_action" class="fb_text" value="<%iif::fb_form_action,,fb_form_submit,<%:fb_form_action%>%>"></div></div>'+
			'<input type="hidden" name="fb_form_id" value="<%:form_id%>">'+
			'<div class="fb_form_row"><div class="fb_label"><%:FORMBUILDER_SEND_TO_EMAIL%></div><div class="fb_field"><input type="checkbox" name="fb_send_to_email" id="fb_send_to_email" value="1" onclick="showOrHideEmailFields();"<%iif:<%:fb_send_to_email%>,1, checked%>></div></div>'+
			'<div class="fb_form_row" id="fb_dest_email_row"<%iif:<%:fb_send_to_email%>,1,, style="display: none;"%>><div class="fb_label"><%:FORMBUILDER_DEST_EMAIL%></div><div class="fb_field"><input type="text" name="fb_dest_email" class="fb_text" value="<%:fb_dest_email%>"></div></div>'+
			'<div class="fb_form_row" id="fb_from_email_row"<%iif:<%:fb_send_to_email%>,1,, style="display: none;"%>><div class="fb_label"><%:FORMBUILDER_FROM_EMAIL%></div><div class="fb_field"><input type="text" name="fb_from_email" class="fb_text" value="<%:fb_from_email%>"></div></div>'+
			'<div class="fb_form_row" id="fb_email_title_row"<%iif:<%:fb_send_to_email%>,1,, style="display: none;"%>><div class="fb_label"><%:FORMBUILDER_EMAIL_TITLE%></div><div class="fb_field"><%fb_print_edit_cms:fb_mail_title_<%:form_id%>a,0,,text,_form_title%></div></div>'+
			'<div class="fb_form_row" id="fb_email_charset_row"<%iif:<%:fb_send_to_email%>,1,, style="display: none;"%>><div class="fb_label"><%:FORMBUILDER_EMAIL_CHARSET%></div><div class="fb_field"><input type="text" name="fb_email_charset" class="fb_text" value="<%:fb_email_charset%>"></div></div>'+
			//'<div class="fb_form_row" id="fb_send_to_user_row"><div class="fb_label">Send email to user?</div><div class="fb_field"><input type="checkbox" name="fb_send_to_user" value="1"<%iif:<%:fb_send_to_user%>,1, checked%>></div></div>'+
			'<div class="fb_form_row"><div class="fb_label"><%:FORMBUILDER_STORE_IN_DB%></div><div class="fb_field"><input type="checkbox" name="fb_store_in_db" value="1"<%iif:<%:fb_store_in_db%>,1, checked%>></div></div>'+
			'<div class="fb_form_row"><div class="fb_label"><%:FORMBUILDER_THANKYOU_URL%></div><div class="fb_field"><div style="float: left;"><%get_js_safe_satelite_list:300,<%:fb_thanks_page%>%></div><div style="float: left;">&nbsp;<input type="button" name="self_thanks_page" value="Self" onclick="document.getElementById(\'satelit\').value=\'\'; document.getElementById(\'sattelite_page_path\').innerHTML=\'<%htmlspecialchars:<%:FORMBUILDER_CONFIRM_PAGE_SELF%>%>\';"></div></div></div>'+
			//'<div class="fb_form_row"><div class="fb_label">Form send method:</div><div class="fb_field"><select name="fb_form_method" class="fb_select"><option value="post"<%iif:<%:fb_form_method%>,post, selected%>>post</option><option value="get"<%iif:<%:fb_form_method%>,get, selected%>>get</option></select></div></div>'+
			'<div class="fb_form_row"><div class="fb_label">Only for registered users:</div><div class="fb_field"><input type="checkbox" name="fb_for_registered" id="fb_for_registered" value="1" onclick="showOrHideForRegistered();"<%iif:<%:fb_for_registered%>,1, checked%>></div></div>'+
			'<div class="fb_form_row" id="fb_for_registered_text_row"<%iif:<%:fb_for_registered%>,1,, style="display: none;"%>><div class="fb_label">Only for registered message:</div>'+
				'<div class="fb_field">'+
					'<div class="no_overlow">'+
						'<div class="config_sub_left_row">Show html: <input type="radio" name="fb_for_registered_message_type" value="1" <%iif:<%:fb_for_registered_message_type%>,1,checked,<%iif:<%:fb_for_registered_message_type%>,,checked%>%> onclick="showOrHideMessageType(\'for_registered\');" /></div><div class="config_sub_right_row" style="visibility: <%iif:<%:fb_for_registered_message_type%>,1,visible,<%iif:<%:fb_for_registered_message_type%>,,visible,hidden%>%>;" id="for_registered_html"><%fb_print_edit_cms:fb_for_registered_text_<%:form_id%>a,0,,,_for_registered_text%></div>'+
					'</div>'+
					'<div class="no_overlow">'+
						'<div class="config_sub_left_row">Include template: <input type="radio" name="fb_for_registered_message_type" value="2" onclick="showOrHideMessageType(\'for_registered\');" <%iif:<%:fb_for_registered_message_type%>,2,checked%> /></div><div class="config_sub_right_row" style="visibility: <%iif:<%:fb_for_registered_message_type%>,2,visible,hidden%>;" id="for_registered_template"><select name="fb_for_registered_template" class="config_sub_right_row_select"><%parse_sql_to_html:SELECT id as option_value\,concat(file_name\,".tpl") as option_text\,"<%:fb_for_registered_template%>" as option_value_test FROM v_tpl_file ORDER BY option_text,templates/option%></select></div>'+
					'</div>'+
				'</div>'+
			'</div>'+
			'<div class="fb_form_row" id="fb_submit_once_row"<%iif:<%:fb_for_registered%>,1,, style="display: none;"%>><div class="fb_label">Submit just once:</div><div class="fb_field"><input type="checkbox" name="fb_submit_once" id="fb_submit_once" value="1" onclick="showOrHideSubmitOnce();"<%iif:<%:fb_submit_once%>,1, checked%>></div>'+
			'</div>'+
			'<div class="fb_form_row" id="fb_submit_once_text_row"<%iif:<%:fb_submit_once%>,1,, style="display: none;"%>><div class="fb_label">Submit just once message:</div>'+
				'<div class="fb_field">'+
					
					'<div class="no_overlow">'+
						'<div class="config_sub_left_row">Show html: <input type="radio" name="fb_submit_once_message_type" value="1" <%iif:<%:fb_submit_once_message_type%>,1,checked,<%iif:<%:fb_for_registered_message_type%>,,checked%>%> onclick="showOrHideMessageType(\'submit_once\');" /></div><div class="config_sub_right_row" style="visibility: <%iif:<%:fb_submit_once_message_type%>,1,visible,<%iif:<%:fb_submit_once_message_type%>,,visible,hidden%>%>;" id="submit_once_html"><%fb_print_edit_cms:fb_submit_once_text_<%:form_id%>a,0,,,_submit_once%></div>'+
					'</div>'+
					'<div class="no_overlow">'+
						'<div class="config_sub_left_row">Include template: <input type="radio" name="fb_submit_once_message_type" value="2" onclick="showOrHideMessageType(\'submit_once\');" <%iif:<%:fb_submit_once_message_type%>,2,checked%> /></div><div class="config_sub_right_row" style="visibility: <%iif:<%:fb_submit_once_message_type%>,2,visible,hidden%>;" id="submit_once_template"><select name="fb_submit_once_template" class="config_sub_right_row_select"><%parse_sql_to_html:SELECT id as option_value\,concat(file_name\,".tpl") as option_text\,"<%:fb_submit_once_template%>" as option_value_test FROM v_tpl_file ORDER BY option_text,templates/option%></select></div>'+
					'</div>'+
				'</div>'+
		'</div>',
		active: false
	}));
	
    tabView.addTab( new YAHOO.widget.Tab({
        label: 'Design',
        content: '<div id="design_block">'+
					'<ul id="design_fields"></ul>'+
					'<div id="config_block">'+
						'<div id="add_fields_buttons"></div>'+
						'<div id="config_fields"><input type="hidden" name="ids" id="ids" value=""></div>'+
					'</div>'+
				'</div>',
		active: true
	}));

    tabView.addTab( new YAHOO.widget.Tab({
        label: 'Preview',
		//dataSrc: 'http://localhost/ee3.2/formbuilder_preview.html?query=form+builder+preview',
		//cacheData: false,
		content: '<form><div id="preview_block"></div></form>',
		active: false
    }));

    tabView.appendTo('container');
	
	function handleClick(e) {   
		//alert(e.target);
		var designFields = document.getElementById('design_fields').innerHTML;
		document.getElementById('preview_block').innerHTML = designFields;
	} 
 	var tab2 = tabView.getTab(2); 
	tab2.addListener('click', handleClick); 
})();
/*** tabview end ***/

/*** buttons begin ***/
YAHOO.example.init = function () {

function makeFieldActive(p_oEvent) {
	var activeFieldId = this.id;
	//hide all config fields
	var fieldsIds = getFieldsIds();
	for(var i=0; i<fieldsIds.length; i++) {
		eval('YAHOO.example.container.module'+fieldsIds[i]+'_config.hide();');
	}
	//show current config container
	eval('YAHOO.example.container.module'+activeFieldId+'_config.show();');
}

//Оболочки
function onTextline(p_oEvent) {
	return onButtonClick(p_oEvent, 'text_line', '');
}
function onParagraphText(p_oEvent) {
	return onButtonClick(p_oEvent, 'paragraph_text', '');
}
function onHtmlField(p_oEvent) {
	return onButtonClick(p_oEvent, 'html_field', '');
}
function onSeparator(p_oEvent) {
	return onButtonClick(p_oEvent, 'separator', '');
}
function onText(p_oEvent) {
	return onButtonClick(p_oEvent, 'text', '');
}
function onTextarea(p_oEvent) {
	return onButtonClick(p_oEvent, 'textarea', '');
}
function onSelect(p_oEvent) {
	return onButtonClick(p_oEvent, 'select', '');
}
function onRadio(p_oEvent) {
	return onButtonClick(p_oEvent, 'radio', '');
}
function onCheckbox(p_oEvent) {
	return onButtonClick(p_oEvent, 'checkbox', '');
}
function onFile(p_oEvent) {
	return onButtonClick(p_oEvent, 'file', '');
}
function onCaptcha(p_oEvent) {
	return onButtonClick(p_oEvent, 'captcha', '');
}
function onHidden(p_oEvent) {
	return onButtonClick(p_oEvent, 'hidden', '');
}
function onReset(p_oEvent) {
	return onButtonClick(p_oEvent, 'reset', '');
}
function onSubmit(p_oEvent) {
	return onButtonClick(p_oEvent, 'submit', '');
}

// "click" event handler for each Button instance
function onButtonClick(p_oEvent, type, newId) {
	//generating new id of container
	if(newId == '') {
		var d = new Date();
		var newId = '_'+d.getTime();
	}
	//determine what text should be added to contaiber
	var containerText = '';
	var configText = '';
	//Do not use p_oEvent.srcElement.id
	
	//set undefined variables used in fields
	var undefinedVariables = new Array('error_class', 'text_class', 'name', 'field_class', 'field_size', 'maxlength', 'default_value', 'required', 'required_indicator', 'wrapper', 'wrapper_class', 'check', 'cols', 'rows', 'multiply', 'checked', 'extensions', 'max_size', 'options', 'action_type');
	for(var i=0; i<undefinedVariables.length; i++) {
		if(eval('typeof('+undefinedVariables[i]+newId+') == "undefined"')) {
			eval('var '+undefinedVariables[i]+newId+' = "";');
			eval('var '+undefinedVariables[i]+newId+'_2 = "";');
		} else {
			switch(undefinedVariables[i]){
				case 'error_class':
					eval('var '+undefinedVariables[i]+newId+'_2 = " class=\\"error_field '+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('error_class'+newId+'_2')+'
				break;
				case 'text_class':
					eval('var '+undefinedVariables[i]+newId+'_2 = " class=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('text_class'+newId+'_2')+'
				break;
				case 'name':
					eval('var '+undefinedVariables[i]+newId+'_2 = " name=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('name'+newId+'_2')+'
				break;
				case 'field_class':
					eval('var '+undefinedVariables[i]+newId+'_2 = " class=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('field_class'+newId+'_2')+'
				break;
				case 'maxlength':
					eval('var '+undefinedVariables[i]+newId+'_2 = " maxlength=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('maxlength'+newId+'_2')+'
				break;
				case 'default_value':
					if((eval('type'+newId)) == 'textarea'){
						eval('var '+undefinedVariables[i]+newId+'_2 = "'+eval(undefinedVariables[i]+newId)+'";');//'+eval('default_value'+newId+'_2')+'
					} else {
						eval('var '+undefinedVariables[i]+newId+'_2 = " value=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('default_value'+newId+'_2')+'
					}
				break;
				case 'cols':
					eval('var '+undefinedVariables[i]+newId+'_2 = " cols=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('cols'+newId+'_2')+'
				break;
				case 'rows':
					eval('var '+undefinedVariables[i]+newId+'_2 = " rows=\\"'+eval(undefinedVariables[i]+newId)+'\\"";');//'+eval('rows'+newId+'_2')+'
				break;
				case 'multiply':
					eval('var '+undefinedVariables[i]+newId+'_2 = " '+eval(undefinedVariables[i]+newId)+'";');//'+eval('multiply'+newId+'_2')+'
				break;
				case 'checked':
					eval('var '+undefinedVariables[i]+newId+'_2 = " '+eval(undefinedVariables[i]+newId)+'";');//'+eval('checked'+newId+'_2')+'
				break;
				case 'options':
					//var optionsArr = eval(undefinedVariables[i]+newId).split('\t');
					//eval('var '+undefinedVariables[i]+newId+'_2 = "";');//'+eval('options'+newId+'_2')+'
					//for(var j=0; j<optionsArr.length; j++){
						//eval(undefinedVariables[i]+newId+'_2 +="<option value=\\"'+optionsArr[j]+'\\">'+optionsArr[j]+'</option>"');
					//}
				break;
			}
		}
	}
	
	var checkNoneWrapper= (eval('wrapper'+newId+' == "none"'))?"selected":"";
	var checkDivWrapper= (eval('wrapper'+newId+' == "div"'))?"selected":"";
	var checkSpanWrapper= (eval('wrapper'+newId+' == "span"'))?"selected":"";
	var checkPWrapper= (eval('wrapper'+newId+' == "p"'))?"selected":"";
	var required = (eval('required'+newId+' != ""'))?" checked":"";
	var required_indicator = (eval('required_indicator'+newId+' != ""'))?" checked":"";
	
	var wrapperConfigText = '<fieldset class="_field">'+
								'<legend>Wrapper</legend>'+
								'<div>Tag:<br><select class="fb_select2" name="wrapper'+newId+'" id="wrapper'+newId+'"><option value=""'+checkNoneWrapper+'>None</option><option value="div"'+checkDivWrapper+'>div</option><option value="span"'+checkSpanWrapper+'>span</option><option value="p"'+checkPWrapper+'>p</option></select></div>'+//wrapper
								'<div>Class:<br><input class="fb_input" type="text" id="wrapper_class'+newId+'" name="wrapper_class'+newId+'" value="'+eval('wrapper_class'+newId)+'" ></div>'+//wrapper_class
							'</fieldset>';
	
	switch(type) {
		case 'text_line':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
				'<fieldset class="_text">'+
            		'<legend>Label</legend>'+
					'<input type="hidden" name="type'+newId+'" value="text_line">'+//type
					//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
					'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_calss   
				'</fieldset>'+
			'</div>';
		break;
		
		case 'paragraph_text':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextareaField.replace(/{field_id}/g,'fb_label'+newId)+'</div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
				'<fieldset class="_text">'+
            		'<legend>Label</legend>'+
					'<input type="hidden" name="type'+newId+'" value="paragraph_text">'+//type
					//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
					'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_calss
				'</fieldset>'+
			'</div>';
		break;
		
		case 'html_field':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsHtmlField.replace(/{field_id}/g,'fb_label'+newId)+'</div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
				'<fieldset class="_text">'+
            		'<legend>Label</legend>'+
					'<input type="hidden" name="type'+newId+'" value="html_field">'+//type
					//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
					'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_calss
				'</fieldset>'+
			'</div>';
		break;
		
		case 'separator':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div><i>&lt;separator&gt;</i></div></div>';
			
			configText = '<div class="field_config">'+
				'<input type="hidden" name="type'+newId+'" value="separator">'+//type
			'</div>';
		break;
		
		case 'text':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);">'+getOperationsDiv(newId)+'<div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><input id="field_id'+newId+'" type="text"'+eval('name'+newId+'_2')+eval('maxlength'+newId+'_2')+eval('default_value'+newId+'_2')+' /></div></div>';// class="editable"
			
			var required = (eval('required'+newId+' != ""'))?" checked":"";
			var checkNone = (eval('check'+newId+' == "none"'))?" selected":"";
			var checkNotEmpty = (eval('check'+newId+' == "not_empty"'))?" selected":"";
			var checkEmailPattern= (eval('check'+newId+' == "email_pattern"'))?"selected":"";
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="text">'+//type
						//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Maxlength:<br><input class="fb_input" type="text" id="maxlength'+newId+'" name="maxlength'+newId+'" value="'+eval('maxlength'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'maxlength\', this.value);"></div>'+//maxlength
						'<div>Default value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'<!--input class="fb_input" type="text" id="default_value'+newId+'" name="default_value'+newId+'" value="'+eval('default_value'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'value\', this.value);"--></div>'+//default_value
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes"'+required+'></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'"><option value="none"'+checkNone+'>None</option><option value="not_empty"'+checkNotEmpty+'>Not empty</option><option value="email_pattern"'+checkEmailPattern+'>Email pattern</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'textarea':

			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><textarea id="field_id'+newId+'"'+eval('name'+newId+'_2')+eval('cols'+newId+'_2')+eval('rows'+newId+'_2')+'>'+eval('default_value'+newId+'_2')+'</textarea></div></div>';// class="editable"
			
			var checkNone = (eval('check'+newId+' == "none"'))?" selected":"";
			var checkNotEmpty = (eval('check'+newId+' == "not_empty"'))?" selected":"";
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="textarea">'+//type
						//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Cols:<br><input class="fb_input" type="text" id="cols'+newId+'" name="cols'+newId+'" value="'+eval('cols'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'cols\', this.value);"></div>'+//cols
						'<div>Rows:<br><input class="fb_input" type="text" id="rows'+newId+'" name="rows'+newId+'" value="'+eval('rows'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'rows\', this.value);"></div>'+//rows
						'<div>Default value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'<!--input class="fb_input" type="text" id="default_value'+newId+'" name="default_value'+newId+'" value="'+eval('default_value'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'value\', this.value);"--></div>'+//default_value
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes"'+required+'></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'"><option value="none"'+checkNone+'>None</option><option value="not_empty"'+checkNotEmpty+'>Not empty</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'select':

			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><select id="field_id'+newId+'"'+eval('name'+newId+'_2')+eval('multiply'+newId+'_2')+'></select></div></div>';// class="editable"
			
			var multiply = (eval('multiply'+newId+' != ""'))?" checked":"";
			var required = (eval('required'+newId+' != ""'))?" checked":"";
			var checkNone = (eval('check'+newId+' == "none"'))?" selected":"";
			var checkNotEmpty = (eval('check'+newId+' == "not_empty"'))?" selected":"";
			
			//eval('var optionsLangs = options_langs'+newId+';');//"EN,DE";//example
			var optionsLangs = (eval('typeof(options_langs'+newId+') == "undefined"'))?'<%:language%>':eval('options_langs'+newId);
			var langsArr = optionsLangs.split(',');
			var newDate = new Date().getTime();
			for(var i=0; i<langsArr.length; i++){
				//eval('var optionsIds'+langsArr[i]+' = options_ids_'+langsArr[i]+newId+';');
				newIdFromDate = '_'+(newDate+i+1);
				eval('var optionsIds'+langsArr[i]+' = (typeof(options_ids_'+langsArr[i]+newId+') == "undefined")?newIdFromDate:options_ids_'+langsArr[i]+newId+';');
			}
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="select">'+//type
						//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div id="options_top'+newId+'" class="options_list">Options:<br><input type="hidden" id="options_langs'+newId+'" name="options_langs'+newId+'" value="'+optionsLangs+'"><!--textarea class="fb_textarea" id="options'+newId+'" name="options'+newId+'" rows="5" cols="20">'+eval('options'+newId).replace(/\t/g,"\r\n")+'</textarea--></div>'+//cols
						'<div>Multiple:<br><input type="checkbox" id="multiply'+newId+'" name="multiply'+newId+'" value="multiple"'+multiply+' onchange="applyAttribute(\''+newId+'\', \'multiple\', this.checked);"></div>'+//myltiply
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes"'+required+'></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'"><option value="none"'+checkNone+'>None</option><option value="not_empty"'+checkNotEmpty+'>Not empty</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'radio':

			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><input id="field_id'+newId+'" type="radio"'+eval('name'+newId+'_2')+eval('checked'+newId+'_2')+' /></div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div></div>';// class="editable"
			
			var checked = (eval('checked'+newId+' != ""'))?" checked":"";
			var required = (eval('required'+newId+' != ""'))?" checked":"";
			var checkNone = (eval('check'+newId+' == "none"'))?" selected":"";
			var checkNotEmpty = (eval('check'+newId+' == "not_empty"'))?" selected":"";
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="radio">'+//type
						//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="'+eval('name'+newId)+'">'+//label_text
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'</div>'+//default_value
						'<div>Checked?<br><input type="checkbox" id="checked'+newId+'" name="checked'+newId+'" value="checked"'+checked+' onchange="applyAttribute(\''+newId+'\', \'checked\', this.checked);"></div>'+//default_value
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes"'+required+'></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'"><option value="none"'+checkNone+'>None</option><option value="not_empty"'+checkNotEmpty+'>Not empty</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'checkbox':

			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><input id="field_id'+newId+'" type="checkbox"'+eval('name'+newId+'_2')+eval('checked'+newId+'_2')+' /></div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div></div>';// class="editable"
			
			var checked = (eval('checked'+newId+' != ""'))?" checked":"";
			var required = (eval('required'+newId+' != ""'))?" checked":"";
			var checkNone = (eval('check'+newId+' == "none"'))?" selected":"";
			var checkNotEmpty = (eval('check'+newId+' == "not_empty"'))?" selected":"";
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="checkbox">'+//type
						//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'</div>'+//default_value
						'<div>Checked?<br><input type="checkbox" id="checked'+newId+'" name="checked'+newId+'" value="checked"'+checked+' onchange="applyAttribute(\''+newId+'\', \'checked\', this.checked);"></div>'+//default_value
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes"'+required+'></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'"><option value="none">None</option><option value="not_empty"'+checkNotEmpty+'>Not empty</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'file':

			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><input id="field_id'+newId+'" type="file"'+eval('name'+newId+'_2')+' /></div></div>';// class="editable"
			
			var required = (eval('required'+newId+' != ""'))?" checked":"";
			var checkNone = (eval('check'+newId+' == "none"'))?" selected":"";
			var checkNotEmpty = (eval('check'+newId+' == "not_empty"'))?" selected":"";
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="file">'+//type
						//'<input type="hidden" name="label_text'+newId+'" id="text_label'+newId+'" value="">'+//label_text
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Size:<br><input class="fb_input" type="text" id="field_size'+newId+'" name="field_size'+newId+'" value="'+eval('field_size'+newId)+'"></div>'+//text_class
						'<div>Extensions:<br><input class="fb_input" type="text" id="extensions'+newId+'" name="extensions'+newId+'" value="'+eval('extensions'+newId)+'"></div>'+//extentions
						'<div>Max Size, Mb:<br><input class="fb_input" type="text" id="max_size'+newId+'" name="max_size'+newId+'" value="'+eval('max_size'+newId)+'"></div>'+//max_size
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes"'+required+'></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'"><option value="none">None</option><option value="not_empty"'+checkNotEmpty+'>Not empty</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'captcha':
			
			var action_type = (eval('action_type'+newId+' != ""'))?eval('action_type'+newId):"show_captcha";
			
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div class="error_field '+eval('error_class'+newId)+'" id="error'+newId+'"'+eval('error_class'+newId+'_2')+'><%:FB_ERROR_MESSAGE%>'+cmsTextField.replace(/{field_id}/g,'fb_error'+newId)+'</div><div id="label'+newId+'"'+eval('text_class'+newId+'_2')+'>'+cmsTextField.replace(/{field_id}/g,'fb_label'+newId)+'</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'>'+
				'<div id="field_id'+newId+'">'+
					'<div class="fb_captcha_image">'+
						'<img src="<%:EE_HTTP%>action.php?action='+action_type+'&'+Math.random()+'" align="absmiddle" border="0" alt="" />'+
					'</div>'+
					'<div class="fb_captcha_field">'+
						'<input type="text"'+eval('name'+newId+'_2')+' value="" />'+
					'</div>'+
				'</div>'+
			'</div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
					'<fieldset class="_error">'+
            			'<legend>Error</legend>'+
						'<div>Class:<br><input class="fb_input" type="text" id="error_class'+newId+'" name="error_class'+newId+'" value="'+eval('error_class'+newId)+'" onchange="applyClass(\'error\', this, \''+newId+'\');"></div>'+//error_class
					'</fieldset>'+
					'<fieldset class="_text">'+
            			'<legend>Label</legend>'+
						'<input type="hidden" name="type'+newId+'" value="captcha">'+//type
						'<div>Class:<br><input class="fb_input" type="text" id="text_class'+newId+'" name="text_class'+newId+'" value="'+eval('text_class'+newId)+'" onchange="applyClass(\'label\', this, \''+newId+'\');"></div>'+//text_class
					'</fieldset>'+
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Action type:<br><input class="fb_input" type="text" id="action_type'+newId+'" name="action_type'+newId+'" value="'+action_type+'"></div>'+
						'<div>Require?<br><input type="checkbox" id="required'+newId+'" name="required'+newId+'" value="yes" checked readonly="readonly"></div>'+//required
						'<div>Add required indicator ("*")?<br><input type="checkbox" id="required_indicator'+newId+'" name="required_indicator'+newId+'" value="yes"'+required_indicator+'></div>'+//required indicator
						'<div>Check:<br><select class="fb_select2" name="check'+newId+'" id="check'+newId+'" disabled><option value="not_empty" selected>Not empty</option></select></div>'+//check
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'hidden':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div id="label'+newId+'" style="display: none;"'+eval('text_class'+newId+'_2')+'>&nbsp;</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><span class="hidden_field_message"><%:FB_HIDDEN_FIELD%></span><input id="field_id'+newId+'" type="hidden"'+eval('name'+newId+'_2')+eval('default_value'+newId+'_2')+' /></div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
				'<input type="hidden" name="type'+newId+'" value="hidden">'+//type
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Default value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'<!--input class="fb_input" type="text" id="default_value'+newId+'" name="default_value'+newId+'" value="'+eval('default_value'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'value\', this.value);"--></div>'+//default_value
					'</fieldset>'+
				'</div>';
		break;
		
		case 'reset':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div id="label'+newId+'" style="display: none;"'+eval('text_class'+newId+'_2')+'>&nbsp;</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><input id="field_id'+newId+'" type="reset"'+eval('name'+newId+'_2')+eval('default_value'+newId+'_2')+' /></div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
				'<input type="hidden" name="type'+newId+'" value="reset">'+//type
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Default value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'<!--input class="fb_input" type="text" id="default_value'+newId+'" name="default_value'+newId+'" value="'+eval('default_value'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'value\', this.value);"--></div>'+//default_value
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case 'submit':
			containerText = '<div class="form_field noOverflow" onclick="makeActive(this);"><div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div><div id="label'+newId+'" style="display: none;"'+eval('text_class'+newId+'_2')+'>&nbsp;</div><div id="field'+newId+'"'+eval('field_class'+newId+'_2')+'><input id="field_id'+newId+'" type="submit"'+eval('name'+newId+'_2')+eval('default_value'+newId+'_2')+' onclick="return false;" /></div></div>';// class="editable"
			
			configText = '<div class="field_config">'+
				'<input type="hidden" name="type'+newId+'" value="submit">'+//type
					'<fieldset class="_field">'+
						'<legend>Field</legend>'+
						'<div>Name*:<br><input class="fb_input" type="text" id="name'+newId+'" name="name'+newId+'" value="'+eval('name'+newId)+'"></div>'+//name
						'<div>Class:<br><input class="fb_input" type="text" id="field_class'+newId+'" name="field_class'+newId+'" value="'+eval('field_class'+newId)+'" onchange="applyClass(\'field\', this, \''+newId+'\');"></div>'+//text_class
						'<div>Default value:<br>'+cmsTextField.replace(/{field_id}/g,'fb_value'+newId)+'<!--input class="fb_input" type="text" id="default_value'+newId+'" name="default_value'+newId+'" value="'+eval('default_value'+newId)+'" onchange="applyAttribute(\''+newId+'\', \'value\', this.value);"--></div>'+//default_value
					'</fieldset>'+
					wrapperConfigText+
				'</div>';
		break;
		
		case '':
			containerText = '';
			
			configText = '';
		break;
	}
	//make new div for field container
	createContainer('design_fields', newId, '_field', containerText);
	createContainer('config_fields', newId, '_config', configText);
	
	//выводим вкладки для списка на разных языках
	if(type == 'select'){
		var optionTab = new YAHOO.widget.TabView();
		
		optionsLangs = optionsLangs.split(',');
		for(var i=0; i<optionsLangs.length; i++){//пробегаемся по языкам
			eval('var optionsIds = optionsIds'+optionsLangs[i]+'.split(",");');
			
			var allOptionsIds = optionsIds.join(',');
			var optionsList = '';
			for(var j=0; j<optionsIds.length; j++){
				optionsList += optionsListRow(newId, optionsIds[j], optionsLangs[i]);//if empty
			}
			
			optionsList = '<input type="hidden" name="options_ids_'+optionsLangs[i]+newId+'" id="options_ids_'+optionsLangs[i]+newId+'" value="'+allOptionsIds+'"><div>'+"\n"+//for innerHTML, in 1 line to void problems in IE
							'<table class="select_list_table" cellspacing="1" id="options_table_'+optionsLangs[i]+newId+'">'+"\n"+
							'<thead>'+"\n"+
							'<tr>'+"\n"+
								"\t"+'<th>D</th>'+"\n"+
								"\t"+'<th>E</th>'+"\n"+
								"\t"+'<th>Text</th>'+"\n"+
								"\t"+'<th>Value</th>'+"\n"+
								"\t"+'<th>Operations</th>'+"\n"+
							'</tr>'+"\n"+
							'</thead>'+"\n"+
							'<tbody id="options_tbody_'+optionsLangs[i]+newId+'">'+"\n"+
							optionsList+
							'</tbody>'+"\n"+
							'</table>'+"\n"+
							'</div>'+"\n";
			
			var tabActive = (i === 0)?true:false;
			optionTab.addTab( new YAHOO.widget.Tab({
				label: optionsLangs[i],
				content: optionsList,
				active: tabActive
			}));
		}
		
		//add
		var allLangs = allAvailableLangs.split(',');
		var allTabs = optionTab.get('tabs');
		
		optionTab.addTab( new YAHOO.widget.Tab({
				label: 'add',
				content: ''
			}));
		
		function onAddTabClick(){
			var addContent = '';
			
			var existingLangs = new Array();
			var existingLangsOptions = new Array('<option value=""></option>');
			for(var i=0; i<allTabs.length-1; i++){//last tab add isn't alnguage
				var optionLabel = allTabs[i].get('label');
				existingLangs[existingLangs.length] = optionLabel;
				existingLangsOptions[existingLangsOptions.length] = '<option value="'+optionLabel+'">'+optionLabel+'</option>';
			}
			
			//save new languages in hidden field
			document.getElementById('options_langs'+newId).value = existingLangs.join(',');
			
			var availableLangs = new Array();
			var availableLangsOptions = new Array();
			for(var i=0; i<allLangs.length; i++){
			var langInUse = 0;
				for(var j=0; j<existingLangs.length; j++){
					if(allLangs[i] == existingLangs[j]) langInUse = 1;
				}
				if(!langInUse){
					availableLangs[availableLangs.length] = allLangs[i];
					availableLangsOptions[availableLangsOptions.length] = '<option value="'+allLangs[i]+'">'+allLangs[i]+'</option>';
				}
			}
			if(availableLangsOptions.length > 0){
				addContent += '<tr><td>Choose language: </td><td><select id="available_langs'+newId+'">'+availableLangsOptions.join('')+'</select></td></tr>';
				if(existingLangsOptions.length > 1){
					addContent += '<tr><td>Copy from: </td><td><select id="existing_langs'+newId+'">'+existingLangsOptions.join('')+'</select></td></tr>';
				}
			}
			
			if(addContent != ''){
				addContent = '<table>'+addContent+'<tr><td colspan="2"><input type="button" id="add_button'+newId+'" name="add_button'+newId+'" value="Add"></td></tr></table>';
			}else{
				addContent = 'No language available';
			}
			
			optionTab.get(addLangTab.set('content', addContent));
			
			var addNewTab = function() {
			var optionsList = '';
			var label = document.getElementById('available_langs'+newId)[document.getElementById('available_langs'+newId).selectedIndex].value;
			var copyFromLang = document.getElementById('existing_langs'+newId)[document.getElementById('existing_langs'+newId).selectedIndex].value;
			var newDate = new Date().getTime();
			
			var isCopyFromOtherLanguage = 0;
			if(copyFromLang == ''){
				var tmpOptionId = '_'+(parseInt(newId.substr(1))+2);
				var tmpOptionId2 = '_'+newDate;
				if(newDate > parseInt(tmpOptionId.substr(1))) tmpOptionId = tmpOptionId2;
				optionsList += optionsListRow(newId, tmpOptionId, label);//if empty
			}else{
			/////////////////////////////////////////////////////////////////////////////////////////
				isCopyFromOtherLanguage = 1;
				//table from which we must copy data
				var copyFromTbody = document.getElementById('options_tbody_'+copyFromLang+newId);
				var fieldsToCopy = new Array();//old and new ids to copy cms fields
				var newFieldsIds = new Array();//ids of new options
				var storedValues = new Array();//array for store copied values
				var j=0;
				for (var i=0; i<copyFromTbody.childNodes.length; i++) {
					if (copyFromTbody.childNodes[i].nodeType==1) {//копируем елементы tr
						//ищем предыдущий идентификатор
						var reg = /fb_sel_opt_(\d+)a/gi;
						reg.lastIndex = 0;//reset previous values
						var text = copyFromTbody.childNodes[i].innerHTML;
						var previousId = reg.exec(text);
						//генерируем новый идентификатор
						var nextId = '_'+(newDate+i);
						
						//alert(text);
						//запоминаем идентификаторы
						fieldsToCopy[fieldsToCopy.length] = '_'+previousId[1]+','+nextId;
						newFieldsIds[newFieldsIds.length] = nextId;
						//создаем такое же содержимое но с новыми идентификаторами
						optionsList += optionsListRow(newId, nextId, label);

						//запиминаем введенные значения из предыдущей вкладки
						storedValues[j] = new Array();
						reg = /fb_sel_opt_(\d+)a("?)>([^<]+)?/gi; reg.lastIndex = 0;
						var isEmpty = reg.exec(text);
						storedValues[j][0] = (isEmpty[3] == undefined)?'':isEmpty[3];
	
						reg = /fb_emp_opt_(\d+)a("?)>([^<]+)?/gi; reg.lastIndex = 0;
						isEmpty = reg.exec(text);
						storedValues[j][1] = (isEmpty[3] == undefined)?'':isEmpty[3];
						
						reg = /fb_opt_text_(\d+)a("?)>([^<]+)?/gi; reg.lastIndex = 0;
						isEmpty = reg.exec(text);
						storedValues[j][2] = (isEmpty[3] == undefined)?'':isEmpty[3];
						
						reg = /fb_opt_value_(\d+)a("?)>([^<]+)?/gi; reg.lastIndex = 0;
						isEmpty = reg.exec(text);
						storedValues[j][3] = (isEmpty[3] == undefined)?'':isEmpty[3];
						j++;
					}
				}
				//делаем содержимое для скрытого поля
				tmpOptionId = newFieldsIds.join(',');
				//вызываем php скрипт который скопирует cms поля
				var ajax = new ajax_son('<%:EE_HTTP%>action.php');
				ajax.method = 'get';
				ajax.onComplete = function() {
					//запихиваем полученные значения полей обратно
					//alert(ajax.response);
				}
				ajax.run('action=fb_copy_cms&select_id='+escape(newId)+'&previous_lang='+escape(copyFromLang)+'&next_lang='+escape(label)+'&ids='+escape(fieldsToCopy.join(';'))+'&t=0&rand='+Math.random());
			/////////////////////////////////////////////////////////////////////////////////////////
			}
			optionsList = '<input type="hidden" name="options_ids_'+label+newId+'" id="options_ids_'+label+newId+'" value="'+tmpOptionId+'">'+"\n"+
							'<div>'+"\n"+//for innerHTML
							'<table class="select_list_table" cellspacing="1" id="options_table_'+optionsLangs[i]+newId+'">'+"\n"+
							'<thead>'+"\n"+
							'<tr style="background-color: #ccc;">'+"\n"+
								"\t"+'<th>D</th>'+"\n"+
								"\t"+'<th>E</th>'+"\n"+
								"\t"+'<th>Text</th>'+"\n"+
								"\t"+'<th>Value</th>'+"\n"+
								"\t"+'<th>Operations</th>'+"\n"+
							'</tr>'+"\n"+
							'</thead>'+"\n"+
							'<tbody id="options_tbody_'+label+newId+'">'+"\n"+
							optionsList+
							'</tbody>'+"\n"+
							'</table>'+"\n"+
							'</div>'+"\n";
				
			optionTab.addTab( new YAHOO.widget.Tab({
				label: label,
				content: optionsList
			}),allTabs.length-1);//добавляем перед вкладкой Добавить
			//вписываем содержимое полей в скорированную вкладку
			if(isCopyFromOtherLanguage){
				for(var i=0; i<newFieldsIds.length; i++){
					document.getElementById('fb_sel_opt'+newFieldsIds[i]+'a').innerHTML = storedValues[i][0];
					document.getElementById('fb_emp_opt'+newFieldsIds[i]+'a').innerHTML = storedValues[i][1];
					document.getElementById('fb_opt_text'+newFieldsIds[i]+'a').innerHTML = storedValues[i][2];
					document.getElementById('fb_opt_value'+newFieldsIds[i]+'a').innerHTML = storedValues[i][3];
				}
			}
			//обновляем содержимое закладки Добавить
			onAddTabClick();
    		};
			eval('var addButton = new YAHOO.widget.Button("add_button'+newId+'", { onclick: { fn: addNewTab } });');
		}
		var addLangTab = optionTab.getTab(allTabs.length-1);
		addLangTab.addListener('click', onAddTabClick);

		//remove
    	var removeTab = function() {
			if(optionTab.get('activeTab').get('label') == defaultLang) return false;
			if(optionTab.get('activeTab').get('label') == 'add') return false;
       		optionTab.removeTab(optionTab.get('activeTab'));
			//обновляем содержимое закладки Добавить
			onAddTabClick();
			
    	};
		var delButtonId = 'remove_button'+newId;
    	var delTabButton = document.createElement('input');
		delTabButton.setAttribute('type', 'button');
		delTabButton.setAttribute('id', delButtonId);
		delTabButton.setAttribute('value', 'del');
		delTabButton.className ='remove_tab_button';
		
		var delTabDiv = document.createElement('div');
		delTabDiv.className = 'remove_button';
		delTabDiv.appendChild(delTabButton);
		
    	//YAHOO.util.Event.on(delTabButton, 'click', removeTab);
    	optionTab.appendChild(delTabDiv);
		
		optionTab.appendTo('options_top'+newId);
		
		var removeButton = new YAHOO.widget.Button(delButtonId, { onclick: { fn: removeTab } });
	}
	
	makeActive(document.getElementById(newId).firstChild.firstChild);
	
	fieldsIds = getFieldsIds();
	for(var i=0; i<fieldsIds.length-1; i++) {
		eval('YAHOO.example.container.module'+fieldsIds[i]+'_config.hide();');
	}
}

function createContainer(divId, newId, idSuffix, containerText) {
	//make new div for container
	var pNode = document.getElementById(divId);
	//in order to not create 2 same ids
	if(idSuffix == '_config') {
		var newDiv = document.createElement('div');
		newDiv.setAttribute('id', newId+'_2');
	} else {//_field
		var newDiv = document.createElement('li');
		newDiv.setAttribute('id', newId);
		//привязываем drag & drop к елементу
		new YAHOO.example.DDList(newId);
	}
	pNode.appendChild(newDiv);
	//insert container to this div
	YAHOO.namespace('example.container');
	eval('YAHOO.example.container.module'+newId+idSuffix+' = new YAHOO.widget.Module(newDiv, { visible: false });');
	//YAHOO.example.container.module'+newId+idSuffix'.setHeader('');
	eval('YAHOO.example.container.module'+newId+idSuffix+'.setBody(containerText);');
	//YAHOO.example.container.module'+newId+idSuffix'.setFooter('');
	eval('YAHOO.example.container.module'+newId+idSuffix+'.render();');
	eval('YAHOO.example.container.module'+newId+idSuffix+'.show();');
	//add onclick atribute for field to make their configs active
	if(idSuffix == '_field') {
		YAHOO.util.Event.addListener(newDiv, "click", makeFieldActive);
	}
	
}

 // Create Buttons without using existing markup
//var textLine = new YAHOO.widget.Button({ label:"Text line", id:"text_line", container:"add_fields_buttons", onclick: { fn: onTextline } });
//var paragraphText = new YAHOO.widget.Button({ label:"Paragraph text", id:"paragraph_text", container:"add_fields_buttons", onclick: { fn: onParagraphText } });
//var htmlField = new YAHOO.widget.Button({ label:"Html field", id:"html_field", container:"add_fields_buttons", onclick: { fn: onHtmlField } });
//var text = new YAHOO.widget.Button({ label:"Text field", id:"text", container:"add_fields_buttons", onclick: { fn: onText } });
//var textarea = new YAHOO.widget.Button({ label:"Textarea", id:"textarea", container:"add_fields_buttons", onclick: { fn: onTextarea } });
//var select = new YAHOO.widget.Button({ label:"Select", id:"select", container:"add_fields_buttons", onclick: { fn: onSelect } });
//var radio = new YAHOO.widget.Button({ label:"Radio", id:"radio", container:"add_fields_buttons", onclick: { fn: onRadio } });
//var checkbox = new YAHOO.widget.Button({ label:"Checkbox", id:"checkbox", container:"add_fields_buttons", onclick: { fn: onCheckbox } });
//var file = new YAHOO.widget.Button({ label:"File", id:"file", container:"add_fields_buttons", onclick: { fn: onFile } });
//var hidden = new YAHOO.widget.Button({ label:"Hidden", id:"hidden", container:"add_fields_buttons", onclick: { fn: onHidden } });
//var reset = new YAHOO.widget.Button({ label:"Reset", id:"reset", container:"add_fields_buttons", onclick: { fn: onReset } });
//var submit = new YAHOO.widget.Button({ label:"Submit", id:"submit", container:"add_fields_buttons", onclick: { fn: onSubmit } });

//  Create an array of YAHOO.widget.MenuItem configuration properties 
var addFieldsList = [ 
	{ text: "Text line", value: "text_line", onclick: { fn: onTextline } },
	{ text: "Paragraph text", value: "paragraph_text", onclick: { fn: onParagraphText } },
	{ text: "Html field", value: "html_field", onclick: { fn: onHtmlField } },
	{ text: "Separator", value: "separator", onclick: { fn: onSeparator } },
	{ text: "Text field", value: "text", onclick: { fn: onText } },
	{ text: "Textarea", value: "textarea", onclick: { fn: onTextarea } },
	{ text: "Select", value: "select", onclick: { fn: onSelect } },
	{ text: "Radio", value: "radio", onclick: { fn: onRadio } },
	{ text: "Checkbox", value: "checkbox", onclick: { fn: onCheckbox } },
	{ text: "File", value: "file", onclick: { fn: onFile } },
	{ text: "Captcha", value: "captcha", onclick: { fn: onCaptcha } },
	{ text: "Hidden", value: "hidden", onclick: { fn: onHidden } },
	{ text: "Reset", value: "reset", onclick: { fn: onReset } },
	{ text: "Submit", value: "submit", onclick: { fn: onSubmit } }
]; 
/*
	Instantiate a Menu Button using the array of YAHOO.widget.MenuItem 
	configuration properties as the value for the "menu" configuration 
	attribute.
*/  
var addFieldsMenu = new YAHOO.widget.Button({
                            type: "menu",//split
                            label: "Add field",  
                            name: "add_field_menu", 
                            menu: addFieldsList,  
                            container: "add_fields_buttons" });   

var backButton = new YAHOO.widget.Button({ type: "link", label: "Back", id: "back_button", name: "back", value: "back_button", container: "save_form", href: "<%:EE_ADMIN_URL%><%:modul%>.php" });
var saveButton = new YAHOO.widget.Button({ type: "submit", label: "Save form", id: "save_form_button", name: "save", container: "save_form", onclick: { fn: onSaveForm } });
var saveAndContinueButton = new YAHOO.widget.Button({ type: "submit", label: "Save & continue", id: "save_and_continue", name: "save_and_continue", container: "save_form", onclick: { fn: onSaveForm } });

//restore saved fields
<%:restore_fields%>

(function(){
	//get all fields which must be restored
	for(var i=0; i<fieldsWithText.length; i++) {
		if(document.getElementById('fb_label'+fieldsWithText[i]+'a') != null) {
			document.getElementById('fb_label'+fieldsWithText[i]+'a').innerHTML = eval('label_text'+fieldsWithText[i]).replace(/\t/g, '<br />');
		}
		if(document.getElementById('fb_error'+fieldsWithText[i]+'a') != null) {
			document.getElementById('fb_error'+fieldsWithText[i]+'a').innerHTML = eval('error_text'+fieldsWithText[i]).replace(/\t/g, '<br />');
		}
		if(document.getElementById('fb_value'+fieldsWithText[i]+'a') != null) {
			document.getElementById('fb_value'+fieldsWithText[i]+'a').innerHTML = eval('default_value'+fieldsWithText[i]).replace(/\t/g, '<br />');
		}
	}
	
	//hide all config fields
	fieldsIds = getFieldsIds();
	for(var i=0; i<fieldsIds.length-1; i++) {
		eval('YAHOO.example.container.module'+fieldsIds[i]+'_config.hide();');
	}
	//alert('restored');
})();

//если страница подтверждения == '', значит вместо названия страницы выводим слово <Self>
if('<%:fb_thanks_page%>' == '') {
	document.getElementById('sattelite_page_path').innerHTML='<%:FORMBUILDER_CONFIRM_PAGE_SELF%>';
}
//YAHOO.util.Event.on("formbuilder_form", "submit", onSaveForm);
} ();
/*** buttons end ***/

/*** drag & drop begin ***/
/*** drag & drop end ***/

/*** texteditor begin ***/
(function() {
    var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event,
        editing = null;
    
    var myConfig = {
        height: '150px',
        width: '520px',
        animate: true,
        toolbar: {
            titlebar: 'Edit text',
            limitCommands: true,
            collapse: true,
            buttons: [
                { group: 'textstyle', label: 'Font Style',
                    buttons: [
                        { type: 'push', label: 'Bold', value: 'bold' },
                        { type: 'push', label: 'Italic', value: 'italic' },
                        { type: 'push', label: 'Underline', value: 'underline' }
					]
				},
				
				{ group: 'alignment', label: 'Font Name and Size',
					buttons: [
                        { type: 'select', label: 'Arial', value: 'fontname', disabled: true,
                            menu: [
                                { text: 'Arial', checked: true },
                                { text: 'Arial Black' },
                                { text: 'Comic Sans MS' },
                                { text: 'Courier New' },
                                { text: 'Lucida Console' },
                                { text: 'Tahoma' },
                                { text: 'Times New Roman' },
                                { text: 'Trebuchet MS' },
                                { text: 'Verdana' }
                            ]
                        },
                        { type: 'spin', label: '13', value: 'fontsize', range: [ 9, 75 ], disabled: true },
                        { type: 'separator' },
                        { type: 'color', label: 'Font Color', value: 'forecolor', disabled: true },
                        { type: 'color', label: 'Background Color', value: 'backcolor', disabled: true }
                    ]
                },
				
				{ group: 'alignment', label: 'Alignment', 
					buttons: [ 
						{ type: 'push', label: 'Align Left CTRL + SHIFT + [', value: 'justifyleft' }, 
						{ type: 'push', label: 'Align Center CTRL + SHIFT + |', value: 'justifycenter' }, 
						{ type: 'push', label: 'Align Right CTRL + SHIFT + ]', value: 'justifyright' }, 
						{ type: 'push', label: 'Justify', value: 'justifyfull' } 
					] 
				}
            ]
        }
    };

    YAHOO.widget.Toolbar.prototype.STR_COLLAPSE = 'Click to close the editor.';
    myEditor = new YAHOO.widget.Editor('editor', myConfig);
    myEditor.on('toolbarLoaded', function() {
        this.toolbar.on('toolbarCollapsed', function() {
            Dom.setXY(this.get('element_cont').get('element'), [-99999, -99999]);
            Dom.removeClass(this.toolbar.get('cont').parentNode, 'yui-toolbar-container-collapsed');
            myEditor.saveHTML();
            editing.innerHTML = myEditor.get('element').value;
            editing = null;
        }, myEditor, true);
    }, myEditor, true);
    myEditor.render();

    Event.on('design_fields', 'dblclick', function(ev) {//design_fields
        var tar = Event.getTarget(ev);
        while(tar.id != 'design_fields') {//design_fields
            if (Dom.hasClass(tar, 'editable')) {
                if (editing !== null) {
                    myEditor.saveHTML();
                    editing.innerHTML = myEditor.get('element').value;
                }
                var xy = Dom.getXY(tar);
                myEditor.setEditorHTML(tar.innerHTML);
                Dom.setXY(myEditor.get('element_cont').get('element'), xy);
                editing = tar;
            }
            tar = tar.parentNode;
        }
    });

})();
/*** texteditor end ***/

/*** container begin ***/
//SAMPLE
//YAHOO.namespace("example.container");

//    YAHOO.util.Event.onDOMReady(function () {

//        YAHOO.example.container.module2 = new YAHOO.widget.Module("module2", { visible: false });
//        YAHOO.example.container.module2.setHeader("Module #2 from Script");
//        YAHOO.example.container.module2.setBody("This is a dynamically generated Module.");
//        YAHOO.example.container.module2.setFooter("End of Module #2");
//        YAHOO.example.container.module2.render();

//        YAHOO.util.Event.addListener("show2", "click", YAHOO.example.container.module2.show, YAHOO.example.container.module2, true);
//        YAHOO.util.Event.addListener("hide2", "click", YAHOO.example.container.module2.hide, YAHOO.example.container.module2, true);

//    });
/*** container end ***/

/*** operations with fields begin ***/
function setConfigPosition(id){
	//set new position to config block
	var pos_shift = -2;
	if(navigator.appName == "Microsoft Internet Explorer"){
		pos_shift = 33;//35-2
	}
	document.getElementById('config_block').style.top = (document.getElementById(id).offsetTop + pos_shift)+'px';
}
function fieldUp(id) {
	var Dom = YAHOO.util.Dom;
	var elem = Dom.get(id);
	var previousElem = elem.previousSibling;
	var parentElem = elem.parentNode;
	if(previousElem) {
		parentElem.insertBefore(elem, previousElem);
	}
}
function fieldDown(id) {
	var Dom = YAHOO.util.Dom;
	var elem = Dom.get(id);
	var nextElem = elem.nextSibling;
	var parentElem = elem.parentNode;
	if(nextElem) {
		parentElem.insertBefore(nextElem, elem);
	}
}
function fieldDelete(id) {
	eval('YAHOO.example.container.module'+id+'_config.destroy();');
	eval('YAHOO.example.container.module'+id+'_field.destroy();');
}
/*** operations with fields end ***/

/*** formbuilder onmouse config begin ***/
function applyClass(type, field, id) {
	var className = field.value;
	if(type == 'error')
		className = 'error_field '+className;
	//if(type == 'label') className = 'editable '+className;
	document.getElementById(type+id).className = className;
}
// onchange="applyAttribute(\''+newId+'\', \'value\', this.value);"
function applyAttribute(id, name, value) {
	var element = document.getElementById('field_id'+id);
	element.setAttribute(name, value);
}
function getOperationsDiv(newId)
{
	return '<div class="operations"><a href="javascript:void(0);" onclick="setConfigPosition(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/right.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldUp(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/up.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDown(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/down.gif" width="16" height="16" border="0" alt="" class="action_ico"></a><a href="javascript:void(0);" onclick="fieldDelete(\''+newId+'\');"><img src="<%:EE_HTTP%>img/formbuilder/delete.gif" width="16" height="16" border="0" alt="" class="action_ico"></a></div>';
}
/*** formbuilder onmouse config end ***/
document.formbuilder_form.fb_form_name.onkeyup = function() {
	replaceFBSpecialCharacters(this);
}
document.formbuilder_form.fb_form_name.onpaste= function() {
	replaceFBSpecialCharacters(this);
}
function replaceFBSpecialCharacters(fieldObj) {
	var val = fieldObj.value;
	fieldObj.value = val.replace(/[^a-z0-9_]/ig, "");
}
</script>

</body>
</html>