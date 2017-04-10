<?php

/**
* @package PHPLayersMenu
*/

/**
* This is the "common" class of the PHP Layers Menu library.
*
* You need to include PEAR.php and DB.php if (and only if) you want to use the DB support provided by ths class.
*
* @version 3.2.0-rc
* @package PHPLayersMenu
*/
class LayersMenuCommon
{

/**
* The name of the package
* @access private
* @var string
*/
var $_packageName;
/**
* The version of the package
* @access private
* @var string
*/
var $version;
/**
* The copyright of the package
* @access private
* @var string
*/
var $copyright;
/**
* The author of the package
* @access private
* @var string
*/
var $author;

/**
* URL to be prepended to the menu hrefs
* @access private
* @var string
*/
var $prependedUrl = '';
/**
* Do you want that code execution halts on error?
* @access private
* @var string
*/
var $haltOnError = 'yes';

/**
* The base directory where the package is installed
* @access private
* @var string
*/
var $dirroot;
/**
* The "libjs" directory of the package
* @access private
* @var string
*/
var $libjsdir;
/**
* The directory where images related to the menu can be found
* @access private
* @var string
*/
var $imgdir;
/**
* The http path corresponding to imgdir
* @access private
* @var string
*/
var $imgwww;
/**
* The directory where icons of menu items can be found
* @access private
* @var string
*/
var $icondir;
/**
* The http path corresponding to icondir
* @access private
* @var string
*/
var $iconwww;
/**
* This array may contain width and height of all icons
* @access private
* @var integer
*/
var $iconsize = array();
/**
* If this var is false, width and height of icons have to be detected; if this var is true, width and height of icons are not detected and are retrieved from the iconsize array
* @access private
* @var boolean
*/
var $issetIconsize = false;
/**
* The directory where templates can be found
* @access private
* @var string
*/
var $tpldir;
/**
* The string containing the menu structure
* @access private
* @var string
*/
var $menuStructure;

/**
* It counts nodes for all menus
* @access private
* @var integer
*/
var $_nodesCount;
/**
* A multi-dimensional array to store informations for each menu entry
* @access private
* @var array
*/
var $tree;
/**
* A multi-dimensional array used only with the DB support; for each $menu_name, it stores the $cnt associated to each item id
*
* This array is needed for selection of the current item
* through the corresponding id (see the DB table structure)
* as, internally, items are stored, sorted and addressed in terms of $cnt
*
* @access private
* @var array
*/
var $treecnt;
/**
* The maximum hierarchical level of menu items
* @access private
* @var integer
*/
var $_maxLevel;
/**
* An array that counts the number of first level items for each menu
* @access private
* @var array
*/
var $_firstLevelCnt;
/**
* An array containing the number identifying the first item of each menu
* @access private
* @var array
*/
var $_firstItem;
/**
* An array containing the number identifying the last item of each menu
* @access private
* @var array
*/
var $_lastItem;

/**
* Data Source Name: the connection string for PEAR DB
* @access private
* @var string
*/
var $dsn = 'pgsql://dbuser:dbpass@dbhost/dbname';
/**
* DB connections are either persistent or not persistent
* @access private
* @var boolean
*/
var $persistent = false;
/**
* Name of the table storing data describing the menu
* @access private
* @var string
*/
var $tableName = 'phplayersmenu';
/**
* Name of the i18n table corresponding to $tableName
* @access private
* @var string
*/
var $tableName_i18n = 'phplayersmenu_i18n';
/**
* Names of fields of the table storing data describing the menu
*
* default field names correspond to the same field names foreseen
* by the menu structure format
*
* @access private
* @var array
*/
var $tableFields = array(
	'id'		=> 'id',
	'parent_id'	=> 'parent_id',
	'text'		=> 'text',
	'href'		=> 'href',
	'title'		=> 'title',
	'icon'		=> 'icon',
	'target'	=> 'target',
	'orderfield'	=> 'orderfield',
	'expanded'	=> 'expanded'
);
/**
* Names of fields of the i18n table corresponding to $tableName
* @access private
* @var array
*/
var $tableFields_i18n = array(
	'language'	=> 'language',
	'id'		=> 'id',
	'text'		=> 'text',
	'title'		=> 'title'
);
/**
* A temporary array to store data retrieved from the DB and to perform the depth-first search
* @access private
* @var array
*/
var $_tmpArray = array();

/**
* The constructor method; it initializates the menu system
* @return void
*/
function LayersMenuCommon()
{
	$this->_packageName = '';
	$this->version = '';
	$this->copyright = '';
	$this->author = '';

	$this->prependedUrl = '';

	$this->dirroot = EE_CORE_PATH;
	$this->libjsdir = EE_CORE_PATH.'lib/dynamic_menu/js/';
	$this->imgdir = EE_CORE_PATH.'img/menuimages/';
	$this->imgwww = EE_HTTP.'img/menuimages/';
	$this->icondir = EE_CORE_PATH.'img/menu/';
	$this->iconwww = EE_HTTP.'img/menu/';
	$this->tpldir = EE_CORE_PATH.'lib/dynamic_menu/templates/';
	$this->menuStructure = '';
	$this->separator = '|';

	$this->_nodesCount = 0;
	$this->tree = array();
	$this->treecnt = array();
	$this->_maxLevel = array();
	$this->_firstLevelCnt = array();
	$this->_firstItem = array();
	$this->_lastItem = array();
}

/**
* The method to set the prepended URL
* @access public
* @return boolean
*/
function setPrependedUrl($prependedUrl)
{
	// We do not perform any check
	$this->prependedUrl = $prependedUrl;
	return true;
}

/**
* The method to set the dirroot directory
* @access public
* @return boolean
*/
function setDirrootCommon($dirroot)
{
	if (!is_dir($dirroot)) {
		$this->error("setDirroot: $dirroot is not a directory.");
		return false;
	}
	if (substr($dirroot, -1) != '/') {
		$dirroot .= '/';
	}
	$oldlength = strlen($this->dirroot);
	$foobar = strpos($this->libjsdir, $this->dirroot);
	if (!($foobar === false || $foobar != 0)) {
		$this->libjsdir = $dirroot . substr($this->libjsdir, $oldlength);
	}
	$foobar = strpos($this->imgdir, $this->dirroot);
	if (!($foobar === false || $foobar != 0)) {
		$this->imgdir = $dirroot . substr($this->imgdir, $oldlength);
	}
	$foobar = strpos($this->icondir, $this->dirroot);
	if (!($foobar === false || $foobar != 0)) {
		$this->icondir = $dirroot . substr($this->icondir, $oldlength);
	}
	$foobar = strpos($this->tpldir, $this->dirroot);
	if (!($foobar === false || $foobar != 0)) {
		$this->tpldir = $dirroot . substr($this->tpldir, $oldlength);
	}
	$this->dirroot = $dirroot;
	return true;
}

/**
* The method to set the libjsdir directory
* @access public
* @return boolean
*/
function setLibjsdir($libjsdir)
{
	if ($libjsdir != '' && substr($libjsdir, -1) != '/') {
		$libjsdir .= '/';
	}
	if ($libjsdir == '' || substr($libjsdir, 0, 1) != '/') {
		$foobar = strpos($libjsdir, $this->dirroot);
		if ($foobar === false || $foobar != 0) {
			$libjsdir = $this->dirroot . $libjsdir;
		}
	}
	if (!is_dir($libjsdir)) {
		$this->error("setLibjsdir: $libjsdir is not a directory.");
		return false;
	}
	$this->libjsdir = $libjsdir;
	return true;
}

/**
* The method to set the imgdir directory
* @access public
* @return boolean
*/
function setImgdir($imgdir)
{
	if ($imgdir != '' && substr($imgdir, -1) != '/') {
		$imgdir .= '/';
	}
	if ($imgdir == '' || substr($imgdir, 0, 1) != '/') {
		$foobar = strpos($imgdir, $this->dirroot);
		if ($foobar === false || $foobar != 0) {
			$imgdir = $this->dirroot . $imgdir;
		}
	}
	if (!is_dir($imgdir)) {
		$this->error("setImgdir: $imgdir is not a directory.");
		return false;
	}
	$this->imgdir = $imgdir;
	return true;
}

/**
* The method to set imgwww
* @access public
* @return void
*/
function setImgwww($imgwww)
{
	if ($imgwww != '' && substr($imgwww, -1) != '/') {
		$imgwww .= '/';
	}
	$this->imgwww = $imgwww;
}

/**
* The method to set the icondir directory
* @access public
* @return boolean
*/
function setIcondir($icondir)
{
	if ($icondir != '' && substr($icondir, -1) != '/') {
		$icondir .= '/';
	}
	if ($icondir == '' || substr($icondir, 0, 1) != '/') {
		$foobar = strpos($icondir, $this->dirroot);
		if ($foobar === false || $foobar != 0) {
			$icondir = $this->dirroot . $icondir;
		}
	}
	if (!is_dir($icondir)) {
		$this->error("setIcondir: $icondir is not a directory.");
		return false;
	}
	$this->icondir = $icondir;
	return true;
}

/**
* The method to set iconwww
* @access public
* @return void
*/
function setIconwww($iconwww)
{
	if ($iconwww != '' && substr($iconwww, -1) != '/') {
		$iconwww .= '/';
	}
	$this->iconwww = $iconwww;
}

/**
* The method to set the iconsize array
* @access public
* @return void
*/
function setIconsize($width, $height)
{
	$this->iconsize['width'] = ($width == (int) $width) ? $width : 0;
	$this->iconsize['height'] = ($height == (int) $height) ? $height : 0;
	$this->issetIconsize = true;
}

/**
* The method to unset the iconsize array
* @access public
* @return void
*/
function unsetIconsize()
{
	unset($this->iconsize['width']);
	unset($this->iconsize['height']);
	$this->issetIconsize = false;
}

/**
* The method to set the tpldir directory
* @access public
* @return boolean
*/
function setTpldirCommon($tpldir)
{
	if ($tpldir != '' && substr($tpldir, -1) != '/') {
		$tpldir .= '/';
	}
	if ($tpldir == '' || substr($tpldir, 0, 1) != '/') {
		$foobar = strpos($tpldir, $this->dirroot);
		if ($foobar === false || $foobar != 0) {
			$tpldir = $this->dirroot . $tpldir;
		}
	}
	if (!is_dir($tpldir)) {
		$this->error("setTpldir: $tpldir is not a directory.");
		return false;
	}
	$this->tpldir = $tpldir;
	return true;
}

/**
* The method to read the menu structure from a file
* @access public
* @param string $tree_file the menu structure file
* @return boolean
*/
function setMenuStructureFile($tree_file)
{
	if (!($fd = fopen($tree_file, 'r'))) {
		$this->error("setMenuStructureFile: unable to open file $tree_file.");
		return false;
	}
	$this->menuStructure = '';
	while ($buffer = fgets($fd, 4096)) {
		$buffer = preg_replace('/'.chr(13).'/', '', $buffer);	// Microsoft Stupidity Suppression
		$this->menuStructure .= $buffer;
	}
	fclose($fd);
	if ($this->menuStructure == '') {
		$this->error("setMenuStructureFile: $tree_file is empty.");
		return false;
	}
	return true;
}

/**
* The method to set the menu structure passing it through a string
* @access public
* @param string $tree_string the menu structure string
* @return boolean
*/
function setMenuStructureString($tree_string)
{
	$this->menuStructure = preg_replace('/'.chr(13).'/', '', $tree_string);	// Microsoft Stupidity Suppression
	if ($this->menuStructure == '') {
		$this->error('setMenuStructureString: empty string.');
		return false;
	}
	return true;
}

/**
* The method to set the value of separator
* @access public
* @return void
*/
function setSeparator($separator)
{
	$this->separator = $separator;
}

/**
* The method to set parameters for the DB connection
* @access public
* @param string $dns Data Source Name: the connection string for PEAR DB
* @param bool $persistent DB connections are either persistent or not persistent
* @return boolean
*/
function setDBConnParms($dsn, $persistent=false)
{
	if (!is_string($dsn)) {
		$this->error('initdb: $dsn is not an string.');
		return false;
	}
	if (!is_bool($persistent)) {
		$this->error('initdb: $persistent is not a boolean.');
		return false;
	}
	$this->dsn = $dsn;
	$this->persistent = $persistent;
	return true;
}

/**
* The method to set the name of the table storing data describing the menu
* @access public
* @param string
* @return boolean
*/
function setTableName($tableName)
{
	if (!is_string($tableName)) {
		$this->error('setTableName: $tableName is not a string.');
		return false;
	}
	$this->tableName = $tableName;
	return true;
}

/**
* The method to set the name of the i18n table corresponding to $tableName
* @access public
* @param string
* @return boolean
*/
function setTableName_i18n($tableName_i18n)
{
	if (!is_string($tableName_i18n)) {
		$this->error('setTableName_i18n: $tableName_i18n is not a string.');
		return false;
	}
	$this->tableName_i18n = $tableName_i18n;
	return true;
}

/**
* The method to set names of fields of the table storing data describing the menu
* @access public
* @param array
* @return boolean
*/
function setTableFields($tableFields)
{
	if (!is_array($tableFields)) {
		$this->error('setTableFields: $tableFields is not an array.');
		return false;
	}
	if (count($tableFields) == 0) {
		$this->error('setTableFields: $tableFields is a zero-length array.');
		return false;
	}
	reset ($tableFields);
	while (list($key, $value) = each($tableFields)) {
		$this->tableFields[$key] = ($value == '') ? "''" : $value;
	}
	return true;
}

/**
* The method to set names of fields of the i18n table corresponding to $tableName
* @access public
* @param array
* @return boolean
*/
function setTableFields_i18n($tableFields_i18n)
{
	if (!is_array($tableFields_i18n)) {
		$this->error('setTableFields_i18n: $tableFields_i18n is not an array.');
		return false;
	}
	if (count($tableFields_i18n) == 0) {
		$this->error('setTableFields_i18n: $tableFields_i18n is a zero-length array.');
		return false;
	}
	reset ($tableFields_i18n);
	while (list($key, $value) = each($tableFields_i18n)) {
		$this->tableFields_i18n[$key] = ($value == '') ? "''" : $value;
	}
	return true;
}

/**
* The method to parse the current menu structure and correspondingly update related variables
* @access public
* @param string $menu_name the name to be attributed to the menu
*   whose structure has to be parsed
* @return void
*/
function parseStructureForMenu(
	$menu_name = ''	// non consistent default...
	)
{
	$this->_maxLevel[$menu_name] = 0;
	$this->_firstLevelCnt[$menu_name] = 0;
	$this->_firstItem[$menu_name] = $this->_nodesCount + 1;
	$cnt = $this->_firstItem[$menu_name];
	$menuStructure = $this->menuStructure;

	/* *********************************************** */
	/* Partially based on a piece of code taken from   */
	/* TreeMenu 1.1 - Bjorge Dijkstra (bjorge@gmx.net) */
	/* *********************************************** */

	while ($menuStructure != '') {
		$before_cr = strcspn($menuStructure, "\n");
		$buffer = substr($menuStructure, 0, $before_cr);
		$menuStructure = substr($menuStructure, $before_cr+1);
		if (substr($buffer, 0, 1) == '#') {
			continue;	// commented item line...
		}
		$tmp = rtrim($buffer);
		$node = explode($this->separator, $tmp);
		for ($i=count($node); $i<=6; $i++) {
			$node[$i] = '';
		}
		$this->tree[$cnt]['level'] = strlen($node[0]);
		$this->tree[$cnt]['text'] = $node[1];
		$this->tree[$cnt]['href'] = $node[2];
		$this->tree[$cnt]['title'] = $node[3];
		$this->tree[$cnt]['icon'] = $node[4];
		$this->tree[$cnt]['target'] = $node[5];
		$this->tree[$cnt]['expanded'] = $node[6];
		$cnt++;
	}

	/* *********************************************** */

	$this->_lastItem[$menu_name] = count($this->tree);
	$this->_nodesCount = $this->_lastItem[$menu_name];
	$this->tree[$this->_lastItem[$menu_name]+1]['level'] = 0;
	$this->_postParse($menu_name);
}

/**
* The method to parse the current menu table and correspondingly update related variables
* @access public
* @param string $menu_name the name to be attributed to the menu
*   whose structure has to be parsed
* @param string $language i18n language; either omit it or pass
*   an empty string ('') if you do not want to use any i18n table
* @return void
*/
function scanTableForMenu(
	$menu_name = '', // non consistent default...
	$language = ''
	)
{
	$this->_maxLevel[$menu_name] = 0;
	$this->_firstLevelCnt[$menu_name] = 0;
	unset($this->tree[$this->_nodesCount+1]);
	$this->_firstItem[$menu_name] = $this->_nodesCount + 1;
/* BEGIN BENCHMARK CODE
$time_start = $this->_getmicrotime();
/* END BENCHMARK CODE */
	$db = DB::connect($this->dsn, $this->persistent);
	if (DB::isError($db)) {
		$this->error('scanTableForMenu: ' . $db->getMessage());
	}
	$dbresult = $db->query('
		SELECT ' .
			$this->tableFields['id'] . ' AS id, ' .
			$this->tableFields['parent_id'] . ' AS parent_id, ' .
			$this->tableFields['text'] . ' AS text, ' .
			$this->tableFields['href'] . ' AS href, ' .
			$this->tableFields['title'] . ' AS title, ' .
			$this->tableFields['icon'] . ' AS icon, ' .
			$this->tableFields['target'] . ' AS target, ' .
			$this->tableFields['expanded'] . ' AS expanded
		FROM ' . $this->tableName . '
		WHERE ' . $this->tableFields['id'] . ' <> 1
		ORDER BY ' . $this->tableFields['orderfield'] . ', ' . $this->tableFields['text'] . ' ASC
	');
	$this->_tmpArray = array();
	while ($dbresult->fetchInto($row, DB_FETCHMODE_ASSOC)) {
		$this->_tmpArray[$row['id']]['parent_id'] = $row['parent_id'];
		$this->_tmpArray[$row['id']]['text'] = $row['text'];
		$this->_tmpArray[$row['id']]['href'] = $row['href'];
		$this->_tmpArray[$row['id']]['title'] = $row['title'];
		$this->_tmpArray[$row['id']]['icon'] = $row['icon'];
		$this->_tmpArray[$row['id']]['target'] = $row['target'];
		$this->_tmpArray[$row['id']]['expanded'] = $row['expanded'];
	}
	if ($language != '') {
		$dbresult = $db->query('
			SELECT ' .
				$this->tableFields_i18n['id'] . ' AS id, ' .
				$this->tableFields_i18n['text'] . ' AS text, ' .
				$this->tableFields_i18n['title'] . ' AS title
			FROM ' . $this->tableName_i18n . '
			WHERE ' . $this->tableFields_i18n['id'] . ' <> 1
				AND ' . $this->tableFields_i18n['language'] . ' = ' . "'$language'" . '
		');
		while ($dbresult->fetchInto($row, DB_FETCHMODE_ASSOC)) {
			if (isset($this->_tmpArray[$row['id']])) {
				$this->_tmpArray[$row['id']]['text'] = $row['text'];
				$this->_tmpArray[$row['id']]['title'] = $row['title'];
			}
		}
	}
	unset($dbresult);
	unset($row);
	$this->_depthFirstSearch($menu_name, $this->_tmpArray, 1, 1);
/* BEGIN BENCHMARK CODE
$time_end = $this->_getmicrotime();
$time = $time_end - $time_start;
print "TIME ELAPSED = $time\n<br>";
/* END BENCHMARK CODE */
	$this->_lastItem[$menu_name] = count($this->tree);
	$this->_nodesCount = $this->_lastItem[$menu_name];
	$this->tree[$this->_lastItem[$menu_name]+1]['level'] = 0;
	$this->_postParse($menu_name);
}

function _getmicrotime()
{
	list($usec, $sec) = explode(' ', microtime());
	return ((float) $usec + (float) $sec);
}

/**
* Recursive method to perform the depth-first search of the tree data taken from the current menu table
* @access private
* @param string $menu_name the name to be attributed to the menu
*   whose structure has to be parsed
* @param array $tmpArray the temporary array that stores data to perform
*   the depth-first search
* @param integer $parent_id id of the item whose children have
*   to be searched for
* @param integer $level the hierarchical level of children to be searched for
* @return void
*/
function _depthFirstSearch($menu_name, $tmpArray, $parent_id=1, $level=1)
{
	reset ($tmpArray);
	while (list($id, $foobar) = each($tmpArray)) {
		if ($foobar['parent_id'] == $parent_id) {
			unset($tmpArray[$id]);
			unset($this->_tmpArray[$id]);
			$cnt = count($this->tree) + 1;
			$this->tree[$cnt]['level'] = $level;
			$this->tree[$cnt]['text'] = $foobar['text'];
			$this->tree[$cnt]['href'] = $foobar['href'];
			$this->tree[$cnt]['title'] = $foobar['title'];
			$this->tree[$cnt]['icon'] = $foobar['icon'];
			$this->tree[$cnt]['target'] = $foobar['target'];
			$this->tree[$cnt]['expanded'] = $foobar['expanded'];
			$this->treecnt[$menu_name][$id] = $cnt;
			unset($foobar);
			if ($id != $parent_id) {
				$this->_depthFirstSearch($menu_name, $this->_tmpArray, $id, $level+1);
			}
		}
	}
}

/**
* A method providing parsing needed after both file/string parsing and DB table parsing
* @access private
* @param string $menu_name the name of the menu for which the parsing
*   has to be performed
* @return void
*/
function _postParse(
	$menu_name = ''	// non consistent default...
	)
{
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the new menu
		$this->tree[$cnt]['child_of_root_node'] = ($this->tree[$cnt]['level'] == 1);
		$this->tree[$cnt]['parsed_text'] = stripslashes($this->tree[$cnt]['text']);
		$this->tree[$cnt]['parsed_href'] = (preg_replace('/ /', '', $this->tree[$cnt]['href']) == '') ? '#' : $this->prependedUrl . $this->tree[$cnt]['href'];
		$this->tree[$cnt]['parsed_title'] = ($this->tree[$cnt]['title'] == '') ? '' : ' title="' . stripslashes($this->tree[$cnt]['title']) . '"';
		$fooimg = $this->icondir . $this->tree[$cnt]['icon'];
		if ($this->tree[$cnt]['icon'] != '' && (substr($this->tree[$cnt]['icon'], 0, 7) == 'http://' || substr($this->tree[$cnt]['icon'], 0, 8) == 'https://')) {
			$this->tree[$cnt]['parsed_icon'] = $this->tree[$cnt]['icon'];
			if ($this->issetIconsize) {
				$this->tree[$cnt]['iconwidth'] = $this->iconsize['width'];
				$this->tree[$cnt]['iconheight'] = $this->iconsize['height'];
			} else {
				$foobar = getimagesize($this->tree[$cnt]['icon']);
				$this->tree[$cnt]['iconwidth'] = $foobar[0];
				$this->tree[$cnt]['iconheight'] = $foobar[1];
			}
		} elseif ($this->tree[$cnt]['icon'] != '' && file_exists($fooimg)) {
			$this->tree[$cnt]['parsed_icon'] = $this->iconwww . $this->tree[$cnt]['icon'];
			if ($this->issetIconsize) {
				$this->tree[$cnt]['iconwidth'] = $this->iconsize['width'];
				$this->tree[$cnt]['iconheight'] = $this->iconsize['height'];
			} else {
				$foobar = getimagesize($fooimg);
				$this->tree[$cnt]['iconwidth'] = $foobar[0];
				$this->tree[$cnt]['iconheight'] = $foobar[1];
			}
		} else {
			$this->tree[$cnt]['parsed_icon'] = '';
		}
		$this->tree[$cnt]['parsed_target'] = ($this->tree[$cnt]['target'] == '') ? '' : ' target="' . $this->tree[$cnt]['target'] . '"';
//		$this->tree[$cnt]['expanded'] = ($this->tree[$cnt]['expanded'] == '') ? 0 : $this->tree[$cnt]['expanded'];
		$this->_maxLevel[$menu_name] = max($this->_maxLevel[$menu_name], $this->tree[$cnt]['level']);
		if ($this->tree[$cnt]['level'] == 1) {
			$this->_firstLevelCnt[$menu_name]++;
		}
	}
}

/**
* A method to replace strings in all URLs (hrefs) of a menu
* @access public
* @param string $menu_name the name of the menu for which the replacement
*   has to be performed
* @param string $string the string to be replaced
* @param string $value the replacement string
* @return void
*/
function replaceStringInUrls($menu_name, $string, $value)
{
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the new menu
		$this->tree[$cnt]['parsed_href'] = str_replace($string, $value, $this->tree[$cnt]['parsed_href']);
	}
}

/**
* A method to set the same target for all links of a menu
* @access public
* @param string $menu_name the name of the menu for which the targets
*   have to be set
* @param string $target the target to be set for all links
*   of the $menu_name menu
* @return void
*/
function setLinksTargets($menu_name, $target)
{
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the new menu
		$this->tree[$cnt]['parsed_target'] = ' target="' . $target . '"';
	}
}

