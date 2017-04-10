<?

if (!(array_key_exists('topic_id', $_GET)))
{
	exit;
}

header('Content-type: charset=UTF-8');

include "config.php";
//define('DEBUG_MODE', 1);
//include_once "../_core/ee/lib.php";

$csv_output = '';
$list = array();
$list[] = array('subject', 'text', 'date');

$db_connect_id = mysql_connect($dbhost.':'.$dbport, $dbuser, $dbpasswd);
mysql_select_db($dbname, $db_connect_id);

mysql_query("SET NAMES 'utf8'", $db_connect_id);


$sql = '
SELECT topic_id, topic_title, forum_id
  FROM phpbb_topics
 WHERE topic_id = \''.mysql_escape_string($_GET['topic_id']).'\'
';

$res = mysql_query($sql);

if (1 == mysql_num_rows($res))
{
	$sql = '
        SELECT 
               post_subject,
               post_text,
               
               post_time
               

          FROM phpbb_posts
         WHERE topic_id = \''.mysql_escape_string($_GET['topic_id']).'\'

        ';

	$res = mysql_query($sql);
	while ($row = mysql_fetch_assoc($res))
	{
/*
		$post_id = $row['post_id'];
		$tijd = $row['post_time'];
		$bb = $row['bbcode_uid'];
		$tit = $row['post_subject'];
		$txt = $row['post_text'];
*/

//		$dat = date("Y-m-d H:i:s", $tijd);
//		$tit = str_replace(":$bb]", "]", $tit);
//$tit = str_replace("·", "", $tit); // was in my old postings the start

//		$txt = str_replace(":$bb]", "]", $txt);
		$row['post_time'] = date("Y-m-d H:i:s", $row['post_time']);
		$list[] = $row;//implode(',', $row);//"\"$tit\",\"$txt\",,,\"old\",\"old\",\"$dat\",,,,\n<br>";
	}
//var_dump($list);
//exit;

	$temp = tmpfile();

	foreach ($list as $line)
	{
	    fputcsv($temp, $line);
	}

	fseek($temp, 0);

	while (!feof($temp))
	{
		$csv_output.= fread($temp, 8192);
	}

	fclose($temp);

	header("Content-type: application/vnd.ms-excel");
	header("Content-disposition: attachment;");
	header("Content-disposition: filename=topic_".$_GET['topic_id'].".csv");
 
	print $csv_output;
}
 
