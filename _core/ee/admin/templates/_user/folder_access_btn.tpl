	<%iif::current_user_role_id,<%constant:POWERUSER%>,<a href="#" onclick="javascript:openPopup('_user.php?op=set_dir_permissions&edit=<%:id%>&admin_template=yes'\,900\,500\,0)">%><img src="<%:EE_HTTP%>img/folders_<%iif::current_user_role_id,<%constant:POWERUSER%>,a,p%>.gif" width="16" height="16" alt="<%cons:GRID_DIR_ACCESS_LIST%>" title="<%cons:GRID_DIR_ACCESS_LIST%>" border="0" /><%iif::current_user_role_id,<%constant:POWERUSER%>,</a>,%>&nbsp;&nbsp;