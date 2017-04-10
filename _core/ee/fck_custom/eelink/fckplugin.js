//Adding LINK-button to toolbar
FCKCommands.RegisterCommand('My_link', new FCKDialogCommand('Insert or Edit link','Insert or Edit link', FCKPlugins.Items['eelink'].Path + 'link.php', 500, 400));
var oeelinkitem = new FCKToolbarButton('My_link','Insert or Edit link');
oeelinkitem.IconPath =  FCKPlugins.Items['eelink'].Path +'link.gif';
FCKToolbarItems.RegisterItem( 'My_link', oeelinkitem) ;

//Adding LINK-button to context menu
FCK.ContextMenu.RegisterListener( {
        AddItems : function( menu, tag, tagName )
        {
		var bInsideLink = ( tagName == 'A' || FCKSelection.HasAncestorNode( 'A' ) ) ;

                // under what circumstances do we display this option
		if ( bInsideLink || FCK.GetNamedCommandState( 'Unlink' ) != FCK_TRISTATE_DISABLED )
		{
			// Go up to the anchor to test its properties
			var oLink = FCKSelection.MoveToAncestorNode( 'A' ) ;
			var bIsAnchor = ( oLink && oLink.name.length > 0 && oLink.href.length == 0 ) ;
			// If it isn't a link then don't add the Link context menu
			if ( bIsAnchor )
				return ;

			menu.AddSeparator() ;
			if ( bInsideLink )
			{
				FCKCommands.RegisterCommand('Width_link', new FCKDialogCommand('Insert or Edit link','Insert or Edit link', FCKPlugins.Items['eelink'].Path + 'link.php', 500, 400));
				menu.AddItem( 'Width_link', FCKLang.EditLink, 34) ;
			}
			menu.AddItem( 'Unlink'	, FCKLang.RemoveLink	, 35 ) ;
		}
        }}
);

