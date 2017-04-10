<?

include('_core/ee/lib.php');

$ar_params = array (
	'respondent_id_'	=> 294,
	'result_'		=> 0
);

$oci = ap_oci_init();

vdump($oci->sp('access_panel.access_package.activate_respondent', $ar_params, 1));
