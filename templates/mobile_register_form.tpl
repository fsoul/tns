<%set_allowed_uri_params_list:reffer_email_%>

<%ap_process_registration_form%>

<%include:header_internal_1%>


<div id="main_internal_content_center_block_info">

    <div id="page_comment">
        <%nl2br_page_cms:page_comment%>
    </div>

    <%include:page_error%>

    <%include:ap_ajax_selectors%>

    <script type="text/javascript" src="<%:EE_HTTP%>js/respondent.js"></script>


    <form action="#" method="post" name="registration" id="registration_form">

        <div class="int">

            <%text_edit_page_cms:int_h_class%>
            <div class="int_h color_<%page_cms:int_h_class%>">
                <div class="int_h_text">
                    <%e_cms_cons:Registration form%>
                </div>
            </div>

            <div class="int_b_ color_<%page_cms:int_b_class%>">
                <div class="int_b_content_">
                    <div class="form-item">

                        <input type="hidden" name="tns_id" id="tns_id" value="">

                        <table id="respondent_edit_form" border="0">

                            <%setValueOf:respondent_id_,0%>

                            <%include:ap_respondent_fields%>

                            <%include:password_fields%>

                            <tr class="narrow">
                                <td><%inv:105%></td>
                                <td><%inv:5%></td>
                                <td><%inv:175%></td>
                                <td><%inv:5%></td>
                                <td><%inv:125%></td>
                            </tr>

                            <tr>
                                <td align="right"><%e_cms_cons:How do you know about us%></td>
                                <td>&nbsp;</td>
                                <td><%text_edit_cms_cons:Use other-option to enter own value%>
                                    <%text_edit_cms_cons:Other%><div class="selection-list">
                                        <select class="selector" name="know_about_" id="selector_street" onchange="display_hidden_fields();displayOther(this);"
                                        <%iif:<%getError:know_about_%>,,,style="background: #ff0;"%>
                                        title="<%cms_cons:Use other-option to enter own value%>"
                                        >
                                        <%ap_select_know_about_options:<%:language%>,<%:know_about_,0,0%>%>
                                        </select></div>
                                </td>
                                <td>&nbsp;</td>
                                <td>
                                    <input
                                    <%iif:<%getError:know_about_other_%>,,,style="background: #ff0;"%>
                                    type="text" class="inputTxtShort" name="know_about_other" id="input_know_about_other" <%iif::display_dic_info_source_other,1,value="<%iif:<%:know_about_other,0,0%>,,<%iif:<%:know_about_,0,0%>,<%:OPTION_VALUE_OTHER%>,,<%:know_about_,0,0%>%>,<%:know_about_other,0,0%>%>",style="display:none"%> />
                                    <%text_edit_cms_cons:Reffer%></td>
                            </tr>
                            <%iif::reffer_email_,,,  <tr class="narrow">
                                <td><%inv:105%></td>
                                <td><%inv:5%></td>
                                <td><%inv:175%></td>
                                <td><%inv:5%></td>
                                <td><%inv:125%></td>
                            </tr><tr><td align="right"><%cms_cons:Reffer%></td><td>&nbsp;</td><td><%:reffer_email_%>
                                    <input type="hidden" name="reffer_email_" value="<%:reffer_email_%>"/>
                                </td></tr>%>
                            <!--tr class="narrow_text">
                              <td align="right"><%e_cms_cons:Reffer%><br/><span class="small_text"><%e_cms_cons:if exists%></span></td>
                              <td>&nbsp;</td>
                              <td><%text_edit_cms_cons:Enter reffer email if you know it%>
                                <input
                                  type="text"
                              class="inputTxt"
                              name="reffer_email_"
                              value="<%:reffer_email_%>"
                                  <%iif:<%getError:reffer_email_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
                              title="<%cms_cons:Enter reffer email if you know it%>"
                                />
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr-->

                            <tr class="narrow">
                                <td><%inv:105%></td>
                                <td><%inv:5%></td>
                                <td><%inv:175%></td>
                                <td><%inv:5%></td>
                                <td><%inv:125%></td>
                            </tr>

                            <!-- %include:ap_respondent_cumulative_card_number% -->

                            <%setValueOf:captcha_name,respondent_fields_captcha_code%>
                            <%include:captcha_row%>

                            <tr><td colspan="5">&nbsp;</td></tr>

                            <tr>
                                <td align="right" valign="top">

                                    <div id="reg_form_checkbox" <%iif:<%getError:checkboxConfirm%>,,,class="error"%>>
                                    <input
                                            type="checkbox"
                                            id="checkboxConfirm"
                                            name="checkboxConfirm"
                                    <%iif::checkboxConfirm,,,checked="checked"%>
                                    />
                    </div>

                    </td>
                    <td>&nbsp;</td>
                    <td colspan="3">
                        <%e_cms:rules_read_confirm%>
                    </td>
                    </tr>


                    </table>

                    <div id="register_form_submit_link">
                        <%text_edit_cms_cons:Send%>
                        <a class="button link" href="javascript:setHidden(); document.forms['registration'].submit();"><%cms_cons:Send%></a>
                    </div>

                </div>
            </div>
        </div>
        <%text_edit_page_cms:int_b_class%>

</div>

</form>

<%longtext_edit_page_cms:email_subject%>
<%longtext_edit_page_cms:email_body%>


<div class="flash">
    <%media_insert:flash,registration_form%>
</div>

<%include:footer_internal%>

