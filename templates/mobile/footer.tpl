<%text_edit_cms_cons:Your account is not approved%>
<%text_edit_cms_cons:Your account is blocked%>
<%text_edit_cms_cons:Your account is deleted%>
      </div><!-- id=main-->
    </div><!-- id="common"-->
	
    <!-- <footer class="primary">
        <div class="container-12">
            <%get_menu_level:100,1,templates/menu/menu_bottom_pr.tpl,templates/menu/menu_bottom_pr.tpl,,<%ap_is_respondent_authorized%>%>
        </div>
    </footer> -->
    <footer class="secondary">
        <div class="container-12">
            <div class="site-links grid-6">
        <ul class="clearfix">

            <%get_menu_level:300,1,templates/menu/bottom_inactive.tpl,templates/menu/bottom_inactive.tpl,templates/menu/bottom_separator.tpl%>
        </ul>
            </div>
            <div class="legal grid-6 f-copyright">
                <small><%e_cms:footer_copy%></small>
            </div>
        </div>
    </footer>

<%include:<%iif:<%post:is_email_baned%>,1,email_is_baned_alert,2,email_is_removed_alert,3,email_is_not_approved_alert%>%>
<%include:foot%>