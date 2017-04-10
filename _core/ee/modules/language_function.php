<?
/*
if(!defined('PHP_DATE_FORMAT')) define('PHP_DATE_FORMAT','d-m-Y');
if(!defined('PHP_DATE_TIME_FORMAT')) define('PHP_DATE_TIME_FORMAT','Y-m-d H:i:s');
if(!defined('MYSQL_DATE_FORMAT')) define('MYSQL_DATE_FORMAT','%d-%m-%Y');
if(!defined('MYSQL_DATE_TIME_FORMAT')) define('MYSQL_DATE_TIME_FORMAT','%Y-%m-%d %H:%i:%s');
*/
if(!defined('CHECK_YOU_ANSWER')) define('CHECK_YOU_ANSWER','Check your answer please');
if(!defined('CHECK_YOU_ANSWER_INTEGER')) define('CHECK_YOU_ANSWER_INTEGER','Please, check your answer - only integer allowed');
if(!defined('CHECK_YOU_ANSWER_MIN')) define('CHECK_YOU_ANSWER_MIN','Min number of answers');
if(!defined('CHECK_YOU_ANSWER_MAX')) define('CHECK_YOU_ANSWER_MAX','Max number of answers');

//        Buttons
if(!defined('LOGIN_BTN')) define('LOGIN_BTN','LOGIN');
if(!defined('CANCEL')) define('CANCEL','Cancel');
if(!defined('RESET')) define('RESET','Reset');
if(!defined('NEXT')) define('NEXT','Next');
if(!defined('ADD')) define('ADD','Add');
if(!defined('BACK')) define('BACK','Back');
if(!defined('SAVE')) define('SAVE','Save');
if(!defined('CLOSE')) define('CLOSE','Close');
if(!defined('SELECT')) define('SELECT','Select');
if(!defined('SAVE_AND_CLOSE')) define('SAVE_AND_CLOSE','Save and Close');
if(!defined('EXECUTE')) define('EXECUTE','Execute');
if(!defined('FINISH')) define('FINISH','Finish');
if(!defined('PREV')) define('PREV','Previous');
if(!defined('BACK')) define('BACK','Back');
if(!defined('CLOSE')) define('CLOSE','Close');
if(!defined('PRINT_SERTIFICATE_TO_PDF')) define('PRINT_SERTIFICATE_TO_PDF','Print sertificate to PDF');

//	LOGIN
if(!defined('AUTORIZATION')) define('AUTORIZATION','Autorization');
if(!defined('LOGIN')) define('LOGIN','Login');
if(!defined('PASSWORD')) define('PASSWORD','Password');
if(!defined('LANGUAGE')) define('LANGUAGE','Language');

if(!defined('PRINT_THIS_PAGE')) define('PRINT_THIS_PAGE','Print this page');

if(!defined('NO_FILTER')) define('NO_FILTER','No filter');


// ADMIN-MENU CONFIGURATION
// Example "Content|300/". It's mean that Menu-Item will be called "Content" and its Sort-Number will be "300".
if (!defined('ADMIN_MENU_ITEM_ALT_TAGS'))		define('ADMIN_MENU_ITEM_ALT_TAGS',		'Resources/Media/Image Alt Tags');
if (!defined('ADMIN_MENU_ITEM_CONFIG'))			define('ADMIN_MENU_ITEM_CONFIG',		'Administration/Configuration/General');
if (!defined('ADMIN_MENU_ITEM_DNS'))			define('ADMIN_MENU_ITEM_DNS',			'Administration/DNS');
if (!defined('ADMIN_MENU_ITEM_ERROR_HANDLE'))		define('ADMIN_MENU_ITEM_ERROR_HANDLE',		'Administration/Configuration/Error Handling/popup');
if (!defined('ADMIN_MENU_ITEM_ERROR_LOG'))		define('ADMIN_MENU_ITEM_ERROR_LOG',		'Administration/Logs/Errors Log');
if (!defined('ADMIN_MENU_ITEM_ERROR_PAGE'))		define('ADMIN_MENU_ITEM_ERROR_PAGE',		'Administration/Error Pages');
if (!defined('ADMIN_MENU_ITEM_ESHOP_CONFIG'))		define('ADMIN_MENU_ITEM_ESHOP_CONFIG',		'Administration/Configuration/Catalog');
if (!defined('ADMIN_MENU_ITEM_FILES'))			define('ADMIN_MENU_ITEM_FILES',			'Resources/File Manager|10');
if (!defined('ADMIN_MENU_ITEM_GALLERY'))		define('ADMIN_MENU_ITEM_GALLERY',		'Resources|200/Gallery');
if (!defined('ADMIN_MENU_ITEM_GALLERY_IMAGE'))		define('ADMIN_MENU_ITEM_GALLERY_IMAGE',		'Resources|250/Gallery Images');
if (!defined('ADMIN_MENU_ITEM_HELP'))			define('ADMIN_MENU_ITEM_HELP',			'Administration/Help');