/**
* A method to select the current item of $menu_name in terms of $cnt, i.e., very likely, in terms of its line number in the corresponding menu structure file (excluding from the count commented out lines, if any)
* @access public
* @param string $menu_name the name of the menu for which the current item
*   has to be selected
* @param integer $count the line number of the current item
*   in the corresponding menu structure file
*   (excluding from the count commented out lines, if any)
* @return void
*/
function setSelectedItemByCount($menu_name, $count)
{
	if ($count < 1) {
		$this->error("setSelectedItemByCount: the \$count argument is $count, but \$count can not be lower than 1");
		return;
	}
	if ($count > $this->_lastItem[$menu_name] - $this->_firstItem[$menu_name] + 1) {
		$this->error("setSelectedItemByCount: the \$count argument is $count and is larger than the number of items of the '$menu_name' menu");
		return;
	}
	$cnt = $this->_firstItem[$menu_name] + $count - 1;
	$this->tree[$cnt]['selected'] = true;
}

/**
* A method to select the current item of $menu_name in terms of the corresponding id (see the DB table structure); obviously, this method can be used only together with the DB support
* @access public
* @param string $menu_name the name of the menu for which the current item
*   has to be selected
* @param integer $id the id of the current item in the corresponding DB table
* @return void
*/
function setSelectedItemById($menu_name, $id)
{
	if (!isset($this->treecnt[$menu_name][$id])) {
		$this->error("setSelectedItemById: there is not any item with \$id = $id in the '$menu_name' menu");
		return;
	}
	$cnt = $this->treecnt[$menu_name][$id];
	$this->tree[$cnt]['selected'] = true;
}

/**
* A method to select the current item of $menu_name specifying a string that occurs in the current URL
* @access public
* @param string $menu_name the name of the menu for which the current item
*   has to be selected
* @param string $url a string that occurs in the current URL
* @return void
*/
function setSelectedItemByUrl($menu_name, $url)
{
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {  // this counter scans all nodes of the new menu
		if (!(strpos($this->tree[$cnt]['parsed_href'], $url) === false)) {
			$this->tree[$cnt]['selected'] = true;
			break;
		}
	}
}

