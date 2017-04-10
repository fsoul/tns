<?php
/*
* Copyright 2004-2007 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL.
* http://www.2k-group.com
*/

/*
** Check if one record
**
*/
function function_check_if_one_map($id_map)
{
	if ($id_map==0) //если нет в базе идентификатора и менюшка одна
	{
		$sql = "SELECT var_id
			FROM content
			WHERE var like 'menu_structure_%' and var not like '%jpg%'
			and language = '' and val not like 'a:1:%' and val not like 'a:0%'
			ORDER BY var";

		$result = viewsql($sql);
		if(db_sql_num_rows($result)==1)
		{
			while ($row = db_sql_fetch_array($result, MYSQL_NUM))
			{
				$sitemap_id = $row[0];
			}
		}
	}
	else
	{
		$sitemap_id = $id_map;
	}
	return $sitemap_id;
}

/*
** Creats drop-down list
** $s - html output;
** $id - array of list menu
** $menu_identifier, $menu_text -id and text of menu
*/

function optionMenu()
{
	global $t;
	global $choosed;

        $id =  getListMap();

 	$sql =  "SELECT val
		 FROM content
		 WHERE var = 'sitemap_html_selected_menu' and page_id = '$t'";

        $select = getField($sql);

	foreach($id as $key=>$val)
	{
		if($val['menu_structure_'] == $select)
		{
			$id_sel = $val['menu_structure_'];
		}
		$arr[] = array('sitemap_html_name'=>'menu_structure_'.$val['menu_structure_'], 'id_map'=>$val['menu_structure_'], 'menu_items_count'=>count($id), 'sel'=>($val['menu_structure_'] == $select? $val['menu_structure_']:1));
	}

	$s = parse_array_to_html($arr,'sitemap_html_option');

	return $s;
}

/*
** Gets structures of available menus
** $show_list - array of row menus struture
** $parsed - parsed array of menu structure
*/

function getListMap($only_id = false)
{
	$sql = "SELECT var as option_text , var_id as option_value
		FROM content
		WHERE var like 'menu_structure_%' and var not like '%jpg%'
		and val not like 'a:1:%' and val not like 'a:0%'
		ORDER BY var";

	$result = viewsql($sql);
	while ($row = db_sql_fetch_array($result, MYSQL_NUM))
	{
		if($only_id == true)
		{
			$show_list[] = $row[1];
		}
		else		
		{
			$show_list[] = array($row[0] => $row[1]);
		}
	}
	return $show_list;
}


/* Saves choosed map-list
** $id_i - id of choosed map-list
**
*/

function saveMap($id_i)
{
	global $t;
	if($id_i == 0) return;
	$sql =  "SELECT var
		FROM content
		WHERE var = 'sitemap_html_selected_menu' and page_id = '$t'";

        $res = getField($sql, 'var');

	if(strlen(trim($res))==0)
	{
		$sql =  "INSERT into content (page_id, var, val)
			values($t, 'sitemap_html_selected_menu', $id_i)";
	}
	else
	{
		$sql =  "UPDATE content set val = $id_i
			 WHERE var = 'sitemap_html_selected_menu' and page_id='$t'";
	}

        RunSQL($sql, 0);
}
/*
** Gets id of structure from DB
**
*/
function getMap()
{
	global $t;
 	$sql =  "SELECT val
		 FROM content
		 WHERE var = 'sitemap_html_selected_menu' and page_id='$t'";
        $res = getField($sql, 'val');

        if($res)
		return (int)  $res;
	else
		return 0;
}

function show_map($menu_id, $t, $level_id, $tpl_top, $tpl_bottom, $tpl_next_top, $tpl_next_bottom, $tpl_active, $submenus = array(), $tpl_subitem = '', $lang_for_label='', $lang_for_link='', $type = false)
{
	global $language;
	$lang_for_label = ($lang_for_label == '') ? $language : $lang_for_label;
	$lang_for_link  = ($lang_for_link  == '') ? $language : $lang_for_link;

	global $link, $label, $child_count, $menu_item_number, $item_level, $item_order, $code;
  	$ret_menu = "";
	if ($type == true )
	{
		$ret_menu .= parse('menu/map_separator', "", false);
	}
	$menu_labels  = new Menu(trim($menu_id), $lang_for_label, $t, $_GET['topmenu']);
	$level_labels = $menu_labels->get_menu($level_id);

	$menu_links = new Menu(trim($menu_id), $lang_for_link, $t, $_GET['topmenu']);
	$level_links = $menu_links->get_menu($level_id);

	foreach ($level_labels as $cur_item => $cur_level)
	{
		$label = $cur_level["label"];
		$code = $cur_level["code"];

		$link = $level_links[$cur_item]["link"];
		$child_count = $menu_links->child_count($cur_level['sat']);
		$menu_item_number = $cur_item;
		$item_order = $cur_level["order"];
		$separator = $cur_level["type"] == 'separator';

		$item_level = $level_id;

	 	if ((($label != '') and ($link != '') and ($label != ' ') and ($link != ' ')) || $separator == true)
		{
			$ret_menu .= $separator ? '' : parse($tpl_active, "", false);
			if ((!empty($submenus))//&&(strpos(",".implode(",", $submenus).",",",".$cur_item.",") !== false)
				  && !$cur_level["sat"] == '' || $separator == true)// || $cur_item == 1)
			{
				$ret_menu .= parse($tpl_next_top, "", false);
				$ret_menu .= show_map($menu_id, $cur_level["sat"], $level_id+1, $tpl_top, $tpl_bottom, $tpl_next_top, $tpl_next_bottom, $tpl_subitem, $submenus, $tpl_subitem, $lang_for_label, $lang_for_link, $separator);
				$ret_menu .= parse($tpl_next_bottom, "", false);
			}
		}
	}
	return $ret_menu;
}

/*
** Creates tree-map
**
*/
function site_map($menu_id, $tpl_top, $tpl_bottom, $tpl_next_top, $tpl_next_bottom, $tpl_active, $tpl_subitem, $lang_for_label='', $lang_for_link='')
{
	global $language;
	$lang_for_label = ($lang_for_label == '') ? $language : $lang_for_label;
	$lang_for_link  = ($lang_for_link  == '') ? $language : $lang_for_link;

	if($menu_id == -1)
	{
		$ar_menu_id = getListMap(1);
	}
	else
	{
		$ar_menu_id[] = $menu_id;
	}
	$sitemap_num_row = 0;
	foreach($ar_menu_id as $val)
	{

		$menu = new Menu(trim($val), $lang_for_label, $t, $_GET['topmenu']);
		$submenus = '';
		$submenus_cnt = 0;
		foreach ($menu->structure as $menu_item_tmp)
		{
			if (($menu_item_tmp["parent"] !== '')&&($menu_item_tmp["parent"] != 0)&&($menu_item_tmp["parent"] != 1))
			{
				if ((empty($submenus))or(strpos(",".implode(",", $submenus).",",",".$menu_item_tmp["parent"].",") === false))
				{
					$submenus[] = $menu_item_tmp["parent"];
					$submenus_cnt++;
				}
			}
		}
		$ret_menu .= parse($tpl_top, "", false);
		$ret_menu .= show_map($val, '', '1', $tpl_top, $tpl_bottom, $tpl_next_top, $tpl_next_bottom, $tpl_active, $submenus, $tpl_subitem, $lang_for_label, $lang_for_link);
		$ret_menu .= parse($tpl_bottom, "", false);
		$sitemap_num_row++;
	}
        return $ret_menu;
}
?>