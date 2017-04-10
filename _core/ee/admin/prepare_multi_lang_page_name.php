<?php
	global $check_pattern;

	$__langs = ViewSQL('SELECT language_code FROM v_language',1);
	$__lang_list = array();
	$__page_name_list = array();
	while ($__cur_lang = db_sql_fetch_assoc($__langs))
	{
		$__lang_list[] = $__cur_lang['language_code'];
		$__page_name_list[] = 'page_name_' . $__cur_lang['language_code'];
	}                                 	
	$__page_name_list[] = 'page_name_general';

	global $page_name_general;
	if (!empty($edit))
	{
		if (!isset($page_name_general))
			 $page_name_general = $page_name;
		$rs = ViewSQL('SELECT page_name, language FROM v'.$modul.'_content WHERE id = ' . sqlValue($edit), 0);
		while ($row = db_sql_fetch_assoc($rs)) {
			$__field_name = 'page_name_' . $row['language'];
			global $$__field_name;
			if (!isset($$__field_name))
				$$__field_name = $row['page_name'];
		}

		foreach($__page_name_list as $val)
		{
			if (isset($check_pattern[$val]))
			{
				$__pattern[0] = $check_pattern[$val][0];
				$__pattern[1] = $check_pattern[$val][1];
			}
			else
			{
				$__pattern[0] = $check_pattern['page_name'][0];
				$__pattern[1] = $check_pattern['page_name'][1];
			}
			if (!preg_match('/'.$__pattern[0].'/', trim($_POST[$val])))
			{
//echo 'pattern: '.$__pattern[0].'   value:  '.trim($_POST[$val]).' = '.(!ereg($__pattern[0], trim($_POST[$val]))).'<br>';
				$error[$val]=($__pattern[0]!=''?$__pattern[1]:CHECK_PATTERN_ERROR);
			}
		} 

	}
?>
