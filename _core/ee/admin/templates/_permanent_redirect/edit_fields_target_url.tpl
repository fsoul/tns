<div id="target_url" style="float:left">

<%iif::id,
	,
	,
	<%iif::target_url,
		,
		<%iif::t_view,
			<%db_constant:DEFAULT_TPL_VIEW_ID%>,
			<%get_href::page_id,:lang_code%>,
			<%:EE_HTTP%><%get_default_alias_for_view::page_id,:t_view,:lang_code%>
	%>,
	:target_url%>
%>

</div>

<div style="align:left">&nbsp;&nbsp;<a id="target_url_link" href="

<%iif::id,
	,
	,
	<%iif::target_url,
		,
		<%iif::t_view,
			<%db_constant:DEFAULT_TPL_VIEW_ID%>,
			<%get_href::page_id,:lang_code%>,
			<%:EE_HTTP%><%get_default_alias_for_view::page_id,:t_view,:lang_code%>
	%>,
	:i_target_url%>
%>" target="_blank"><img src="<%:EE_HTTP%>img/published_page.gif" border="0" /></a></div>