<?php
/**
 * Hide email functionality
 *
 * @package engine-express
 */

/**
 * Converts PHP array to Javascript object
 *
 * @param array $arr
 * @return string
 */
function php_array_to_js_array($arr)
{
	$return_value = '{';
	foreach ($arr as $key=>$value)
	{
		if (is_array($value))
		{
			$return_value .= "{$key}: " . php_array_to_js_array($value) . ', ';
		}
		else
		{
			$return_value .= "{$key}: '" . str_replace('\'','\\\'',$value) . "', ";
		}
	}
	$return_value = trim($return_value,' ,');
	return  $return_value . '}';
}


/**
 * Converts email to not understandable string
 * Algoritm:
 * 		1) reverse e-mail
 * 		2) if email length is odd adding space to the end
 * 		3) Swap each odd character with even character
 * 		4) Replacing char '@' with '#'
 *
 * @param string $__email
 * @return string
 */
function escape_email($__email)
{
	if (strpos($__email, '@') === false)
	{
		return $__email;
	}

	$__new_email = strrev(trim($__email));
	if (strlen($__new_email) % 2 == 1)
	{
		$__new_email .= ' ';
	}

	$__retvalue = '';

	for ($__cnt = 0; $__cnt < strlen($__new_email); $__cnt += 2)
	{
		$__lchar = substr($__new_email, $__cnt, 1);
		$__hchar = substr($__new_email, $__cnt+1, 1);
		$__retvalue .= str_replace('@','#',$__hchar) . str_replace('@','#',$__lchar);
	}

	return $__retvalue;
}

/**
 * Reformates e-mailes in provided param
 * @param sting $html
 * @return string
 */

function hide_emails($html, $for_ajax = 0)
{
	$hide_emails = config_var('antispam_security');

	if ($hide_emails)
	{
		preg_match_all('|<a([^>]*)href=[\'"]mailto:([^@]*[@]?[^\'"]*)[\'"]([^>]*)>(.*)<\/a>|U',$html, $regs);
		$searches = array();
		$replaces = array();
		$js_objects = array();
		foreach ($regs[0] as $key => $value)
		{
			$searches[] = $value;
			$replaces[] = '<span id="ee-hm-' . $key . '"></span>';
			$js_objects[] = Array(
					'mt'	=> escape_email($regs[2][$key]),
					'title'		=> escape_email($regs[4][$key]),
					'prefix'	=> $regs[1][$key],
					'postfix'	=> $regs[3][$key]);
		}
		$js_objects['count'] = sizeof($regs[0]);
		// Convert array to Javascripot object
		$__js_mail_array = php_array_to_js_array($js_objects);

		if(!$for_ajax)
		{
			// Add:
			// 1) before closing head data array & calling JS file with decoding functions;
			$__html = str_replace('</head>',"<script type='text/javascript'><!--\nvar __hm_data = {$__js_mail_array};\n//--></script><script type='text/javascript' src='". EE_HTTP ."js/unhmt.js'></script>\n</head>", str_replace($searches,$replaces,$html));
			// 2) before closing body - executing of decode function
			$__html = str_replace('</body>',"<script type='text/javascript'><!--\n__show_mt();\n//--></script>\n</body>",$__html);
		}
		else //return ajax text response
		{
			$__html = str_replace($searches, $replaces, $html); //return text in which email replaced by empty containers
			//add to response text information about new email addresses
			//as far as developer may not decode email addresses via js function in the end
			//json array with email addresses would be returned in html commentary in order to prevent errors on innerHTML event
			$__html .= '<!-- var __hm_data = '.$__js_mail_array.'; -->';
		}
		$html = $__html;
	}

	return $html;
}

/*
HOW TO USE hide_emails FUNCTION FOR AJAX:
- pass you ajax response text (not xml!) through function hide_emails, for example: echo hide_emails('<a href="mailto:mail@dot.com">mail@dot.com</a>', 1);exit;
- apply javascript function email_decode_ajax_code() to apply ne email decode rules, for example:
var result = ajax.response;
if(typeof email_decode_ajax_code == 'function') {
	result = email_decode_ajax_code(result);
}
- insert result (not source responce) into nesesarry block, for example: document.getElementById('container').innerHTML = result;
- call javascript function __show_mt() with such construction:
if(typeof __show_mt == 'function') {
	__show_mt();
}
*/
?>