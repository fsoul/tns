<?php

/**
 * Класс для работы с меню.
 *
 *
 */

class Menu
{
	var $lang = '';
	var $t = '';
	var $cur_id = 0;
	var $structure = array();

	var $path = array();
	var $active = array();
	var $db_variable_name = '';
	var $instance_id = 0;
	var $sat = '';

	function Menu($id, $lang, $t='', $prev_t=array(), $sat='')
	{
		$this->lang = $lang;
		$this->t = $t;
		$this->prev_t = is_array($prev_t) ? $prev_t : array();
		$this->instance_id = $id;
		$this->db_variable_name='menu_structure_'.$this->instance_id;

		$this->get_structure();

		// узнаем id текущего елемента
		$this->cur_id = 0;

		foreach ($this->structure as $k=>$v)
		{
			if ($v['shadow'] == VISIBLE_FOR_ALL) // item is visible for all users types
			{
				// do nothing
			}

			// If item is visible for some special users type,
			// but current user type is another -
			elseif ($v['shadow'] == VISIBLE_FOR_BACKOFFICE &&	// item is visible for backoffice users
				get('admin_template')!='yes' 			// but it is not the backoffice now
				||
				$v['shadow'] == VISIBLE_FOR_NOT_AUTHORIZED &&
				checkFrontEndAdmin() == true
				||
				$v['shadow'] == VISIBLE_FOR_AUTHORIZED &&
				checkFrontEndAdmin() == false
			)
			{
				// skip it!
				continue;
			}

			if ($sat!='' && $v['sat'] == $sat)
			{
				$this->cur_id = $k;
                break;
			}
			elseif ((isset($v['sat']) && ($v['sat']==$this->t or in_array($v['sat'], $this->prev_t))))
			{
				$this->cur_id = $k;
			}

			//Setup active item if current page in list of pages on which menu should be selected
			if (isset($v['selected']) && in_array($this->t, $v['selected']))
			{
				$this->cur_id = $k;
			}
		}

		$path = $this->get_path($this->cur_id);

		if ($this->cur_id>0)
		{
			$path[] = 0;
		}

		$n = sizeof($path);

		foreach ($path as $k=>$v)
		{
			$this->path[$n] = $v;
			$n--;
		}
	}

	function get_structure()
	{
		$res = cms($this->db_variable_name, 0,'' , 1, 0);

		if (!empty($res))
		{
			$structure = unserialize($res);
		}
		else
		{
			save_cms($this->db_variable_name, serialize(array()), 0, '', '');
			$structure = array();
		}

		if (!is_array($structure))
		{
			$this->structure = array();
		}
		else
		{
			$this->structure = $structure;
		}
	}

	function is_active($item)
	{
		return isset($this->active[$item]);
	}

	function get_path($id, $path=array())
	{
		$path[] = $id;
		$this->active[$id] = 1;

		if (isset($this->structure[$id]) && $this->structure[$id]['parent']>0)
		{
			$path = $this->get_path($this->structure[$id]['parent'], $path);
		}

		return $path;
	}

	function get_menu($level)	{
		$menu = array();

		if (isset($this->path[$level])){
			foreach ($this->structure as $k=>$v){
				if (	isset($v['parent']) && $v['parent']==$this->path[$level]){
					$v['label'] = $this->get_menu_label($k);
					$v['title'] = $this->get_menu_title($k);

					// If language-dependent-URL is not empty then get it, in another case - get default URL ($v['url']) 
					$lang_dependent_url = $this->get_menu_lang_dependent_url($k);
					$v['url'] = $lang_dependent_url!='' ? $lang_dependent_url : $v['url'];

					$v['link'] = $this->get_link($v);
					$v['open_type'] = ($v['open_type']=='_blank' ? 'target="'.$v['open_type'].'"' : '');
					$v['active'] = $this->is_active($k);

					// let code = menu item id by default
					if (!array_key_exists('code', $v)){
						$v['code'] = $k;
					}
					$menu[$k] = $v;
					//res($menu[$k]);
				}
			}

			$a = array();

			// make array sorting
			foreach ($menu as $k=>$v){
				$a[$k] = $v['order'];
			}

			asort($a);
			reset($a);
			$menu2 = array();

			foreach($a as $k=>$v){
				$menu2[$k] = $menu[$k];
			}
			$menu = $menu2;
		}

		return $menu;
	}


	function get_menu_parent($level)
	{
		if (isset($this->path[$level]))
		{
			return $this->path[$level];
		}
		else
		{
			return 0;
		}
	}


