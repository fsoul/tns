<?
//Menu visibility level
define('VISIBLE_FOR_ALL',		'');
define('VISIBLE_FOR_NOT_AUTHORIZED',	'not_auth');
define('VISIBLE_FOR_AUTHORIZED',	'auth');
define('VISIBLE_FOR_BACKOFFICE',	'admin');

// Roles
define('USER',0);
define('ADMINISTRATOR',3);
define('POWERUSER',2);
// Content access(default access) constant
define('CA_READ_ONLY', 1);
define('CA_EDIT', 2);
define('CA_PUBLISH', 3);
define('CA_FULL', 4);
// Access mode constant
define('AM_ALL', 1);
define('AM_GROUPS', 2);
//
define('ENABLED',1);
define('DISABLED',0);

define('ZIP_HEADER_SIGNATURE', '504b34');  //zip header signature  4 bytes  (0x04034b50)

$size_units 	= array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
$b_color[0]='#ffffff';
$b_color[1]='#ededfd';

define('ITEM_STATUS_NO',0);
define('ITEM_STATUS_YES',1);

define('RMA_STATUS_NEW',0);
define('RMA_STATUS_AUTHORIZED',1);
define('RMA_STATUS_RESEIVED',2);
define('RMA_STATUS_RETURNED',3);
define('RMA_STATUS_CLOSED',4);

// Global access keys
define('BUT_LABEL_ADDNEW','Add New');
define('BUT_LABEL_EDIT','Edit');
define('BUT_LABEL_DELETE','Delete');
define('BUT_LABEL_CANCEL','Cancel');
define('BUT_LABEL_SAVE','Save');
define('BUT_LABEL_SAVE_ADD_MORE','Save and Add More');
define('BUT_LABEL_SAVE_CONTINUE','Save and Continue Editing');
define('BUT_LABEL_SAVE_EDIT','Save and Edit Contents');
define('BUT_LABEL_RESET','Reset');
define('BUT_LABEL_IMPORT','Import');
define('BUT_LABEL_BACK','Back');
define('BUT_LABEL_SEND','Send');
define('BUT_LABEL_SELECT_EVENTS','Select Events');
define('BUT_LABEL_CLOSE','Close');
define('BUT_LABEL_EXPORT', 'Export burnable copy');
define('BUT_LABEL_EXPORT_META', 'Export');
define('BUT_LABEL_YES', 'Yes');
define('BUT_LABEL_NO', 'No');
define('BUT_LABEL_OK','OK');

define('BUT_ACCESS_KEY_EXPORT', 'X');
define('BUT_ACCESS_KEY_ADDNEW','A');
define('BUT_ACCESS_KEY_EDIT','E');
define('BUT_ACCESS_KEY_DELETE','D');
define('BUT_ACCESS_KEY_CANCEL','C');
define('BUT_ACCESS_KEY_SAVE','S');
define('BUT_ACCESS_KEY_RESET','R');
define('BUT_ACCESS_KEY_IMPORT','I');
define('BUT_ACCESS_KEY_BACK','B');
define('BUT_ACCESS_KEY_SEND','S');
define('BUT_ACCESS_KEY_CLOSE','C');
define('BUT_ACCESS_KEY_OK','O');

define('TEMPLATE_PREVIEW','TEMPLATE_PREVIEW');
define('GRID_EDIT','Edit');
define('GRID_PREVIEW','Preview');
define('GRID_DEL','Delete');
define('GRID_MODULS_LIST','Edit allowed moduls list');
define('GRID_DIR_ACCESS_LIST','Change access to folders');

define('ADMIN_EDIT_PAGE_CONTENT', 'Edit Page Content');
define('ADMIN_EDIT_PAGE_CONTENT_BY_TYPE', 'Edit Page Content (by type)');
define('ADMIN_EDIT_OBJECT', 'Edit Object ');
define('ADMIN_EDIT_IMAGE', 'Edit Image ');

define('GRID_DISABLED','Disabled');
define('GRID_ENABLED','Enabled');

	/*Media*/
/*Media properties position*/
if (!defined('MEDIA_PROPERTY_POSITION_TOP')) define('MEDIA_PROPERTY_POSITION_TOP' , '-18px');
if (!defined('MEDIA_PROPERTY_POSITION_RIGHT')) define('MEDIA_PROPERTY_POSITION_RIGHT' , '50px');

