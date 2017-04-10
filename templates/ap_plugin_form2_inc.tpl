<%include:page_error%>
<script type="text/javascript">
    var submit_form = function(){
        //var tid = new TnsId();
        window["IDCore"].addOnReadyListener(function(id) {
            if (document.getElementById('tns_id')) {
                document.getElementById('tns_id').value = id;
            }
        });
        window["IDCore"].init();
        document.forms['internal_login_form'].submit();
        return false;
    }
</script>
<%longtext_edit_cms:cs_plugin_answers%>
<form action="#" method="post" name="internal_login_form" id="internal_login_form">
    <input type="hidden" name="tns_id" id="tns_id" value=""/>
    <input type="hidden" name="step_n" id="step_n" value="2"/>
<div class="int">

  <div class="int_h">
    <div class="int_h_text">
      <%text_edit_page_cms:Plugin step 2%><%page_cms:Plugin step 2%>
    </div>
  </div>

  <div class="int_b">
    <div class="int_b_content">
        <div class="form_row">
            <div class="form_label" style="width: 190px;">
                <%text_edit_page_cms:question_1%><%page_cms:question_1%>
            </div>

            <div class="form_input" style="margin-top: 10px;"><div class="selection-list">
                <select name="question_1" id="question_1" style="width:190px;">
                    <%ap_inet_device_options:<%:language%>%>
                </select></div>
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
