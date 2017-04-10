
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/assets/skins/sam/container.css" />

<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%><%:EE_HTTP_PREFIX_CORE%>lib/yui/build/container/container-min.js"></script>

<script type="text/javascript">

YAHOO.namespace("example.container");

function draft_mode_handler(obj)
{
	if (obj.checked === false)
	{
		var popupBody = '<table>' +
				'	<tr>' +
				'	<td>You try to turn off draft mode. What you want to do?</td>' +
				'	</tr>' +
				'	<tr>' +
				'	<td>' +
				'		<input id="publish_all" type="button" class="button" value="Publish all data" />' +
				'		<input id="revert_all" type="button" class="button" value="Revert all data" />' + 
				'		<input id="cancel" type="button" class="button" value="Cancel" />' +
				'	</td>' +
				'	</tr>' +
				'</table>';

		YAHOO.example.container.panel2.setBody(popupBody);
		YAHOO.example.container.panel2.setHeader("Draft mode");

		YAHOO.util.Event.addListener("publish_all", "click", function() {
										YAHOO.example.container.panel2.hide();
										document.getElementById('DM_Action').value = 'publish_all';
										document.getElementById('DM_notice').innerHTML = 'Notice: After save draft mode action - <strong>PUBLISH</strong> content';
									}, YAHOO.example.container.panel2, true);

		YAHOO.util.Event.addListener("revert_all", "click", function() {
										YAHOO.example.container.panel2.hide();
										document.getElementById('DM_Action').value = 'revert_all';
										document.getElementById('DM_notice').innerHTML = 'Notice: After save draft mode action - <strong>REVERT</strong> content';
									}, YAHOO.example.container.panel2, true);

		YAHOO.util.Event.addListener("cancel", "click", function() {
									YAHOO.example.container.panel2.hide();
									obj.checked 	= true;
									obj.disabled 	= false;
									document.getElementById('DM_notice').innerHTML = '';
								}, YAHOO.example.container.panel2, true);

		YAHOO.example.container.panel2.cfg.setProperty("visible", true);
		obj.disabled = true;
	}
}

function initDM()
{
	// Instantiate a Panel from script

	YAHOO.example.container.panel2 = new YAHOO.widget.Panel("panel2", { width:"330px", visible:false, draggable:true, close: false } );
	YAHOO.example.container.panel2.setHeader("");
	YAHOO.example.container.panel2.setBody("");

	YAHOO.example.container.panel2.render("container");
}

YAHOO.util.Event.addListener(window, "load", initDM);

</script>

<input type="hidden" id="DM_Action" name="DM_Action" value="" />
<input <%iif::readonly,,,readonly%> type="checkbox" name="<%:field_name%>" <%iif:<%:<%:field_name%>%>,1,checked%> value="1" onclick="draft_mode_handler(this);">
<span id="DM_notice" style="color: #509048;">&nbsp;</span>
<div id="container"></div>