if (!defined('ADMIN_MENU_ITEM_LANG'))			define('ADMIN_MENU_ITEM_LANG',			'Administration/Language');
if (!defined('ADMIN_MENU_ITEM_MAIL_INBOX'))		define('ADMIN_MENU_ITEM_MAIL_INBOX',		'Mailing/Mail inbox');
if (!defined('ADMIN_MENU_ITEM_MAILING'))		define('ADMIN_MENU_ITEM_MAILING',		'Mailing|400/Mail Reports');

if (!defined('ADMIN_MENU_ITEM_FAVORITE_LINKS'))		define('ADMIN_MENU_ITEM_FAVORITE_LINKS',	'Favorite links');
if (!defined('ADMIN_MENU_ITEM_MANAGE_FAVORITE'))	define('ADMIN_MENU_ITEM_MANAGE_FAVORITE',	ADMIN_MENU_ITEM_FAVORITE_LINKS.'|150/Manage links/popup');

if (!defined('ADMIN_MENU_ITEM_ITEM_MEDIA'))		define('ADMIN_MENU_ITEM_MEDIA',			'Resources/Media/Media files');
if (!defined('ADMIN_MENU_ITEM_NEWS_LETTERS'))		define('ADMIN_MENU_ITEM_NEWS_LETTERS',		'Mailing/Newsletters');
if (!defined('ADMIN_MENU_ITEM_NL_GROUPS'))		define('ADMIN_MENU_ITEM_NL_GROUPS',		'Mailing/Groups');
if (!defined('ADMIN_MENU_ITEM_NL_NOTIFICATION'))	define('ADMIN_MENU_ITEM_NL_NOTIFICATION',	'Mailing/Mail Notifications');
if (!defined('ADMIN_MENU_ITEM_NL_SUBSCRIBERS'))		define('ADMIN_MENU_ITEM_NL_SUBSCRIBERS',	'Mailing/Subscribers');
if (!defined('ADMIN_MENU_ITEM_OBJECT'))			define('ADMIN_MENU_ITEM_OBJECT',		'Objects/Object management');
if (!defined('ADMIN_MENU_ITEM_OBJECT_CONTENT'))		define('ADMIN_MENU_ITEM_OBJECT_CONTENT',	'Objects/Object Content');
if (!defined('ADMIN_MENU_ITEM_OBJECT_FIELD'))		define('ADMIN_MENU_ITEM_OBJECT_FIELD',		'Objects/Object Fields');
if (!defined('ADMIN_MENU_ITEM_OBJECT_FIELD_TYPE'))	define('ADMIN_MENU_ITEM_OBJECT_FIELD_TYPE',	'Objects/Object Fields type');
if (!defined('ADMIN_MENU_ITEM_OBJECT_RECORD'))		define('ADMIN_MENU_ITEM_OBJECT_RECORD',		'Objects/Object Records');
if (!defined('ADMIN_MENU_ITEM_POLL'))			define('ADMIN_MENU_ITEM_POLL',			'Resources/Polls');
if (!defined('ADMIN_MENU_ITEM_SEARCH_CONFIG'))		define('ADMIN_MENU_ITEM_SEARCH_CONFIG',		'Administration/Configuration/Search');
//if (!defined('ADMIN_MENU_ITEM_SEO'))			define('ADMIN_MENU_ITEM_SEO',			'Content/SEO');
if (!defined('ADMIN_MENU_ITEM_SOAP_CONFIG'))		define('ADMIN_MENU_ITEM_SOAP_CONFIG',		'Administration/Configuration/SOAP');
if (!defined('ADMIN_MENU_ITEM_STYLE'))			define('ADMIN_MENU_ITEM_STYLE',			'Content|300/Styles');
if (!defined('ADMIN_MENU_ITEM_TPL_FOLDER'))		define('ADMIN_MENU_ITEM_TPL_FOLDER',		'Content/Satellite Page folders');
if (!defined('ADMIN_MENU_ITEM_TPL_FILE'))		define('ADMIN_MENU_ITEM_TPL_FILE',		'Content/Satellite templates');
if (!defined('ADMIN_MENU_ITEM_TPL_PAGE'))		define('ADMIN_MENU_ITEM_TPL_PAGE',		'Content/Satellite pages');
if (!defined('ADMIN_MENU_ITEM_USER'))			define('ADMIN_MENU_ITEM_USER',			'Administration/Users');

