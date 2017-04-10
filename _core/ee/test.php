<?
	include('lib.php');
	get_custom_or_core_file_name(EE_PATH.'test_exists.html');
	get_custom_or_core_file_name(EE_PATH.'test_absent.html');

	get_custom_or_core_file_name(EE_PATH.'test_custom_exists.html');
	get_custom_or_core_file_name(EE_PATH.'test_custom_and_core_exists.html');

?>