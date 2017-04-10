<?
	$modul='cms';

	if (!isset($op))
	{
		$op = 0;
	}

	$reload = (isset($_GET['reload']))?trim($_GET['reload']):'yes';
//********************************************************************
	include_once('../lib.php');
//********************************************************************
	if (!CheckAdmin() or ($UserRole!=ADMINISTRATOR and $UserRole!=POWERUSER))
	{
		echo parse_tpl('norights');
		exit;
	}

	$baseHref='<BASE href="'.EE_HTTP.'">';

	$page_id = intval(is($t));

	if ($page_id>0)
	{
		// проверяем есть ли такая страница $page_id
		$row = getField('

                SELECT
                       count(*) AS c
                  FROM
                       tpl_pages
                 WHERE
                       id='.sqlValue($page_id)

		, 0, 0);

		if ($row['c']==0)
		{
			return '';
		}
	}

if (empty($close) and !empty($lang) and !empty($cms_name))
{
	if (array_key_exists('cms_value', $_POST) && !array_key_exists('cms_val', $_POST))
	{
		$_POST['cms_val'] = $_POST['cms_value'];
		unset($_POST['cms_value']);
	}
	
	if (array_key_exists('cms_val', $_POST) && !is_array($_POST['cms_val']))
	{
		$_POST['cms_val'] = array($_POST['cms_val']);
	}

	if (is_array($cms_name))
	{
		// use all text-type cms
		if (get('type')=='text')
		{
			$ar_cms_name = $cms_name;
		}
		// use only first element of any non text-type cms
		else
		{
			$ar_cms_name = array($cms_name[0]);
		}
	}
	else
	{
		$ar_cms_name = array($cms_name);
	}

	if (!empty($_POST['save']))
	{
		if ($_POST['save_content_cancel']!='true')
		{
			//Подготовка сохранения линка
			if (post('type') == 'link')
			{
				$link_info_arr['type'] = post('link_type');
				$link_info_arr['link'] = post('url_link');
				$link_info_arr['sat']  = post('satelit');
				$link_info_arr['diff_urls_per_t_view']  = post('diff_urls_per_t_view');
				foreach($_POST as $k=>$v)
				{
					if (substr($k, 0, 10) == 'link_type_')
					{
						$link_info_arr['type_'.substr($k, 10)] = $v;
					}
					if (substr($k, 0, 9) == 'url_link_')
					{
						$link_info_arr['link_'.substr($k, 9)] = $v;
					}
					if (substr($k, 0, 8) == 'satelit_')
					{
						$link_info_arr['sat_'.substr($k, 8)] = $v;
					}
				}
				$txt = serialize($link_info_arr);
			}
        
			$i = 0;
        
			$lang = trim($_POST['lang']);
        
			foreach ($ar_cms_name as $cms_name)
			{
				if (post('use_default_language') == 'on')
				{
					$txt = null;
				}
				else
				{
					if (post('type') != 'link')
					{
						$txt = $_POST['cms_val'][$i];
					}
        
					$txt = trim($txt);
					$txt = encd($txt);
        
					if (post('type') != 'html')
					{
						if (post('type') == 'text')
						{
							$txt = strip_tags($txt);
						}
						else
						{
							$txt = norm($txt);
						}
					}
				}
        
				$aFieldShortDesc = trim($_POST['aFieldShortDesc'][$i]);
				$aFieldFullDesc = trim($_POST['aFieldFullDesc'][$i]);

				save_cms($cms_name, $txt, $page_id, $lang, $aFieldShortDesc, $aFieldFullDesc);

				$i++;
			}
		}

		if ($_POST['nextlang'] == '')
		{
			header('Location: cms.php?close=true'.(!empty($_GET['popup2'])?'&popup2=true':'').'&reload='.$reload);
			exit;
		}
		else
		{
			$lang = $_POST['nextlang'];
		}
	}
	elseif (post('cms_selector'))
	{
		$cms_name = $_POST['cms_selector'];
	}

	$ar_sql = array();

	$sql_select = '

        SELECT
               page_id,
               var,
               var_id,
               '.val_field_name().',
               short_desc,
               full_desc,
               %s AS cms_name
        ';

	$sql_from_where = '

          FROM
               content
         WHERE
               language=%s
           AND page_id='.sqlValue($page_id).'
           AND var=%s
           AND var_id=%s
        ';

	$sql_format = $sql_select.$sql_from_where;

	foreach ($ar_cms_name as $cms_name)
	{
	       	list($var, $var_id) = get_var_id($cms_name);

		$sql = sprintf($sql_format, sqlValue($cms_name), sqlValue($lang), sqlValue($var), sqlValue($var_id));

		$ar_sql[] = $sql;

		$rs = viewsql($sql, 0);

		if (db_sql_num_rows($rs) < 1)
		{
			save_cms($cms_name, null, $page_id, $lang, $cms_name);
		}
	}

	$sql = implode(' UNION ', $ar_sql);

	$i = 0;
	$ar_res = array();

	$not_null_current_language_content_var_count = getField($sql_test = sprintf('SELECT COUNT(1) '.$sql_from_where.' AND val IS NOT NULL', sqlValue($lang), sqlValue($var), sqlValue($var_id)));

	require('cms_lib.php');

	$rs = viewsql($sql, 0);

	while ($r = db_sql_fetch_array($rs))
	{
		$txt = $r[val_field_name()];
		$toolbar = 'Alloc';

		$tmp = 'default_language_'.$cms_name.'_cms_value';
		$$tmp = getField(sprintf($sql_format, sqlValue($cms_name), sqlValue($default_language), sqlValue($var), sqlValue($var_id)), val_field_name());

		/*
		For default language field must be named as cms_val
		for all types except fck-field (type will be empty)
		-- Issue #11928 --
		*/
//		$ar_res[$i]['big_cms_field_for_default_language'] = print_big_cms_field($$tmp, 'cms_val'.($type == '' ? '_for_default_language' : ''));
		$ar_res[$i]['big_cms_field_for_default_language'] = print_big_cms_field($$tmp, 'cms_val_for_default_language');
		$ar_res[$i]['big_cms_field'] = print_big_cms_field($txt);

		$ar_res[$i]['short_desc'] = $r['short_desc'];
		$ar_res[$i]['full_desc'] = $r['full_desc'];
		$ar_res[$i]['cms_name'] = $r['cms_name'];

		$i++;
	}

	$list_rows = parse_array_to_html($ar_res, EE_CORE_PATH.EE_ADMIN_SECTION.'templates/'.$modul.'/list_row'.(count($ar_res)>1?'s':''));

	//********************************************************************
	echo parse_popup($modul.'/list');
} else {

?>

<script language="JavaScript">
	window.parent.closePopup<? if (!empty($_GET['popup2'])) echo '2'; ?>('<?php echo $reload; ?>');
</script>

<?}?>
