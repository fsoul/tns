<!--div id="dhtmltooltip2" onMouseOver="clearTimeout(tm1)" onMouseOut="tm1=setTimeout('hideddrivetip()',500)"></div>
<script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/bar_js.js"></script-->

<a href="javascript:<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH,%>,,openPopup('<%:modul%>.php?op=3'\,<%:popup_width%>\,<%:popup_height%>\, <%:popup_scroll%>),alert('<%:NO_CONTENT_ACCESS%>')%>" class="<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH%>,,button,button_gray%>">&nbsp;Add <%str_to_title::modul_title%>...&nbsp;</a>&nbsp;&nbsp;

<%iif:<%zip_enabled%>,
1,<a href="javascript:<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH,%>,,openPopup('<%:modul%>.php?op=add_zip'\\,<%:popup_width%>\\,<%:popup_height_zip%>\\,<%:popup_scroll%>),alert('<%:NO_CONTENT_ACCESS%>')%>" class="<%iif:<%check_content_access::CA_READ_ONLY,:CA_EDIT,:CA_PUBLISH%>,,button,button_gray%>">&nbsp;Add <%str_to_title::modul_title%> from zip&nbsp;</a>
,0,<span onmouseover="ddrivetip(\'<%cons:FUNCTION_NOT_AVAILABLE%>\')" onMouseout="hideddrivetip()"><a href="#" class="button" >&nbsp;Add <%str_to_title::modul_title%> from zip&nbsp;</a></span>%>