/**
* A method to select the current item of $menu_name specifying a regular expression that matches (a substring of) the current URL; just the same as the setSelectedItemByUrl() method, but using eregi() instead of strpos()
* @access public
* @param string $menu_name the name of the menu for which the current item
*   has to be selected
* @param string $url_eregi the regular expression that matches
*   (a substring of) the current URL
* @return void
*/
function setSelectedItemByUrlEregi($menu_name, $url_eregi)
{
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {  // this counter scans all nodes of the new menu
		if (preg_match('/'.$url_eregi.'/i', $this->tree[$cnt]['parsed_href'])) {
			$this->tree[$cnt]['selected'] = true;
			break;
		}
	}
}

/**
* Method to handle errors
* @access private
* @param string $errormsg the error message
* @return void
*/
function error($errormsg)
{
	print "<b>LayersMenu Error:</b> $errormsg<br />\n";
	if ($this->haltOnError == 'yes') {
		die("<b>Halted.</b><br />\n");
	}
}

} /* END OF CLASS */


/**
* @package PHPLayersMenu
*/

/**
* This is an extension of the "common" class of the PHP Layers Menu library.
*
* It provides methods useful to process/convert menus data, e.g. to output a menu structure and a DB SQL dump corresponding to already parsed data and hence also to convert a menu structure file to a DB SQL dump and viceversa
*
* @version 3.2.0-rc
* @package PHPLayersMenu
*/
class ProcessLayersMenu extends LayersMenuCommon
{

/**
* The constructor method
* @return void
*/
function ProcessLayersMenu()
{
	$this->LayersMenuCommon();
}

/**
* The method to set the dirroot directory
* @access public
* @return boolean
*/
function setDirroot($dirroot)
{
	return $this->setDirrootCommon($dirroot);
}

/**
* Method to output a menu structure corresponding to items of a menu
* @access public
* @param string $menu_name the name of the menu for which a menu structure
*   has to be returned
* @param string $separator the character used in the menu structure format
*   to separate fields of each item
* @return string
*/
function getMenuStructure(
	$menu_name = '',	// non consistent default...
	$separator = '|'
	)
{
	$menuStructure = '';
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the menu
		$menuStructure .= str_repeat('.', $this->tree[$cnt]['level']);
		$menuStructure .= $separator;
		$menuStructure .= $this->tree[$cnt]['text'];
		$menuStructure .= $separator;
		$menuStructure .= $this->tree[$cnt]['href'];
		$menuStructure .= $separator;
		$menuStructure .= $this->tree[$cnt]['title'];
		$menuStructure .= $separator;
		$menuStructure .= $this->tree[$cnt]['icon'];
		$menuStructure .= $separator;
		$menuStructure .= $this->tree[$cnt]['target'];
		$menuStructure .= $separator;
		$menuStructure .= $this->tree[$cnt]['expanded'];
		$menuStructure .= "\n";
	}
	return $menuStructure;
}

/**
* Method to output a DB SQL dump corresponding to items of a menu
* @access public
* @param string $menu_name the name of the menu for which a DB SQL dump
*   has to be returned
* @param string $db_type the type of DB to dump for;
*   leave it either empty or not specified if you are using PHP < 5,
*   as sqlite_escape_string() has been added in PHP 5;
*   it has to be specified and set to 'sqlite' only if the dump
*   has to be prepared for SQLite; it is not significant if != 'sqlite'
* @return string
*/
function getSQLDump(
	$menu_name = '',	// non consistent default...
	$db_type = ''
	)
{
	$SQLDump = '';
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the menu
		$current_node[$this->tree[$cnt]['level']] = $cnt;
		if (!$this->tree[$cnt]['child_of_root_node']) {
			$this->tree[$cnt]['father_node'] = $current_node[$this->tree[$cnt]['level']-1];
		}
		$VALUES = '';
		$SQLDump .= 'INSERT INTO ';
		$SQLDump .= $this->tableName;
		$SQLDump .= ' (';
		$SQLDump .= $this->tableFields['id'] . ', ';
		$VALUES .= "'" . 10*$cnt . "', ";
		$SQLDump .= $this->tableFields['parent_id'] . ', ';
		if (isset($this->tree[$cnt]['father_node']) && $this->tree[$cnt]['father_node'] != 0) {
			$VALUES .= "'" . 10*$this->tree[$cnt]['father_node'] . "', ";
		} else {
			$VALUES .= "'1', ";
		}
		$SQLDump .= $this->tableFields['text'] . ', ';
		$foobar = $this->tree[$cnt]['text'];
		if ($foobar != '') {
			if ($db_type != 'sqlite') {
				$foobar = addslashes($foobar);
			} else {
				$foobar = sqlite_escape_string($foobar);
			}
		}
		$VALUES .= "'$foobar', ";
		$SQLDump .= $this->tableFields['href'] . ', ';
		$VALUES .= "'" . $this->tree[$cnt]['href'] . "', ";
		if ($this->tableFields['title'] != "''") {
			$SQLDump .= $this->tableFields['title'] . ', ';
			$foobar = $this->tree[$cnt]['title'];
			if ($foobar != '') {
				if ($db_type != 'sqlite') {
					$foobar = addslashes($foobar);
				} else {
					$foobar = sqlite_escape_string($foobar);
				}
			}
			$VALUES .= "'$foobar', ";
		}
		if ($this->tableFields['icon'] != "''") {
			$SQLDump .= $this->tableFields['icon'] . ', ';
			$VALUES .= "'" . $this->tree[$cnt]['icon'] . "', ";
		}
		if ($this->tableFields['target'] != "''") {
			$SQLDump .= $this->tableFields['target'] . ', ';
			$VALUES .= "'" . $this->tree[$cnt]['target'] . "', ";
		}
		if ($this->tableFields['orderfield'] != "''") {
			$SQLDump .= $this->tableFields['orderfield'] . ', ';
			$VALUES .= "'" . 10*$cnt . "', ";
		}
		if ($this->tableFields['expanded'] != "''") {
			$SQLDump .= $this->tableFields['expanded'] . ', ';
			$this->tree[$cnt]['expanded'] = (int) $this->tree[$cnt]['expanded'];
			$VALUES .= "'" . $this->tree[$cnt]['expanded'] . "', ";
		}
		$SQLDump = substr($SQLDump, 0, -2);
		$VALUES = substr($VALUES, 0, -2);
		$SQLDump .= ") VALUES ($VALUES);\n";
	}
	return $SQLDump;
}

} /* END OF CLASS */

/**
* @package PHPLayersMenu
*/

/**
* This is the LayersMenu class of the PHP Layers Menu library.
*
* This class depends on the LayersMenuCommon class and on the PEAR conforming version of the PHPLib Template class, i.e. on HTML_Template_PHPLIB
*
* @version 3.2.0-rc
* @package PHPLayersMenu
*/
class LayersMenu extends LayersMenuCommon
{

/**
* The template to be used for the first level menu of a horizontal menu.
*
* The value of this variable is significant only when preparing
* a horizontal menu.
*
* @access private
* @var string
*/
var $horizontalMenuTpl;
/**
* The template to be used for the first level menu of a vertical menu.
*
* The value of this variable is significant only when preparing
* a vertical menu.
*
* @access private
* @var string
*/
var $verticalMenuTpl;
/**
* The template to be used for submenu layers
* @access private
* @var string
*/
var $subMenuTpl;

/**
* A string containing the header needed to use the menu(s) in the page
* @access private
* @var string
*/
var $header;
/**
* This var tells if the header has been made or not
* @access private
* @var boolean
*/
var $_headerHasBeenMade = false;
/**
* The JS vector to list layers
* @access private
* @var string
*/
var $listl;
/**
* The JS vector of keys to know the father of each layer
* @access private
* @var string
*/
var $father_keys;
/**
* The JS vector of vals to know the father of each layer
* @access private
* @var string
*/
var $father_vals;
/**
* The JS function to set initial positions of all layers
* @access private
* @var string
*/
var $moveLayers;
/**
* An array containing the code related to the first level menu of each menu
* @access private
* @var array
*/
var $_firstLevelMenu;
/**
* A string containing the footer needed to use the menu(s) in the page
* @access private
* @var string
*/
var $footer;
/**
* This var tells if the footer has been made or not
* @access private
* @var boolean
*/
var $_footerHasBeenMade = false;

/**
* The image used for forward arrows.
* @access private
* @var string
*/
var $forwardArrowImg;
/**
* The image used for down arrows.
* @access private
* @var string
*/
var $downArrowImg;
/**
* A 1x1 transparent icon.
* @access private
* @var string
*/
var $transparentIcon;
/**
* An array to keep trace of layers containing / not containing icons
* @access private
* @var array
*/
var $_hasIcons;
/**
* Top offset for positioning of sub menu layers
* @access private
* @var integer
*/
var $menuTopShift;
/**
* Right offset for positioning of sub menu layers
* @access private
* @var integer
*/
var $menuRightShift;
/**
* Left offset for positioning of sub menu layers
* @access private
* @var integer
*/
var $menuLeftShift;
/**
* Threshold for vertical repositioning of a layer
* @access private
* @var integer
*/
var $thresholdY;
/**
* Step for the left boundaries of layers
* @access private
* @var integer
*/
var $abscissaStep;

/**
* The constructor method; it initializates the menu system
* @return void
*/
function LayersMenu(
	$menuTopShift = 6,	// Gtk2-like
	$menuRightShift = 7,	// Gtk2-like
	$menuLeftShift = 2,	// Gtk2-like
	$thresholdY = 5,
	$abscissaStep = 140
	)
{
	$this->LayersMenuCommon();

	$this->horizontalMenuTpl = $this->tpldir . 'layersmenu-horizontal_menu.ihtml';
	$this->verticalMenuTpl = $this->tpldir . 'layersmenu-vertical_menu.ihtml';
	$this->subMenuTpl = $this->tpldir . 'layersmenu-sub_menu.ihtml';

	$this->header = '';
	$this->listl = '';
	$this->father_keys = '';
	$this->father_vals = '';
	$this->moveLayers = '';
	$this->_firstLevelMenu = array();
	$this->footer = '';

	$this->transparentIcon = 'transparent.png';
	$this->_hasIcons = array();
	$this->forwardArrowImg['src'] = 'forward-arrow.png';
	$this->forwardArrowImg['width'] = 4;
	$this->forwardArrowImg['height'] = 7;
	$this->downArrowImg['src'] = 'down-arrow.png';
	$this->downArrowImg['width'] = 9;
	$this->downArrowImg['height'] = 5;
	$this->menuTopShift = $menuTopShift;
	$this->menuRightShift = $menuRightShift;
	$this->menuLeftShift = $menuLeftShift;
	$this->thresholdY = $thresholdY;
	$this->abscissaStep = $abscissaStep;
	$this->setIconsize(16, 16);
}

/**
* The method to set the value of menuTopShift
* @access public
* @return void
*/
function setMenuTopShift($menuTopShift)
{
	$this->menuTopShift = $menuTopShift;
}

/**
* The method to set the value of menuRightShift
* @access public
* @return void
*/
function setMenuRightShift($menuRightShift)
{
	$this->menuRightShift = $menuRightShift;
}

/**
* The method to set the value of menuLeftShift
* @access public
* @return void
*/
function setMenuLeftShift($menuLeftShift)
{
	$this->menuLeftShift = $menuLeftShift;
}

/**
* The method to set the value of thresholdY
* @access public
* @return void
*/
function setThresholdY($thresholdY)
{
	$this->thresholdY = $thresholdY;
}

/**
* The method to set the value of abscissaStep
* @access public
* @return void
*/
function setAbscissaStep($abscissaStep)
{
	$this->abscissaStep = $abscissaStep;
}

/**
* The method to set the dirroot directory
* @access public
* @return boolean
*/
function setDirroot($dirroot)
{
	$oldtpldir = $this->tpldir;
	if ($foobar = $this->setDirrootCommon($dirroot)) {
		$this->updateTpldir($oldtpldir);
	}
	return $foobar;
}

/**
* The method to set the tpldir directory
* @access public
* @return boolean
*/
function setTpldir($tpldir)
{
	$oldtpldir = $this->tpldir;
	if ($foobar = $this->setTpldirCommon($tpldir)) {
		$this->updateTpldir($oldtpldir);
	}
	return $foobar;
}

/**
* The method to update the templates directory path to the new tpldir
* @access private
* @return void
*/
function updateTpldir($oldtpldir)
{
	$oldlength = strlen($oldtpldir);
	$foobar = strpos($this->horizontalMenuTpl, $oldtpldir);
	if (!($foobar === false || $foobar != 0)) {
		$this->horizontalMenuTpl = $this->tpldir . substr($this->horizontalMenuTpl, $oldlength);
	}
	$foobar = strpos($this->verticalMenuTpl, $oldtpldir);
	if (!($foobar === false || $foobar != 0)) {
		$this->verticalMenuTpl = $this->tpldir . substr($this->verticalMenuTpl, $oldlength);
	}
	$foobar = strpos($this->subMenuTpl, $oldtpldir);
	if (!($foobar === false || $foobar != 0)) {
		$this->subMenuTpl = $this->tpldir . substr($this->subMenuTpl, $oldlength);
	}
}

/**
* The method to set horizontalMenuTpl
* @access public
* @return boolean
*/
function setHorizontalMenuTpl($horizontalMenuTpl)
{
	if (str_replace('/', '', $horizontalMenuTpl) == $horizontalMenuTpl) {
		$horizontalMenuTpl = $this->tpldir . $horizontalMenuTpl;
	}
	if (!file_exists($horizontalMenuTpl)) {
		$this->error("setHorizontalMenuTpl: file $horizontalMenuTpl does not exist.");
		return false;
	}
	$this->horizontalMenuTpl = $horizontalMenuTpl;
	return true;
}

/**
* The method to set verticalMenuTpl
* @access public
* @return boolean
*/
function setVerticalMenuTpl($verticalMenuTpl)
{
	if (str_replace('/', '', $verticalMenuTpl) == $verticalMenuTpl) {
		$verticalMenuTpl = $this->tpldir . $verticalMenuTpl;
	}
	if (!file_exists($verticalMenuTpl)) {
		$this->error("setVerticalMenuTpl: file $verticalMenuTpl does not exist.");
		return false;
	}
	$this->verticalMenuTpl = $verticalMenuTpl;
	return true;
}

/**
* The method to set subMenuTpl
* @access public
* @return boolean
*/
function setSubMenuTpl($subMenuTpl)
{
	if (str_replace('/', '', $subMenuTpl) == $subMenuTpl) {
		$subMenuTpl = $this->tpldir . $subMenuTpl;
	}
	if (!file_exists($subMenuTpl)) {
		$this->error("setSubMenuTpl: file $subMenuTpl does not exist.");
		return false;
	}
	$this->subMenuTpl = $subMenuTpl;
	return true;
}

/**
* A method to set transparentIcon
* @access public
* @param string $transparentIcon a transparentIcon filename (without the path)
* @return void
*/
function setTransparentIcon($transparentIcon)
{
	$this->transparentIcon = $transparentIcon;
}

/**
* The method to set an image to be used for the forward arrow
* @access public
* @param string $forwardArrowImg the forward arrow image filename
* @return boolean
*/
function setForwardArrowImg($forwardArrowImg)
{
	if (!file_exists($this->imgdir . $forwardArrowImg)) {
		$this->error('setForwardArrowImg: file ' . $this->imgdir . $forwardArrowImg . ' does not exist.');
		return false;
	}
	$foobar = getimagesize($this->imgdir . $forwardArrowImg);
	$this->forwardArrowImg['src'] = $forwardArrowImg;
	$this->forwardArrowImg['width'] = $foobar[0];
	$this->forwardArrowImg['height'] = $foobar[1];
	return true;
}

/**
* The method to set an image to be used for the down arrow
* @access public
* @param string $downArrowImg the down arrow image filename
* @return boolean
*/
function setDownArrowImg($downArrowImg)
{
	if (!file_exists($this->imgdir . $downArrowImg)) {
		$this->error('setDownArrowImg: file ' . $this->imgdir . $downArrowImg . ' does not exist.');
		return false;
	}
	$foobar = getimagesize($this->imgdir . $downArrowImg);
	$this->downArrowImg['src'] = $downArrowImg;
	$this->downArrowImg['width'] = $foobar[0];
	$this->downArrowImg['height'] = $foobar[1];
	return true;
}

/**
* A method providing parsing needed both for horizontal and vertical menus; it can be useful also with the ProcessLayersMenu extended class
* @access public
* @param string $menu_name the name of the menu for which the parsing
*   has to be performed
* @return void
*/
function parseCommon(
	$menu_name = ''	// non consistent default...
	)
{
	$this->_hasIcons[$menu_name] = false;
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the new menu
		$this->_hasIcons[$cnt] = false;
		$this->tree[$cnt]['layer_label'] = "L$cnt";
		$current_node[$this->tree[$cnt]['level']] = $cnt;
		if (!$this->tree[$cnt]['child_of_root_node']) {
			$this->tree[$cnt]['father_node'] = $current_node[$this->tree[$cnt]['level']-1];
			$this->father_keys .= ",'L$cnt'";
			$this->father_vals .= ",'" . $this->tree[$this->tree[$cnt]['father_node']]['layer_label'] . "'";
		}
		$this->tree[$cnt]['not_a_leaf'] = ($this->tree[$cnt+1]['level']>$this->tree[$cnt]['level'] && $cnt<$this->_lastItem[$menu_name]);
		// if the above condition is true, the node is not a leaf,
		// hence it has at least a child; if it is false, the node is a leaf
		if ($this->tree[$cnt]['not_a_leaf']) {
			// initialize the corresponding layer content trought a void string
			$this->tree[$cnt]['layer_content'] = '';
			// the new layer is accounted for in the layers list
			$this->listl .= ",'" . $this->tree[$cnt]['layer_label'] . "'";
		}
/*
		if ($this->tree[$cnt]['not_a_leaf']) {
			$this->tree[$cnt]['parsed_href'] = '#';
		}
*/
		if ($this->tree[$cnt]['parsed_icon'] == '') {
			$this->tree[$cnt]['iconsrc'] = $this->imgwww . $this->transparentIcon;
			$this->tree[$cnt]['iconwidth'] = 16;
			$this->tree[$cnt]['iconheight'] = 16;
			$this->tree[$cnt]['iconalt'] = ' ';
		} else {
			if ($this->tree[$cnt]['level'] > 1) {
				$this->_hasIcons[$this->tree[$cnt]['father_node']] = true;
			} else {
				$this->_hasIcons[$menu_name] = true;
			}
			$this->tree[$cnt]['iconsrc'] = $this->tree[$cnt]['parsed_icon'];
			$this->tree[$cnt]['iconalt'] = 'O';
		}
	}
}

