<?
include_once('menu_classes.php');

function print_front_avail_lang_bar($delimiter='&nbsp;-&nbsp;')
{
	global $UserRole;
	global $language, $t, $sid, $pid, $tid;

	$sql='select * from v_language';
	// only for administrators
	if (	!checkAdmin()
		or
		$UserRole!=ADMINISTRATOR and $UserRole!=POWERUSER
		or
		get('admin_template') !='yes'
	)
	{
		$sql.=' where status=1';
	}

	$sql.=' order by language_code desc';
	// prepare get
	$get = array();
	$get = $_GET;
	if(isset($get['language'])) unset($get['language']);
	if(isset($get['t'])) unset($get['t']);
	if(isset($get['t_name'])) unset($get['t_name']);
	foreach($get as $k=>$v) $get[$k] = $k.'='.urlencode($v);
	$get = implode('&', $get);

	$res = viewsql($sql,0);
	$menu = array();

	while($row = db_sql_fetch_assoc($res))
	{
		$href = EE_HTTP.((get('admin_template')=='yes')?('index.php?t='.$t.'&language='.$row['language_code'].(strlen($get)>1 ?'&'.$get:'')):(get_default_aliase_for_page($t,'',$row['language_code']).(strlen($get)>1 ?'?'.$get:'')));
		$lang_name = need_convert_from_utf() ? convert_from_utf($row['language_name'], $language) : $row['language_name'];
		$menu[] = '<span id="menu_lang"><a '.($language == $row['language_code'] ? 'class="active"' : '').' href="'.$href.'">'.$lang_name.'</a></span>'."\n";
	}
	return implode($delimiter, $menu);
}

function child_count($id, $level_id)
{
	global $count_child, $t, $language, $menu_id, $default_language;
        $menu = new Menu($menu_id, $language, $t);

	$label = cms('menu_'.$level_id.'_'.$v_id,'',$language);

	$label = strtolower($label);
	$label[0] = strtoupper($label[0]);

	if ($menu->child_count($id) == 0)
	{
		return $label;
	}
	else
	{
		return false;
	}
}

function menu_item_child_exists($menu_id, $sat = null)
{
	global $t,$language, $default_language;
        $menu = new Menu($menu_id, $language, $t);
	$v_id = $menu->id_by_sat($sat);

	if($menu->child_count($sat))
	{
		return true;	   
	}
	else
	{
		return false;
	}
}

/**
 * Function count_menu_items($id) counts menu items by menu id.
 */
function count_menu_items($id)
{
	global $language;
	$id = intval($id);
        $menu = new Menu($id, $language, $t);

	// count menu items
	$menu->db_variable_name="menu_structure_".$id;
	$menu->get_structure();
	$items_amount = count($menu->structure);

	// if the item just one, then need to check if it not empty (it will be in case if menu already exists but it is empty yet)
	if ($items_amount == 1)
	{
		$filling_items = getField('SELECT count(var) FROM content WHERE var LIKE "menu_'.$id.'_%" AND val!="" AND language='.sqlValue($language));
		if ($filling_items == 0)
		{
			$items_amount = 0;
		}
	}
	return $items_amount;
}

/**
 *  Most main function for organization a menu on a site.
 *  Support the 2-level sub-menu, separators, protected items, and many other.
 */
