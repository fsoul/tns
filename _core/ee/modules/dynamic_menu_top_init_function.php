<?

//top level of dynamic menu items initialisation
function dynamic_menu_top_init()
{
	return  array (
		'Home'=>array(
			'Link' => EE_HTTP.'?admin_template=yes',
			'Hint' => 'Homepage',
			'Icon' => 'cms.gif',
			'Sort' => 600
		),

		'Page properties'=>array(
			'Link' => 'javascript:openPageMeta(page_id)',
			'Hint' => 'properties of page ...',
			'Icon' => 'scroll.gif',
			'UserRole' => ADMINISTRATOR,
			'parent_menu' => 'Administration'
		),

		'Sitemap Object Config' =>array(
			'Link'	=> 'javascript:openPopup(\''.EE_HTTP.EE_ADMIN_SECTION_IN_HTACCESS.'sitemap_obj.php\',600,500,1);',
			'Hint' => 'Sitemap',
			'Icon' => 'self_test_all.gif',
			'UserRole' => ADMINISTRATOR,
			'parent_menu' => 'Configuration'
		),

/*		'Page Aliases'=>array(
			'Link' => 'javascript:set_alias(\''.EE_HTTP.'index.php?t=\' + page_folder + page_name);',
			'Hint' => 'properties of page ...',
			'Icon' => 'alias.gif',
			'UserRole' => ADMINISTRATOR,
			'parent_menu' => 'Administration'			
		),
*/		
		'All modules self testing'=>array(
			'Link' => 'javascript:openPopup(\''.EE_HTTP.EE_ADMIN_SECTION_IN_HTACCESS.'self_test_all.php\',600,500,1);',
			'Hint' => 'All modules self testing',
			'Icon' => 'self_test_all.gif',
			'UserRole' => ADMINISTRATOR,
			'parent_menu' => 'Configuration'
		),

/*		'Administration'=>array(
			'Hint' => 'Site Administration',
			'Icon' => 'config.gif',
			'UserRole' => ADMINISTRATOR,
			'Sort' => 500
		),                   */
/*
		'Mailing' => array(
			'Hint' => 'Mail system',
			'Icon' => 'mailing.gif',
			'Sort' => 400
		),
		'Content'=>array(
			'Hint' => 'CMS modules',
			'Icon' => 'cms.gif',
			'Sort' => 300
		),

		'Resources'=>array(
			'Hint' => 'Site resources',
			'Icon' => 'files.gif',
			'Sort' => 200
		),

		'Favorite links'=>array(
			'Hint' => 'Favorite links',
			'Icon' => 'star.gif',
			'Sort' => 150
		),

		'Support'=>array(
			'Link' => EE_ADMIN_URL.'support.php',
			'Hint' => 'Support',
			'Icon' => 'support.gif',
			'Sort' => 100
		),
*/
                'HTMLvalidation'=>array(
			'Link' => EE_ADMIN_URL.'_HTML_validation.php', 
			'Hint' => '_HTML_validation.php.hint',
			'Icon' => 'HTML_validation.gif',
			'parent_menu' => 'Administration',
			'Sort' => 0
		),

		'Log out'=>array(
			'Link' => EE_ADMIN_URL.'logout.php',
			'Hint' => 'Log out from system',
			'Icon' => 'logout.gif',
			'Sort' => 0
		)
	);
}

?>