/**
* A method needed to update the footer both for horizontal and vertical menus
* @access private
* @param string $menu_name the name of the menu for which the updating
*   has to be performed
* @return void
*/
function _updateFooter(
	$menu_name = ''	// non consistent default...
	)
{
	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->subMenuTpl);
	$t->setBlock('tplfile', 'template', 'template_blck');
	$t->setBlock('template', 'sub_menu_cell', 'sub_menu_cell_blck');
	$t->setVar('sub_menu_cell_blck', '');
	$t->setBlock('template', 'separator', 'separator_blck');
	$t->setVar('separator_blck', '');
	$t->setVar('abscissaStep', $this->abscissaStep);

	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {
		if ($this->tree[$cnt]['not_a_leaf']) {
			$t->setVar(array(
				'layer_label'		=> $this->tree[$cnt]['layer_label'],
				'layer_title'		=> $this->tree[$cnt]['text'],
				'sub_menu_cell_blck'	=> $this->tree[$cnt]['layer_content']
			));
			$this->footer .= $t->parse('template_blck', 'template');
		}
	}
}

/**
* Method to preparare a horizontal menu.
*
* This method processes items of a menu to prepare the corresponding
* horizontal menu code updating many variables; it returns the code
* of the corresponding _firstLevelMenu
*
* @access public
* @param string $menu_name the name of the menu whose items have to be processed
* @return string
*/
function newHorizontalMenu(
	$menu_name = ''	// non consistent default...
	)
{
	global $UserName, $UserRole;
	if (!isset($this->_firstItem[$menu_name]) || !isset($this->_lastItem[$menu_name])) {
		$this->error("newHorizontalMenu: the first/last item of the menu '$menu_name' is not defined; please check if you have parsed its menu data.");
		return 0;
	}

	$this->parseCommon($menu_name);

	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->horizontalMenuTpl);
	$t->setBlock('tplfile', 'template', 'template_blck');
	$t->setBlock('template', 'horizontal_menu_cell', 'horizontal_menu_cell_blck');
	$t->setVar('horizontal_menu_cell_blck', '');
	$t->setBlock('horizontal_menu_cell', 'cell_link', 'cell_link_blck');
	$t->setVar('cell_link_blck', '');
	$t->setBlock('cell_link', 'cell_icon', 'cell_icon_blck');
	$t->setVar('cell_icon_blck', '');
	$t->setBlock('cell_link', 'cell_arrow', 'cell_arrow_blck');
	$t->setVar('cell_arrow_blck', '');

	$t_sub = new Template_PHPLIB();
	$t_sub->setFile('tplfile', $this->subMenuTpl);
	$t_sub->setBlock('tplfile', 'sub_menu_cell', 'sub_menu_cell_blck');
	$t_sub->setVar('sub_menu_cell_blck', '');
	$t_sub->setBlock('sub_menu_cell', 'cell_icon', 'cell_icon_blck');
	$t_sub->setVar('cell_icon_blck', '');
	$t_sub->setBlock('sub_menu_cell', 'cell_arrow', 'cell_arrow_blck');
	$t_sub->setVar('cell_arrow_blck', '');
	$t_sub->setBlock('tplfile', 'separator', 'separator_blck');
	$t_sub->setVar('separator_blck', '');

	$this->_firstLevelMenu[$menu_name] = '';

	$foobar = $this->_firstItem[$menu_name];
	$this->moveLayers .= "\tvar " . $menu_name . "TOP = getOffsetTop('" . $menu_name . "L" . $foobar . "');\n";
	$this->moveLayers .= "\tvar " . $menu_name . "HEIGHT = getOffsetHeight('" . $menu_name . "L" . $foobar . "');\n";

	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the new menu
		if ($this->tree[$cnt]['not_a_leaf']) {
			// geometrical parameters are assigned to the new layer, related to the above mentioned children
			if ($this->tree[$cnt]['child_of_root_node']) {
				$this->moveLayers .= "\tsetTop('" . $this->tree[$cnt]['layer_label'] . "', "  . $menu_name . "TOP + " . $menu_name . "HEIGHT);\n";
				$this->moveLayers .= "\tmoveLayerX1('" . $this->tree[$cnt]['layer_label'] . "', '" . $menu_name . "');\n";
			}
		}

		if ($this->tree[$cnt]['child_of_root_node']) {
			if ($this->tree[$cnt]['text'] == '---') {
				continue;
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="moveLayerX1(' . "'" . $this->tree[$cnt]['layer_label'] . "', '" . $menu_name . "') ; LMPopUp('" . $this->tree[$cnt]['layer_label'] . "'" . ', false);"';
			} else {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="shutdown();"';
			}
			checkAdmin();
			$ee_version_text = (defined('VERSION_EE') && VERSION_EE != '')?'<br/>Engine express version '.VERSION_EE.' (build '.EE_BUILD_NUMBER.')':'';
			$t->setVar(array(
			  'EE_HTTP' => EE_HTTP,
			  'EE_SITE_NAME' => EE_SITE_NAME,
			  'ee_version_text' => $ee_version_text,
			  'EE_ADMIN_URL' => EE_ADMIN_URL,
			  'username' => $UserName,
			  'userlogin' => $_SESSION['login'],
			  'userrole' => getRole($UserRole),
			  'userip' => $_SERVER['REMOTE_ADDR'],
			  'userdate' => strtolower(date("d.M.Y", $_SESSION['startTime'])),
			  'usertime' => date("G:i", $_SESSION['startTime']),
			  'userid' => $_SESSION['UserId'],
			  'EE_WELCOME' => 'Welcome <i style="color: #3000AB">'.$UserName.' ('.getRole($UserRole).')</i>',
				'menu_layer_label'	=> $menu_name . $this->tree[$cnt]['layer_label'],
				'imgwww'		=> $this->imgwww,
				'transparent'		=> $this->transparentIcon,
				'href'			=> $this->tree[$cnt]['parsed_href'],
				'onmouseover'		=> $this->tree[$cnt]['onmouseover'],
				'title'			=> $this->tree[$cnt]['parsed_title'],
				'target'		=> $this->tree[$cnt]['parsed_target'],
				'text'			=> $this->tree[$cnt]['text'],
				'downsrc'		=> $this->downArrowImg['src'],
				'downwidth'		=> $this->downArrowImg['width'],
				'downheight'		=> $this->downArrowImg['height']
			));
			if ($this->tree[$cnt]['parsed_icon'] != '') {
				$t->setVar(array(
					'iconsrc'	=> $this->tree[$cnt]['iconsrc'],
					'iconwidth'	=> $this->tree[$cnt]['iconwidth'],
					'iconheight'	=> $this->tree[$cnt]['iconheight'],
					'iconalt'	=> $this->tree[$cnt]['iconalt'],
				));
				$t->parse('cell_icon_blck', 'cell_icon');
			} else {
				$t->setVar('cell_icon_blck', '');
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$t->parse('cell_arrow_blck', 'cell_arrow');
			} else {
				$t->setVar('cell_arrow_blck', '');
			}
			$foobar = $t->parse('cell_link_blck', 'cell_link');
			$t->setVar(array(
				'cellwidth'		=> $this->abscissaStep,
				'cell_link_blck'	=> $foobar
			));
			$t->parse('horizontal_menu_cell_blck', 'horizontal_menu_cell', true);
		} else {
			if ($this->tree[$cnt]['text'] == '---') {
				$this->tree[$this->tree[$cnt]['father_node']]['layer_content'] .= $t_sub->parse('separator_blck', 'separator');
				continue;
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="moveLayerX(' . "'" . $this->tree[$cnt]['layer_label'] . "') ; moveLayerY('" . $this->tree[$cnt]['layer_label'] . "') ; LMPopUp('" . $this->tree[$cnt]['layer_label'] . "'". ', false);"';
			} else {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="LMPopUp(' . "'" . $this->tree[$this->tree[$cnt]['father_node']]['layer_label'] . "'" . ', true);"';
			}
			$t_sub->setVar(array(
				'imgwww'	=> $this->imgwww,
				'transparent'	=> $this->transparentIcon,
				'href'		=> $this->tree[$cnt]['parsed_href'],
				'refid'		=> 'ref' . $this->tree[$cnt]['layer_label'],
				'onmouseover'	=> $this->tree[$cnt]['onmouseover'],
				'title'		=> $this->tree[$cnt]['parsed_title'],
				'target'	=> $this->tree[$cnt]['parsed_target'],
				'text'		=> $this->tree[$cnt]['text'],
				'arrowsrc'	=> $this->forwardArrowImg['src'],
				'arrowwidth'	=> $this->forwardArrowImg['width'],
				'arrowheight'	=> $this->forwardArrowImg['height']
			));
			if ($this->_hasIcons[$this->tree[$cnt]['father_node']]) {
				$t_sub->setVar(array(
					'iconsrc'	=> $this->tree[$cnt]['iconsrc'],
					'iconwidth'	=> $this->tree[$cnt]['iconwidth'],
					'iconheight'	=> $this->tree[$cnt]['iconheight'],
					'iconalt'	=> $this->tree[$cnt]['iconalt']
				));
				$t_sub->parse('cell_icon_blck', 'cell_icon');
			} else {
				$t_sub->setVar('cell_icon_blck', '');
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$t_sub->parse('cell_arrow_blck', 'cell_arrow');
			} else {
				$t_sub->setVar('cell_arrow_blck', '');
			}
			$this->tree[$this->tree[$cnt]['father_node']]['layer_content'] .= $t_sub->parse('sub_menu_cell_blck', 'sub_menu_cell');
		}
	}	// end of the "for" cycle scanning all nodes

	$foobar = $this->_firstLevelCnt[$menu_name] * $this->abscissaStep;
	$t->setVar('menuwidth', $foobar);
	$t->setVar(array(
		'layer_label'	=> $menu_name,
		'menubody'	=> $this->_firstLevelMenu[$menu_name]
	));
	$this->_firstLevelMenu[$menu_name] = $t->parse('template_blck', 'template');

	$this->_updateFooter($menu_name);

	return $this->_firstLevelMenu[$menu_name];
}

