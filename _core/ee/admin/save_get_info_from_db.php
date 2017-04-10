<?php
		if (!is_array($error))
		{
			$error = array();
		}

		// начальная инициализация при редактировании
		$info = array();
		if (!empty($edit))
		{
			if (empty($sql))
			{
				$sql = 'select * from v'.$modul.'_edit where id='.sqlValue($edit);
			}

			$info=db_sql_fetch_assoc(viewsql($sql, 0));
		}

?>