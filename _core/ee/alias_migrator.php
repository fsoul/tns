<?php

	include('lib.php');

	$r = viewSQL('SELECT * FROM aliase');
	while($row = db_sql_fetch_array($r))
	{
		$source_url = $row['alias'];
		$target_url = $row['original'];

		if(preg_match_all("/\?t=([a-z0-9\._]{1,})+(&language=([A-Z]{2}))?$/i", $target_url, $matches))
		{
			$t = $matches[1][0];
			if(!is_int($t))
			{
				$page_id = getField('SELECT id FROM tpl_pages WHERE page_name="'.$t.'"');
			}
			else if($page_id == getField('SELECT * FROM tpl_pages WHERE id="'.$t.'"'))
			{
				$page_id = $t;
			}
			else
			{
				$page_id = '';
			}

			$language = (empty($matches[3][0]) ? $default_language : $matches[3][0]);

			if(db_sql_num_rows(viewSQL('SELECT * FROM permanent_redirect WHERE source_url="'.$source_url.'"')) == 0)
			{
				if(empty($page_id))
				{
					runSQL('INSERT INTO permanent_redirect SET source_url="'.$source_url.'", target_url="'.$target_url.'"');
				}
				else
				{
					runSQL('INSERT INTO permanent_redirect SET source_url="'.$source_url.'", target_url="'.$target_url.'", page_id="'.$page_id.'", lang_code="'.$language.'"');
				}
			}
		}
	}

?>