function get_menu_level($menu_id, $level_id, $tpl_active, $tpl_inactive, $tpl_delimiter='', $value_to_check=true, $add2link='', $topmenu='', $sat='', $tpl_separator='', $use_pictures=true)
{
	//res($menu_id);
	//if($menu_id != 300) return;
	global $language, $t;

	$active_menu = get_custom_or_core_file_contents(EE_PATH.$tpl_active);
	$inactive_menu = get_custom_or_core_file_contents(EE_PATH.$tpl_inactive);

	if (!empty($tpl_delimiter)){
		$delimiter = get_custom_or_core_file_contents(EE_PATH.$tpl_delimiter);
	}

	if (!empty($tpl_separator)){
		$separator = get_custom_or_core_file_contents(EE_PATH.$tpl_separator);
	}

	$menu = new Menu($menu_id, $language, $t, get('topmenu'), $sat, $value_to_check);

	$cur_parent = $menu->get_menu_parent($level_id);

	if (!empty($cur_parent) && $menu->structure[$cur_parent]['sat'] == $topmenu)
	{
		$topmenu=$t;
	}

	$menu = new Menu($menu_id, $language, ($topmenu)?($topmenu):$t, get('topmenu'), $sat);
	// If there are no menu items - add default one
	if (get('admin_template')=='yes' and count($menu->structure)==0){
		add_menu_default($menu_id, $menu->get_menu_parent($level_id));
		$menu = new Menu($menu_id, $language, ($topmenu)?($topmenu):$t, get('topmenu'), $sat);
	}

	$level = $menu->get_menu($level_id);
	$active_childs = !$menu->is_empty_level($level_id+1);
	$ret_menu = '';
	$first = true;

	$add_menu = '';

	if (get('admin_template')=='yes' && count($level) == 0){
		$level[0] = array(
			'code'		=>'',
			'title'		=>'',
			'label'		=>'',
			'link'		=>'',
			'sat'		=>'',
			'parent'	=>'',
			'open_type'	=>'',
			'active'	=>'',
			'shadow'	=>'',
			'page_name'	=>'',
		);
	}

	if (isset($menu->path[$level_id])){
		$add_menu=add_menu($menu_id, $menu->get_menu_parent($level_id));
	}
	//res($level);
	foreach ($level as $id=>$j){
		//$menu_id
		//res($level);
		if ($add2link!='' and $j['sat']!='')
		{
			$j['link'] = $j['link'].'&'.$add2link;
		}
		// если пункт меню пустой

		if (strlen(trim($j['label']))==0){
			// если админка -
			if (CheckAdmin() && get('admin_template')=='yes'){
				//  рисуем чего-нибудь
				if ($j['type'] == 'separator'){
					$j['label'] = '&lt;separator&gt;';
				}
				else {
					$j['label'] = '&lt;enter menu name&gt;';
				}
			}
			else {	// иначе ничего не рисуем
				if ($j['type'] == 'separator'){
					$j['label'] = '&nbsp;';
				}
				else{
					continue;
				}
			}
		}

		if ($j['shadow'] == VISIBLE_FOR_ALL){ // item is visible for all users types
			// do nothing
		}

		// $value_to_check - in real is front-end authorization status
		//
		// If item is visible for some special users type,
		// but current user type is another -
		elseif ($j['shadow'] == VISIBLE_FOR_BACKOFFICE &&	// item is visible for backoffice users
			get('admin_template')!='yes' 			// but it is not the backoffice now
			||
			$j['shadow'] == VISIBLE_FOR_NOT_AUTHORIZED &&
			$value_to_check==true
			||
			$j['shadow'] == VISIBLE_FOR_AUTHORIZED &&
			$value_to_check==false
		){  continue; }// skip it!


		if (!empty($delimiter)){
			if (!$first){
				$ret_menu.= $delimiter;
			}
		}

		if ($j['type'] == 'separator'){
			$ret_menu1 = $separator;
		}
	   	elseif ($j['active']){
			global $menu_item_label;
			global $ar_menu_item_code, $menu_item_code;

			$menu_item_label = $j['label'];
			$ar_menu_item_code[$menu_id] = $menu_item_code = $j['code'];
   			$ret_menu1 = $active_menu;
	   	}
		else{
			$ret_menu1 = $inactive_menu;
	   	}

	   	if (!empty($j['sat'])){
			$sql = '	page_name
			   	FROM v_tpl_page
			  	WHERE id = \''.$j['sat'].'\'
			';

			$j['page_name'] = getsql($sql,0);
	   	}

		$ret_menu1 = str_replace('<%:','<%getValueOf:',$ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:sat%>', empty($j['sat'])?'':$j['sat'], $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:page_name%>', empty($j['page_name'])?'':$j['page_name'], $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:link%>', $j['link'], $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:open%>', $j['open_type'], $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:label_only%>', $j['label'], $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:code%>', $j['code'], $ret_menu1);

		//Transmission XITI-attributes into item template
		if (EE_LINK_XITI_ENABLE)
		{
			$ret_menu1 = str_replace('<%getValueOf:xitiClickType%>',	isset($j['xitiClickType'])	?$j['xitiClickType']:'',	$ret_menu1);
			$ret_menu1 = str_replace('<%getValueOf:xitiS2%>',		isset($j['xitiS2'])		?$j['xitiS2']:'',		$ret_menu1);
			$ret_menu1 = str_replace('<%getValueOf:xitiLabel%>',		isset($j['xitiLabel'])		?$j['xitiLabel']:'',		$ret_menu1);
		}

		if (checkAdmin() and get('admin_template')=='yes')
		{
			$ret_menu1 = str_replace('<%getValueOf:label%>', '<span onmouseover="clearTimeout(tm1); ddrivetip(\''.cut(js_clear($j['label']),10).'<br/><%getValueOf:tooltip_buttons%>\')" onmouseout="tm1 = setTimeout(\'hideddrivetip()\',500);"><%getValueOf:label%></span>', $ret_menu1);
		}

		if ($use_pictures)
		{
			$picture_active = cms('menu_'.$menu_id.'_picture_active_'.$id);
			$picture_inactive = cms('menu_'.$menu_id.'_picture_inactive_'.$id);

			if ($picture_inactive)
			{
				if ($j['active'])
				{
					$j['label'] = '<img src="'.
					($picture_active?$picture_active:$picture_inactive)
					.'" border="0" alt="'.$j['label'].'"/>';
		   		}
				else
				{
					$j['label'] = '<img src="'.$picture_inactive.'" '
					.($picture_active?'onmouseover="this.src=\''.$picture_active.'\'" onmouseout="this.src=\''.$picture_inactive.'\'"':'')
					.' border="0" alt="'.$j['label'].'"/>';
		   		}
			}
		}

		$ret_menu1 = str_replace('<%getValueOf:this_menu_id%>', $menu_id, $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:menu_item_number%>', $id, $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:label%>', $j['label'], $ret_menu1);
		// menu title
		$ret_menu1 = str_replace('<%getValueOf:title%>', $j['title'], $ret_menu1);

		$ret_menu1 = str_replace('<%getValueOf:buttons%>', edit_menu($menu_id, $id).delete_menu($menu_id, $id), $ret_menu1);
		$ret_menu1 = str_replace('<%getValueOf:tooltip_buttons%>', str_replace('\'', '\\\'', str_replace('"', '\'', edit_menu($menu_id, $id).delete_menu($menu_id, $id, 'confirm_del_msg').$add_menu)), $ret_menu1);

		$open_class = ($active_childs || get('admin_template')=='yes') ? "open" : "on";
		$ret_menu1 = str_replace('<%getValueOf:open_class%>', $open_class, $ret_menu1);

		// menu_item_code - language independent text
		$ret_menu1 = str_replace('<%getValueOf:menu_item_code%>', $j['code'], $ret_menu1);

		$ret_menu1 = str_replace('<%getValueOf:is_menu_item_first%>', ((int)$first), $ret_menu1);

		if ($first)
		{
			$first = false;
		}

		$ret_menu1 = str_replace('<%getValueOf:is_menu_item_last%>', ((int)(($id)==count($level))), $ret_menu1);

		$ret_menu.= $ret_menu1;
	}

	$ret_menu = parse2($ret_menu);

	return $ret_menu;
}

