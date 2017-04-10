<div class="int" id="replenishment_mobile"  <%iif:<%post:points_convertion_type%>,replenishment_mobile,,style="display:none"%>>

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Replenishment mobile%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Enter phone number in format (NNN) NNNNNNN%>
        </div>
  
        <div class="form_input">
          <input type="text" class="inputTxt" id="inputPhoneNumber" name="cell_phone_number_" value="<%:cell_phone_number_%>"
            <%iif:<%getError:cell_phone_number_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>

<%setValueOf:password_sfx,replenishment_mobile%>
<%include:int_points_convertion_password%>
  
<%include:int_points_convertion_send_request%>

    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>
