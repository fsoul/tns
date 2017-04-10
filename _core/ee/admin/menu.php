<?	$admin=true;
	$UserRole=0;
//********************************************************************
	include('../lib.php');
//********************************************************************
	if(!CheckAdmin() or ($UserRole!=ADMINISTRATOR and $UserRole!=POWERUSER)) {header('Location: norights.html');exit;}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Menu</title>
	<link rel=stylesheet href="../css/admin_panel_style.css" type="text/css">
<script language="JavaScript">
var active='config';
var activ = new Array();
var passiv = new Array();

activ['lang']="<?=EE_HTTP?>img/menu/lang_a.gif";passiv['lang']="<?=EE_HTTP?>img/menu/lang_p.gif";
activ['config']="<?=EE_HTTP?>img/menu/config_a.gif";passiv['config']="<?=EE_HTTP?>img/menu/config_p.gif";
activ['cms']="<?=EE_HTTP?>img/menu/cms_a.gif";passiv['cms']="<?=EE_HTTP?>img/menu/cms_p.gif";
activ['tpl_file']="<?=EE_HTTP?>img/menu/tpl_a.gif";passiv['tpl_file']="<?=EE_HTTP?>img/menu/tpl_p.gif";
activ['tpl_page']="<?=EE_HTTP?>img/menu/tpl_sat_a.gif";passiv['tpl_page']="<?=EE_HTTP?>img/menu/tpl_sat_p.gif";
activ['tpl_folder']="<?=EE_HTTP?>img/menu/tpl_folder_a.gif";passiv['tpl_folder']="<?=EE_HTTP?>img/menu/tpl_folder_p.gif";
activ['dns']="<?=EE_HTTP?>img/menu/dns_a.gif";passiv['dns']="<?=EE_HTTP?>img/menu/dns_p.gif";
activ['user']="<?=EE_HTTP?>img/menu/user_a.gif";passiv['user']="<?=EE_HTTP?>img/menu/user_p.gif";
activ['gallery']="<?=EE_HTTP?>img/menu/picture_a.gif";passiv['gallery']="<?=EE_HTTP?>img/menu/picture_p.gif";
activ['files']="<?=EE_HTTP?>img/menu/files_a.gif";passiv['files']="<?=EE_HTTP?>img/menu/files_p.gif";
activ['media']="<?=EE_HTTP?>img/menu/media_a.gif";passiv['media']="<?=EE_HTTP?>img/menu/media_p.gif";
activ['poll']="<?=EE_HTTP?>img/menu/poll_a.gif";passiv['poll']="<?=EE_HTTP?>img/menu/poll_p.gif";
activ['search']="<?=EE_HTTP?>img/menu/search_a.gif";passiv['search']="<?=EE_HTTP?>img/menu/search_p.gif";
activ['support']="<?=EE_HTTP?>img/menu/support_a.gif";passiv['support']="<?=EE_HTTP?>img/menu/support_p.gif";
activ['news']="<?=EE_HTTP?>img/menu/events_a.gif";passiv['news']="<?=EE_HTTP?>img/menu/events_p.gif";
activ['seo']="<?=EE_HTTP?>img/menu/seo_a.gif";passiv['seo']="<?=EE_HTTP?>img/menu/seo_p.gif";
activ['mailing']="../img/menu/mailing_a.gif";passiv['mailing']="../img/menu/mailing_p.gif";
activ['mailing_tool']="../img/menu/news_letters_a.gif";passiv['mailing_tool']="../img/menu/news_letters_p.gif";