/**
* Method to preparare a vertical menu.
*
* This method processes items of a menu to prepare the corresponding
* vertical menu code updating many variables; it returns the code
* of the corresponding _firstLevelMenu
*
* @access public
* @param string $menu_name the name of the menu whose items have to be processed
* @return string
*/
function newVerticalMenu(
	$menu_name = ''	// non consistent default...
	)
{
	if (!isset($this->_firstItem[$menu_name]) || !isset($this->_lastItem[$menu_name])) {
		$this->error("newVerticalMenu: the first/last item of the menu '$menu_name' is not defined; please check if you have parsed its menu data.");
		return 0;
	}

	$this->parseCommon($menu_name);

	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->verticalMenuTpl);
	$t->setBlock('tplfile', 'template', 'template_blck');
	$t->setBlock('template', 'vertical_menu_box', 'vertical_menu_box_blck');
	$t->setVar('vertical_menu_box_blck', '');
	$t->setBlock('vertical_menu_box', 'vertical_menu_cell', 'vertical_menu_cell_blck');
	$t->setVar('vertical_menu_cell_blck', '');
	$t->setBlock('vertical_menu_cell', 'cell_icon', 'cell_icon_blck');
	$t->setVar('cell_icon_blck', '');
	$t->setBlock('vertical_menu_cell', 'cell_arrow', 'cell_arrow_blck');
	$t->setVar('cell_arrow_blck', '');
	$t->setBlock('vertical_menu_box', 'separator', 'separator_blck');
	$t->setVar('separator_blck', '');

	$t_sub = new Template_PHPLIB();
	$t_sub->setFile('tplfile', $this->subMenuTpl);
	$t_sub->setBlock('tplfile', 'sub_menu_cell', 'sub_menu_cell_blck');
	$t_sub->setVar('sub_menu_cell_blck', '');
	$t_sub->setBlock('sub_menu_cell', 'cell_icon', 'cell_icon_blck');
	$t_sub->setVar('cell_icon_blck', '');
	$t_sub->setBlock('sub_menu_cell', 'cell_arrow', 'cell_arrow_blck');
	$t_sub->setVar('cell_arrow_blck', '');
	$t_sub->setBlock('tplfile', 'separator', 'separator_blck');
	$t_sub->setVar('separator_blck', '');

	$this->_firstLevelMenu[$menu_name] = '';

	$this->moveLayers .= "\tvar " . $menu_name . "TOP = getOffsetTop('" . $menu_name . "');\n";
	$this->moveLayers .= "\tvar " . $menu_name . "LEFT = getOffsetLeft('" . $menu_name . "');\n";
	$this->moveLayers .= "\tvar " . $menu_name . "WIDTH = getOffsetWidth('" . $menu_name . "');\n";

	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {	// this counter scans all nodes of the new menu
		if ($this->tree[$cnt]['not_a_leaf']) {
			// geometrical parameters are assigned to the new layer, related to the above mentioned children
			if ($this->tree[$cnt]['child_of_root_node']) {
				$this->moveLayers .= "\tsetLeft('" . $this->tree[$cnt]['layer_label'] . "', " . $menu_name . "LEFT + " . $menu_name . "WIDTH - menuRightShift);\n";
			}
		}

		if ($this->tree[$cnt]['child_of_root_node']) {
			if ($this->tree[$cnt]['text'] == '---') {
				$this->_firstLevelMenu[$menu_name] .= $t->parse('separator_blck', 'separator');
				continue;
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="moveLayerX(' . "'" . $this->tree[$cnt]['layer_label'] . "') ; moveLayerY('" . $this->tree[$cnt]['layer_label'] . "') ; LMPopUp('" . $this->tree[$cnt]['layer_label'] . "'" . ', false);"';
			} else {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="shutdown();"';
			}
			$t->setVar(array(
				'imgwww'	=> $this->imgwww,
				'transparent'	=> $this->transparentIcon,
				'href'		=> $this->tree[$cnt]['parsed_href'],
				'refid'		=> 'ref' . $this->tree[$cnt]['layer_label'],
				'onmouseover'	=> $this->tree[$cnt]['onmouseover'],
				'title'		=> $this->tree[$cnt]['parsed_title'],
				'target'	=> $this->tree[$cnt]['parsed_target'],
				'text'		=> $this->tree[$cnt]['text'],
				'arrowsrc'	=> $this->forwardArrowImg['src'],
				'arrowwidth'	=> $this->forwardArrowImg['width'],
				'arrowheight'	=> $this->forwardArrowImg['height']
			));
			if ($this->_hasIcons[$menu_name]) {
				$t->setVar(array(
					'iconsrc'	=> $this->tree[$cnt]['iconsrc'],
					'iconwidth'	=> $this->tree[$cnt]['iconwidth'],
					'iconheight'	=> $this->tree[$cnt]['iconheight'],
					'iconalt'	=> $this->tree[$cnt]['iconalt']
				));
				$t->parse('cell_icon_blck', 'cell_icon');
			} else {
				$t->setVar('cell_icon_blck', '');
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$t->parse('cell_arrow_blck', 'cell_arrow');
			} else {
				$t->setVar('cell_arrow_blck', '');
			}
			$this->_firstLevelMenu[$menu_name] .= $t->parse('vertical_menu_cell_blck', 'vertical_menu_cell');
		} else {
			if ($this->tree[$cnt]['text'] == '---') {
				$this->tree[$this->tree[$cnt]['father_node']]['layer_content'] .= $t_sub->parse('separator_blck', 'separator');
				continue;
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="moveLayerX(' . "'" . $this->tree[$cnt]['layer_label'] . "') ; moveLayerY('" . $this->tree[$cnt]['layer_label'] . "') ; LMPopUp('" . $this->tree[$cnt]['layer_label'] . "'" . ', false);"';
			} else {
				$this->tree[$cnt]['onmouseover'] = ' onmouseover="LMPopUp(' . "'" . $this->tree[$this->tree[$cnt]['father_node']]['layer_label'] . "'" . ', true);"';
			}
			$t_sub->setVar(array(
				'imgwww'	=> $this->imgwww,
				'transparent'	=> $this->transparentIcon,
				'href'		=> $this->tree[$cnt]['parsed_href'],
				'refid'		=> 'ref' . $this->tree[$cnt]['layer_label'],
				'onmouseover'	=> $this->tree[$cnt]['onmouseover'],
				'title'		=> $this->tree[$cnt]['parsed_title'],
				'target'	=> $this->tree[$cnt]['parsed_target'],
				'text'		=> $this->tree[$cnt]['text'],
				'arrowsrc'	=> $this->forwardArrowImg['src'],
				'arrowwidth'	=> $this->forwardArrowImg['width'],
				'arrowheight'	=> $this->forwardArrowImg['height']
			));
			if ($this->_hasIcons[$this->tree[$cnt]['father_node']]) {
				$t_sub->setVar(array(
					'iconsrc'	=> $this->tree[$cnt]['iconsrc'],
					'iconwidth'	=> $this->tree[$cnt]['iconwidth'],
					'iconheight'	=> $this->tree[$cnt]['iconheight'],
					'iconalt'	=> $this->tree[$cnt]['iconalt']
				));
				$t_sub->parse('cell_icon_blck', 'cell_icon');
			} else {
				$t_sub->setVar('cell_icon_blck', '');
			}
			if ($this->tree[$cnt]['not_a_leaf']) {
				$t_sub->parse('cell_arrow_blck', 'cell_arrow');
			} else {
				$t_sub->setVar('cell_arrow_blck', '');
			}
			$this->tree[$this->tree[$cnt]['father_node']]['layer_content'] .= $t_sub->parse('sub_menu_cell_blck', 'sub_menu_cell');
		}
	}	// end of the "for" cycle scanning all nodes

	$t->setVar(array(
		'menu_name'			=> $menu_name,
		'vertical_menu_cell_blck'	=> $this->_firstLevelMenu[$menu_name],
		'separator_blck'		=> ''
	));
	$this->_firstLevelMenu[$menu_name] = $t->parse('vertical_menu_box_blck', 'vertical_menu_box');
	$t->setVar('abscissaStep', $this->abscissaStep);
	$t->setVar(array(
		'layer_label'			=> $menu_name,
		'vertical_menu_box_blck'	=> $this->_firstLevelMenu[$menu_name]
	));
	$this->_firstLevelMenu[$menu_name] = $t->parse('template_blck', 'template');

	$this->_updateFooter($menu_name);

	return $this->_firstLevelMenu[$menu_name];
}

/**
* Method to prepare the header.
*
* This method obtains the header using collected informations
* and the suited JavaScript template; it returns the code of the header
*
* @access public
* @return string
*/
function makeHeader()
{
	$t = new Template_PHPLIB();
	$this->listl = 'listl = [' . substr($this->listl, 1) . '];';
	$this->father_keys = 'father_keys = [' . substr($this->father_keys, 1) . '];';
	$this->father_vals = 'father_vals = [' . substr($this->father_vals, 1) . '];';
	$t->setFile('tplfile', $this->libjsdir . 'layersmenu-header.ijs');
	$t->setVar(array(
		'packageName'	=> $this->_packageName,
		'version'	=> $this->version,
		'copyright'	=> $this->copyright,
		'author'	=> $this->author,
		'menuTopShift'	=> $this->menuTopShift,
		'menuRightShift'=> $this->menuRightShift,
		'menuLeftShift'	=> $this->menuLeftShift,
		'thresholdY'	=> $this->thresholdY,
		'abscissaStep'	=> $this->abscissaStep,
		'listl'		=> $this->listl,
		'nodesCount'	=> $this->_nodesCount,
		'father_keys'	=> $this->father_keys,
		'father_vals'	=> $this->father_vals,
		'moveLayers'	=> $this->moveLayers
	));
	$this->header = $t->parse('out', 'tplfile');
	$this->_headerHasBeenMade = true;
	return $this->header;
}

/**
* Method that returns the code of the header
* @access public
* @return string
*/
function getHeader()
{
	if (!$this->_headerHasBeenMade) {
		$this->makeHeader();
	}
	return $this->header;
}

/**
* Method that prints the code of the header
* @access public
* @return void
*/
function printHeader()
{
	return $this->getHeader();
}

/**
* Method that returns the code of the requested _firstLevelMenu
* @access public
* @param string $menu_name the name of the menu whose _firstLevelMenu
*   has to be returned
* @return string
*/
function getMenu($menu_name)
{
	return $this->_firstLevelMenu[$menu_name];
}

/**
* Method that prints the code of the requested _firstLevelMenu
* @access public
* @param string $menu_name the name of the menu whose _firstLevelMenu
*   has to be printed
* @return void
*/
function printMenu($menu_name)
{
	return $this->_firstLevelMenu[$menu_name];
}

/**
* Method to prepare the footer.
*
* This method obtains the footer using collected informations
* and the suited JavaScript template; it returns the code of the footer
*
* @access public
* @return string
*/
function makeFooter()
{
	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->libjsdir . 'layersmenu-footer.ijs');
	$t->setVar(array(
		'packageName'	=> $this->_packageName,
		'version'	=> $this->version,
		'copyright'	=> $this->copyright,
		'author'	=> $this->author,
		'footer'	=> $this->footer

	));
	$this->footer = $t->parse('out', 'tplfile');
	$this->_footerHasBeenMade = true;
	return $this->footer;
}

/**
* Method that returns the code of the footer
* @access public
* @return string
*/
function getFooter()
{
	if (!$this->_footerHasBeenMade) {
		$this->makeFooter();
	}
	return $this->footer;
}

/**
* Method that prints the code of the footer
* @access public
* @return void
*/
function printFooter()
{
	return $this->getFooter();
}

} /* END OF CLASS */

/**
* This file contains the code of the PHPTreeMenu class.
* @package PHPLayersMenu
*/

