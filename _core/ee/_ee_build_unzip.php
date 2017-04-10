<pre>
<?php

echo $_SERVER['REMOTE_ADDR'].'<br/>';

if ($_SERVER['REMOTE_ADDR'] != '82.144.201.69')
{
	echo 'Forbidden.<br/>';
	exit;
}

$path = getcwd();

$stop_file = $path.'/unzip_is_running.txt';

if (file_exists($stop_file))
{
	echo 'Unzip is running now.<br/>'.file_get_contents($stop_file);
	exit;
}
else
{
	$handler = fopen($stop_file, "w");
	fwrite($handler, 'Started at '.date("Y/m/d h:i:s")."\r\n");
	fclose($handler);

	if (unzip_arch($path.'/ee33_core.zip'))
	{
		echo 'Done';
	}

	unlink($stop_file);
}


function make_dirs_tree($list, $path)
{
	$list = str_replace('\\', '/', $list);
	$list = trim($list, '/');
	$ar_list = explode('/', $list);

	$prev_dir = '';//rtrim($path, '/');

	foreach ($ar_list as $dir)
	{
		$d = ltrim($prev_dir.'/'.$dir, '/');

		if (!is_dir($d))
		{
			mkdir($d);
		}

		chmod($d, 0777);

		$prev_dir.= '/'.$dir;
	}
}

function unzip_arch($arch_name, $path_to = null)
{
	if ($path_to == null)
	{
		$path_to = getcwd();
	}

	$arch_name = str_replace('\\', '/', $arch_name);
	$path_to = str_replace('\\', '/', $path_to);

	if ($path_to[strlen($path_to)-1] != '/')
	{
		$path_to.= '/';
	}

	if (	!file_exists($arch_name)
		||
		!is_file($arch_name)
		||
		!file_exists($path_to)
		||
		!is_dir($path_to)
	)
	{
		echo 'No archive or incorrect destination path.';
		return false;
	}

	echo '<b>$arch_name:</b> '.$arch_name.'<br/>';
	echo '<b>$path_to:</b>   '.$path_to.'<br/>';

	$zip = zip_open($arch_name);

	if ($zip)
	{
		while ($zip_entry = zip_read($zip))
		{
			$f_name = zip_entry_name($zip_entry);

			$dir_name = substr($f_name, 0, strrpos($f_name, '/'));

			make_dirs_tree($dir_name, $path_to);

			if (zip_entry_open($zip, $zip_entry, "r"))
			{
				$buf = zip_entry_read($zip_entry, zip_entry_filesize($zip_entry));

				$f = $path_to.$f_name;

				if (!is_dir($f))
				{
					$handle = fopen($f, "w");
					fwrite($handle, $buf);
					fclose($handle);

					chmod($f, 0777);

					zip_entry_close($zip_entry);
				}
			}
		}

		zip_close($zip);

		return true;
	}
	else
	{
		echo '<br/>Can\'t open zip-file.';

		return false;
	}
}

?>