<%set_allowed_uri_params_list:page_error_flag%>
<%set_allowed_uri_params_list:backurl%>

<%ap_process_login_form%>

<%include:header_internal%>

<%include:page_error%>

<form action="<%:EE_HTTP%>action.php" method="post" name="internal_login_form" id="internal_login_form">

<input type="hidden" name="action" value="access_package.authorize" />
<input type="hidden" name="backurl" value="<%get:backurl%>" />
<input type="hidden" name="login_cookie" id="login_cookie2" value="" />
<input type="hidden" name="login_plid" id="login_plid2" value="" />

<div class="int form-item">
  <div class="int_h">
    <div class="int_h_text">
      <%cms_cons:Authorization form%>
    </div>
  </div>

  <div class="int_b">
    <div class="int_b_content">

      <div class="form_row">
        <div class="form_label">
          <%cms_cons:Login%>
        </div>

        <div class="form_input">
          <input
            type="text"
            class="inputTxt"
            id="inputEnterEmail"
            name="login"
            value="<%post:login%>"
            onkeypress="if(checkEnter(event)) {try_login(document.getElementById('inputEnterEmail').value, 'internal_login_form'); return false;}"
          />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label">
          <%cms_cons:Password%>
        </div>
  
        <div class="form_input">
          <input
            type="password"
            class="inputTxt"
            id="inputEnterPassword"
            name="passw"
            onkeypress="if(checkEnter(event)) {try_login(document.getElementById('inputEnterEmail').value, 'internal_login_form'); return false;}"
          />
        </div>
      </div>
  
      <div id="forgot_password_link">
        <a href="<%get_href:57%>"><%cms_cons:Forgot password%>?</a>
      </div>
      <div id="new_plugin_auth_form"> 
		<%e_page_cms:authorization_plugin%>
      </div>
      <style>
      #new_plugin_auth_form * {
		display: none;
      }
      #new_plugin_auth_form > a {
		display: block;
      }
      #new_plugin_auth_form > a *{
		display: block;
      
      </style>
	      <div class="form_row" id="authorize_link">
<%text_edit_cms_cons:Authorization%>
        <a class="button link" href="<%get_href::t%>" onclick="try_login(document.getElementById('inputEnterEmail').value, 'internal_login_form'); return false;"><%cms_cons:Authorization%></a>
      </div>



    </div>
  </div>

</div>


</form>


<%include:footer_internal%>