/**
* This is the PHPTreeMenu class of the PHP Layers Menu library.
*
* This class depends on the LayersMenuCommon class.  It provides "server-side" (PHP-based) tree menus, that to do not require JavaScript to work.
*
* @version 3.2.0-rc
* @package PHPLayersMenu
*/
class PHPTreeMenu extends LayersMenuCommon
{

/**
* The character used for the PHP Tree Menu in the query string to separate items ids
* @access private
* @var string
*/
var $phpTreeMenuSeparator;
/**
* The default value of the expansion string for the PHP Tree Menu
* @access private
* @var string
*/
var $phpTreeMenuDefaultExpansion;
/**
* Type of images used for the Tree Menu
* @access private
* @var string
*/
var $phpTreeMenuImagesType;
/**
* Prefix for filenames of images of a theme
* @access private
* @var string
*/
var $phpTreeMenuTheme;
/**
* An array where we store the PHP Tree Menu code for each menu
* @access private
* @var array
*/
var $_phpTreeMenu;

/**
* The constructor method; it initializates some variables
* @return void
*/
function PHPTreeMenu()
{
	$this->LayersMenuCommon();

	$this->phpTreeMenuSeparator = '|';
	$this->phpTreeMenuDefaultExpansion = '';
	$this->phpTreeMenuImagesType = 'png';
	$this->phpTreeMenuTheme = '';
	$this->_phpTreeMenu = array();
}

/**
* The method to set the dirroot directory
* @access public
* @return boolean
*/
function setDirroot($dirroot)
{
	return $this->setDirrootCommon($dirroot);
}

/**
* The method to set the value of separator for the Tree Menu query string
* @access public
* @return void
*/
function setPHPTreeMenuSeparator($phpTreeMenuSeparator)
{
	$this->phpTreeMenuSeparator = $phpTreeMenuSeparator;
}

/**
* The method to set the default value of the expansion string for the PHP Tree Menu
* @access public
* @return void
*/
function setPHPTreeMenuDefaultExpansion($phpTreeMenuDefaultExpansion)
{
	$this->phpTreeMenuDefaultExpansion = $phpTreeMenuDefaultExpansion;
}

/**
* The method to set the type of images used for the Tree Menu
* @access public
* @return void
*/
function setPHPTreeMenuImagesType($phpTreeMenuImagesType)
{
	$this->phpTreeMenuImagesType = $phpTreeMenuImagesType;
}

/**
* The method to set the prefix for filenames of images of a theme
* @access public
* @return void
*/
function setPHPTreeMenuTheme($phpTreeMenuTheme)
{
	$this->phpTreeMenuTheme = $phpTreeMenuTheme;
}

/**
* Method to prepare a new PHP Tree Menu.
*
* This method processes items of a menu and parameters submitted
* through GET (i.e. nodes to be expanded) to prepare and return
* the corresponding Tree Menu code.
*
* @access public
* @param string $menu_name the name of the menu whose items have to be processed
* @return string
*/
function newPHPTreeMenu(
	$menu_name = ''	// non consistent default...
	)
{
	$protocol = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 'https://' : 'http://';
	$this_host = (isset($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : $_SERVER['SERVER_NAME'];
	if (isset($_SERVER['SCRIPT_NAME'])) {
		$me = $_SERVER['SCRIPT_NAME'];
	} elseif (isset($_SERVER['REQUEST_URI'])) {
		$me = $_SERVER['REQUEST_URI'];
	} elseif (isset($_SERVER['PHP_SELF'])) {
		$me = $_SERVER['PHP_SELF'];
	} elseif (isset($_SERVER['PATH_INFO'])) {
		$me = $_SERVER['PATH_INFO'];
	}
	$url = $protocol . $this_host . $me;
	$query = '';
	reset($_GET);
	while (list($key, $value) = each($_GET)) {
		if ($key != 'p' && $value != '') {
			$query .= '&amp;' . $key . '=' . $value;
		}
	}
	if ($query != '') {
		$query = '?' . substr($query, 5) . '&amp;p=';
	} else {
		$query = '?p=';
	}
	$p = (isset($_GET['p'])) ? $_GET['p'] : $this->phpTreeMenuDefaultExpansion;

/* ********************************************************* */
/* Based on TreeMenu 1.1 by Bjorge Dijkstra (bjorge@gmx.net) */
/* ********************************************************* */
	$this->_phpTreeMenu[$menu_name] = '';

	$img_collapse			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_collapse.' . $this->phpTreeMenuImagesType;
	$alt_collapse			= '--';
	$img_collapse_corner		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_collapse_corner.' . $this->phpTreeMenuImagesType;
	$alt_collapse_corner		= '--';
	$img_collapse_corner_first	= $this->imgwww . $this->phpTreeMenuTheme . 'tree_collapse_corner_first.' . $this->phpTreeMenuImagesType;
	$alt_collapse_corner_first	= '--';
	$img_collapse_first		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_collapse_first.' . $this->phpTreeMenuImagesType;
	$alt_collapse_first		= '--';
	$img_corner			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_corner.' . $this->phpTreeMenuImagesType;
	$alt_corner			= '`-';
	$img_expand			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_expand.' . $this->phpTreeMenuImagesType;
	$alt_expand			= '+-';
	$img_expand_corner		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_expand_corner.' . $this->phpTreeMenuImagesType;
	$alt_expand_corner		= '+-';
	$img_expand_corner_first	= $this->imgwww . $this->phpTreeMenuTheme . 'tree_expand_corner_first.' . $this->phpTreeMenuImagesType;
	$alt_expand_corner_first	= '+-';
	$img_expand_first		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_expand_first.' . $this->phpTreeMenuImagesType;
	$alt_expand_first		= '+-';
	$img_folder_closed		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_folder_closed.' . $this->phpTreeMenuImagesType;
	$alt_folder_closed		= '->';
	$img_folder_open		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_folder_open.' . $this->phpTreeMenuImagesType;
	$alt_folder_open		= '->';
	$img_leaf			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_leaf.' . $this->phpTreeMenuImagesType;
	$alt_leaf			= '->';
	$img_space			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_space.' . $this->phpTreeMenuImagesType;
	$alt_space			= '  ';
	$img_split			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_split.' . $this->phpTreeMenuImagesType;
	$alt_split			= '|-';
	$img_split_first		= $this->imgwww . $this->phpTreeMenuTheme . 'tree_split_first.' . $this->phpTreeMenuImagesType;
	$alt_split_first		= '|-';
	$img_vertline			= $this->imgwww . $this->phpTreeMenuTheme . 'tree_vertline.' . $this->phpTreeMenuImagesType;
	$alt_vertline			= '| ';

	for ($i=$this->_firstItem[$menu_name]; $i<=$this->_lastItem[$menu_name]; $i++) {
		$expand[$i] = 0;
		$visible[$i] = 0;
		$this->tree[$i]['last_item'] = 0;
	}
	for ($i=0; $i<=$this->_maxLevel[$menu_name]; $i++) {
		$levels[$i] = 0;
	}

	// Get numbers of nodes to be expanded
	if ($p != '') {
		$explevels = explode($this->phpTreeMenuSeparator, $p);
		$explevels_count = count($explevels);
		for ($i=0; $i<$explevels_count; $i++) {
			$expand[$explevels[$i]] = 1;
		}
	}

	// Find last nodes of subtrees
	$last_level = $this->_maxLevel[$menu_name];
	for ($i=$this->_lastItem[$menu_name]; $i>=$this->_firstItem[$menu_name]; $i--) {
		if ($this->tree[$i]['level'] < $last_level) {
			for ($j=$this->tree[$i]['level']+1; $j<=$this->_maxLevel[$menu_name]; $j++) {
				$levels[$j] = 0;
			}
		}
		if ($levels[$this->tree[$i]['level']] == 0) {
			$levels[$this->tree[$i]['level']] = 1;
			$this->tree[$i]['last_item'] = 1;
		} else {
			$this->tree[$i]['last_item'] = 0;
		}
		$last_level = $this->tree[$i]['level'];
	}

	// Determine visible nodes
	// all root nodes are always visible
	for ($i=$this->_firstItem[$menu_name]; $i<=$this->_lastItem[$menu_name]; $i++) {
		if ($this->tree[$i]['level'] == 1) {
			$visible[$i] = 1;
		}
	}
	if (isset($explevels)) {
		for ($i=0; $i<$explevels_count; $i++) {
			$n = $explevels[$i];
			if ($n >= $this->_firstItem[$menu_name] && $n <= $this->_lastItem[$menu_name] && $visible[$n] == 1 && $expand[$n] == 1) {
				$j = $n + 1;
				while ($j<=$this->_lastItem[$menu_name] && $this->tree[$j]['level']>$this->tree[$n]['level']) {
					if ($this->tree[$j]['level'] == $this->tree[$n]['level']+1) {
						$visible[$j] = 1;
					}
					$j++;
				}
			}
		}
	}

	// Output nicely formatted tree
	for ($i=0; $i<$this->_maxLevel[$menu_name]; $i++) {
		$levels[$i] = 1;
	}
	$max_visible_level = 0;
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {
		if ($visible[$cnt]) {
			$max_visible_level = max($max_visible_level, $this->tree[$cnt]['level']);
		}
	}
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {
		if ($this->tree[$cnt]['text'] == '---') {
			continue;	// separators are significant only for layers-based menus
		}

		if (isset($this->tree[$cnt]['selected']) && $this->tree[$cnt]['selected']) {
			$linkstyle = 'phplmselected';
		} else {
			$linkstyle = 'phplm';
		}

		if ($visible[$cnt]) {
			$this->_phpTreeMenu[$menu_name] .= '<div class="treemenudiv">' . "\n";

			// vertical lines from higher levels
			for ($i=0; $i<$this->tree[$cnt]['level']-1; $i++) {
				if ($levels[$i] == 1) {
					$img = $img_vertline;
					$alt = $alt_vertline;
				} else {
					$img = $img_space;
					$alt = $alt_space;
				}
				$this->_phpTreeMenu[$menu_name] .= '<img align="top" border="0" class="imgs" src="' . $img . '" alt="' . $alt . '" />';
			}

			$not_a_leaf = $cnt<$this->_lastItem[$menu_name] && $this->tree[$cnt+1]['level']>$this->tree[$cnt]['level'];

			if ($not_a_leaf) {
				// Create expand/collapse parameters
				$params = '';
				for ($i=$this->_firstItem[$menu_name]; $i<=$this->_lastItem[$menu_name]; $i++) {
					if ($expand[$i] == 1 && $cnt!= $i || ($expand[$i] == 0 && $cnt == $i)) {
						$params .= $this->phpTreeMenuSeparator . $i;
					}
				}
				if ($params != '') {
					$params = substr($params, 1);
				}
			}

			if ($this->tree[$cnt]['last_item'] == 1) {
			// corner at end of subtree or t-split
				if ($not_a_leaf) {
					if ($expand[$cnt] == 0) {
						if ($cnt == $this->_firstItem[$menu_name]) {
							$img = $img_expand_corner_first;
							$alt = $alt_expand_corner_first;
						} else {
							$img = $img_expand_corner;
							$alt = $alt_expand_corner;
						}
					} else {
						if ($cnt == $this->_firstItem[$menu_name]) {
							$img = $img_collapse_corner_first;
							$alt = $alt_collapse_corner_first;
						} else {
							$img = $img_collapse_corner;
							$alt = $alt_collapse_corner;
						}
					}
					$this->_phpTreeMenu[$menu_name] .= '<a name="' . $cnt . '" class="' . $linkstyle . '" href="' . $url . $query . $params . '#' . $cnt . '"><img align="top" border="0" class="imgs" src="' . $img . '" alt="' . $alt . '" /></a>';
				} else {
					$this->_phpTreeMenu[$menu_name] .= '<img align="top" border="0" class="imgs" src="' . $img_corner . '" alt="' . $alt_corner . '" />';
				}
				$levels[$this->tree[$cnt]['level']-1] = 0;
			} else {
				if ($not_a_leaf) {
					if ($expand[$cnt] == 0) {
						if ($cnt == $this->_firstItem[$menu_name]) {
							$img = $img_expand_first;
							$alt = $alt_expand_first;
						} else {
							$img = $img_expand;
							$alt = $alt_expand;
						}
					} else {
						if ($cnt == $this->_firstItem[$menu_name]) {
							$img = $img_collapse_first;
							$alt = $alt_collapse_first;
						} else {
							$img = $img_collapse;
							$alt = $alt_collapse;
						}
					}
					$this->_phpTreeMenu[$menu_name] .= '<a name="' . $cnt . '" class="' . $linkstyle . '" href="' . $url . $query . $params . '#' . $cnt . '"><img align="top" border="0" class="imgs" src="' . $img . '" alt="' . $alt . '" /></a>';
				} else {
					if ($cnt == $this->_firstItem[$menu_name]) {
						$img = $img_split_first;
						$alt = $alt_split_first;
					} else {
						$img = $img_split;
						$alt = $alt_split;
					}
					$this->_phpTreeMenu[$menu_name] .= '<img align="top" border="0" class="imgs" src="' . $img . '" alt="' . $alt . '" />';
				}
				$levels[$this->tree[$cnt]['level']-1] = 1;
			}

			if ($this->tree[$cnt]['parsed_href'] == '' || $this->tree[$cnt]['parsed_href'] == '#') {
				$a_href_open_img = '';
				$a_href_close_img = '';
				$a_href_open = '<a class="phplmnormal">';
				$a_href_close = '</a>';
			} else {
				$a_href_open_img = '<a href="' . $this->tree[$cnt]['parsed_href'] . '"' . $this->tree[$cnt]['parsed_title'] . $this->tree[$cnt]['parsed_target'] . '>';
				$a_href_close_img = '</a>';
				$a_href_open = '<a href="' . $this->tree[$cnt]['parsed_href'] . '"' . $this->tree[$cnt]['parsed_title'] . $this->tree[$cnt]['parsed_target'] . ' class="' . $linkstyle . '">';
				$a_href_close = '</a>';
			}

			if ($not_a_leaf) {
				if ($expand[$cnt] == 1) {
					$img = $img_folder_open;
					$alt = $alt_folder_open;
				} else {
					$img = $img_folder_closed;
					$alt = $alt_folder_closed;
				}
				$this->_phpTreeMenu[$menu_name] .= $a_href_open_img . '<img align="top" border="0" class="imgs" src="' . $img . '" alt="' . $alt . '" />' . $a_href_close_img;
			} else {
				if ($this->tree[$cnt]['parsed_icon'] != '') {
					$this->_phpTreeMenu[$menu_name] .= $a_href_open_img . '<img align="top" border="0" src="' . $this->tree[$cnt]['parsed_icon'] . '" width="' . $this->tree[$cnt]['iconwidth'] . '" height="' . $this->tree[$cnt]['iconheight'] . '" alt="' . $alt_leaf . '" />' . $a_href_close_img;
				} else {
					$this->_phpTreeMenu[$menu_name] .= $a_href_open_img . '<img align="top" border="0" class="imgs" src="' . $img_leaf . '" alt="' . $alt_leaf . '" />' . $a_href_close_img;
				}
			}

			// output item text
			$foobar = $max_visible_level - $this->tree[$cnt]['level'] + 1;
			if ($foobar > 1) {
				$colspan = ' colspan="' . $foobar . '"';
			} else {
				$colspan = '';
			}
			$this->_phpTreeMenu[$menu_name] .= '&nbsp;' . $a_href_open . $this->tree[$cnt]['parsed_text'] . $a_href_close . "\n";
			$this->_phpTreeMenu[$menu_name] .= '</div>' . "\n";
		}
	}
/* ********************************************************* */

/*
	$this->_phpTreeMenu[$menu_name] =
	'<div class="phplmnormal">' . "\n" .
	$this->_phpTreeMenu[$menu_name] .
	'</div>' . "\n";
*/
	// Some (old) browsers do not support the "white-space: nowrap;" CSS property...
	$this->_phpTreeMenu[$menu_name] =
	'<table cellspacing="0" cellpadding="0" border="0">' . "\n" .
	'<tr>' . "\n" .
	'<td class="phplmnormal" nowrap="nowrap">' . "\n" .
	$this->_phpTreeMenu[$menu_name] .
	'</td>' . "\n" .
	'</tr>' . "\n" .
	'</table>' . "\n";

	return $this->_phpTreeMenu[$menu_name];
}

/**
* Method that returns the code of the requested PHP Tree Menu
* @access public
* @param string $menu_name the name of the menu whose PHP Tree Menu code
*   has to be returned
* @return string
*/
function getPHPTreeMenu($menu_name)
{
	return $this->_phpTreeMenu[$menu_name];
}

/**
* Method that prints the code of the requested PHP Tree Menu
* @access public
* @param string $menu_name the name of the menu whose PHP Tree Menu code
*   has to be printed
* @return void
*/
function printPHPTreeMenu($menu_name)
{
	print $this->_phpTreeMenu[$menu_name];
}

} /* END OF CLASS */

/**
* @package PHPLayersMenu
*/

/**
* This is the PlainMenu class of the PHP Layers Menu library.
*
* This class depends on the LayersMenuCommon class and on the PEAR conforming version of the PHPLib Template class, i.e. on HTML_Template_PHPLIB.  It provides plain menus, that to do not require JavaScript to work.
*
* @version 3.2.0-rc
* @package PHPLayersMenu
*/
class PlainMenu extends LayersMenuCommon
{

/**
* The template to be used for the Plain Menu
*/
var $plainMenuTpl;
/**
* An array where we store the Plain Menu code for each menu
* @access private
* @var array
*/
var $_plainMenu;

/**
* The template to be used for the Horizontal Plain Menu
*/
var $horizontalPlainMenuTpl;
/**
* An array where we store the Horizontal Plain Menu code for each menu
* @access private
* @var array
*/
var $_horizontalPlainMenu;

/**
* The constructor method; it initializates some variables
* @return void
*/
function PlainMenu()
{
	$this->LayersMenuCommon();

	$this->plainMenuTpl = $this->tpldir . 'layersmenu-plain_menu.ihtml';
	$this->_plainMenu = array();

	$this->horizontalPlainMenuTpl = $this->tpldir . 'layersmenu-horizontal_plain_menu.ihtml';
	$this->_horizontalPlainMenu = array();
}

/**
* The method to set the dirroot directory
* @access public
* @return boolean
*/
function setDirroot($dirroot)
{
	$oldtpldir = $this->tpldir;
	if ($foobar = $this->setDirrootCommon($dirroot)) {
		$this->updateTpldir($oldtpldir);
	}
	return $foobar;
}

/**
* The method to set the tpldir directory
* @access public
* @return boolean
*/
function setTpldir($tpldir)
{
	$oldtpldir = $this->tpldir;
	if ($foobar = $this->setTpldirCommon($tpldir)) {
		$this->updateTpldir($oldtpldir);
	}
	return $foobar;
}

/**
* The method to update the templates directory path to the new tpldir
* @access private
* @return void
*/
function updateTpldir($oldtpldir)
{
	$oldlength = strlen($oldtpldir);
	$foobar = strpos($this->plainMenuTpl, $oldtpldir);
	if (!($foobar === false || $foobar != 0)) {
		$this->plainMenuTpl = $this->tpldir . substr($this->plainMenuTpl, $oldlength);
	}
	$foobar = strpos($this->horizontalPlainMenuTpl, $oldtpldir);
	if (!($foobar === false || $foobar != 0)) {
		$this->horizontalPlainMenuTpl = $this->tpldir . substr($this->horizontalPlainMenuTpl, $oldlength);
	}
}

/**
* The method to set plainMenuTpl
* @access public
* @return boolean
*/
function setPlainMenuTpl($plainMenuTpl)
{
	if (str_replace('/', '', $plainMenuTpl) == $plainMenuTpl) {
		$plainMenuTpl = $this->tpldir . $plainMenuTpl;
	}
	if (!file_exists($plainMenuTpl)) {
		$this->error("setPlainMenuTpl: file $plainMenuTpl does not exist.");
		return false;
	}
	$this->plainMenuTpl = $plainMenuTpl;
	return true;
}

/**
* Method to prepare a new Plain Menu.
*
* This method processes items of a menu to prepare and return
* the corresponding Plain Menu code.
*
* @access public
* @param string $menu_name the name of the menu whose items have to be processed
* @return string
*/
function newPlainMenu(
	$menu_name = ''	// non consistent default...
	)
{
	$plain_menu_blck = '';
	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->plainMenuTpl);
	$t->setBlock('tplfile', 'template', 'template_blck');
	$t->setBlock('template', 'plain_menu_cell', 'plain_menu_cell_blck');
	$t->setVar('plain_menu_cell_blck', '');
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {
		if ($this->tree[$cnt]['text'] == '---') {
			continue;	// separators are significant only for layers-based menus
		}
		$nbsp = '';
		for ($i=1; $i<$this->tree[$cnt]['level']; $i++) {
			$nbsp .= '&nbsp;&nbsp;&nbsp;';
		}
		$t->setVar(array(
			'nbsp'		=> $nbsp,
			'href'		=> $this->tree[$cnt]['parsed_href'],
			'title'		=> $this->tree[$cnt]['parsed_title'],
			'target'	=> $this->tree[$cnt]['parsed_target'],
			'text'		=> $this->tree[$cnt]['parsed_text']
		));
		$plain_menu_blck .= $t->parse('plain_menu_cell_blck', 'plain_menu_cell', false);
	}
	$t->setVar('plain_menu_cell_blck', $plain_menu_blck);
	$this->_plainMenu[$menu_name] = $t->parse('template_blck', 'template');

	return $this->_plainMenu[$menu_name];
}

/**
* Method that returns the code of the requested Plain Menu
* @access public
* @param string $menu_name the name of the menu whose Plain Menu code
*   has to be returned
* @return string
*/
function getPlainMenu($menu_name)
{
	return $this->_plainMenu[$menu_name];
}

/**
* Method that prints the code of the requested Plain Menu
* @access public
* @param string $menu_name the name of the menu whose Plain Menu code
*   has to be printed
* @return void
*/
function printPlainMenu($menu_name)
{
	print $this->_plainMenu[$menu_name];
}

/**
* The method to set horizontalPlainMenuTpl
* @access public
* @return boolean
*/
function setHorizontalPlainMenuTpl($horizontalPlainMenuTpl)
{
	if (str_replace('/', '', $horizontalPlainMenuTpl) == $horizontalPlainMenuTpl) {
		$horizontalPlainMenuTpl = $this->tpldir . $horizontalPlainMenuTpl;
	}
	if (!file_exists($horizontalPlainMenuTpl)) {
		$this->error("setHorizontalPlainMenuTpl: file $horizontalPlainMenuTpl does not exist.");
		return false;
	}
	$this->horizontalPlainMenuTpl = $horizontalPlainMenuTpl;
	return true;
}

/**
* Method to prepare a new Horizontal Plain Menu.
*
* This method processes items of a menu to prepare and return
* the corresponding Horizontal Plain Menu code.
*
* @access public
* @param string $menu_name the name of the menu whose items have to be processed
* @return string
*/
function newHorizontalPlainMenu(
	$menu_name = ''	// non consistent default...
	)
{
	$horizontal_plain_menu_blck = '';
	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->horizontalPlainMenuTpl);
	$t->setBlock('tplfile', 'template', 'template_blck');
	$t->setBlock('template', 'horizontal_plain_menu_cell', 'horizontal_plain_menu_cell_blck');
	$t->setVar('horizontal_plain_menu_cell_blck', '');
	$t->setBlock('horizontal_plain_menu_cell', 'plain_menu_cell', 'plain_menu_cell_blck');
	$t->setVar('plain_menu_cell_blck', '');
	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {
		if ($this->tree[$cnt]['text'] == '---') {
			continue;	// separators are significant only for layers-based menus
		}
		if ($this->tree[$cnt]['level'] == 1 && $cnt > $this->_firstItem[$menu_name]) {
			$t->parse('horizontal_plain_menu_cell_blck', 'horizontal_plain_menu_cell', true);
			$t->setVar('plain_menu_cell_blck', '');
		}
		$nbsp = '';
		for ($i=1; $i<$this->tree[$cnt]['level']; $i++) {
			$nbsp .= '&nbsp;&nbsp;&nbsp;';
		}
		$t->setVar(array(
			'nbsp'		=> $nbsp,
			'href'		=> $this->tree[$cnt]['parsed_href'],
			'title'		=> $this->tree[$cnt]['parsed_title'],
			'target'	=> $this->tree[$cnt]['parsed_target'],
			'text'		=> $this->tree[$cnt]['parsed_text']
		));
		$t->parse('plain_menu_cell_blck', 'plain_menu_cell', true);
	}
	$t->parse('horizontal_plain_menu_cell_blck', 'horizontal_plain_menu_cell', true);
	$this->_horizontalPlainMenu[$menu_name] = $t->parse('template_blck', 'template');

	return $this->_horizontalPlainMenu[$menu_name];
}

/**
* Method that returns the code of the requested Horizontal Plain Menu
* @access public
* @param string $menu_name the name of the menu whose Horizontal Plain Menu code
*   has to be returned
* @return string
*/
function getHorizontalPlainMenu($menu_name)
{
	return $this->_horizontalPlainMenu[$menu_name];
}

/**
* Method that prints the code of the requested Horizontal Plain Menu
* @access public
* @param string $menu_name the name of the menu whose Horizontal Plain Menu code
*   has to be printed
* @return void
*/
function printHorizontalPlainMenu($menu_name)
{
	print $this->_horizontalPlainMenu[$menu_name];
}

} /* END OF CLASS */

