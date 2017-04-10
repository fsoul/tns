
<%text_edit_cms_cons:Points number should be at least %s%>
<%text_edit_cms_cons:You can not use more then %s points number%>
<%text_edit_cms_cons:Points number should be divisible by %s%>


<div class="int" id="points_using">

<%text_edit_page_cms:int_h_class%>
  <div class="int_h color_<%page_cms:int_h_class%>">
    <div class="int_h_text">
<%e_cms_cons:Points using%>
    </div>
  </div>

  <div class="int_b color_<%page_cms:int_b_class%>">
    <div class="int_b_content">

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Enter points number you wish to convert%>
        </div>
  
        <div class="form_input">
<%text_edit_cms_cons:Min %s\, max %s\, divisible by %s%>
          <input type="text" class="inputTxt" id="inputPointsNumber" name="points_number" value="<%post:points_number%>"
                 title="<%inputPointsNumberTitle%>"
                 <%iif:<%getError:points_number%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
          />
        </div>
      </div>

      <div class="form_row">
        <div class="form_label_long">
          <%e_cms_cons:Select points convertion type%>
        </div>
  
        <div class="form_input">

<%text_edit_cms_cons:Post order%>
<%text_edit_cms_cons:Replenishment mobile%>
<%text_edit_cms_cons:Replenishment WebMoney%>
<%text_edit_cms_cons:Project Investigation of children%>

          <select name="points_convertion_type" id="points_convertion_type"
                  onchange="start_convertion(document.forms['points_convertion'].points_convertion_type.value);"
          >

              <!-- %dic_score_convert_type_list% -->

              <option value=""></option>
            <option value="post_order" <%iif:<%post:points_convertion_type%>,post_order,selected="selected"%>><%cms_cons:Post order%></option>
            <option value="replenishment_mobile" <%iif:<%post:points_convertion_type%>,replenishment_mobile,selected="selected"%>><%cms_cons:Replenishment mobile%></option>
            <option value="replenishment_webmoney" <%iif:<%post:points_convertion_type%>,replenishment_webmoney,selected="selected"%>><%cms_cons:Replenishment WebMoney%></option>
            <option value="project_help" <%iif:<%post:points_convertion_type%>,project_help,selected="selected"%>><%cms_cons:Project Investigation of children%></option>
              <!-- -->
          </select>

        </div>
      </div>

    </div>
  </div>
<%text_edit_page_cms:int_b_class%>

</div>