define('MANDATORY_FIELDS','mandatory fields');
define('NO_RECORDS_FOUND','No records found');
define('ERROR_EMAIL_PATTERN', 'Email address is not valid');

define('EMAIL_PATTERN', '^([a-zA-Z0-9_-]+\.)*[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*\.[a-zA-Z]{2,4}$');

define('TAX_VALUE', 0.16);

define('DATE_FORMAT_MYSQL', '%Y-%m-%d');
define('TIME_FORMAT_MYSQL', '%H:%i:%s');
define('DATETIME_FORMAT_MYSQL', DATE_FORMAT_MYSQL.' '.TIME_FORMAT_MYSQL);

define('DATE_FORMAT_MYSQL_PRINTF', str_replace('%', '%%', DATE_FORMAT_MYSQL));
define('TIME_FORMAT_MYSQL_PRINTF', str_replace('%', '%%', TIME_FORMAT_MYSQL));
define('DATETIME_FORMAT_MYSQL_PRINTF', str_replace('%', '%%', DATETIME_FORMAT_MYSQL));

define('DATETIME_FORMAT_PHP', str_replace('%', '', DATETIME_FORMAT_MYSQL));
define('DATE_FORMAT_PHP', str_replace('%', '', DATE_FORMAT_MYSQL));
define('TIME_FORMAT_PHP', str_replace('%', '', TIME_FORMAT_MYSQL));

define('DATE_FORMAT_JS', 'y-mm-dd');

define('DATE_FORMAT_ORACLE', 'dd.mm.yyyy HH24:MI:SS');

if (!defined('MANAGED_BY_URL'))		define('MANAGED_BY_URL', 'http://.../');
if (!defined('MANAGED_BY_NAME'))	define('MANAGED_BY_NAME', '...');
if (!defined('SUPPORT_CONTACTS_EMAIL')) define('SUPPORT_CONTACTS_EMAIL', '...'); // visible on site
if (!defined('SUPPORT_EMAIL'))		define('SUPPORT_EMAIL','...');		// for scripts only
if (!defined('SUPPORT_CONTACTS_PHONE')) define('SUPPORT_CONTACTS_PHONE', '');
if (!defined('SUPPORT_CONTACTS_HOURS')) define('SUPPORT_CONTACTS_HOURS', '10:00 - 19:00 (CET + 1)');

if (!defined('INSTALLATION_ID'))	define('INSTALLATION_ID', 'UNDEFINED');
if (!defined('DOMAIN_NAME'))		define('DOMAIN_NAME', EE_HTTP_SERVER);

if (!defined('USER_IP')) define('USER_IP', $_SERVER['REMOTE_ADDR']);
define('SERVER_IP', $_SERVER['SERVER_ADDR']);

define('MIN_PASSWORD_LENGTH', 8);
define('MIN_PASSWORD_LENGTH_FRONTEND', 5);
			     
define('PASSWORD_TOO_SHORT', 'Password must not be shorter than ' . MIN_PASSWORD_LENGTH . ' characters');
define('PASSWORD_TOO_SHORT_FRONTEND', 'Password must not be shorter than ' . MIN_PASSWORD_LENGTH_FRONTEND . ' characters');

define('EMPTY_ERROR', 'This field is mandatory');

define('DRAFT', 'draft');
define('PUBLISHED', 'published');
define('ARCHIVE', 'archive');

define('DRAFT_MODE_TITLE', 'You are in draft mode');
define('NOT_AUTHORIZED_MSG', 'You are not authorized');

define('PUBLISH', 'Publish page content');
define('REVERT', 'Revert page content');

if (!defined('SITEMAP_CHANGEFREQ')) define('SITEMAP_CHANGEFREQ', 'monthly');
if (!defined('SITEMAP_PRIORITY')) define('SITEMAP_PRIORITY', '0.8');

define('BUT_CHECK_MODULES', 'Check modules');

define('LOG OUT', 'Exit');
define('DNS', 'De eN eS');
define('URL_SYNTAX_WARNING', 'Absolute URL should begin with <b>http://</b> or <b>https://</b>');

if (!defined('DELETE_CACHE_ALL_LANG')) define('DELETE_CACHE_ALL_LANG' , 'Clear the cache for a page');
if (!defined('DELETE_CACHE_CURR_LANG')) define('DELETE_CACHE_CURR_LANG' , 'Clear the cache for a page');