/**
* @package PHPLayersMenu
*/

/**
* This is the TreeMenu class of the PHP Layers Menu library.
*
* This class depends on the LayersMenuCommon class and on the PEAR conforming version of the PHPLib Template class, i.e. on HTML_Template_PHPLIB
*
* @version 3.2.0-rc
* @package PHPLayersMenu
*/
class TreeMenu extends LayersMenuCommon
{

/**
* Type of images used for the Tree Menu
* @access private
* @var string
*/
var $treeMenuImagesType;
/**
* Prefix for filenames of images of a theme
* @access private
* @var string
*/
var $treeMenuTheme;
/**
* An array where we store the Tree Menu code for each menu
* @access private
* @var array
*/
var $_treeMenu;

/**
* The constructor method; it initializates the menu system
* @return void
*/
function TreeMenu()
{
	$this->LayersMenuCommon();

	$this->treeMenuImagesType = 'png';
	$this->treeMenuTheme = '';
	$this->_treeMenu = array();

	$this->_nodesCount = 0;
	$this->tree = array();
	$this->_maxLevel = array();
	$this->_firstLevelCnt = array();
	$this->_firstItem = array();
	$this->_lastItem = array();
}

/**
* The method to set the dirroot directory
* @access public
* @return boolean
*/
function setDirroot($dirroot)
{
	return $this->setDirrootCommon($dirroot);
}

/**
* The method to set the type of images used for the Tree Menu
* @access public
* @return void
*/
function setTreeMenuImagesType($treeMenuImagesType)
{
	$this->treeMenuImagesType = $treeMenuImagesType;
}

/**
* The method to set the prefix for filenames of images of a theme
* @access public
* @return void
*/
function setTreeMenuTheme($treeMenuTheme)
{
	$this->treeMenuTheme = $treeMenuTheme;
}

/**
* Method to prepare a new Tree Menu.
*
* This method processes items of a menu to prepare and return
* the corresponding Tree Menu code.
*
* @access public
* @param string $menu_name the name of the menu whose items have to be processed
* @return string
*/
function newTreeMenu(
	$menu_name = ''	// non consistent default...
	)
{
	if (!isset($this->_firstItem[$menu_name]) || !isset($this->_lastItem[$menu_name])) {
		$this->error("newTreeMenu: the first/last item of the menu '$menu_name' is not defined; please check if you have parsed its menu data.");
		return 0;
	}

	$this->_treeMenu[$menu_name] = '';

	$img_collapse			= $this->imgwww . $this->treeMenuTheme . 'tree_collapse.' . $this->treeMenuImagesType;
	$alt_collapse			= '--';
	$img_collapse_corner		= $this->imgwww . $this->treeMenuTheme . 'tree_collapse_corner.' . $this->treeMenuImagesType;
	$alt_collapse_corner		= '--';
	$img_collapse_corner_first	= $this->imgwww . $this->treeMenuTheme . 'tree_collapse_corner_first.' . $this->treeMenuImagesType;
	$alt_collapse_corner_first	= '--';
	$img_collapse_first		= $this->imgwww . $this->treeMenuTheme . 'tree_collapse_first.' . $this->treeMenuImagesType;
	$alt_collapse_first		= '--';
	$img_corner			= $this->imgwww . $this->treeMenuTheme . 'tree_corner.' . $this->treeMenuImagesType;
	$alt_corner			= '`-';
	$img_expand			= $this->imgwww . $this->treeMenuTheme . 'tree_expand.' . $this->treeMenuImagesType;
	$alt_expand			= '+-';
	$img_expand_corner		= $this->imgwww . $this->treeMenuTheme . 'tree_expand_corner.' . $this->treeMenuImagesType;
	$alt_expand_corner		= '+-';
	$img_expand_corner_first	= $this->imgwww . $this->treeMenuTheme . 'tree_expand_corner_first.' . $this->treeMenuImagesType;
	$alt_expand_corner_first	= '+-';
	$img_expand_first		= $this->imgwww . $this->treeMenuTheme . 'tree_expand_first.' . $this->treeMenuImagesType;
	$alt_expand_first		= '+-';
	$img_folder_closed		= $this->imgwww . $this->treeMenuTheme . 'tree_folder_closed.' . $this->treeMenuImagesType;
	$alt_folder_closed		= '->';
	$img_folder_open		= $this->imgwww . $this->treeMenuTheme . 'tree_folder_open.' . $this->treeMenuImagesType;
	$alt_folder_open		= '->';
	$img_leaf			= $this->imgwww . $this->treeMenuTheme . 'tree_leaf.' . $this->treeMenuImagesType;
	$alt_leaf			= '->';
	$img_space			= $this->imgwww . $this->treeMenuTheme . 'tree_space.' . $this->treeMenuImagesType;
	$alt_space			= '  ';
	$img_split			= $this->imgwww . $this->treeMenuTheme . 'tree_split.' . $this->treeMenuImagesType;
	$alt_split			= '|-';
	$img_split_first		= $this->imgwww . $this->treeMenuTheme . 'tree_split_first.' . $this->treeMenuImagesType;
	$alt_split_first		= '|-';
	$img_vertline			= $this->imgwww . $this->treeMenuTheme . 'tree_vertline.' . $this->treeMenuImagesType;
	$alt_vertline			= '| ';

	for ($i=0; $i<=$this->_maxLevel[$menu_name]; $i++) {
		$levels[$i] = 0;
	}

	// Find last nodes of subtrees
	$last_level = $this->_maxLevel[$menu_name];
	for ($i=$this->_lastItem[$menu_name]; $i>=$this->_firstItem[$menu_name]; $i--) {
		if ($this->tree[$i]['level'] < $last_level) {
			for ($j=$this->tree[$i]['level']+1; $j<=$this->_maxLevel[$menu_name]; $j++) {
				$levels[$j] = 0;
			}
		}
		if ($levels[$this->tree[$i]['level']] == 0) {
			$levels[$this->tree[$i]['level']] = 1;
			$this->tree[$i]['last_item'] = 1;
		} else {
			$this->tree[$i]['last_item'] = 0;
		}
		$last_level = $this->tree[$i]['level'];
	}

	$toggle = '';
	$toggle_function_name = 'toggle' . $menu_name;

	for ($cnt=$this->_firstItem[$menu_name]; $cnt<=$this->_lastItem[$menu_name]; $cnt++) {
		if ($this->tree[$cnt]['text'] == '---') {
			continue;	// separators are significant only for layers-based menus
		}

		if (isset($this->tree[$cnt]['selected']) && $this->tree[$cnt]['selected']) {
			$linkstyle = 'phplmselected';
		} else {
			$linkstyle = 'phplm';
		}

		$this->_treeMenu[$menu_name] .= '<div id="jt' . $cnt . '" class="treemenudiv">' . "\n";

		// vertical lines from higher levels
		for ($i=0; $i<$this->tree[$cnt]['level']-1; $i++) {
			if ($levels[$i] == 1) {
				$img = $img_vertline;
				$alt = $alt_vertline;
			} else {
				$img = $img_space;
				$alt = $alt_space;
			}
			$this->_treeMenu[$menu_name] .= '<img align="top" border="0" class="imgs" src="' . $img . '" alt="' . $alt . '" />';
		}

		$not_a_leaf = $cnt<$this->_lastItem[$menu_name] && $this->tree[$cnt+1]['level']>$this->tree[$cnt]['level'];

		if ($this->tree[$cnt]['last_item'] == 1) {
		// corner at end of subtree or t-split
			if ($not_a_leaf) {
				if ($cnt == $this->_firstItem[$menu_name]) {
					$img = $img_collapse_corner_first;
					$alt = $alt_collapse_corner_first;
				} else {
					$img = $img_collapse_corner;
					$alt = $alt_collapse_corner;
				}
				$this->_treeMenu[$menu_name] .= '<a onmousedown="' . $toggle_function_name . "('" . $cnt . "')" . '"><img align="top" border="0" class="imgs" id="jt' . $cnt . 'node" src="' . $img . '" alt="' . $alt . '" /></a>';
			} else {
				$this->_treeMenu[$menu_name] .= '<img align="top" border="0" class="imgs" src="' . $img_corner . '" alt="' . $alt_corner . '" />';
			}
			$levels[$this->tree[$cnt]['level']-1] = 0;
		} else {
			if ($not_a_leaf) {
				if ($cnt == $this->_firstItem[$menu_name]) {
					$img = $img_collapse_first;
					$alt = $alt_collapse_first;
				} else {
					$img = $img_collapse;
					$alt = $alt_collapse;
				}
				$this->_treeMenu[$menu_name] .= '<a onmousedown="' . $toggle_function_name . "('" . $cnt . "');" . '"><img align="top" border="0" class="imgs" id="jt' . $cnt . 'node" src="' . $img . '" alt="' . $alt . '" /></a>';
			} else {
				if ($cnt == $this->_firstItem[$menu_name]) {
					$img = $img_split_first;
					$alt = $alt_split_first;
				} else {
					$img = $img_split;
					$alt = $alt_split;
				}
				$this->_treeMenu[$menu_name] .= '<img align="top" border="0" class="imgs" id="jt' . $cnt . 'node" src="' . $img . '" alt="' . $alt . '" />';
			}
			$levels[$this->tree[$cnt]['level']-1] = 1;
		}

		if ($this->tree[$cnt]['parsed_href'] == '' || $this->tree[$cnt]['parsed_href'] == '#') {
			$a_href_open_img = '';
			$a_href_close_img = '';
			$a_href_open = '<a class="phplmnormal">';
			$a_href_close = '</a>';
		} else {
			$a_href_open_img = '<a href="' . $this->tree[$cnt]['parsed_href'] . '"' . $this->tree[$cnt]['parsed_title'] . $this->tree[$cnt]['parsed_target'] . '>';
			$a_href_close_img = '</a>';
			$a_href_open = '<a href="' . $this->tree[$cnt]['parsed_href'] . '"' . $this->tree[$cnt]['parsed_title'] . $this->tree[$cnt]['parsed_target'] . ' class="' . $linkstyle . '">';
			$a_href_close = '</a>';
		}

		if ($not_a_leaf) {
			$this->_treeMenu[$menu_name] .= $a_href_open_img . '<img align="top" border="0" class="imgs" id="jt' . $cnt . 'folder" src="' . $img_folder_open . '" alt="' . $alt_folder_open . '" />' . $a_href_close_img;
		} else {
			if ($this->tree[$cnt]['parsed_icon'] != '') {
				$this->_treeMenu[$menu_name] .= $a_href_open_img . '<img align="top" border="0" src="' . $this->tree[$cnt]['parsed_icon'] . '" width="' . $this->tree[$cnt]['iconwidth'] . '" height="' . $this->tree[$cnt]['iconheight'] . '" alt="' . $alt_leaf . '" />' . $a_href_close_img;
			} else {
				$this->_treeMenu[$menu_name] .= $a_href_open_img . '<img align="top" border="0" class="imgs" src="' . $img_leaf . '" alt="' . $alt_leaf . '" />' . $a_href_close_img;
			}
		}
		$this->_treeMenu[$menu_name] .= '&nbsp;' . $a_href_open . $this->tree[$cnt]['text'] . $a_href_close . "\n";
		$this->_treeMenu[$menu_name] .= '</div>' . "\n";

		if ($cnt<$this->_lastItem[$menu_name] && $this->tree[$cnt]['level']<$this->tree[$cnt+1]['level']) {
			$this->_treeMenu[$menu_name] .= '<div id="jt' . $cnt . 'son" class="treemenudiv">' . "\n";
			if ($this->tree[$cnt]['expanded'] != 1) {
				$toggle .= 'if (phplm_expand[' . $cnt . '] != 1) ' . $toggle_function_name . "('" . $cnt . "');\n";
			} else {
				$toggle .= 'if (phplm_collapse[' . $cnt . '] == 1) ' . $toggle_function_name . "('" . $cnt . "');\n";
			}
		}

		if ($cnt>$this->_firstItem[$menu_name] && $this->tree[$cnt]['level']>$this->tree[$cnt+1]['level']) {
			for ($i=max(1, $this->tree[$cnt+1]['level']); $i<$this->tree[$cnt]['level']; $i++) {
				$this->_treeMenu[$menu_name] .= '</div>' . "\n";
			}
		}
	}

/*
	$this->_treeMenu[$menu_name] =
	'<div class="phplmnormal">' . "\n" .
	$this->_treeMenu[$menu_name] .
	'</div>' . "\n";
*/
	// Some (old) browsers do not support the "white-space: nowrap;" CSS property...
	$this->_treeMenu[$menu_name] =
	'<table cellspacing="0" cellpadding="0" border="0">' . "\n" .
	'<tr>' . "\n" .
	'<td class="phplmnormal" nowrap="nowrap">' . "\n" .
	$this->_treeMenu[$menu_name] .
	'</td>' . "\n" .
	'</tr>' . "\n" .
	'</table>' . "\n";

	$t = new Template_PHPLIB();
	$t->setFile('tplfile', $this->libjsdir . 'layerstreemenu.ijs');
	$t->setVar(array(
		'toggle_function_name'		=> $toggle_function_name,
		'img_collapse'			=> $img_collapse,
		'img_collapse_corner'		=> $img_collapse_corner,
		'img_collapse_corner_first'	=> $img_collapse_corner_first,
		'img_collapse_first'		=> $img_collapse_first,
		'img_expand'			=> $img_expand,
		'img_expand_corner'		=> $img_expand_corner,
		'img_expand_corner_first'	=> $img_expand_corner_first,
		'img_expand_first'		=> $img_expand_first,
		'img_folder_closed'		=> $img_folder_closed,
		'img_folder_open'		=> $img_folder_open
	));
	$toggle_function = $t->parse('out', 'tplfile');
	$toggle_function =
	'<script language="JavaScript" type="text/javascript">' . "\n" .
	'<!--' . "\n" .
	$toggle_function .
	'// -->' . "\n" .
	'</script>' . "\n";

	$toggle =
	'<script language="JavaScript" type="text/javascript">' . "\n" .
	'<!--' . "\n" .
	'if ((DOM && !Opera56 && !Konqueror22) || IE4) {' . "\n" .
	$toggle .
	'}' . "\n" .
	'if (NS4) alert("Only the accessibility is provided to Netscape 4 on the JavaScript Tree Menu.\nWe *strongly* suggest you to upgrade your browser.");' . "\n" .
	'// -->' . "\n" .
	'</script>' . "\n";

	$this->_treeMenu[$menu_name] = $toggle_function . "\n" . $this->_treeMenu[$menu_name] . "\n" . $toggle;

	return $this->_treeMenu[$menu_name];
}

/**
* Method that returns the code of the requested Tree Menu
* @access public
* @param string $menu_name the name of the menu whose Tree Menu code
*   has to be returned
* @return string
*/
function getTreeMenu($menu_name)
{
	return $this->_treeMenu[$menu_name];
}

/**
* Method that prints the code of the requested Tree Menu
* @access public
* @param string $menu_name the name of the menu whose Tree Menu code
*   has to be printed
* @return void
*/
function printTreeMenu($menu_name)
{
	print $this->_treeMenu[$menu_name];
}

} /* END OF CLASS */

?>
