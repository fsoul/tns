<?
	$result = logout();
//vdump($result, 'logout');
	header('Location: '.EE_ADMIN_URL);

?>
