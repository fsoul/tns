      </div><!-- id=main-->

      <div id="footer">
        <div id="footer_menu">
<%get_menu_level:300,1,templates/menu/bottom_active.tpl,templates/menu/bottom_inactive.tpl,templates/menu/bottom_separator.tpl%>
        </div>

        <div id="footer_line">
        </div>
        <div id="footer_copy_siteby">
          <div id="footer_siteby">
&nbsp;
          </div>
          <div id="footer_copy">
<%e_cms:footer_copy%>
          </div>
        </div>
      </div>

    </div><!-- id="common3" -->
    </div><!-- id="common2" -->
  </div><!-- id="common1"-->
  <div id="shadow_bottom">
  </div>
</div><!-- id="common"-->

<%include:<%iif:<%post:is_email_baned%>,yes,email_is_baned_alert%>%>

<%include:test_cmeter_foot%>