if (!defined('DELETE_SEL_GRID_ITEM_CONFIRM')) define('DELETE_SEL_GRID_ITEM_CONFIRM' , 'Do you really want to delete selected items?');
if (!defined('SEL_GRID_ITEM_WARNING')) define('SEL_GRID_ITEM_WARNING' , 'Please select items!');
if (!defined('SEL_GRID_ITEM_EXTEND_WARNING')) define('SEL_GRID_ITEM_EXTEND_WARNING' , 'No selected pages found. Action will be applied for all pages - please confirm!');

if (!defined('DELETE_SEL_GRID_IMAGE_ALT')) define('DELETE_SEL_GRID_IMAGE_ALT' , 'Delete selected rows');
if (!defined('REFRESH_A_PAGE_DATE_TO_CURRENT')) define('REFRESH_A_PAGE_DATE_TO_CURRENT' , 'Refresh a date of selected pages');
# MAX_MEDIA_DIRECT_OUTPUT_SIZE sets in bytes. 1048576 for 1 Mbyte
if (!defined('MAX_MEDIA_DIRECT_OUTPUT_SIZE')) define('MAX_MEDIA_DIRECT_OUTPUT_SIZE' , 1048576);
# Read buffer
if (!defined('DIRECT_OUTPUT_BUFF_SIZE')) define('DIRECT_OUTPUT_BUFF_SIZE' , 32768);

//copy page (deviant add)
if (!defined('COPY_SEL_GRID_IMAGE_ALT')) define('COPY_SEL_GRID_IMAGE_ALT' , 'Copy selected pages');
if (!defined('GRID_COPY_ALT')) define('GRID_COPY_ALT' , 'Copy page');
if (!defined('COPY_SEL_GRID_ITEM_CONFIRM')) define('COPY_SEL_GRID_ITEM_CONFIRM' , 'Do you really want to copy selected pages?');

define('COPY_FORM' , 'Copy form');

define('MEDIA_PREVIEW_WIDTH',200);
define('FUNCTION_NOT_AVAILABLE',"This function is not available on your server. Please contact administrator");

define('YOUR_NEW_PASSWORD', 'Your new password');
define('USERS_NEW_PASSWORD', 'user\'s new password');

define('MAIL_SENDING_ERROR', 'Mail was not sent because of unknown error');
define('RECORD_SAVED_BUT_MAIL_SENDING_ERROR', 'Record was saved, but '.MAIL_SENDING_ERROR);
define('PASSWORD_RESETED_BUT_MAIL_SENDING_ERROR', 'Password was reseted, but '.MAIL_SENDING_ERROR);

define('SATELLITE_PAGE', 'Satellite page');
define('SOAP_PAGE_TITLE', 'Soap configuration');

// 8897
define('PASSWORD_MUST_CONTAIN_LETTERS', 'Password must contain letters from a-zA-Z');
define('PASSWORD_MUST_CONTAIN_LETTERS_WITH_DIFF_CASE', 'Password must contain upper and lower case letters');
define('PASSWORD_MUST_CONTAIN_NUMBER', 'Password must contain a number from 0 to 9');
define('PASSWORD_NOT_HAVE_LOGIN_INSIDE', 'Password must not contain the username information');

//url query string
define('URL_QUERY_STRING_WARNING', 'Trying access with special query string: ');

define('DO_YOU_WANT_TO_SAVE_CONTENT', 'Do you want to save content?');

//OBJECTS
define('OBJECT_UNIQUE_NAME_EXISTS_ERROR', 'Such object unique name already exists');

//tpl_file
define('TPL_FILE_CANT_DELETE', 'Can\'t delete\, because it used by some pages');

//formbuilder
define('FORMBUILDER_CONFIRM_PAGE_SELF', '&lt;self&gt;');

define('SELECT_BUTTON', 'Select');

define('ASSETS_EDIT', 'Edit');
define('ASSETS_DELETE', 'Delete');
define('ASSETS_VIEW_PAGE', 'View Page');
define('ASSETS_VIEW_MEDIA', 'View Media');
define('ASSETS_NO_PREVIEW', 'No Preview');

define('ASSETS_CACHABLE', 	'Cachable');
define('ASSETS_NOT_CACHABLE', 	'Not cachable');

define('ASSETS_PAGE_INDEXING_ENABLED', 'Page Indexing Enabled');
define('ASSETS_PAGE_INDEXING_DISABLED', 'Page Indexing Disabled');
?>