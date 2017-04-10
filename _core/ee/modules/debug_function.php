<?php
/*
* Copyright 2004-2005 2K-Group. All rights reserved.
* 2K-GROUP PROPRIETARY/CONFIDENTIAL. 
* http://www.2k-group.com
*/

function msg ($val, $var = "value")
{

	if (DEBUG_MODE)
	{
		echo "<p><b>".$var."</b>: ".$val."</p>";
	}
}

function vdump ($val, $var = "var_dump")
{
	if (DEBUG_MODE)
	{
		echo '<br><b>'.$var.':</b><br><pre>';
		var_dump ($val);
		echo '</pre><br><br>';
	}
}

function vdump_e($val, $var = "var_dump")
{
	vdump($val, $var);
	exit;
}

function hdump ($val, $var = "var_dump")
{
	vdump (htmlentities($val), $var);
}

function htm ($htm)
{
	return htmlentities($htm);
}