if (!defined('ADMIN_MENU_ITEM_NEWS'))			define('ADMIN_MENU_ITEM_NEWS',			'News|50');
if (!defined('ADMIN_MENU_ITEM_NEWS_CHANNELS'))		define('ADMIN_MENU_ITEM_NEWS_CHANNELS',		'News/News channel');
if (!defined('ADMIN_MENU_ITEM_NEWS_EXPORT'))		define('ADMIN_MENU_ITEM_NEWS_EXPORT',		'News/News export');
if (!defined('ADMIN_MENU_ITEM_NEWS_ITEMS'))		define('ADMIN_MENU_ITEM_NEWS_ITEMS',		'News/News items');
if (!defined('ADMIN_MENU_ITEM_NEWS_MAPPING'))		define('ADMIN_MENU_ITEM_NEWS_MAPPING',		'News/News mapping');

if (!defined('ADMIN_MENU_SURVEY_RESULT'))		define('ADMIN_MENU_SURVEY_RESULT',		'Resources/Surveys/Results');
if (!defined('ADMIN_MENU_SURVEY_QUESTION'))		define('ADMIN_MENU_SURVEY_QUESTION',		'Resources/Surveys/Manage');

if (!defined('FB_DATE'))						define('FB_DATE',		'date');
if (!defined('FB_USER_IP'))						define('FB_USER_IP',		'user ip');
if (!defined('FB_ERROR_MESSAGE'))				define('FB_ERROR_MESSAGE',		'Error_message:');
if (!defined('FB_HIDDEN_FIELD'))				define('FB_HIDDEN_FIELD',		'[hidden field]');

if (!defined('FORMBUILDER_FORM_NAME'))			define('FORMBUILDER_FORM_NAME', 'Form name:');
if (!defined('FORMBUILDER_FORM_ACTION'))			define('FORMBUILDER_FORM_ACTION', 'Form action:');
if (!defined('FORMBUILDER_EMAIL_TITLE'))			define('FORMBUILDER_EMAIL_TITLE', 'E-mail title:');
if (!defined('FORMBUILDER_SEND_TO_EMAIL'))			define('FORMBUILDER_SEND_TO_EMAIL', 'Send information to email?');
if (!defined('FORMBUILDER_EMAIL_CHARSET'))			define('FORMBUILDER_EMAIL_CHARSET', 'E-mail charset:');
if (!defined('FORMBUILDER_DEST_EMAIL'))			define('FORMBUILDER_DEST_EMAIL', 'Destination e-mail');
if (!defined('FORMBUILDER_STORE_IN_DB'))			define('FORMBUILDER_STORE_IN_DB', 'Store information in DB?');
if (!defined('FORMBUILDER_FROM_EMAIL'))			define('FORMBUILDER_FROM_EMAIL', 'From e-mail:');
if (!defined('FORMBUILDER_THANKYOU_URL'))			define('FORMBUILDER_THANKYOU_URL', 'ThankYou URL:');

if (!defined('ASSETS_FILTER'))			define('ASSETS_FILTER', 'Filter:');
if (!defined('ASSETS_GROUP_BY'))			define('ASSETS_GROUP_BY', 'Group by:');
if (!defined('ASSETS_SEARCH'))			define('ASSETS_SEARCH', 'Search:');
if (!defined('ASSETS_SEARCH_CAPTION'))			define('ASSETS_SEARCH_CAPTION', 'Search');
if (!defined('ASSETS_RESET_CAPTION'))			define('ASSETS_RESET_CAPTION', 'Reset');
if (!defined('ASSETS_BUSY_CAPTION'))			define('ASSETS_BUSY_CAPTION', 'Busy');

