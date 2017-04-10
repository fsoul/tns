<!--
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: fckstyles.xml
 * 	This is the sample style definitions file. It makes the styles combo
 * 	completely customizable.
 * 	See FCKConfig.StylesXmlPath in the configuration file.
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
-->
<Styles>
<%row%
<Style name="<%:title%>" element="<%iif::element,,span,<%:element%>%>">
	<%include_if:class,,,style/dynamic_styles_xml_attr%>
</Style>
%row%>
<%row_empty%
<!--list is empty-->
%row_empty%>
</Styles>