function build_path($menu_id, $always_put_links = false)
{
	global $language, $t;

	$menu = new Menu($menu_id, $language, $t);
	$path = array();
	$active = $menu->active;
	end($active);

	do
	{	$k = key($active);

		if (array_key_exists($k, $menu->structure))
		{
			$path[$k] = $menu->structure[$k];
		}

		$path[$k]['label'] = cms("menu_".$menu_id."_".$k);

	} while(prev($active));

	reset($active);

	$i=1;

	foreach($path as $k=>$v)
	{
//		$path[$k] = ($i<count($path)?'<a href="?t='.$v['sat'].'&language='.$language.'">':'').htmlspecialchars($v['label']).($i<count($path)?'</a>':'');
		$path[$k] = (($i<count($path) or $always_put_links)?'<a href="'.EE_HTTP.
		(
			is_admin_template()?

			'?admin_template=yes&t='.$v['sat'].'&language='.$language.'&res=1'
			:
			get_default_aliase_for_page($v['sat'],'',$language)

		).'">':'').htmlspecialchars($v['label']).(($i<count($path) or $always_put_links)?'</a>':'');

		$i++;
	}
	unset($path[0]);
	return implode('&nbsp;/&nbsp;', $path);
}

function edit_menu($menu_id, $menu_item_id)
{
	global $UserRole;
	$menu_item_id = intval($menu_item_id);
	$menu_id = intval($menu_id);
	if($menu_item_id==0) return '';
	$s='';
	if(checkAdmin() and ($UserRole == ADMINISTRATOR or $UserRole == POWERUSER) and get('admin_template')=='yes')
		$s='<a href="#" onclick="editMenu('.$menu_id.','.$menu_item_id.');return false" class="a_image" style="display:inline;padding:0px; background-image:url();"><img src="img/edit/doc_edit.gif" alt="Edit menu" border="0" ></a>';
	return $s;
}

