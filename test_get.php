<?php

//var_dump($_GET);//
$arr_ereg = array();
$arr_ereg2 = array();
$mask = '^(.*[^0-9])([0-9]+)$';
$var='POPUP_SUBMIT';//'page_name_119';

echo 'mask: '.$mask.' __ var: '.$var.'<br>';
var_dump(ereg('^(.*[^0-9])([0-9]+)$', $var,$arr_ereg));
echo '<hr>';
var_dump(preg_match('/'.'^(.*[^0-9])([0-9]+)$'.'/', $var,$arr_ereg2));

echo '<hr>';echo '<hr>';
var_dump($arr_ereg);
echo '<br>';
var_dump($arr_ereg2);