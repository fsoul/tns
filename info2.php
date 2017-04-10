<?
session_start();
if ($_SESSION['a']) {
	var_dump(123);
	} else {
	var_dump(222);
	}
$_SESSION['a'] = 123;
?>
