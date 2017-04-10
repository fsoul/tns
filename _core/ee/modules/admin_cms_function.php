<?

function img_btn($img, $show_img=1)
{
	return edit_image($img);
}

function print_edit_img_bt($img)
{
	global $UserRole;
	$s='';
	if(checkAdmin() and ($UserRole==ADMINISTRATOR or $UserRole==POWERUSER) and get('admin_template')=='yes' and !check_content_access(CA_READ_ONLY)) {
		if(strpos($img,'.')) $im=$img;
		else if(function_exists($img)) $im=trim($img());
		else $im='';
		if(preg_match('/^</',$im)) {
			$im=substr(strstr($im,'src='),5);
			$p=strpos($im,'"');
			$im=substr($im,0,$p);
		}
		$im=preg_replace("/^".EE_HTTP_SERVER."/i","",$im);
		$im=preg_replace("/^".EE_HTTP_PREFIX."/i","",$im);
		$im=preg_replace("/^".EE_IMG_PATH."/i","",$im);
//		$s='<table cellpadding="0" cellspacing="0" border="0"><tr><td>&nbsp;&nbsp;</td><td align="center" height="25">';
//		$s.='<a href="#" onclick="edit_img(\''.$im.'\');return false"><img src="img/cms_edit_img.gif" width="43" height="16" alt="Edit Image '.$im.'" border="0"/></a>';
		$s='<a href="#" onclick="edit_img(\''.$im.'\');return false"><img src="img/cms_edit_img.gif" style="width:43px; height:16px;" alt="'.ADMIN_EDIT_IMAGE.''.$im.'" title="'.ADMIN_EDIT_IMAGE.''.$im.'" border="0"/></a>';
//		$s.='</td><td>&nbsp;&nbsp;</td></tr></table>';
	}
	return $s;
}

/**
 * Set control-button for image or html-content.
 */
function edit_cms_by_type($var, $alt='') {
	global $UserRole;

	if ($alt=='') $alt=$var;
	$s='';
	if(checkAdmin() and ($UserRole==ADMINISTRATOR or $UserRole==POWERUSER) and get('admin_template')=='yes') {
		$s.='<a href="#" onclick="openTypeSelector(\''.$var.'\');return false">';
		$s.='<img src="img/cms_edit_by_type.gif" width="43" height="16" alt="'.ADMIN_EDIT_PAGE_CONTENT_BY_TYPE.''.($alt==''?'':' of '.$alt).'" title="'.ADMIN_EDIT_PAGE_CONTENT_BY_TYPE.''.($alt==''?'':' of '.$alt).'" border="0"/>';
		$s.='</a><br/>';
	}
	return $s;
}
function html_edit_page_cms($var, $alt='', $sp='') {
	return html_edit(edit_page_cms($var, $alt, $sp));
}
function html_edit_cms2($var, $alt='', $sp='') {
	return html_edit(edit_cms2($var, 0, $alt, $sp));
}

function html_edit_cms($var, $alt='', $sp='')
{
	return html_edit(edit_cms($var, 0, $alt, $sp));
}

function html_edit($s) {
	$s=str_replace('openEditor','openEditorHTML',$s);
	$s=str_replace ('cms_edit_bt.gif', 'cms_html_bt.gif', $s);
	return $s;
}

/**
 * Set control-button to indicate a news channel.
 */
function channel_chooser($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'select');
}

/**
 * Set control-button to indicate a survey.
 */
function survey_chooser($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'select_survey');
}

function gallery_chooser($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'select_gallery');
}

/**
 * Set control-button for selecting form build with formbuider. Page-independent.
 * Page independent.
 */
function edit_form($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'form');
}

/**
 * Set control-button for selecting form build with formbuider. Page-dependent.
 * Page dependent.
 */
function edit_page_form($var, $alt='')
{
	global $t;
	return print_edit_cms($var, $t, $alt, 'form');
}

function form($var)
{
	return create_formbuilder_form(cms($var));
}

function page_form($var)
{
	global $t;
	return create_formbuilder_form(cms($var, $t));
}

function e_form($var)
{
	return edit_form($var).' '.form($var);
}

function e_page_form($var)
{
	return edit_page_form($var).' '.page_form($var);
}

function form_e($var)
{
	return form($var).' '.edit_form($var);
}

function page_form_e($var)
{
	return page_form($var).' '.edit_page_form($var);
}

/**
 * Set control-button to indicate a link. Page-independent.
 * Page independent.
 */
function edit_link($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'link');
}

/**
 * Set control-button to indicate a link. Page-dependent.
 * Page dependent.
 */
function edit_page_link($var, $alt='')
{
	global $t;
	return print_edit_cms($var, $t, $alt, 'link');
}

/**
 * Set control-button to one text line.  Page-independent.
 */
