<%include:page_error%>
<script type="text/javascript">
    jQuery(function($){
        $("#inputEnterPhone").mask("(999) 999-99-99");
    });
    var submit_form = function(){
        //var tid = new TnsId();
        window["IDCore"].addOnReadyListener(function(id) {
            if (document.getElementById('tns_id')) {
                document.getElementById('tns_id').value = id;
            }
        });
        window["IDCore"].init();
        if("addonCMeter" in window) {
            document.getElementById("pl_id").value = addonCMeter.PLID;
        }
        document.forms['internal_login_form'].submit();
        return false;
    }
</script>
<%ap_prefill_plugin_form1%>
<form action="#" method="post" name="internal_login_form" id="internal_login_form">
    <input type="hidden" name="tns_id" id="tns_id" value=""/>
    <input type="hidden" name="pl_id" id="pl_id" value=""/>
    <input type="hidden" name="step_n" id="step_n" value="1"/>
<div class="int form-item">
  <div class="int_h">
    <div class="int_h_text">
      <a name="plugin_form_title" id="plugin_form_title"></a><%text_edit_page_cms:Plugin step 1%><%page_cms:Plugin step 1%>
    </div>
  </div>
  <div class="int_b">
    <div class="int_b_content">
      <div class="form_row">
        <div class="form_label">
          <%text_edit_page_cms:FIO%><%page_cms:FIO%>
        </div>
        <div class="form_input">
          <%iif::loggedin,1,<input type="hidden" name="login" value="<%post:login%>"/><span><%post:login%></span>,<input
            type="text"
            class="inputTxt"
            id="inputEnterEmail"
            name="login"
            value="<%post:login%>"
            style="width: 270px;"
          />%>
        </div>
      </div>
      <div class="form_row">
        <div class="form_label">
            <%text_edit_page_cms:Phone%><%page_cms:Phone%>
        </div>
        <div class="form_input">
          <%iif::loggedin,1,<input type="hidden" name="phone" value="<%post:phone%>"/><span><%post:phone%></span>,<input
            type="text"
            class="inputTxt"
            id="inputEnterPhone"
            name="phone"
            value="<%post:phone%>"
            style="width: 270px;"
            placeholder="(___) ___-__-__"
          />%>
        </div>
      </div>
      <div class="form_row plugin" id="authorize_link">
          <br style="clear: both;"/>
<%text_edit_page_cms:Enter%>
        <a class="plugin_button small button link" href="<%get_href::t%>" onclick="return submit_form();"><%page_cms:Enter%></a>
      </div>
    </div>
  </div>
</div>
</form>

