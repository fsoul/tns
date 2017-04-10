<?php
/**
 * Created by PhpStorm.
 * User: dandima
 * Date: 11.09.15
 * Time: 10:23
 */

error_reporting(E_ALL);
include_once('_core/ee/lib.php');
require_once(EE_PATH.'autoloader.php');

$dbRequest = initHttpReq();
echo $dbRequest->url;
echo '<br>';

//$res =  $dbRequest->dic_info_source_list();

$res =  $dbRequest->is_phone_exists(0731231212);

res($res, 'is_phone_exists');

/*
$res =  $dbRequest->dic_region_list();
res($res, 'dic_region_list');

/*
echo '<pre>';
var_dump($res);
echo '</pre>';

*/