function add_menu($menu_id, $parent)
{
	global $UserRole;
	$parent  = intval($parent);
	$menu_id = intval($menu_id);
	$s='';
	if(checkAdmin() and ($UserRole == ADMINISTRATOR or $UserRole == POWERUSER) and get('admin_template')=='yes')
		$s='<a href="#" onclick="addMenu('.$menu_id.','.$parent.');return false" style="display:inline;;padding:0px; background-image:url();" class="a_image"><img src="img/edit/doc_add.gif" alt="Add menu" border="0" class="a_image"></a>&nbsp;';
	return $s;
}

function delete_menu($menu_id, $menu, $confirm_text = '\'Are you sure you want to delete ?\'')
{
	global $UserRole;
	if($menu==0) return '';
	$s='';
	if (checkAdmin() and ($UserRole == ADMINISTRATOR or $UserRole == POWERUSER) and get('admin_template')=='yes')
		$s='<a href="#" onclick="if(confirm('.$confirm_text.')) deleteMenu('.$menu_id.','.$menu.');return false" style="display:inline;padding:0px; background-image:url();" class="a_image"><img src="img/edit/doc_delete.gif" alt="Remove menu" border="0"></a>';
	return $s;
}

function add_menu_default ($menu_id, $parent)
{
	global $language;

	$mn = new Menu($menu_id, $language);

	$item = array();
	$item['label'] = ' ';
	$item['url'] = '';
	$item['sat'] = '';
	$item['open_type'] = '';
	$item['parent'] = $parent;
	$item['order'] = 0;
	$item['shadow'] = 0;

	$mn->add_new_menuitem($item);
}

/**
 * Check if is the menu level empty
 * @param int sat menu item link page
 */
function is_menu_level_empty($menu_id, $level_id, $sat = false)
{
	global $t, $language;
	$menu = new Menu($menu_id, $language, $sat != false?$sat:$t, $_GET['topmenu']);
	return $menu->is_empty_level($level_id);
}


function get_active_label($menu_id, $level_id)
{
	global $t, $language;
	$menu = new Menu($menu_id, $language, $t);
	return $menu->get_active_label($level_id);
}

function get_active_code($menu_id, $level_id)
{
	global $t, $language;
	$menu = new Menu($menu_id, $language, $t);
	return $menu->get_active_code($level_id);
}


