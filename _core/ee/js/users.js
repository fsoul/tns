// функции для работы с полями "Role" и "Backoffice user access".
function changeSelectState(state) {
	var disabledState = (state == 'hide')?true:false;
	document.getElementById('user_groups_sel').disabled = disabledState;
	document.getElementById('available_groups_sel').disabled = disabledState;
}

function getSelectedFields(id) {
	var result = new Array();
	var object = document.getElementById(id);
	var j = 0;
	for(var i = 0; i < object.options.length; i++) {
	if(object.options[i].value != ''){
			result[j++] = object.options[i].value;
			result[j++] = object.options[i].text;
		}
	}
	return result;
}

var available_groups_selected;
var user_groups_selected;
var is_restore = 1;
function storeValues(is_adm) {
	if(is_restore) {
		user_groups_selected = getSelectedFields('user_groups_sel');
		available_groups_selected = getSelectedFields('available_groups_sel');
	}
	if(is_adm == 'yes') {
		is_restore = 0;
	} else {
		is_restore = 1;
	}
}

function setSelectedFields(id) {
	if(available_groups_selected.length > 0 || user_groups_selected.length > 0) {
		if(id == 'user_groups_sel') {
			var lastValues = user_groups_selected;
		} else {
			var lastValues = available_groups_selected;
		}
		var object = document.getElementById(id);
		//clear select list
		object.options.length = 0;
		//restore values
		for(var i = 0; i < lastValues.length; i=i+2) {
			object.options[object.options.length] = new Option(lastValues[i+1], lastValues[i]);
		}
	}
}

function restoreValues() {
	setSelectedFields('user_groups_sel');
	setSelectedFields('available_groups_sel');
}

function check_role(role)
{
	if(role == 3)
	{
		for(var i=1; i<5; i++)
			set_disable_bo_congf('content_access_' + i);
		document.getElementById('content_access_4').checked = true;
	}
	else if(role == 2)
	{
		for(var i=1; i<5; i++)
			set_available_bo_congf('content_access_' + i);
	}
	else if(role == 0)
	{
		for(var i=1; i<5; i++)
			set_disable_bo_congf('content_access_' + i);
		document.getElementById('content_access_1').checked = true;
	}
}

function set_available_bo_congf(id)
{
	document.getElementById(id).disabled = false;
}

function set_disable_bo_congf(id)
{
	document.getElementById(id).disabled = true;
	
}

function check_access_mode(am)
{

	if(am == 1)
	{
		i_move('no_access_groups', 'access_groups');
		set_disable_bo_congf('access_groups');
		set_disable_bo_congf('no_access_groups');
	}
	else
	{

		set_available_bo_congf('access_groups');
		set_available_bo_congf('no_access_groups');
	}
}
// функции для работы со списками. Перемещает все "<option>" c "from" в "to"
function i_move(from, to)
{
	var from = document.getElementById(from);
	var to = document.getElementById(to);

	if(from.disabled || to.disabled) return;
	for(var i = 0; i < from.options.length;)
	{
		var new_text = from.options[i].text;
		var new_value = from.options[i].value;
		from.options[0] = null;
		to.options[to.options.length] = new Option(new_text, new_value);
	}	
}
// функции для работы со списками. Перемещает выделеные "<option>" c "from" в "to"
function i_move_select(from, to)
{
	var from = document.getElementById(from);
	var to = document.getElementById(to);

	for(var i = 0; i < from.options.length; i++)
	{
		if(from.options[i].selected)
		{
			var new_text = from.options[i].text;
			var new_value = from.options[i].value;
			from.options[i] = null;
			if(is_find(new_text, to))
			{}
			else
			{
				to.options[to.options.length] = new Option(new_text, new_value);
			}
			i = i - 1;
		}
	}
}
// функция которая ищет в списке "el" строку "what" в случае первого совпадения возвразщает true;
function is_find(what, el)
{       
	for(var i = 0; i < el.options.length; i++)
	{
		var text = el.options[i].text;
		if(text == what) return true;
	}
	return false;
}

function submit_edit_form(list1, list2)
{
	//show disabled select lists
	//changeSelectState('show');
	var list1 = document.getElementById(list1);
	var list2 = document.getElementById(list2);

	if (list1 != undefined)
	{
	        for(var i = 0; i < list1.options.length; i++)
		{
			list1.options[i].selected = true;
		}
	}
	if (list2 != undefined)
	{
		for(var i = 0; i < list2.options.length; i++)
		{
			list2.options[i].selected = true;
		}
	}
	return true;
	//submit();
}

//
function hideDiv(id, className)
{
	if (document.getElementById(id) != undefined)
	{
		document.getElementById(id).style.display = 'none';
		if(className)
		{
			document.getElementById(id + '_sl').className = className;
		}
	}
}
function showDiv(id, className)
{
	if (document.getElementById(id) != undefined)
	{
		document.getElementById(id).style.display = 'block';
		if(className)
		{
			document.getElementById(id + '_sl').className = className;
		}
	}
}

function selectTab(li)
{
	var im = li.parentNode.getElementsByTagName('li');

	var _id = li.id.substr(0,li.id.indexOf('_sl'));

	for (i = 0; i < im.length; i++)
	{
		im[i].className = 'sl_unselect';

		var __id = im[i].id.substr(0,im[i].id.indexOf('_sl'));

		if (document.getElementById(__id))
		{
			document.getElementById(__id).style.display = 'none';
		}
	}

	li.className = 'sl';
	document.getElementById(_id).style.display = 'block';
}