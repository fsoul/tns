<?
		if (ceil($tot/$MAX_ROWS_IN_ADMIN)<$page)
			$page=1;

		if ($MAX_ROWS_IN_ADMIN > 0 && empty($export))
			$sql.= ' limit '.(($page-1)*$MAX_ROWS_IN_ADMIN).','.$MAX_ROWS_IN_ADMIN;
		else
			$MAX_ROWS_IN_ADMIN = $tot;
?>