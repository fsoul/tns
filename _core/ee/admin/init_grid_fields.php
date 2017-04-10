<?
	if(empty($fields))
	{
		if (($op=='1') OR ($op=='3') OR ($op=='add_zip')) $table_postfix = '_edit';
		else $table_postfix = '_grid';
		$fields = db_sql_table_fields('v'.$modul.$table_postfix);
	}
?>
