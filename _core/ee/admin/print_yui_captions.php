<?php
		global $modul, $caption, $captions, $grid_col_style, $fields, $hidden, $align, $valign, $sort_disabled, $size_filter, $type_filter, $readonly, $ar_meta_fixed,
		$image_preview_field, $disable_delete, $default_sort_field, $default_sort_order, $custom_formatters;
		if (!is_array($hidden))
		{
			$hidden = array();
		}
		//��� ���������� � ������� �� ������ ������� ���� ����������� $click & $srt ��������� � $default_sort_field � $default_sort_order
		if (!isset($default_sort_field) || empty($default_sort_field))
		{
			$default_sort_field = isset($click) && array_key_exists(abs($click), $fields) ? $fields[abs($click)] : '';
		}
		if (!isset($default_sort_order) || empty($default_sort_order))
		{
			$default_sort_order = '';
			if (isset($click))
			{
				$default_sort_order = (isset($srt) && $srt < 0 && abs($srt) == $click) ? 'DESC' : 'ASC';
			}
		}
		//������� �������� ��������� �������� � ��������� ������
		for ($i=0; $i<count($fields); $i++)
		{
			if (in_array($fields[$i],$hidden))
			{
				continue;
			}
			$field_captions[$i]['caption'] = str_replace('&nbsp;',' ',$caption[$fields[$i]]);
			$field_captions[$i]['sorting'] = (is_array($sort_disabled) && in_array($fields[$i], $sort_disabled)) ? 'false' : 'true';
		}
		//��������� ������ ����� ������������ �������� ������� ��� yui (hidden ���� ����� ���������)
		$needle_array = array("\r\n",PHP_EOL,"\n");
		$replace_array = array('','','<br/>');
		for ($i=0; $i<count($fields); $i++)
		{
			if (in_array($fields[$i],$hidden))
			{
				continue;
			}
			if ($full == 'yes')
			{
				$filter_row[$i]['field_name'] = $fields[$i];
				$filter_row[$i]['field_size']	= $size_filter[$fields[$i]];
				$filter_row[$i]['type']	= $type_filter[$fields[$i]];
				$filter_row[$i]['readonly']	= (is_array($readonly) && in_array($fields[$i], $readonly));
				$filter_row[$i]['filter_align']  = 'left';//$align[$fields[$i]];
				$filter_row[$i]['filter_valign']  = $valign[$fields[$i]];
				$filter_row[$i]['field_num'] 	= $i+1;
				$is_field_fixed = '';
				if ($modul == '_seo' || $modul == '_object_seo')
				{
					$is_field_fixed = ', fixed:'.(in_array($fields[$i],$ar_meta_fixed) ? 'true' : 'false');
				}
				foreach ($filter_row[$i] as $key=>$v)
				{
					global $$key;
					$$key = $v;
				}
				$field_formatter = (is_array($custom_formatters) && array_key_exists($fields[$i],$custom_formatters) ? ', formatter:YAHOO.widget.DataTable.'.$custom_formatters[$fields[$i]] : '');
				$yui_fields_row[$i] = '{label:"'.str_replace($needle_array,$replace_array,addcslashes(parse_tpl($modul.'/list_filters_'.$type_filter[$fields[$i]]),'"')).'", children: [{key:"'.$fields[$i].'", label:"'.$field_captions[$i]['caption'].'", sortable:'.$field_captions[$i]['sorting'].$is_field_fixed.$field_formatter.'}]},';
			}
			else
			{
				$is_field_default_sort = ($fields[$i] == $default_sort_field) ? ', sortBy:true, sortDir:"'.(isset($default_sort_order) && $default_sort_order != '' ? strtolower($default_sort_order) : 'asc').'"' : '';
				$yui_fields_row[$i] = '{key:"'.$fields[$i].'"'.$is_field_default_sort.'},';
			}
		}
		//���� ������ _user - ��������� 2 �������: ������ � ������ � ������ ����������� �������
		if ($modul == '_user')
		{
			if ($full == 'yes')
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [
					{key:"folder_access", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatFolderAccess},
					{key:"modules_list", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatModulesList}
				]},';
			}
			else
			{
				$yui_fields_row[] = '{key:"folder_access"},';
				$yui_fields_row[] = '{key:"modules_list"},';
			}
		}
		//���� ������ _object_seo - ��������� �������: ���� �� ��������� ��������
		if ($modul == '_object_seo')
		{
			if ($full == 'yes')
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [
					{key:"obj_link", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatObjectLink}
				]},';
			}
			else
			{
				$yui_fields_row[] = '{key:"obj_link"},';
			}
		}
		//��������� ������� ��������
		//������� ������ ���������� ��� ������������ yui �������
		if ($full == 'yes')
		{
			if ($modul == '_tpl_folder')
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [
					{key:"folder_access", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatModulesList}
				]},';
			}
			if ($modul == '_dns')
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [
					{key:"dns_cdn_server", label:"", sortable:false, formatter:YAHOO.widget.DataTable.dnsCDNServer}
				]},';
			}
			//���� ������ _tpl_file - ��������� �������� ��������� ��������
			if ($modul == '_tpl_file')
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [{key:"tpl_preview", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatTplPreview}]},';
			}
			//���� ������ _gallery_image ��� _media - ��������� �������� ��������� ��������
			elseif ($modul == '_gallery_image' || $modul == '_media' || (isset($image_preview_field) && $image_preview_field != ''))
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [{key:"image_preview", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatImagePreview}]},';
			}
			//���� ������ _formbuilder - ��������� 3 ��������: ������� ����� � XML, ������� ����������� � csv � ����������� �����
			elseif ($modul == '_formbuilder')
			{
				$yui_fields_row[] = '{key:"add_th", label:"", children: [
					{key:"export_form", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatExportForm},
					{key:"export_form_data", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatExportFormData},
					{key:"copy_form", label:"", sortable:false, formatter:YAHOO.widget.DataTable.formatCopyForm}
				]},';
			}
			//��� ������ _alt_tags ��� ������� �������� - ������� ������ ������ ������� edit
			$editFormatter = '';
			if ($modul != '_alt_tags')
			{
				$editFormatter = ', formatter:YAHOO.widget.DataTable.';
			//��� ������ _seo ������ ������� edit �������� �� ������ ��������� seo
			//��� ������ _mailing - �� ������ ��������� ��������� ������
			//��� ���� ��������� ������� - ��������������
				$editFormatter .= ($modul == '_seo' ? 'formatSeoPreview' : ($modul == '_mailing' ? 'formatView' : 'formatEdit'));
			}
			//��������� �������� ���������� � ������� ���������� (��� ��������� ���������� - ��������������
			$yui_fields_row[] = '{key:"zoom_in", label:"<button type=\'submit\' title=\''.cons('Apply filter').'\'><img src=\"'.EE_HTTP.'img/icons_library/gif/24/zoom_in.gif\" alt=\''.cons('Apply filter').'\'></button>", children: [
				{key:"edit", label:"<button type=\'button\' title=\''.words(cons('Show_filter')).'\'><img alt=\''.words(cons('Show_filter')).'\' src=\''.EE_HTTP.'img/icons_library/gif/24/up.gif\'/></button><button type=\'button\' style=\'display: none\' title=\''.words(cons('Hide_filter')).'\'><img alt=\''.words(cons('Hide_filter')).'\' src=\''.EE_HTTP.'img/icons_library/gif/24/down.gif\'/></button>", sortable:false'.$editFormatter.'}
				]},
				{key:"zoom_out", label:"<button type=\'reset\' title=\''.words(cons('Show_all')).'\'><img src=\"'.EE_HTTP.'img/icons_library/gif/24/zoom_out.gif\" alt=\''.words(cons('Show_all')).'\'></button>", children: [';
			//�������� �������� - ��� ���� ������� ����� _seo, _object_seo, _mailing, _mail_inbox � _alt_tags
			if (check_if_delete_enabled($modul))
			{
				$yui_fields_row[] = '{key:"del", label:"<button type=\'button\' title=\''.DELETE_SEL_GRID_IMAGE_ALT.'\'><img alt=\''.DELETE_SEL_GRID_IMAGE_ALT.'\' src=\''.EE_HTTP.'img/icons_library/gif/24/stop.gif\'/></button>", sortable:false, formatter:YAHOO.widget.DataTable.formatDel}';
			}
			//��� ������ _object_seo ���� �������� ��������� seo
			elseif ($modul == '_object_seo')
			{
				$yui_fields_row[] = '{key:"seo_preview", label:"", formatter:YAHOO.widget.DataTable.formatSeoPreview}';
			}
			//��� ��������� ������� � ������� ��� �������� �������� - ������� ������ �������
			else
			{
				$yui_fields_row[] = '{key:"empty", label:""}';
			}
			$yui_fields_row[] = ']},';
			//��� ������� _seo, _object_seo, _error_page, _mail_inbox, _alt_tags � _mailing ��� ��������� - �� ������� ��
			if (check_if_delete_enabled($modul))
			{
				$yui_fields_row[] = '{label:"", children: [';
				$yui_fields_row[] = '{key:"checkbox", label:"<input type=\"checkbox\" name=\"selected_rows_switcher\" title=\"'.cons('All rows check/uncheck').'\"/>", sortable:false, formatter:YAHOO.widget.DataTable.formatCheckbox}';
				$yui_fields_row[] = ']},';
			}
		}
		//������ ����� ������������ � ����� �� JSON ������
		else
		{
			if ($modul == '_gallery_image'  || $modul == '_media' || (isset($image_preview_field) && $image_preview_field != ''))
			{
				$yui_fields_row[] = '{key:"image_preview"},';
			}
			elseif ($modul == '_formbuilder')
			{
				$yui_fields_row[] = '{key:"export_form_data"},';
			}
			elseif ($modul == '_tpl_page')
			{
				$yui_fields_row[] = '{key:"edit"},';
			}
			elseif ($modul == '_dns')
			{
				$yui_fields_row[] = '{key:"dns_cdn_server"},';
			}
		//��� ������� _seo, _object_seo, _error_page � _mailing ��� ������������� ���������� ������ ��� �������� "�������" � "��������"
		//��� ��������� ��� ����� ��� ����������� disabled ��������� � �����
			if ($modul != '_seo' && $modul != '_error_page' && $modul != '_mailing' && $modul != '_object_seo' && $modul != '_alt_tags')
			{
				$yui_fields_row[] = '{key:"del"},';
				$yui_fields_row[] = '{key:"checkbox"},';
			}
			elseif (($modul == '_seo' || $modul == '_object_seo'))
			{
				$yui_fields_row[] = '{key:"'.($modul == '_seo' ? 'edit' : 'seo_preview').'"},';
			}
		}
		return implode("\n",$yui_fields_row);


?>