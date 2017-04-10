<?
		global $pageTitle, $modul, $config_vars, $error;

		$pageTitle = str_to_title($modul.' configuration');
		$ar_langs = SQLField2Array(viewsql('SELECT language_code FROM v_language WHERE status=1', 0));

		$config_vars_temp = array();

		$temp_array_index=0;
		$multi_lang_fields_index_arr = array();
		foreach ($config_vars as $k=>$v)
		{
			if (empty($config_vars[$k]['type']))
			{
				$config_vars[$k]['type'] = 'text';
			}

			if (empty($config_vars[$k]['field_title']))
			{
				$config_vars[$k]['field_title'] = str_to_title($config_vars[$k]['field_name']);
			}

			$config_vars[$k]['readonly'] = '';

			//Prepare multi-language fields
			if(!isset($config_vars[$k]['for_all_languages']) || (isset($config_vars[$k]['for_all_languages']) && $config_vars[$k]['for_all_languages']!=true))
			{
				if (empty($_POST['refresh']))
        			{
					global $$config_vars[$k]['field_name'];
					$$config_vars[$k]['field_name'] = config_var($config_vars[$k]['field_name']);
				}
			}
			else
			{
				foreach($ar_langs as $lang_code)
				{
					$config_vars_temp[$temp_array_index]['field_name']	= $config_vars[$k]['field_name'].'__'.$lang_code;
					$config_vars_temp[$temp_array_index]['type']		= $config_vars[$k]['type'];
					$config_vars_temp[$temp_array_index]['field_title']	= $config_vars[$k]['field_title'].' ('.$lang_code.')';
					$config_vars_temp[$temp_array_index]['readonly']	= $config_vars[$k]['readonly'];

					if (empty($_POST['refresh']))
        				{
						$new_global_var_name = $config_vars_temp[$temp_array_index]['field_name'];
						global $$new_global_var_name;
						$$new_global_var_name = config_var($config_vars[$k]['field_name'], $lang_code);
					}
					$temp_array_index++;
				}
				$multi_lang_fields_index_arr[] = $k;
			}
		}

		$config_vars_new = array();
		//Clear old multi languages fields
		foreach($config_vars as $k=>$v)
		{
			if(!in_array($k, $multi_lang_fields_index_arr))
			{	
				$config_vars_new[] = $v;
			}
		}
		$config_vars = $config_vars_new;
		unset($config_vars_new);		

		//Adding new language-depending languages
		foreach($config_vars_temp as $new_fields_arr)
		{
			$config_vars[] = $new_fields_arr;
		}		

		//SAVING
		if (post('refresh'))
		{
			$reset = post('reset');

			foreach ($config_vars as $k=>$v)
			{
				// set default fields
				if ($reset)
				{
					if ($default_config_var = get_config_var('default_' . $v['field_name']))
					{
						$_POST[$v['field_name']] = $default_config_var;
					}
				}
				//Check alias rule for all needed parts
				if (	$v['field_name'] == 'object_alias_rule' 
					&& 
					($check_alias = check_default_alias_mask($_POST[$v['field_name']],'object',false)) != ''
				)
				{
					$error[$v['field_name']] = $check_alias;
					break;
				}

				if (	$v['field_name'] == 'alias_rule' 
					&& 
					($check_alias = check_default_alias_mask($_POST[$v['field_name']],'page',false)) != ''
				)
				{
					$error[$v['field_name']] = $check_alias;
					break;
				}

				if ($v['type'] == 'integer')
				{
					if (	array_key_exists('min', $v) && 
						$_POST[$v['field_name']] < $v['min']
					)
					{
						$error[$v['field_name']] = 'Must be >= '.$v['min'];
						break;
					}

					if (	array_key_exists('max', $v) && 
						$_POST[$v['field_name']] > $v['max']
					)
					{
						$error[$v['field_name']] = 'Must be <= '.$v['max'];
						break;
					}

					if (!preg_match("/^[0-9]+$/", $_POST[$v['field_name']]))
					{
						$error[$v['field_name']] = 'Must be integer';
						break;
					}

				}

				// Saveing all fields
				if (preg_match("/^(.*)__([A-Z][A-Z])$/", $config_vars[$k]['field_name'], $regs))
 				{
					save_config_var($regs[1], $_POST[$config_vars[$k]['field_name']], $regs[2]);
				}
				else
				{
					save_config_var($config_vars[$k]['field_name'], $_POST[$config_vars[$k]['field_name']]);
				}
			}

			if ($reset)
			{
				header('Location:' . EE_ADMIN_URL . $modul . '.php');
			}
			else
			{
				if (count($error)==0)
				{
					close_popup('yes');
				}
			}
		}
//vdump($config_vars, '$config_vars');
//vdump($modul, '$modul');
		$return = parse_array_to_html($config_vars, 'templates/'.$modul.'/edit_modul_config_row');
		$return = str_replace('</body>',get_popup_header_script($pageTitle),$return);
		return $return;
