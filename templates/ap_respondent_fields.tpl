


  <tr>
    <!--<td><img src="<%:EE_HTTP%>/img/inv.gif" width="120" height="0"></td>-->
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr style="display:none"> 
    <td align="right"><%e_cms_cons:Id%></td>
    <td>&nbsp;</td>
    <td width="175px"><input readonly="readonly" type="text" class="inputTxt" name="respondent_id_" value="<%:respondent_id_%>" /></td>
    <td>&nbsp;</td>
    <td width="150px">&nbsp;</td>
  </tr>

  <!-- changed by kletsko -->
  <tr style="display:none">
    <td width="180px" align="right"><%e_cms_cons:Family%></td>
    <td>&nbsp;</td>
    <td width="175px"><input type="text" class="inputTxt" name="last_name_" id="last_name_" value="фамилия"
        <%iif:<%getError:last_name_%>,,,style="background: #ff0;"%> onkeypress="this.style.background='#fff';display_hidden_fields(this.id)"
        onchange=""
/></td>
    <td>&nbsp;</td>
    <td width="310px">&nbsp;</td>
  </tr>
  <!-- END changed by kletsko -->

  <tr>
    <td align="right"><%e_cms_cons:Name%></td>
    <td>&nbsp;</td>
    <td><input type="text" class="inputTxt" name="first_name_" id="first_name_" value="<%:first_name_,0,0%>"
        <%iif:<%getError:first_name_%>,,,style="background: #ff0;"%> onkeypress="this.style.background='#fff';display_hidden_fields(this.id)"
        onchange=""
/></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr class="narrow">
    <td valign="top" align="right"><%e_cms_cons:Sex%></td>
    <td>&nbsp;</td>

    <td>
      <div id="reg_form_radio_buttons" <%iif:<%getError:sex_%>,,,class="error"%>>
        <div class="reg_form_radio">
          <input
              <%iif::sex_,1,checked%> type="radio" name="sex_" value="1" id="radioSexMale"
              onchange="display_hidden_fields()"
          />
        </div>

        <div class="reg_form_radio">
          <input 
              <%iif::sex_,0,checked%> type="radio" name="sex_" value="0" id="radioSexFemale"
              onchange="display_hidden_fields()"
          />
        </div>

      </div>

      <div id="reg_form_radio_lables">
        <div class="reg_form_radio_lable">
          <label id="forRadioSexMale" for="radioSexMale">
            <%e_cms_cons:Male%>
          </label>
        </div>
        <div class="reg_form_radio_lable">
          <label id="forRadioSexFemale" for="radioSexFemale">
            <%e_cms_cons:Female%>   
          </label>
        </div>
      </div>
    </td>

    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:Birthday%></td><td>&nbsp;</td>
    <td colspan="3">

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td>

      <input type="hidden" name="birth_date_" id="birth_date_" />
<div class="selection-list">
<select class="selector" name="birth_date_d" id="birth_date_d" onchange="display_hidden_fields();setBirthDate();"
	<%iif:<%getError:birth_date_%>,,,style="background: #ff0;"%>
>
<option value=""></option>
<%ap_numbers_to_options:1,31,<%:birth_date_d%>%>
</select></div>
    </td>
    <td>
    <div class="selection-list">
<select class="selector" name="birth_date_m" id="birth_date_m" onchange="display_hidden_fields();setBirthDate();"
	style="<%iif:<%getError:birth_date_%>,,,background: #ff0;%>"
>
<option value=""></option>
<%ap_numbers_to_options:1,12,<%:birth_date_m%>,ap_month_name%>
</select></div>
    </td>
      <td><div class="selection-list">
          <select class="selector" name="birth_date_y" id="birth_date_y" onchange="display_hidden_fields();setBirthDate();"
          <%iif:<%getError:birth_date_%>,,,style="background: #ff0;"%>
          >
          <option value=""></option>
          <%ap_numbers_to_options:<%tpl_sub:<%date:Y%>,75%>,<%tpl_sub:<%date:Y%>,12%>, <%:birth_date_y%>,,1%>
          </select></div>
      </td>
  </tr>
</table>

    </td>
</tr>

  <tr>
    <td colspan="5" style="padding-left: 60px;" valign="bottom"><%e_cms_cons:Address%>
    </td>

  </tr>

  <tr>
    <td align="right"><%e_cms_cons:District%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:KYIV_&_SEVASTOPOL%>
      <select class="selector <%iif:<%getError:district_id_%>,,,selector_error%>" name="district_id_" id="selector_district_id" onchange="display_hidden_fields();getOptions('region', this);"
	<%iif:<%getError:district_id_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:KYIV_&_SEVASTOPOL%>"
      >
        <%ap_select_district_options:<%:district_id_%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%e_cms_cons:Region%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Use other-option to enter own value%>
      <select class="selector <%iif:<%getError:region_%>,,,selector_error%>" name="region_" id="selector_region" onchange="display_hidden_fields();getOptions('city', this);"
	<%iif:<%getError:region_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:Use other-option to enter own value%>"
      >
        <%ap_select_region_options:<%:district_id_%>,<%:region_,0,0%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>
        &nbsp;
    </td>
  </tr>
  <tr>
    <td align="right"><%e_cms_cons:City%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Use other-option to enter own value%>
      <select class="selector <%iif:<%getError:city_%>,,,selector_error%>" name="city_" id="selector_city" onchange="display_hidden_fields();"
	<%iif:<%getError:city_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:Use other-option to enter own value%>"
      >
        <%ap_select_city_options:<%:region_%>,<%:city_,0,0%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>
        &nbsp;
    </td>
  </tr>

  <tr class="narrow">
    <td><%inv:120%></td>
    <td><%inv:5%></td>
    <td><%inv:175%></td>
    <td><%inv:5%></td>
    <td><%inv:125%></td>
  </tr>


  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:Cellular phone%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Enter phone number with code (10 digits)%>
      <input
        type="text"
	class="inputTxt"
	name="cell_phone_number_"
	value="<%:cell_phone_number_%>"
        <%iif:<%getError:cell_phone_number_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms_cons:Enter phone number with code (10 digits)%>"
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr class="narrow">
    <td><%inv:120%></td>
    <td><%inv:5%></td>
    <td><%inv:175%></td>
    <td><%inv:5%></td>
    <td><%inv:125%></td>
  </tr>

  <tr>
    <td align="right"><%e_cms_cons:E-mail%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Enter e-mail in standart format%>
      <input
        type="text"
        class="inputTxt"
        name="email_"
        value="<%:email_%>"
        <%iif:<%getError:email_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms_cons:Enter e-mail in standart format%>"
      />

    </td>
    <td>&nbsp;</td>


    <td>&nbsp;</td>
  </tr>


  <tr class="narrow">
    <td><%inv:105%></td>
    <td><%inv:5%></td>
    <td><%inv:175%></td>
    <td><%inv:5%></td>
    <td><%inv:125%></td>
  </tr>
