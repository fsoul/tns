<?php
			global $__new_page_name;
			$__new_page_name = array();
			foreach ($__lang_list as $__lang)
			{
				$__field_name = 'page_name_' . $__lang;
				$__new_page_name[$__lang] = $_POST[$__field_name];
			}
			$field_values['page_name'] = '__new_page_name';
			if ($page_name_general == '')
			{
			 	if (isset($edit) && !empty($edit))
					$page_name_general = $edit;
				else
					$page_name_general = '__replace_after_insert__';
			}
			$__new_page_name['general'] = $page_name_general;
			if ($page_name_general != '' && $__new_page_name[$default_language] != '' && isset($error['page_name']))
				unset($error['page_name']);
			else
			{
				vdump($page_name_general, '$page_name_general');
				vdump($__new_page_name, '$__new_page_name');
				vdump($error,'$error');
				vdump($__new_page_name[$default_language], '$__new_page_name[$default_language]');
				vdump($default_language, '$default_language');
			}
?>