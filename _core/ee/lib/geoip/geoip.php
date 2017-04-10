<?php
	include("geoip.inc.php");

	function ee_get_country_by_ip()
	{
		$user_ip = (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR'];

		$gi = geoip_open(EE_PATH.'_core/'.EE_HTTP_VERSION_CORE_DIR.'lib/geoip/GeoIP.dat', GEOIP_STANDARD);

		$country_code = geoip_country_code_by_addr($gi, $user_ip/*"82.144.201.69"*/);

		geoip_close($gi);

		return $country_code;
	}

?>