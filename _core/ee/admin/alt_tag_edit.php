<?
	if (count($_GET))
	{
		include_once('../lib.php');

		if (!CheckAdmin() or !($UserRole==ADMINISTRATOR or $UserRole==POWERUSER))
		{
			echo parse('norights');
			exit;
		}
		
		$picture_vars = media_manage_vars('media_'.$_GET['page_id']);

		$picture_vars['alts'][$_GET['language']] = $_GET['val'];
		
		$picture_vars = media_manage_vars('media_'.$_GET['page_id'], $picture_vars);
		
		global $default_language;

		save_cms('meta_'.($_GET['var']), $_GET['val'], $_GET['page_id'], $default_language);
	}
?>