if (!defined('ASSETS_GROUP_BY_TREE')) 			define('ASSETS_GROUP_BY_TREE', 'Tree');
if (!defined('ASSETS_GROUP_BY_PLAIN')) 			define('ASSETS_GROUP_BY_PLAIN', 'Plain');
if (!defined('ASSETS_FILTER_ALL')) 			define('ASSETS_FILTER_ALL', 'All');
if (!defined('ASSETS_FILTER_PAGES')) 			define('ASSETS_FILTER_PAGES', 'Pages only');
if (!defined('ASSETS_FILTER_MEDIAS')) 			define('ASSETS_FILTER_MEDIAS', 'Medias only');
if (!defined('ASSETS_DRAFT_MODE')) 			define('ASSETS_DRAFT_MODE', 'Draft mode');
if (!defined('ASSETS_DRAFT_ALL')) 			define('ASSETS_DRAFT_ALL', 'All');
if (!defined('ASSETS_DRAFT_SELECTED')) 			define('ASSETS_DRAFT_SELECTED', 'Selected');
if (!defined('ASSETS_DRAFT_INDEPENT')) 			define('ASSETS_DRAFT_INDEPENT', 'Page-independent');
if (!defined('ASSETS_PUBLISH_ALL_TITLE')) 		define('ASSETS_PUBLISH_ALL_TITLE', 'Publish all pages content');
if (!defined('ASSETS_PUBLISH_ALL_CAPTION')) 		define('ASSETS_PUBLISH_ALL_CAPTION', 'Are you sure want to publish all draft content?');
if (!defined('ASSETS_PUBLISH_INDEPENT_TITLE')) 		define('ASSETS_PUBLISH_INDEPENT_TITLE', 'Publish common content');
if (!defined('ASSETS_PUBLISH_INDEPENT_CAPTION')) 	define('ASSETS_PUBLISH_INDEPENT_CAPTION', 'Are you sure want to publish draft content common for all pages?');
if (!defined('ASSETS_PUBLISH_SELECTED_TITLE')) 		define('ASSETS_PUBLISH_SELECTED_TITLE', 'Publish selected pages');
if (!defined('ASSETS_PUBLISH_SELECTED_CAPTION')) 	define('ASSETS_PUBLISH_SELECTED_CAPTION', 'Are you sure want to publish draft content for selected pages?');
if (!defined('ASSETS_REVERT_ALL_TITLE')) 		define('ASSETS_REVERT_ALL_TITLE', 'Revert back all pages content');
if (!defined('ASSETS_REVERT_ALL_CAPTION')) 		define('ASSETS_REVERT_ALL_CAPTION', 'Are you sure want to revert back and loose all draft content?');
if (!defined('ASSETS_REVERT_INDEPENT_TITLE')) 		define('ASSETS_REVERT_INDEPENT_TITLE', 'Revert back common content');
if (!defined('ASSETS_REVERT_INDEPENT_CAPTION')) 	define('ASSETS_REVERT_INDEPENT_CAPTION', 'Are you sure want to revert back and loose draft content common for all pages?');
if (!defined('ASSETS_REVERT_SELECTED_TITLE')) 		define('ASSETS_REVERT_SELECTED_TITLE', 'Revert back selected');
if (!defined('ASSETS_REVERT_SELECTED_CAPTION')) 	define('ASSETS_REVERT_SELECTED_CAPTION', 'Are you sure want to revert back and loose draft content for selected pages?');

if (!defined('ASSETS_PREVIOUS'))			define('ASSETS_PREVIOUS', 'Previous');
if (!defined('ASSETS_NEXT'))			define('ASSETS_NEXT', 'Next');

if (!defined('ASSETS_TEMPLATE_NOT_EXISTS'))			define('ASSETS_TEMPLATE_NOT_EXISTS', 'Template doesn\'t exists');

if (!defined('STYLE_VALUE_ALERT_TEXT'))			define('STYLE_VALUE_ALERT_TEXT', ' example: 1px or 1pt etc...');
if (!defined('STYLE_FORM_SUBMIT_ALERT_TEXT'))		define('STYLE_FORM_SUBMIT_ALERT_TEXT', 'Check values please that contain size.');

if (!defined('MENU_URL_EMPTY_ALERT_TEXT'))		define('MENU_URL_EMPTY_ALERT_TEXT', 'Please enter URL.');
if (!defined('MENU_SAT_EMPTY_ALERT_TEXT'))		define('MENU_SAT_EMPTY_ALERT_TEXT', 'Please set Satellite Page.');


function get_language_array()
{
	$arr = array();

	$sql_langs = '	SELECT
				language_code
			FROM 
				v_language
	      		ORDER BY
				default_language
			DESC';

	$arr = SQLField2Array(viewsql($sql_langs, 0));

	return $arr;
}

?>