function imgOver(nm) {
	if(nm!=active) {
		document.images[nm].src=activ[nm];
	}
}
function imgOut(nm) {
	if(nm!=active) {
		document.images[nm].src=passiv[nm];
	}
}
function imgClick(nm) {
	if(active!=nm) {
		document.images[nm].src=activ[nm];
		document.images[active].src=passiv[active];
		active=nm;
	}
}
function ini() {
	i1 = new Image(); i1.src="<?=EE_HTTP?>/img/menu/config_a.gif";
	i2 = new Image(); i2.src="<?=EE_HTTP?>/img/menu/config_p.gif";
	i11 = new Image(); i11.src="<?=EE_HTTP?>/img/menu/cms_a.gif";
	i12 = new Image(); i12.src="<?=EE_HTTP?>/img/menu/cms_p.gif";
	i13 = new Image(); i13.src="<?=EE_HTTP?>/img/menu/lang_a.gif";
	i14 = new Image(); i14.src="<?=EE_HTTP?>/img/menu/lang_p.gif";
	i21 = new Image(); i21.src="<?=EE_HTTP?>/img/menu/dns_a.gif";
	i22 = new Image(); i22.src="<?=EE_HTTP?>/img/menu/dns_p.gif";
	i23 = new Image(); i23.src="<?=EE_HTTP?>/img/menu/tpl_a.gif";
	i24 = new Image(); i24.src="<?=EE_HTTP?>/img/menu/tpl_p.gif";
	i25 = new Image(); i25.src="<?=EE_HTTP?>/img/menu/tpl_sat_a.gif";
	i26 = new Image(); i26.src="<?=EE_HTTP?>/img/menu/tpl_sat_p.gif";
	i27 = new Image(); i27.src="<?=EE_HTTP?>/img/menu/picture_a.gif";
	i28 = new Image(); i28.src="<?=EE_HTTP?>/img/menu/picture_p.gif";
	i29 = new Image(); i29.src="<?=EE_HTTP?>/img/menu/folder_a.gif";
	i30 = new Image(); i30.src="<?=EE_HTTP?>/img/menu/folder_p.gif";
	i31 = new Image(); i31.src="<?=EE_HTTP?>/img/menu/user_a.gif";
	i32 = new Image(); i32.src="<?=EE_HTTP?>/img/menu/user_p.gif";
	i33 = new Image(); i33.src="<?=EE_HTTP?>img/menu/tpl_files_a.gif";
	i34 = new Image(); i34.src="<?=EE_HTTP?>img/menu/tpl_files_p.gif";
	i35 = new Image(); i35.src="<?=EE_HTTP?>img/menu/media_a.gif";
	i36 = new Image(); i36.src="<?=EE_HTTP?>img/menu/media_p.gif";
	i37 = new Image(); i35.src="<?=EE_HTTP?>img/menu/poll_a.gif";
	i38 = new Image(); i36.src="<?=EE_HTTP?>img/menu/poll_p.gif";
	i39 = new Image(); i39.src="<?=EE_HTTP?>img/menu/search_a.gif";
	i40 = new Image(); i40.src="<?=EE_HTTP?>img/menu/search_p.gif";
	i41 = new Image(); i41.src="<?=EE_HTTP?>img/menu/support_a.gif";
	i42 = new Image(); i42.src="<?=EE_HTTP?>img/menu/support_p.gif";
	i43 = new Image(); i43.src="<?=EE_HTTP?>img/menu/events_a.gif";
	i44 = new Image(); i44.src="<?=EE_HTTP?>img/menu/events_p.gif";
	i45 = new Image(); i45.src="<?=EE_HTTP?>img/menu/seo_a.gif";
	i46 = new Image(); i46.src="<?=EE_HTTP?>img/menu/seo_p.gif";
	imgClick(active);
}
</script>
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" bgcolor="#cccccc" background="<?=EE_HTTP?>img/menu/menu_bakground.gif" onload="ini()">
<img src="<?=EE_HTTP?>/img/inv.gif" width="1" height="2" alt="" /><br />
<table cellpadding="0" cellspacing="1" width="100%" border="0">
<?
if($UserRole==ADMINISTRATOR)
{
?>
	<tr>
		<td>&nbsp;</td>
		<td><b>Admin</b></td>
	</tr>

	<tr>
		<td height="20"><a href="config.php" onmouseover="imgOver('config')" onmouseout="imgOut('config')" onclick="imgClick('config')" target="main"><img src="<?=EE_HTTP?>/img/menu/config_a.gif" name="config" alt="Configuration" border="0"></a></td>
		<td><a href="config.php" onmouseover="imgOver('config')" onmouseout="imgOut('config')" onclick="imgClick('config')" target="main" class="top_menu">Configuration</a></td>
	</tr>

	<tr>
		<td height="20"><a href="user.php" onmouseover="imgOver('user')" onmouseout="imgOut('user')" onclick="imgClick('user')" target="main"><img src="<?=EE_HTTP?>/img/menu/user_p.gif" name="user" alt="Users" border="0"></a></td>
		<td><a href="user.php" onmouseover="imgOver('user')" onmouseout="imgOut('user')" onclick="imgClick('user')" target="main" class="top_menu">Users</a></td>
	</tr>

	<tr>
		<td><a href="lang.php" onmouseover="imgOver('lang')" onmouseout="imgOut('lang')" onclick="imgClick('lang')" target="main"><img src="<?=EE_HTTP?>/img/menu/lang_p.gif" name="lang" alt="Language" border="0"></a></td>
		<td><a href="lang.php" onmouseover="imgOver('lang')" onmouseout="imgOut('lang')" onclick="imgClick('lang')" target="main" class="top_menu">Language</a></td>
	</tr>

	<tr>
		<td height="20"><a href="dns.php" onmouseover="imgOver('dns')" onmouseout="imgOut('dns')" onclick="imgClick('dns')" target="main"><img src="<?=EE_HTTP?>/img/menu/dns_p.gif" name="dns" alt="DNS" border="0"></a></td>
		<td><a href="dns.php" onmouseover="imgOver('dns')" onmouseout="imgOut('dns')" onclick="imgClick('dns')" target="main" class="top_menu">DNS</a></td>
	</tr>

	<tr>
		<td height="20"><a href="tpl_file.php" onmouseover="imgOver('tpl_file')" onmouseout="imgOut('tpl_file')" onclick="imgClick('tpl_file')" target="main"><img src="<?=EE_HTTP?>/img/menu/tpl_p.gif" name="tpl_file" alt="Templates" border="0"></a></td>
		<td><a href="tpl_file.php" onmouseover="imgOver('tpl_file')" onmouseout="imgOut('tpl_file')" onclick="imgClick('tpl_file')" target="main" class="top_menu">Templates</a></td>
	</tr>

	<tr>
		<td height="20"><a href="files.php" onmouseover="imgOver('files')" onmouseout="imgOut('files')" onclick="imgClick('files')" target="main"><img src="<?=EE_HTTP?>/img/menu/files_p.gif" name="files" width="24" height="24" alt="File manager" border="0"></a></td>
		<td><a href="files.php" onmouseover="imgOver('files')" onmouseout="imgOut('files')" onclick="imgClick('files')" target="main" class="top_menu">File manager</a></td>
	</tr>
	<tr>
		<td height="20"><a href="search_config.php" onmouseover="imgOver('search')" onmouseout="imgOut('search')" onclick="imgClick('search')" target="main"><img src="<?=EE_HTTP?>/img/menu/search_p.gif" name="search" width="24" height="24" alt="Search Configuration" border="0"></a></td>
		<td><a href="search_config.php" onmouseover="imgOver('search')" onmouseout="imgOut('search')" onclick="imgClick('search')" target="main" class="top_menu">Search</a></td>
	</tr>
	<tr><td height="20"><a href="news_letters.php" onmouseover="imgOver('mailing_tool')" onmouseout="imgOut('mailing_tool')" onclick="imgClick('mailing_tool')" target="main"><img src="../img/menu/news_letters_p.gif" name="mailing_tool" alt="Mailing Tool" border="0"></a></td>
                <td><a href="news_letters.php?admin_template=yes" onmouseover="imgOver('mailing_tool')" onmouseout="imgOut('mailing_tool')" onclick="imgClick('mailing_tool')" target="main" class="top_menu">Mailing&nbsp;Tool</a></td></tr>

	<tr><td height="20"><a href="mailing.php" onmouseover="imgOver('mailing')" onmouseout="imgOut('mailing')" onclick="imgClick('mailing')" target="main"><img src="../img/menu/mailing_p.gif" name="mailing" alt="Mailing Reports" border="0"></a></td>
                <td><a href="mailing.php" onmouseover="imgOver('mailing')" onmouseout="imgOut('mailing')" onclick="imgClick('Mailing Reports')" target="main" class="top_menu">Mailing Reports</a></td></tr>
		<tr><td height="20"><a href="seo.php" onmouseover="imgOver('seo')" onmouseout="imgOut('seo')" onclick="imgClick('seo')" target="main"><img src="<?=EE_HTTP?>img/menu/seo_p.gif" name="seo" alt="SEO" border="0"></a></td>
		<td><a href="seo.php" onmouseover="imgOver('seo')" onmouseout="imgOut('seo')" onclick="imgClick('seo')" target="main" class="top_menu">SEO</a></td></tr>

	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<?
}
?>
<?
if (	$UserRole==ADMINISTRATOR
	||
	$UserRole==POWERUSER	)
{
?>
	<tr>
		<td>&nbsp;</td>
		<td><b>Group CMS</b></td>
	</tr>

	<tr>
		<td height="20"><a href="../index.php?admin_template=yes" onmouseover="imgOver('cms')" onmouseout="imgOut('cms')" onclick="imgClick('cms')" target="main"><img src="<?=EE_HTTP?>/img/menu/cms_p.gif" name="cms" alt="CMS" border="0"></a></td>
		<td><a href="../index.php?admin_template=yes" onmouseover="imgOver('cms')" onmouseout="imgOut('cms')" onclick="imgClick('cms')" target="main" class="top_menu">CMS</a></td>
	</tr>

	<tr>
		<td height="20"><a href="tpl_page.php" onmouseover="imgOver('tpl_page')" onmouseout="imgOut('tpl_page')" onclick="imgClick('tpl_page')" target="main"><img src="<?=EE_HTTP?>/img/menu/tpl_sat_p.gif" name="tpl_page" alt="Satellite pages" border="0"></a></td>
		<td><a href="tpl_page.php" onmouseover="imgOver('tpl_page')" onmouseout="imgOut('tpl_page')" onclick="imgClick('tpl_page')" target="main" class="top_menu">Satellite pages</a></td>
	</tr>

	<tr>
		<td height="20"><a href="media.php" onmouseover="imgOver('media')" onmouseout="imgOut('media')" onclick="imgClick('media')" target="main"><img src="<?=EE_HTTP?>/img/menu/media_p.gif" name="media" alt="Media manager" border="0"></a></td>
		<td><a href="media.php" onmouseover="imgOver('media')" onmouseout="imgOut('media')" onclick="imgClick('media')" target="main" class="top_menu">Media manager</a></td>
	</tr>

	<tr>
		<td height="20"><a href="channel.php" onmouseover="imgOver('news')" onmouseout="imgOut('news')" onclick="imgClick('news')" target="main"><img src="<?=EE_HTTP?>/img/menu/events_p.gif" name="news" alt="News & Events" border="0"></a></td>
		<td><a href="channel.php" onmouseover="imgOver('news')" onmouseout="imgOut('news')" onclick="imgClick('news')" target="main" class="top_menu">News & Events</a></td>
	</tr>

	<tr>
		<td height="20"><a href="poll.php" onmouseover="imgOver('poll')" onmouseout="imgOut('poll')" onclick="imgClick('poll')" target="main"><img src="<?=EE_HTTP?>/img/menu/poll_p.gif" name="poll" alt="Polls" border="0"></a></td>
		<td><a href="poll.php" onmouseover="imgOver('poll')" onmouseout="imgOut('poll')" onclick="imgClick('poll')" target="main" class="top_menu">Polls</a></td>
	</tr>

	<tr>
		<td height="20"><a href="tpl_folder.php" onmouseover="imgOver('tpl_folder')" onmouseout="imgOut('tpl_folder')" onclick="imgClick('tpl_folder')" target="main"><img src="<?=EE_HTTP?>/img/menu/tpl_folder_p.gif" name="tpl_folder" alt="Page folders" border="0"></a></td>
		<td><a href="tpl_folder.php" onmouseover="imgOver('tpl_folder')" onmouseout="imgOut('tpl_folder')" onclick="imgClick('tpl_folder')" target="main" class="top_menu">Page folders</a></td>
	</tr>

	<tr>
		<td height="20"><a href="gallery.php" onmouseover="imgOver('gallery')" onmouseout="imgOut('gallery')" onclick="imgClick('gallery')" target="main"><img src="<?=EE_HTTP?>/img/menu/picture_p.gif" name="gallery" alt="Gallery" border="0"></a></td>
		<td><a href="gallery.php?modul=gallery&admin_template=yes" onmouseover="imgOver('gallery')" onmouseout="imgOut('gallery')" onclick="imgClick('gallery')" target="main" class="top_menu">Gallery</a></td>
	</tr>
	<tr>
		<td height="40"><a href="support.php" onmouseover="imgOver('support')" onmouseout="imgOut('support')" onclick="imgClick('support')" target="main"><img src="<?=EE_HTTP?>/img/menu/support_p.gif" name="support" width="24" height="24" alt="Support" border="0"></a></td>
		<td><a href="support.php" onmouseover="imgOver('support')" onmouseout="imgOut('support')" onclick="imgClick('support')" target="main" class="top_menu">Support</a></td>
	</tr>
<?
}
?>
	<tr>
		<td height="40"><a href="top.php?logout=yes" target="_top"><img src="<?=EE_HTTP?>/img/logout.gif" alt="Logout" border="0" ></a></td>
		<td><a href="top.php?logout=yes" target="_top" class="top_menu">Logout</a></td>
	</tr>
</table>
</body>
</html>
