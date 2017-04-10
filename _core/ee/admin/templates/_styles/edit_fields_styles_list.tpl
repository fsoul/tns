<tr bgcolor="#ededfd" style="<%:row_style%>">
	<td class="table_data" valign="top" style="padding-top:10px;"><div style="height:280px;">&nbsp;&nbsp;<%:caption%> <%iif::mandatory,,,*%></div></td>
	<td valign="top" style="padding-top:10px;">
<script src="<%:EE_HTTP%>lib/treeview/ua.js" type="text/javascript"></script>
<script src="<%:EE_HTTP%>lib/treeview/ftiens4.js" type="text/javascript"></script>
<script type="text/javascript">
var errorExists = new Array();

function checkErrors()
{
	var ret = false;
	if (errorExists.length > 0)
	{
		alert("<%:STYLE_FORM_SUBMIT_ALERT_TEXT%>");
	}
	else
	{
		ret = true;
	}
	return ret;
}

function checkSizeVal(el)
{
	var pat = new RegExp("^([ ]*)?([0-9]+(px|em|ex|in|cm|mm|pt|pc|%))?([ ]*)?$","i");	
	var alertTextBox = document.createElement("span");

	alertTextBox.innerHTML = "&nbsp;<%:STYLE_VALUE_ALERT_TEXT%>";
	alertTextBox.style.color = "red";
	alertTextBox.style.position = "absolute";

	var parentBox = el.parentNode;
	var childAlertBox = parentBox.getElementsByTagName("span")[0];

	if (pat.test(el.value) == false)
	{
		if (childAlertBox == undefined)
		{
			parentBox.appendChild(alertTextBox);
			errorExists.push('1');
		}

	}
	else if (childAlertBox != undefined)
	{
		parentBox.removeChild(childAlertBox);		
		errorExists.pop();
	}
}


USETEXTLINKS = 0
STARTALLOPEN = 0
USEFRAMES = 0
USEICONS = 0
WRAPTEXT = 0
PERSERVESTATE = 0
BUILDALL = 1
ICONPATH = "<%:EE_HTTP%>lib/treeview/"

foldersTree = gFld("<b>Options</b>", "");

<%print_edit_styles::<%:field_name%>%>
</script>
<table cellspacing="0" cellpadding="0" border=0><tr><td><font size=-2><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target=_blank></a></font></td></tr></table>
<span class="TreeviewSpanArea">
<script>initializeDocument()</script>
<noscript>
A tree of style options will open here if you enable JavaScript in your browser.
</noscript>
</span>

</td>
	<td class="error">&nbsp;&nbsp;<%getError:<%:field_name%>%></td>
</tr>
