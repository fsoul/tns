


  <tr>
    <td><img src="<%:EE_HTTP%>/img/inv.gif" width="120" height="0"></td>
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

  <tr> 
    <td width="180px" align="right"><%e_cms_cons:Family%></td>
    <td>&nbsp;</td>
    <td width="175px"><input type="text" class="inputTxt" name="last_name_" id="last_name_" value="<%:last_name_,0,0%>"
        <%iif:<%getError:last_name_%>,,,style="background: #ff0;"%> onkeypress="this.style.background='#fff';display_hidden_fields(this.id)"
        onchange=""
/></td>
    <td>&nbsp;</td>
    <td width="310px">&nbsp;</td>
  </tr>

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
    <td>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td>

      <input type="hidden" name="birth_date_" id="birth_date_" />

<select class="selector" name="birth_date_d" id="birth_date_d" onchange="display_hidden_fields();setBirthDate();"
	<%iif:<%getError:birth_date_%>,,,style="background: #ff0;"%>
>
<option value=""></option>
<%ap_numbers_to_options:1,31,<%:birth_date_d%>%>
</select>
    </td>
    <td align="right">
<select class="selector" name="birth_date_m" id="birth_date_m" onchange="display_hidden_fields();setBirthDate();"
	style="float:right; clear:both; <%iif:<%getError:birth_date_%>,,,background: #ff0;%>"
>
<option value=""></option>
<%ap_numbers_to_options:1,12,<%:birth_date_m%>,ap_month_name%>
</select>
    </td>
  </tr>
</table>

    </td>
    <td>&nbsp;</td>
    <td>
<select class="selector" name="birth_date_y" id="birth_date_y" onchange="display_hidden_fields();setBirthDate();"
	<%iif:<%getError:birth_date_%>,,,style="background: #ff0;"%>
>
<option value=""></option>
<%ap_numbers_to_options:<%tpl_sub:<%date:Y%>,75%>,<%tpl_sub:<%date:Y%>,12%>,<%:birth_date_y%>,,1%>
</select>
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
      <select class="selector" name="district_id_" id="selector_district_id" onchange="display_hidden_fields();getOptions('region', this);"
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
      <select class="selector" name="region_" id="selector_region" onchange="display_hidden_fields();getOptions('city', this);"
	<%iif:<%getError:region_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:Use other-option to enter own value%>"
      >
        <%ap_select_region_options:<%:district_id_%>,<%:region_,0,0%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>
      <input
	<%iif:<%getError:region_other_%>,,,style="background: #ff0;"%>
	type="text" class="inputTxtShort" name="region_other" id="input_region_other" <%iif::display_region_other,1,value="<%iif:<%:region_other,0,0%>,,<%iif:<%:region_,0,0%>,<%:OPTION_VALUE_OTHER%>,,<%:region_,0,0%>%>,<%:region_other,0,0%>%>",style="display:none"%> />
    </td>
  </tr>
  <tr>
    <td align="right"><%e_cms_cons:City%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Use other-option to enter own value%>
      <select class="selector" name="city_" id="selector_city" onchange="display_hidden_fields();"
	<%iif:<%getError:city_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:Use other-option to enter own value%>"
      >
        <%ap_select_city_options:<%:region_%>,<%:city_,0,0%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>
      <input
	<%iif:<%getError:city_other_%>,,,style="background: #ff0;"%>
	type="text" class="inputTxtShort" name="city_other" id="input_city_other"  <%iif::display_city_other,1,value="<%iif:<%:city_other,0,0%>,,<%iif:<%:city_,0,0%>,<%:OPTION_VALUE_OTHER%>,,<%:city_,0,0%>%>,<%:city_other,0,0%>%>",style="display:none"%> />
    </td>
  </tr>
  <!--tr>
    <td align="right"><%e_cms_cons:Settlement%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Use other-option to enter own value%>
      <select class="selector" name="settlement_" id="selector_settlement" onchange="display_hidden_fields();getOptions('street', this);"
	<%iif:<%getError:settlement_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:Use other-option to enter own value%>"
      >
        <%ap_select_settlement_options:<%:city_%>,<%:settlement_,0,0%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>
      <input
	<%iif:<%getError:settlement_other_%>,,,style="background: #ff0;"%>
	type="text" class="inputTxtShort" name="settlement_other" id="input_settlement_other" <%iif::display_settlement_other,1,value="<%iif:<%:settlement_other,0,0%>,,<%iif:<%:settlement_,0,0%>,<%:OPTION_VALUE_OTHER%>,,<%:settlement_,0,0%>%>,<%:settlement_other,0,0%>%>",style="display:none"%> />
    </td>
  </tr>
  <tr>
    <td align="right"><%e_cms_cons:Street%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Use other-option to enter own value%>
      <select class="selector" name="street_" id="selector_street" onchange="display_hidden_fields();displayOther(this);"
	<%iif:<%getError:street_%>,,,style="background: #ff0;"%>
	title="<%cms_cons:Use other-option to enter own value%>"
      >
        <%ap_select_street_options:<%:settlement_%>,<%:street_,0,0%>%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td>
      <input
	<%iif:<%getError:street_other_%>,,,style="background: #ff0;"%>
	type="text" class="inputTxtShort" name="street_other" id="input_street_other" <%iif::display_street_other,1,value="<%iif:<%:street_other,0,0%>,,<%iif:<%:street_,0,0%>,<%:OPTION_VALUE_OTHER%>,,<%:street_,0,0%>%>,<%:street_other,0,0%>%>",style="display:none"%> />
    </td>
  </tr>
  <tr>
    <td align="right"><%e_cms_cons:House%></td>
    <td>&nbsp;</td>
    <td>
      <input type="text" class="inputTxtShort" name="house_" id="house_" value="<%:house_,0,0%>"
	onkeypress="this.style.background='#fff';display_hidden_fields(this.id)"
	onchange=""
	<%iif:<%getError:house_%>,,,style="background: #ff0;"%>
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td align="right"><%e_cms_cons:Flat%></td>
    <td>&nbsp;</td>
    <td>
      <input type="text" class="inputTxtShort" name="flat_" id="flat_" value="<%:flat_,0,0%>"
	onkeypress="this.style.background='#fff';display_hidden_fields(this.id)"
	onchange=""
	<%iif:<%getError:flat_%>,,,style="background: #ff0;"%>
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr -->

  <tr class="narrow">
    <td><%inv:120%></td>
    <td><%inv:5%></td>
    <td><%inv:175%></td>
    <td><%inv:5%></td>
    <td><%inv:125%></td>
  </tr>

<!--/table>

<table id="respondent_edit_form2" border="0" <%iif::page_file,ap_respondent_register_form,<%iif:<%count_post:%>,0,style="display:none"%>%>>

  <tr class="narrow_text">
    <td align="right"><%e_cms_cons:City phone%></td>
    <td>&nbsp;</td>
    <td><%text_edit_cms_cons:Enter phone number with code (10 digits)%>
      <input
        type="text"
        class="inputTxt"
        name="city_phone_number_"
        value="<%:city_phone_number_%>"
        <%iif:<%getError:city_phone_number_%>,,,style="background: #ff0;" onkeypress="this.style.background='#fff';"%>
	title="<%cms_cons:Enter phone number with code (10 digits)%>"
      />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  -->
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