	function get_link($menuitem)
	{
		global $admin_template;

		if ($menuitem['url']!='')
		{
			return $menuitem['url'];
		}
		elseif ($menuitem['sat']!='')
		{
			return EE_HTTP.(is_admin_template() ? '?admin_template=yes&t='.$menuitem['sat'].'&language='.$this->lang.'&res=1' : get_default_aliase_for_page($menuitem['sat'], '', $this->lang));
		}
	}

	
	function get_menu_attribute($menuitem_id, $sfx='')
	{
		$menuitem_id = $this->prepare_menuitem_id($menuitem_id, $sfx);
		return cms($menuitem_id, '', $this->lang);
	}


	function get_menu_label($menuitem_id)
	{
		return $this->get_menu_attribute($menuitem_id);
	}

	
	function get_menu_title($menuitem_id)
	{
		return $this->get_menu_attribute($menuitem_id, 'title_');
	}


	function get_menu_lang_dependent_url($menuitem_id)
	{
		return $this->get_menu_attribute($menuitem_id, 'lang_dependent_url_');
	}


	function get_menu_code($menuitem_id)
	{
		return $this->get_menu_attribute($menuitem_id, 'code_');
	}


	function prepare_menuitem_id($menuitem_id, $sfx='')
	{
		return 'menu_'.$sfx.$this->instance_id.'_'.db_sql_escape_string($menuitem_id);
	}


	function attribute_to_db($value, $menuitem_id, $sfx='')
	{
		$menuitem_id = $this->prepare_menuitem_id($menuitem_id, $sfx);
		save_cms($menuitem_id, $value, 0, $this->lang);
	}


	function label_to_db($value, $menuitem_id)
	{
		$this->attribute_to_db($value, $menuitem_id);
	}


	function title_to_db($value, $menuitem_id)
	{
		$this->attribute_to_db($value, $menuitem_id, 'title_');
	}


	function lang_dependent_url_to_db($value, $menuitem_id)
	{
		$this->attribute_to_db($value, $menuitem_id, 'lang_dependent_url_');
	}

/*
	function code_to_db($value, $menuitem_id)
	{
		$this->attribute_to_db($value, $menuitem_id, 'code_');
	}
*/

	function add_new_menuitem($item)
	{
		// new element id
		$new_id = (count(array_keys($this->structure)) == 0 ? 1 : (@max(array_keys($this->structure)) + 1));
		// write label to content
		$this->label_to_db($item['label'], $new_id);
		// write title to content
		$this->title_to_db($item['title'], $new_id);
		// write code to content
//		$this->code_to_db($item['code'], $new_id);

		// write lang dependent url to content
		$this->lang_dependent_url_to_db($item['url'], $new_id);
		// If default language is the same with current language, then URL need to save as default URL (into $this->structure[$new_id]['url'])
		$this->structure[$new_id]['url'] = $item['url'];

		$this->structure[$new_id]['code'] = $item['code'];
		$this->structure[$new_id]['sat'] = $item['sat'];
		$this->structure[$new_id]['parent'] = $item['parent'];
		$this->structure[$new_id]['open_type'] = $item['open_type'];
		$this->structure[$new_id]['order'] = $item['order'];
		$this->structure[$new_id]['shadow'] = $item['shadow'];
		$this->structure[$new_id]['type'] = $item['type'];
		$this->structure[$new_id]['selected'] = $item['pages_list'];

		//XITI attributes adding
		$this->process_xiti_attributes($new_id, $item);

		//Save to CMS MENU_STRUCTURE with empty language (''), becouse MENU_STRUCTURE one for each languages
		save_cms($this->db_variable_name, serialize($this->structure), 0, '');

		return $new_id;
	}


	function delete_menuitem($item)
	{
		$item = intval($item);
		if($item==0) return false;

		$this->delete_menuitem_by_parent($item);

		unset($this->structure[$item]);

		//Save to CMS MENU_STRUCTURE with empty language (''), becouse MENU_STRUCTURE one for each languages
		save_cms($this->db_variable_name, serialize($this->structure), 0, '');
		save_cms("menu$k",'');
		return true;
	}


	function delete_menuitem_by_parent($parent)
	{
		foreach($this->structure as $k=>$v)
		{
			if($v['parent'] == $parent)
			{
				$this->delete_menuitem_by_parent($k);

				unset($this->structure[$k]);

				save_cms("menu$k",'');
				return;
			}
		}
	}


