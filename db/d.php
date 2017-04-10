<pre>
<?

include('../_core/ee/lib.php');

$email = 'sergep@2kgroup.com';
$email = 'pletsky@gmail.com';
$email = ( array_key_exists('email', $_GET) ? $_GET['email'] : $email );
var_dump($email);

$resp = ap_resp_init();
if ($resp->Check_If_Email_Exists($email))
{
	$info = $resp->Get_Info_By_Email($email);
	var_dump($info);
//	var_dump($resp->Delete($info['respondent_id_'], false));
}
else
{
	echo 'No such email in DB';
}

//var_dump(ap_points_used1(1));
//var_dump(ap_points_available1(1));
/*
function ap_points_used1($id)
{
	$oci = ap_oci_init();

	if (is_object($oci))
	{
		$sql = '
                SELECT NVL(SUM(access_panel.v_point_convertion.point_num),0) as points
                  FROM access_panel.v_point_convertion
                 WHERE access_panel.v_point_convertion.respondent_id='.($id).'
                ';
var_dump($sql);
		$res = $oci->get_query_as_('assoc', $sql);
	}
	else
	{
		$res = 0;
	}

	return $res;
}

function ap_points_available1($id)
{
	$oci = ap_oci_init();

	if (is_object($oci))
	{
		$sql = '
                SELECT NVL(SUM(access_panel.v_respondent_project.point_num),0) AS points
                  FROM access_panel.v_respondent_project
                 WHERE access_panel.v_respondent_project.respondent_id='.($id).'
                   AND is_complete=1
                ';
var_dump($sql);
		$res = $oci->get_query_as_('assoc', $sql);
	}
	else
	{
		$res = 0;
	}

	return $res;
}


*/