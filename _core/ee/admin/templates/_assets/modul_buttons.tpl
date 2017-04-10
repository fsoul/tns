<%iif::status,Yes,
<a onclick="return publish_confirm(this.href)" title="Publish page content" href="<%:EE_ADMIN_URL%><%:modul%>.php?op=publish&t=<%:id%>&admin_template=yes">
<img src="<%:EE_HTTP%>img/publish_a.gif" width="16" height="16" alt="<%cons:PUBLISH%>" title = "<%cons:PUBLISH%>" border="0"/></a>
<a onclick="return revert_confirm(this.href)" title="Revert page content" href="<%:EE_ADMIN_URL%><%:modul%>.php?op=revert&t=<%:id%>&admin_template=yes">
<img src="<%:EE_HTTP%>img/unpublish_a.gif" width="16" height="16" alt="<%cons:REVERT%>" title = "<%cons:REVERT%>" border="0"/></a>,<%inv:16,16%>&nbsp;<%inv:16,16%>%>