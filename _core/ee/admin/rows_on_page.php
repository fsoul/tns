<?
	function rows_on_page()
	{
		global $url;

		$var = 'rows_on_page_'.$_POST['modul'].'_';

		$var_id = $_SESSION['UserId'];

		save_cms($var.$var_id, $_POST['rows_on_page']);

		if (config_var('use_draft_content')==1)
		{
			publish_cms_on_page(0, $var, $var_id);
		}

		header($url);
	}

?>