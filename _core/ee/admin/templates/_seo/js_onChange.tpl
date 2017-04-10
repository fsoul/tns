<script language="JavaScript">

var changedSEO = false;
 
var editSEOStruct = {
	'metafield' 	: false,
	'langCode' 	: false,
	'pageId' 	: false,
	'inDraft'	: false,
}

window.onkeyup = function(e) {
	if (	e.keyCode == '27' &&
		document.getElementById('seo-full-edit')) {
			closeTextArea();
	}
}

document.onfocus = function() {
	if(document.getElementById('seo-full-edit')) {
		closeTextArea();
	}
}

function editSEO(el, metafield, langCode, pageId) {

	if (document.getElementById('seo-full-edit')) {
		closeTextArea();
	}

	editSEOStruct.metafield  = metafield;
	editSEOStruct.langCode 	 = langCode;
	editSEOStruct.pageId 	 = pageId;

	if (el.className == 'seoInDraft') {
		editSEOStruct.inDraft = true;
	}

	var value = el.value.replace(/\&/gi, '&#38;');

	el.parentNode.innerHTML = 	'<div style="position:absolute; margin-top:-10px;">' + 
						'<textarea id="seo-full-edit" class="seoEdit" cols="40" rows="7" onkeyup="fitToContent(this, 300);" onchange="saveSEO(this);">' + value + '</textarea>' +
					'</div>';


	document.getElementById('seo-full-edit').focus();
}

function closeTextArea() {

	var i 	= editSEOStruct;
	var seoTextArea = document.getElementById('seo-full-edit');

	var value = seoTextArea.value.replace(/\&/gi, '&#38;');
	var value = value.replace(/\"/gi, '&#34;');

	var html = '<input type="text" '+(editSEOStruct.inDraft ? 'class="seoInDraft"' : '')+' onFocus="editSEO(this, \''+i.metafield+'\', \''+i.langCode+'\', \''+i.pageId+'\');" value="' + value + '" ' + (changedSEO ? 'style="color: #006600; <%iif:<%config_var:use_draft_content%>,1,background: #FFFFCC; border: 1px solid #FFCC00;%>"' : '') + '/>';

	seoTextArea.parentNode.parentNode.innerHTML = html;

	if (	'<%config_var:use_draft_content%>' == 1 &&
		changedSEO &&
		document.getElementById('draft_mode_buttons').style.display == 'none'
	) {
		document.getElementById('draft_mode_buttons').style.display = 'block';
	}
	changedSEO = false;
	cleanSEOStruct();
}

function saveSEO(seoTextArea) {

	if (editSEOStruct.metafield) {
		var fr;

		fr = document.getElementById('iframe1');

		fr.src = '<%:EE_ADMIN_URL%>seo_meta_tag_edit.php?var=' 		+ editSEOStruct.metafield + 
								'&val=' 	+ encodeURIComponent(seoTextArea.value) + 
								'&language=' 	+ editSEOStruct.langCode + 
								'&page_id=' 	+ editSEOStruct.pageId;
		changedSEO = true;
		editSEOStruct.inDraft = true;
	}
}

function cleanSEOStruct () {
	editSEOStruct.metafield	 = false;
	editSEOStruct.langCode	 = false;
	editSEOStruct.pageId	 = false;
	editSEOStruct.inDraft	 = false;
}

function fitToContent(id, maxHeight)
{
	var text = id && id.style ? id : document.getElementById(id);
	if ( !text )
		return;

	var adjustedHeight = text.clientHeight;

	if ( !maxHeight || maxHeight > adjustedHeight ) {
		adjustedHeight = Math.max(text.scrollHeight, adjustedHeight);

		if ( maxHeight ) {
			adjustedHeight = Math.min(maxHeight, adjustedHeight);
		}
		if ( adjustedHeight > text.clientHeight ) {
			text.style.height = adjustedHeight + "px";
		}
	}
}

</script>