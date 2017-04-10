<script language="JavaScript">

var changedSEO = false;
 
var editSEOStruct = {
	'metafield' 	: false,
	'langCode' 	: false,
	'pageId' 	: false,
	'objectView' 	: false,
	'inDraft'	: false,
	'haveError'	: false,
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

function editSEO(el, metafield, langCode, pageId, objectView) {

	if (document.getElementById('seo-full-edit')) {
		closeTextArea();
	}

	editSEOStruct.metafield  = metafield;
	editSEOStruct.langCode 	 = langCode;
	editSEOStruct.pageId 	 = pageId;
	editSEOStruct.objectView = objectView;

	if (el.className == 'seoInDraft') {
		editSEOStruct.inDraft = true;
	} else if (el.className == 'iSEOError') {
		editSEOStruct.haveError = true;
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

	var error = (editSEOStruct.haveError ? '&nbsp;<a href="#" class="seoError" title="Page &#171;' + value + '&#187; already exists.">[!]</a>' : '');

	var html = '<input type="text" '+((editSEOStruct.inDraft || changedSEO) && !editSEOStruct.haveError ? 'class="seoInDraft"' : '') + (editSEOStruct.haveError ? 'class="iSEOError"' : '') + ' onFocus="editSEO(this, \''+i.metafield+'\', \''+i.langCode+'\', \''+i.pageId+'\', \''+i.objectView+'\');" value="' + value + '" />' + error;

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

		var checkEl 	= seoTextArea.parentNode.parentNode;
		var value	= seoTextArea.value;

		fr = document.getElementById('iframe1');

		fr.src = '<%:EE_ADMIN_URL%>seo_meta_tag_edit.php?var=' 		+ editSEOStruct.metafield + 
								'&val=' 	+ encodeURIComponent(value) + 
								'&language=' 	+ editSEOStruct.langCode + 
								'&page_id=' 	+ editSEOStruct.pageId + 
								'&obj_seo=1' 	+
								'&obj_view=' 	+ editSEOStruct.objectView;
		fr.onload = function() {

			var result = window.frames[2].document.body.innerHTML;

			if (result == 'PAGE_EXISTS') {
				checkEl.getElementsByTagName('INPUT')[0].className = 'iSEOError';
				length = (checkEl.innerHTML.indexOf('&nbsp;') !== -1 ? checkEl.innerHTML.indexOf('&nbsp;') : checkEl.innerHTML.toString().length);
				checkEl.innerHTML = checkEl.innerHTML.substring(0, length) + '&nbsp;<a href="#" class="seoError" title="Page &#171;' + value + '&#187; already exists.">[!]</a>';
			} else {
				checkEl.getElementsByTagName('INPUT')[0].className = 'seoInDraft';
				length = (checkEl.innerHTML.indexOf('&nbsp;') !== -1 ? checkEl.innerHTML.indexOf('&nbsp;') : checkEl.innerHTML.toString().length);
				checkEl.innerHTML = checkEl.innerHTML.substring(0, length) + '';
			}
		};

		changedSEO = true;
		editSEOStruct.inDraft 	= true;
	}
}

function cleanSEOStruct () {
	editSEOStruct.metafield	 = false;
	editSEOStruct.langCode	 = false;
	editSEOStruct.pageId	 = false;
	editSEOStruct.objectView = false;
	editSEOStruct.inDraft	 = false;
	editSEOStruct.haveError	 = false;
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