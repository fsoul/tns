<?

function general_autoload($class_name){
	if (preg_match("/^AccessPanel/", $class_name))
	{
		require_once str_replace('_', '/', ($class_name.'.php'));
	}
}
spl_autoload_register('general_autoload');