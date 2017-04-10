<?
		global $MAX_ROWS_IN_ADMIN, $click, $page, $srt, $b_color, $order, $UserRole, $UserId;
		global $modul;
		global $sort, $align;
		global $admin_template;
		global $ar_grid_links;
		global $fields;
		global $grid_col_style;
		global $ar_usl;
		global $hidden;
		global $object_where_clause, $filter_function;

		if (empty($sql))
			$sql = 'SELECT * from v'.$modul.'_grid';

		$ar_usl[] = 'page='.$page;
		$ar_usl[] = 'click='.$click;

		$ar_where = array();

		$ar_where[] = ' where 1=1';

		if($object_where_clause) $ar_where[] = $object_where_clause;

		$rows_on_page = (int)(cms('rows_on_page_'.$modul.'_'.$UserId));

		$MAX_ROWS_IN_ADMIN = empty($rows_on_page) ? config_var('MAX_ROWS_IN_ADMIN') : $rows_on_page;
?>