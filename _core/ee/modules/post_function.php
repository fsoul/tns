<?php

function post_error ($data, $port=80)
{
	return post_url (EE_HTTP.'index.php?t=errorpage'.($_GET['popup']?'&popup='.$_GET['popup']:''), $data, $port);
}

function post_url ($url, $data, $port=80)
{
	return post_host (EE_FSOCKOPEN_HOST, $url, $data, $port);
}

// post data to host and return reply
function post_host ($host, $url, $data, $port=80) {
	// INPUT VALIDATION: 
	if ($host=="" || $url=="" || !is_array($data) || sizeof($data)<1)
		return false; 

	$params='';
//Old version:	foreach ($data as $key=>$val)		$params.=$key.'='.urlencode($val).'&';
	foreach ($data as $key=>$val){
		if(is_array($val)){
			foreach ($val as $name=>$value){
				if (!is_array($value)) $params.=$key.'['.$name.']='.urlencode($value).'&';
			}
		}else{
			$params.=$key.'='.urlencode($val).'&';
		}
	}

	if ($params != '') $params=substr($params,0,-1);

	$sock = fsockopen($host, $port, $errno, $errstr, 30);
	if (!$sock) die("$errstr ($errno)\n");
	fputs($sock, "POST ".$url." HTTP/1.0\r\n");
	fputs($sock, "Host: ".$host."\r\n");
	if (isset($_COOKIE['core_ver_dir_path']))
	{
		fputs($sock, "Cookie: core_ver_dir_path=".$_COOKIE['core_ver_dir_path']."\r\n");
	}
	fputs($sock, "Content-type: application/x-www-form-urlencoded\r\n");
	fputs($sock, "Content-length: " . strlen($params) . "\r\n");
	fputs($sock, "Accept: */*\r\n");
	fputs($sock, "\r\n");
	fputs($sock, "$params\r\n");
	fputs($sock, "\r\n");
	$headers='';
	while($str=trim(fgets($sock, 4096))) $headers.="$str\n";
	$headers.="\n";
	$res='';
	while(!feof($sock)) $res.=fgets($sock, 4096);
	fclose($sock);
	return $res;
}

?>