function text_edit_cms($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'text');
}

/**
 * Set control-button to one text line. Page-dependent.
 */
function text_edit_page_cms($var, $alt='')
{
	global $t;
	return print_edit_cms($var, $t, $alt, 'text');
}

/**
 * Set control-button to edit a text (Call textarea-editor). Page-independent.
 */
function longtext_edit_cms($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'textarea');
}

/**
 * Set control-button to edit a text (Call textarea-editor). Page-dependent.
 */
function longtext_edit_page_cms($var, $alt='')
{
	global $t;
	return print_edit_cms($var, $t, $alt, 'textarea');
}

/**
 * Set control-button to edit html content (Call FCK-editor). Page-dependent.
 */
function edit_page_cms($var, $alt='', $sp='')
{
	global $t;
	return edit_cms2($var, $t, ($alt!=''?$alt:$var).' on '.$t, $sp);
}

function edit_cms2($var, $t=0, $alt='', $space='')
{
	$res = print_edit_cms($var, $t, $alt);
	$res = str_replace('<br/>', $space, $res);
	return $res;
}

/**
 * Set control-button to edit html content (Call FCK-editor). Page-independent.
 */
function edit_cms($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt);
}

function text_edit_cms_for_array($var, $t=0, $alt='')
{
	return print_edit_cms($var, $t, $alt, 'text');
}

function print_edit_cms_for_array($var, $t, $alt='', $type='', $image='cms_edit_bt_text_array', $use_languages_list = true)
{
	return print_edit_cms($var, $t, $alt, $type, $image, $use_languages_list);
}

function print_edit_cms($var, $t, $alt='', $type='', $image='', $use_languages_list = true)
{
	global $UserRole;

	$s = '';

	if (	check_admin_template() and
		(
			session('UserRole')==ADMINISTRATOR
			or
			session('UserRole')==POWERUSER
		)
		and !check_content_access(CA_READ_ONLY)
	)
	{
		if (!is_array($var))
		{
			$var = array($var);
		}

		if ($alt=='')
		{
			$alt = "\n".implode(', ', $var);
		}

		$img_alt_text = '"'.ADMIN_EDIT_PAGE_CONTENT.( $alt=='' ? '' : ' of '.$alt ).'"';

		$script_lang_selector_functions = '';
		$lang_selector_attributes = '';

		if ($use_languages_list)
		{
			$lang_selector = '';
			$lang_list_sql_res = viewsql('SELECT language_code, status FROM v_language', 0);

			while ($lang_list = db_sql_fetch_assoc($lang_list_sql_res))
			{
				$lang_item = $lang_list['language_code'];
				$script_lang_selector_functions .= "function openEditor_".implode('_', $var)."_".$t."_".$type."_".$lang_item."() {openEditor(".( 'Array(\''.implode('\', \'', $var).'\')' ).", '".$t."', '".$type."', '".$lang_item."');}\n";
				$lang_selector .= "<a href='#' style='color:#".($lang_list['status']? '000' : '888')."' onclick='openEditor_".implode('_', $var)."_".$t."_".$type."_".$lang_item."(); return false;'>[$lang_item]</a>&nbsp;";
			}

			$lang_selector = str_replace('\\', '\\\\', $lang_selector);
			$lang_selector = str_replace('\'', '\\\'', $lang_selector);

			$lang_selector_attributes = 'onmouseover="clearTimeout(tm1); ddrivetip(\''.$lang_selector.'\');" onmouseout="tm1 = setTimeout(\'hideddrivetip()\',500);"';
		}

		if ($image == '')
		{
			$image = 'cms_edit_bt'.( $type=='' ? '' : '_'.$type );
		}

		global $language;

		$s =
			'<script type="text/javascript">'
			.$script_lang_selector_functions.'
			</script>'.
			'<a
				href="#"
				onclick="openEditor(Array(\''.implode('\', \'', $var).'\'), \''.$t.'\', \''.$type.'\', \''.$language.'\', \''.( $use_languages_list ? 'yes' : 'no' ).'\');return false;"
				title="Edit Page Content'.($alt==''?'':' of '.$alt).'">'.
				'<img
					'.$lang_selector_attributes.'
					src="'.EE_HTTP.'img/'.$image.'.gif" width="43" height="16"
					alt='.$img_alt_text.' title='.$img_alt_text.' border="0"
				 />'.
			'</a><br/>';

	}

	return $s;
}


