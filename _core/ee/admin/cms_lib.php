<?
	function print_big_cms_field($val, $fck_instance_name='cms_val', $toolbar='Alloc')
	{
//vdump($val, 'print_big_cms_field($val)');
		global $lang, $type, $modul, $$fck_instance_name;

//msg($type, '$type');
		switch ($type)
		{
			case 'link':
				$link_info_arr = unserialize($val);
				global $link_type, $url_link, $satelit_link, $diff_urls_per_t_view;
                                $link_type    = (isset($link_info_arr['type']) ? $link_info_arr['type'] : '');
                                $url_link     = (isset($link_info_arr['link']) ? $link_info_arr['link'] : '');
                                $satelit_link = (isset($link_info_arr['sat']) ? $link_info_arr['sat'] : '');
				$diff_urls_per_t_view = (isset($link_info_arr['diff_urls_per_t_view']) ? $link_info_arr['diff_urls_per_t_view'] : '');
                                if (is_array($link_info_arr))
				{
					foreach($link_info_arr as $k=>$v)
					{
						if (substr($k, 0, 5) == 'type_'
							|| substr($k, 0, 5) == 'link_'
							|| substr($k, 0, 4) == 'sat_'
						)
						{
							global $$k;
							$$k = $v;
						}
					}
				}

			case 'text':
//				$$fck_instance_name = htmlspecialchars(strip_tags($val), ENT_QUOTES);
				$val = htmlspecialchars(strip_tags($val), ENT_QUOTES);

			case 'select':
			case 'select_survey':
			case 'select_gallery':
			case 'textarea':
			case 'link':
			case 'form':

				global $cms_field_instance_name;
				$cms_field_instance_name = $fck_instance_name;

				$$fck_instance_name = $val;
				$res = parse_tpl($modul.'/cms_field_'.$type);
				break;

			default:
				$$fck_instance_name = $val;
				$res = print_cms_field($fck_instance_name, '98%', '350', $toolbar);
		}
//vdump($res, 'print_big_cms_field $res');
		return $res;
	}

	function print_avail_languages()
	{
		global $lang, $t, $cms_name;
		$res = '';
		$tpl = '<a href="%s" style="padding:5px;%s"
				onclick="document.fd.nextlang.value=\'%s\';
				if (!confirm(\''.DO_YOU_WANT_TO_SAVE_CONTENT.'\'))
				{
					document.fd.save_content_cancel.value = \'true\';
				}
				document.fd.save.click()">%s</a>';
		$sql="SELECT language_code, status FROM v_language";
		$r = ViewSQL($sql, 0);
		while ($row=db_sql_fetch_assoc($r)) {
			$style='';
			if($row['status']==0) $style='color:#999;';
			if($row['language_code'] == $lang) $style='color:red;';
			$href = '#'; //'cms.php?cms_name='.$cms_name.'&admin_template=yes&t='.$t.'&lang='.$row['language_code'];
			$res .= sprintf($tpl, $href, $style, $row['language_code'], $row['language_code']);
		}
		return $res;
	}

	function field_name()
	{
		global $short_desc;

		return $short_desc;
	}

	function get_title_cms()
	{
		global $lang, $t, $cms_name;
		$res = '';
		if ($t>0)
		{
			$sql = 'SELECT page_name FROM v_tpl_page_content WHERE id='.sqlValue($t);
			list($p_name) = db_sql_fetch_array(ViewSQL($sql, 0));
			$res .= $p_name;
		}
		$res .= (trim(field_name())!='')?' - '.field_name():'';
		return $res;
	}


?>