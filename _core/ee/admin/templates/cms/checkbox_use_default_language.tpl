<textarea style="display:none" id="default_language_<%:cms_name%>_cms_value"><%:default_language_<%:cms_name%>_cms_value%></textarea>

<script>
// config

// what do we do with the toolbar when disabling the editor. Possibilities are 'disable', 'hide', 'collapse'.
// When collapsed the toolbar can be expanded again by the user, but he'll find a disabled toolbar.
var toolbarDisabledState = "disable";

function toggleFCKeditor(editorInstance, OnOf)
{
	if (OnOf = 'off')
	{
		// disable the editArea
		if (document.all)
		{
			editorInstance.EditorDocument.body.disabled = true;
		}
		else
		{
			editorInstance.EditorDocument.designMode = "off";
		}

		// disable the toolbar
		switch (toolbarDisabledState)
		{
			case "collapse" :

				editorInstance.EditorWindow.parent.FCK.ToolbarSet._ChangeVisibility(true);

			case "disable" :

				editorInstance.EditorWindow.parent.FCK.ToolbarSet.Disable();
				buttonRefreshStateClone = editorInstance.EditorWindow.parent.FCKToolbarButton.prototype.RefreshState;
				specialComboRefreshStateClone = editorInstance.EditorWindow.parent.FCKToolbarSpecialCombo.prototype.RefreshState;
				editorInstance.EditorWindow.parent.FCKToolbarButton.prototype.RefreshState = function(){return false;};
				editorInstance.EditorWindow.parent.FCKToolbarSpecialCombo.prototype.RefreshState = function(){return false;};

				break;

			case "hide" :

				if (editorInstance.EditorWindow.parent.document.getElementById("xExpanded").style.display != "none")
				{
					editorInstance.EditorWindow.parent.document.getElementById("xExpanded").isHidden = true;
					editorInstance.EditorWindow.parent.document.getElementById("xExpanded").style.display = "none";
				}
				else
				{
					editorInstance.EditorWindow.parent.document.getElementById("xCollapsed").style.display = "none";
				}

				break;
		}
	}
	else if (OnOf = 'on')
	{
		// enable the editArea
		if (document.all)
		{
			editorInstance.EditorDocument.body.disabled = false;
		}
		else
		{
			editorInstance.EditorDocument.designMode = "on";
		}

		// enable the toolbar
		switch (toolbarDisabledState)
		{
			case "collapse" :

				editorInstance.EditorWindow.parent.FCK.ToolbarSet._ChangeVisibility(false);

			case "disable" :

				editorInstance.EditorWindow.parent.FCK.ToolbarSet.Enable();
				editorInstance.EditorWindow.parent.FCKToolbarButton.prototype.RefreshState = buttonRefreshStateClone;
				editorInstance.EditorWindow.parent.FCKToolbarSpecialCombo.prototype.RefreshState = specialComboRefreshStateClone;

				break;

			case "hide" :

				if (editorInstance.EditorWindow.parent.document.getElementById("xExpanded").isHidden == true)
				{
					editorInstance.EditorWindow.parent.document.getElementById("xExpanded").isHidden = false;
					editorInstance.EditorWindow.parent.document.getElementById("xExpanded").style.display = "";
				}
				else
				{
					editorInstance.EditorWindow.parent.document.getElementById("xCollapsed").style.display = "";
				}

				break;
		}

		// set focus on editorArea
		editorInstance.EditorWindow.focus();

		// and update toolbarset
		editorInstance.EditorWindow.parent.FCK.ToolbarSet.RefreshModeState();
	}
}


function FCKeditor_OnComplete(editorInstance)
{
	if (editorInstance.Name == 'cms_val_for_default_language')
	{
		toggleFCKeditor(editorInstance, 'off');
	}
}

</script>


<input
	id="checkbox_use_default_language"
	type="checkbox"
	name="use_default_language"
	<%iif:<%:lang%>,<%:default_language%>,disabled,<%iif:<%:not_null_current_language_content_var_count%>,1,,checked%>%>

	onClick="

		if (this.checked==false)
		{
			document.getElementById('fck_default_language').style.display = 'none';
			document.getElementById('fck_current_language').style.display = '';
		}
		else
		{
			document.getElementById('fck_current_language').style.display = 'none';
			document.getElementById('fck_default_language').style.display = '';
		}
	"
>

<span id="use_default_language_span" <%iif:<%:lang%>,<%:default_language%>,style="color:#ccc"%>>
Use default language (<%:default_language%>)
</span>