function print_edit_pdf_bt($pdf) {
	global $UserRole;

	$s='';
	if(checkAdmin() and ($UserRole==ADMINISTRATOR or $UserRole==POWERUSER) and get('admin_template')=='yes')
	{
		if(strpos($pdf,'.')) $im=$pdf;
		else if(function_exists($pdf)) $im=trim($pdf());
		else $im='';
		if(preg_match('/^</',$im)) {
			$im=substr(strstr($im,'href='),6);
			$p=strpos($im,'"');
			$im=substr($im,0,$p);
		}
		$im=preg_replace("/^".EE_HTTP_SERVER."/i","",$im);
		$im=preg_replace("/^".EE_HTTP_PREFIX."/i","",$im);
		$im=preg_replace("/^".EE_IMG_PATH."/i","",$im);
		$s='<table cellpadding="0" cellspacing="0" border="0"><tr><td>&nbsp;&nbsp;</td><td align="center" height="25">';
		$s.='<a href="#" onclick="edit_pdf(\''.$im.'\');return false"><img src="img/cms_edit_file.gif" width="43" height="16" alt="Edit Document '.$im.'" border="0"/></a>';
		$s.='</td><td>&nbsp;&nbsp;</td></tr></table>';
	}
	return $s;
}

function print_admin_js($display_menu = true, $admin_module = true)
{
	global $UserRole, $language, $alias_rule, $t, $menuType, $export_run;
	global $page_folder, $page_name;

	$s='';

	if (	($admin_module || check_admin_template()) &&
		($UserRole==ADMINISTRATOR || $UserRole==POWERUSER) &&
		$export_run != 1
	)
	{
		$s.='
<link rel="stylesheet" type="text/css" href="'.EE_HTTP.'lib/yui/build/container/assets/skins/sam/container.css" />
<link rel="stylesheet" type="text/css" href="'.EE_HTTP.'lib/yui/build/resize/assets/skins/sam/resize.css" />
<link rel="stylesheet" type="text/css" href="'.EE_HTTP.'css/yui_popup.css" />

<script type="text/javascript" src="'.EE_HTTP.'lib/yui/build/utilities/utilities.js"></script>
<script type="text/javascript" src="'.EE_HTTP.'lib/yui/build/container/container.js"></script>
<script type="text/javascript" src="'.EE_HTTP.'lib/yui/build/resize/resize.js"></script>

<script type="text/javascript" src="'.EE_HTTP.'js/popup.js"></script>
<script type="text/javascript" src="'.EE_HTTP.'index.php?admin_template=yes&t=admin_js&language='.$language.'"></script>
<script type="text/javascript">

var page_id;
var page_folder;
var page_name;
var page_dependent = 1;
page_id = \''.$t.'\';
page_folder = \''.$page_folder.'\';
if(page_folder != \'\') page_folder = page_folder + \'/\';
page_name = \''.$page_name.'\';

function set_alias(orig)
{
	return;
}

function media_insert(i_name, i_type)
{
	x=450;
	y=600;

	URL="'.EE_ADMIN_URL.'media_insert.php?t='.$t.'&language='.$language.'&i_name="+i_name+"&page_dependent="+page_dependent;
	openPopup(URL,x,y,true);
}
YAHOO.util.Event.addListener(window, "load", function () {YAHOO.util.Dom.addClass(document.body, "yui-skin-sam")});
</script>';
		// File-contents is got with help function "file_get_contents()" ( not "parse_tpl()" )
		// because parse_tpl() can include file from "admin/template" just if we on grids, or just from "/template" if we on frontend...
		// But next file must be included always

		$s .= file_get_contents(EE_CORE_PATH.EE_ADMIN_SECTION.'templates/popup_templates.tpl');

		if ($menuType != 'PLAIN' && $display_menu)
		{
			$s.= '
<script language="JavaScript" type="text/javascript">
DOM = (document.getElementById) ? 1 : 0;
NS4 = (document.layers) ? 1 : 0;
// We need to explicitly detect Konqueror
// because Konqueror 3 sets IE = 1 ... AAAAAAAAAARGHHH!!!
Konqueror = (navigator.userAgent.indexOf(\'Konqueror\') > -1) ? 1 : 0;
// We need to detect Konqueror 2.2 as it does not handle the window.onresize event
Konqueror22 = (navigator.userAgent.indexOf(\'Konqueror 2.2\') > -1 || navigator.userAgent.indexOf(\'Konqueror/2.2\') > -1) ? 1 : 0;
Konqueror30 =
	(
		navigator.userAgent.indexOf(\'Konqueror 3.0\') > -1
		|| navigator.userAgent.indexOf(\'Konqueror/3.0\') > -1
		|| navigator.userAgent.indexOf(\'Konqueror 3;\') > -1
		|| navigator.userAgent.indexOf(\'Konqueror/3;\') > -1
		|| navigator.userAgent.indexOf(\'Konqueror 3)\') > -1
		|| navigator.userAgent.indexOf(\'Konqueror/3)\') > -1
	)
	? 1 : 0;
Konqueror31 = (navigator.userAgent.indexOf(\'Konqueror 3.1\') > -1 || navigator.userAgent.indexOf(\'Konqueror/3.1\') > -1) ? 1 : 0;
// We need to detect Konqueror 3.2 and 3.3 as they are affected by the see-through effect only for 2 form elements
Konqueror32 = (navigator.userAgent.indexOf(\'Konqueror 3.2\') > -1 || navigator.userAgent.indexOf(\'Konqueror/3.2\') > -1) ? 1 : 0;
Konqueror33 = (navigator.userAgent.indexOf(\'Konqueror 3.3\') > -1 || navigator.userAgent.indexOf(\'Konqueror/3.3\') > -1) ? 1 : 0;
Opera = (navigator.userAgent.indexOf(\'Opera\') > -1) ? 1 : 0;
Opera5 = (navigator.userAgent.indexOf(\'Opera 5\') > -1 || navigator.userAgent.indexOf(\'Opera/5\') > -1) ? 1 : 0;
Opera6 = (navigator.userAgent.indexOf(\'Opera 6\') > -1 || navigator.userAgent.indexOf(\'Opera/6\') > -1) ? 1 : 0;
Opera56 = Opera5 || Opera6;
IE = (navigator.userAgent.indexOf(\'MSIE\') > -1) ? 1 : 0;
IE = IE && !Opera;
IE5 = IE && DOM;
IE4 = (document.all) ? 1 : 0;
IE4 = IE4 && IE && !DOM;
</script>
<script language="JavaScript" type="text/javascript" src="'.EE_HTTP.'lib/dynamic_menu/js/layersmenu-library.js"></script>
<script language="JavaScript" type="text/javascript" src="'.EE_HTTP.'lib/dynamic_menu/js/layersmenu.js"></script>';
		}
	}
	return $s;
}

function print_admin_head()
{
	if (get('admin_template') == 'yes')
	return '<div id="dhtmltooltip2" onMouseOver="clearTimeout(tm1)" onMouseOut="tm1=setTimeout(\'hideddrivetip()\',500)"></div><script type="text/javascript" language="JavaScript" src="'.EE_HTTP.'js/bar_js.js"></script><div id="whole_page_content">';
}

function print_admin_foot()
{
	if (get('admin_template') == 'yes')
	return '</div>';
}

function get_popup_header_script($pageTitle)
{
	return '<script>
	if (window.parent.YAHOO.example.PanelFormatting.panel)
	{
		window.parent.YAHOO.example.PanelFormatting.panel.setHeader(\''.$pageTitle.'\');
	}
</script>';
}

function parse_popup($tpl)
{
	global $pageTitle;

	$res = parse_tpl($tpl);

	if (isset($pageTitle))
	{
		$title = $pageTitle;
	}
	else
	{
		preg_match('|<title>(.*?)</title>|is',$res,$arr);
		$title=$arr[1];
	}
	preg_match('|<body[^<>]*>(.*?)</body>|is',$res,$arr);
	$body = $arr[1];
	$script = get_popup_header_script($title);
	if (strpos($body,'<div id="whole_page_content">') === false)
		$res = str_replace($body,$script.$body,$res);
	else
		$res = str_replace('<div id="whole_page_content">','<div id="whole_page_content">'.$script,$res);

	if (!empty($_GET['popup2']))
	{
		$res = str_replace('closePopup(','closePopup2(',$res);
	}

	return $res;
}

function get_js_safe_satelite_list($satelit_table_width2, $sat2=0)
{
	$return = get_satelite_list($satelit_table_width2, $sat2);
	$return = str_replace("\r\n", '', $return);//windows
	$return = str_replace("\n", '', $return);//unix
	$return = str_replace("\r", '', $return);//mac
	$return = str_replace("\t", '', $return);
	$return = str_replace("'", "\'", $return);
	return $return;
}

function get_satelite_list($satelit_table_width2, $sat2=0, $sufix="")
{
	global $satelit_table_width, $sat, $sat_sel_id_sufix;
	$sat_sel_id_sufix = $sufix;
	$satelit_table_width = $satelit_table_width2;
	$sat = $sat2;
	return parse_tpl(EE_CORE_PATH.'templates/satellite_list');
}

function get_formbuilder_forms_list($form=0)
{
	$sql = create_sql_view_by_name('formbuilder');
	$res = ViewSql($sql);
	$ret = '';

	while($row = db_sql_fetch_assoc($res))
	{
		$selected = '';
		if ($form == $row['record_id'])
			$selected = ' selected';
			$ret .= '<option value="'.$row['record_id'].'"'.$selected.'>'.$row['form_name'].'</option>';
	}
	return $ret;
}

function generate_view_version_url_fields()
{
	$sql = "SELECT view_name FROM tpl_views";
	return parse_sql_to_html($sql, 'cms/cms_fields_link_view_row');
}

