<?

include('../_core/ee/lib.php');
trigger_error('test');
var_dump(1/0);
var_dump($_SERVER['REMOTE_ADDR']);
