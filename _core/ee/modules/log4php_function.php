<?
	define('LOG4PHP_DIR', EE_PATH.EE_HTTP_PREFIX_CORE.'lib/log4php/src/log4php');
	define('LOG4PHP_CONFIGURATION',EE_PATH.'modules/log4php.properties');
	
	$global_logger = null;
	
	function get_global_logger()
	{
		global $global_logger;

		if ($global_logger == null)
		{
			require_once(LOG4PHP_DIR . '/LoggerManager.php');
			$global_logger =& LoggerManager::getLogger('main');
		}

		return $global_logger;
	}

?>