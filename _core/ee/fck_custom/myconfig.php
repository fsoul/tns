<?

$admin = true;

include ("../define_constants.php");
header("Content-type: text/javascript");

DEFINE("EE_FCK_CUSTOM_PATH", EE_HTTP_PREFIX.EE_HTTP_PREFIX_CORE."fck_custom/");

?>
FCKConfig.ContextMenu = ['Generic','Width_link','Anchor','Image','Select','Textarea','Checkbox','Radio','TextField','HiddenField','ImageButton','Button','BulletedList','NumberedList','TableCell','Table','Form'] ;
FCKConfig.StylesXmlPath = '<?echo EE_FCK_CUSTOM_PATH?>fckstyles.php' ;
FCKConfig.EditorAreaCSS = '<?echo EE_HTTP_PREFIX?>css/common.css' ;
FCKConfig.Plugins.Add( 'eelink', null, '<?echo EE_FCK_CUSTOM_PATH?>' ) ;
FCKConfig.GeckoUseSPAN	= true ;
FCKConfig.ForcePasteAsPlainText	= false ;
FCKConfig.ForceStrongEm = false ;

FCKConfig.LinkBrowser = true ;
//FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=connectors/php/connector.php';
//FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=connectors/' + _FileBrowserLanguage + '/connector.' + _FileBrowserExtension ;
//FCKConfig.LinkBrowserURL = FCKConfig.BasePath + '../../fck_custom/eelink/default/browser.html?Connector=connectors/php/connector.php' ;
FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=<?echo EE_FCK_CUSTOM_PATH?>eelink/connectors/php/connector.php' ;

FCKConfig.ImageBrowser = true ;
FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector=<?echo EE_FCK_CUSTOM_PATH?>eelink/connectors/php/connector.php' ;

FCKConfig.FlashBrowser = true ;
FCKConfig.FlashBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Flash&Connector=<?echo EE_FCK_CUSTOM_PATH?>eelink/connectors/php/connector.php';

FCKConfig.LinkUpload = true ;
FCKConfig.LinkUploadURL = '<?echo EE_FCK_CUSTOM_PATH?>eelink/upload/upload.php' ;

FCKConfig.ImageUpload = true ;
FCKConfig.ImageUploadURL = '<?echo EE_FCK_CUSTOM_PATH?>eelink/upload/upload.php?Type=Image' ;

FCKConfig.FlashUpload = true ;
FCKConfig.FlashUploadURL = '<?echo EE_FCK_CUSTOM_PATH?>eelink/upload/upload.php?Type=Flash' ;

FCKConfig.ToolbarSets["Empty"] = [];

FCKConfig.ToolbarSets["Alloc"] = [
	['Source','DocProps'],
	['Cut','Copy','Paste','PasteText','-','Print'],
	['Undo','Redo','-','Find','Replace'],
	['My_link','Unlink','Image','Flash','Table'],
	['Select','Textarea','Checkbox','Radio','TextField','HiddenField','ImageButton','Button'],
	'/',
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','Outdent','Indent'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['SelectAll','RemoveFormat'],
	['Rule','SpecialChar'],
	['TextColor','BGColor'],
	'/',
	['Style'],
	['About']
] ;

FCKConfig.ToolbarSets["LAB"] = [
	['Source','DocProps'],
	['Cut','Copy','Paste','PasteText','-','Print'],
	['Undo','Redo','-','Find','Replace'],
	['Link','Unlink','Image','Table'],
	'/',
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','Outdent','Indent'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['SelectAll','RemoveFormat'],
	['Rule','SpecialChar'],
	['TextColor','BGColor'],
	'/',
	['FontName','FontSize'],
	['About']
] ;

function GetUrlParam( paramName )
{
	var oRegex = new RegExp( '[\?&]' + paramName + '=([^&]+)', 'i' ) ;
	var oMatch = oRegex.exec( window.parent.location.search ) ;
	
	if ( oMatch && oMatch.length > 1 )
		return oMatch[1] ;
	else
		return '' ;
}


FCKConfig.lang = GetUrlParam('lang');

// FCKConfig.EnterMode = 'div'; // p | div | br
// FCKConfig.ShiftEnterMode = 'br' ; // p | div | br