	function update_menuitem($item_id, $item)
	{
		// write label to db
		$this->label_to_db($item['label'], $item_id);
		// write title to content
		$this->title_to_db($item['title'], $item_id);
		// write code to db
//		$this->code_to_db($item['code'], $item_id);

		// write lang_dependent_url to content
		$this->lang_dependent_url_to_db($item['url'], $item_id);
		global $default_language;
		// If default language is the same with current language, then URL need to save as default URL (into $this->structure[$new_id]['url'])
		$this->structure[$item_id]['url'] = ($default_language == $this->lang || $item['url']=='' || $this->structure[$item_id]['url']=='') ? $item['url'] : $this->structure[$item_id]['url'];
		// if default URL (URL for default language) is empty, then we should to empty URLs for other languages
		if ($this->structure[$item_id]['url'] == '')
		{
			$menuitem_id = $this->prepare_menuitem_id($item_id, 'lang_dependent_url_');
			del_cms($menuitem_id);
		}

		$this->structure[$item_id]['code'] = $item['code'];
		$this->structure[$item_id]['sat'] = $item['sat'];
		$this->structure[$item_id]['open_type'] = $item['open_type'];
		$this->structure[$item_id]['order'] = $item['order'];
		$this->structure[$item_id]['shadow'] = $item['shadow'];
		$this->structure[$item_id]['type'] = $item['type'];
		$this->structure[$item_id]['selected'] = $item['pages_list'];

		//XITI attributes adding
		$this->process_xiti_attributes($item_id, $item);

		if ($this->structure[$item_id]['order']!=$item['order'])
		{
			$this->structure[$item_id]['order'] = $this->get_order($item['parent']);
		}

		//Save to CMS MENU_STRUCTURE with empty language (''), becouse MENU_STRUCTURE one for each languages

		save_cms($this->db_variable_name,serialize($this->structure), 0, '');
	}


	function get_one_menu($menu_id)
	{
		$ret = $this->structure[$menu_id];

		$ret['label'] = $this->get_menu_label($menu_id);

		$ret['title'] = $this->get_menu_title($menu_id);

		// If language-dependent-URL is not empty then get it, in another case - get default URL ($v['url']) 
		$lang_dependent_url = $this->get_menu_lang_dependent_url($menu_id);
		$ret['url'] = $lang_dependent_url!='' ? $lang_dependent_url : $ret['url'];

//		$ret['code'] = $this->get_menu_code($menu_id);

		return $ret;
	}


	function is_empty_level($level_id)
	{
		$level = $this->get_menu($level_id);
		$res = 1;

		foreach($level as $id=>$j)
		{
			if (strlen(trim($j['label']))!=0)
			{
				$res = 0;
				break;
			}
		}

		return $res;
	}


	function get_active_attribute($level, $attr)
	{
		  $res = '';
		  $level_items = $this->get_menu($level);

		  foreach($level_items as $item)
		  {
			if ($item['active'])
			{
				$res = $item[$attr];
				break;
			}
		  }

		  return $res;
	}


	function get_active_label($level)
	{
		  return $this->get_active_attribute($level, 'label');
	}


	function get_active_code($level)
	{
		  return $this->get_active_attribute($level, 'code');
	}


	function id_by_sat($id)
	{
 		$this->id = $id;
		$structure = array();
		$this->instance_id = 100;
		$this->db_variable_name="menu_structure_".$this->instance_id;

		$this->get_structure();

		foreach ($this->structure as $k=>$v)
		{
			if (($v['sat'] == $this->id) && ($v['parent'] == 0))
			{
				$v_id = $k;
			}
		}

		return $v_id;
	}


	function child_count($id)
	{
		global $count_child;

		$count_child = 0;

		$v_id = $this->id_by_sat($id);

		foreach($this->structure as $k=>$v)
		{
			if ($v['parent'] == $v_id)
			{
				$count_child++;
			}
		}

		return $count_child;
	}


	function process_xiti_attributes($item_id, $item)
	{
		if (EE_LINK_XITI_ENABLE)
		{
			$this->structure[$item_id]['xitiClickType']	= isset($item['xitiClickType'])	? $item['xitiClickType'] : '';
			$this->structure[$item_id]['xitiS2']		= isset($item['xitiS2'])	? $item['xitiS2'] : '';
			$this->structure[$item_id]['xitiLabel']		= isset($item['xitiLabel'])	? $item['xitiLabel'] : '';
		}

		return true;
	}
}

