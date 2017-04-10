<div class="int" id="post_order"  <%iif:<%post:points_convertion_type%>,post_order,,style="display:none"%>>
<%include:ap_ajax_selectors%>

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Post order%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">

      <div class="form_row">
        <div class="form_label_left">
          <%e_cms_cons:Recipient%>:
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Family%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="last_name_" value="<%:last_name_,0,0%>"
            <%iif:<%getError:last_name_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>


      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Name%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="first_name_" value="<%:first_name_,0,0%>"
            <%iif:<%getError:first_name_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>


      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Patronymic name%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="second_name_" value="<%:second_name_,0,0%>"
            <%iif:<%getError:second_name_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>


      <div class="form_row">
        <div class="form_label_left">
          <%e_cms_cons:Recipient address%>:
        </div>
      </div>


      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:District%>
        </div>
  
        <div class="form_input">
            <!--
          <input type="text" class="inputTxt" name="district_" value="<%:district_,0,0%>"
            <%iif:<%getError:district_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
          -->
            <select class="selector <%iif:<%getError:district_id_%>,,,selector_error%>" name="district_id_" id="selector_district_id" onchange="display_hidden_fields();getOptions('region', this);"
            <%iif:<%getError:district_id_%>,,,style="background: #ff0;"%>
            title="<%cms_cons:KYIV_&_SEVASTOPOL%>"
            >
            <%ap_select_district_options:<%:district_id_%>%>
            </select>
            <input type="hidden" name="district_" value="" id="district_" />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Region%>
        </div>
  
        <div class="form_input"><!--
          <input type="text" class="inputTxt" name="region_" value="<%:region_,0,0%>"
            <%iif:<%getError:region_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />-->
            <select class="selector <%iif:<%getError:region_%>,,,selector_error%>" name="region_id" id="selector_region" onchange="display_hidden_fields();getOptions('city', this);"
            <%iif:<%getError:region_%>,,,style="background: #ff0;"%>
            title="<%cms_cons:Use other-option to enter own value%>"
            >
            <%ap_select_region_options:<%:district_id_%>,<%:region_,0,0%>%>
            </select>
            <input type="hidden" name="region_" value="" id="region_" />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:City%>
        </div>
  
        <div class="form_input">
          <!--<input type="text" class="inputTxt" name="city_" value="<%:city_,0,0%>"
            <%iif:<%getError:city_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />-->
            <select class="selector <%iif:<%getError:city_%>,,,selector_error%>" name="city_id_" id="selector_city" onchange="display_hidden_fields();"
            <%iif:<%getError:city_%>,,,style="background: #ff0;"%>
            title="<%cms_cons:Use other-option to enter own value%>"
            >
            <%ap_select_city_options:<%:region_%>,<%:city_,0,0%>%>
            </select>
            <input type="hidden" name="city_" value="" id="city_" />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Street%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="street_" value="<%:street_,0,0%>"
            <%iif:<%getError:street_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:House%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="house_" value="<%:house_,0,0%>"
            <%iif:<%getError:house_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Flat%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="flat_" value="<%:flat_,0,0%>"
            <%iif:<%getError:flat_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Index%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" name="index_" value="<%:index_,0,0%>"
            <%iif:<%getError:index_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>

<%setValueOf:password_sfx,post_order%>
<%include:int_points_convertion_password%>
  
<%include:int_points_convertion_send_request%>

    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>
