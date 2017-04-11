<%set_allowed_uri_params_list:reffer_email_%>

<%ap_process_registration_form%>

<%include:header%>


<%include:ap_ajax_selectors%>

<script type="text/javascript" src="<%:EE_HTTP%>js/respondent.js"></script>
<script type="text/javascript" src="<%:EE_HTTP%>js/jquery.mask.js"></script>




<%include:page_error%>
<form action="" method="post" name="registration" class="registration-form" id="mob_reg">
    <input type="hidden" name="tns_id" id="tns_id" value="">
    <%setValueOf:respondent_id_,0%>
    <!-- main content page (name and last name) -->
    <div class="main-wrap active-main-wrap">

        <div class="int_b_content">
            <input type="text" class="inputTxt" name="last_name_" id="last_name_" value="" placeholder="<%e_cms_cons:Family%>" onkeypress="this.style.background='#fff';display_hidden_fields(this.id)" onchange="">
        </div>


        <div class="int_b_content">
            <input type="text" class="inputTxt" name="first_name_" id="first_name_" value="" placeholder="<%e_cms_cons:Name%>" onkeypress="this.style.background='#fff';display_hidden_fields(this.id)" onchange="">
        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* �������� ������ ���,* ��������� ��������� ������%></div>

        <a class="button button-click click-next-window"><%iif::language,UA,���,�����%></a>

    </div><!-- END main content page (name and last name) -->



    <!-- main content page (floor) -->
    <div class="main-wrap floor-wrap">

        <div class="int_b_content">

            <div class="page-caption floor-block-caption"><%iif::language,UA,������ �����,������� ���%></div>
            <input type="hidden" name="sex_" value="1">
            <div class="mens-floor">
                <img src="/css/images/man.png" class="img-man click-next-window" alt="������">
                <div class="borfer-floor"></div>
                <img src="/css/images/women.png" class="img-woman click-next-window" alt="Ƴ���">
            </div>

        </div>

    </div><!-- END main content page (floor)-->


    <!-- main content page (birthday) -->
    <div class="main-wrap">

        <div class="int_b_content">

            <select class="inputTxt" name="birth_date_d" id="birth_date_d"
                    onchange="display_hidden_fields();setBirthDate();">
                <option value="" selected><%e_cms_cons:Birthday%></option>
                <%ap_numbers_to_options:1,31,<%:birth_date_d%>%>
            </select>

        </div>


        <div class="int_b_content">

            <select class="inputTxt" name="birth_date_m" id="birth_date_m"
                    onchange="display_hidden_fields();setBirthDate();" style="">
                <option value="" selected><%iif::language,UA,̳���� ����������, ����� ��������%></option>
                <%ap_numbers_to_options:1,12,<%:birth_date_m%>,ap_month_name%>
                <!--<option value="1">ѳ����</option>
                <option value="2">�����</option>
                <option value="3">��������</option>
                <option value="4">������</option>
                <option value="5">�������</option>
                <option value="6">�������</option>
                <option value="7">������</option>
                <option value="8">�������</option>
                <option value="9">��������</option>
                <option value="10">�������</option>
                <option value="11">��������</option>
                <option value="12">�������</option>-->
            </select>

        </div>

        <div class="int_b_content">

            <select class="inputTxt" name="birth_date_y" id="birth_date_y"
                    onchange="display_hidden_fields();setBirthDate();">
                <option value="" selected><%iif::language,UA,г� ����������,��� ��������%></option>

                <%ap_numbers_to_options:<%tpl_sub:<%date:Y%>,75%>,<%tpl_sub:<%date:Y%>,12%>, <%:birth_date_y%>,,1%>
            </select>

        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* �������� ������ ���,* ��������� ��������� ������%></div>

        <a class="button button-click click-next-window"><%iif::language,UA,���,�����%></a>

    </div><!-- END main content page (birthday)-->




    <!-- main content page (habitation) -->
    <div class="main-wrap">

        <div class="int_b_content">

            <select class="inputTxt " name="district_id_" id="selector_district_id"
                    onchange="display_hidden_fields();getOptions('region', this);"
                    title="<%cms_cons:KYIV_&_SEVASTOPOL%>">

                <option value="" selected><%e_cms_cons:District%></option>
                <option value="3">�����-����������</option>
                <option value="47">�� ����</option>
                <option value="21">³�������</option>
                <option value="31">���������</option>
                <option value="30">���������������</option>
                <option value="29">��������</option>
                <option value="28">�����������</option>
                <option value="27">������������</option>
                <option value="26">���������</option>
                <option value="25">ʳ������������</option>
                <option value="2">���</option>
                <option value="24">�������</option>
                <option value="23">���������</option>
                <option value="22">��������</option>
                <option value="45">�����������</option>
                <option value="44">�������</option>
                <option value="43">����������</option>
                <option value="63">г��������</option>
                <option value="62">�������</option>
                <option value="61">������������</option>
                <option value="86">���������</option>
                <option value="85">����������</option>
                <option value="84">�����������</option>
                <option value="83">���������</option>
                <option value="82">����������</option>
                <option value="81">����������</option>
            </select>

        </div>

        <div class="int_b_content">

            <select class="inputTxt " name="region_" id="selector_region"
                    onchange="display_hidden_fields();getOptions('city', this);"
                    title="������������� ������� 'I���� ���i���' ��� ������ ����� ������i���">
                <option value="...">...</option>
            </select>

        </div>

        <div class="int_b_content">

            <select class="inputTxt " name="city_" id="selector_city" onchange="display_hidden_fields();"
                    title="������������� ������� 'I���� ���i���' ��� ������ ����� ������i���">
                <option value="...">...</option>
            </select>

        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* �������� ������ ���,* ��������� ��������� ������%></div>

        <a class="button button-click click-next-window"><%iif::language,UA,�� � �������������,��� � �������������%></a>

    </div><!-- END main content page (habitation)-->



    <!-- main content page (contact-data) -->
    <div class="main-wrap">

        <div class="int_b_content">
            <input type="text" class="inputTxt" name="email_" value="" placeholder="Email"
                   title="����i�� e-mail � ������������������ ������i (� �@� - �������� �� �.�- ���������)">
        </div>

        <div class="int_b_content">
            <input id="phone_number" type="text" class="inputTxt" name="cell_phone_number_" value="" placeholder="<%iif::language,UA,�������� ,���������  %> �������"
                   title="����i�� ����� �������� � ����� (10 ����) ��� ���������� ������� (�����, ������, ����, ������)." >
        </div>

        <div class="page-caption number-description"><%iif::language,UA,����� � ������,����� � �������%> 0675258236</div>

        <div class="massage-error page-caption"><%iif::language,UA,* �������� ������ ���,* ��������� ��������� ������%></div>

        <a class="step5 button button-click click-next-window"><%iif::language,UA,�� �����,��� �������%></a>

    </div><!-- END main content page (contact-data)-->



    <!-- main content page (password) -->
    <div class="main-wrap">

        <div class="int_b_content">
            <input type="password" class="inputTxt" name="password" placeholder="������"
                   title="������ �� ���� ��������� �� �����, �� 6 �������.">
        </div>

        <div class="int_b_content">
            <input type="password" class="inputTxt" name="password_confirm" placeholder="<%iif::language,UA,ϳ���������,�����������%> ������"
                   title="������ �� ���� ��������� �� �����, �� 6 �������.">
        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* �������� ������ ���,* ��������� ��������� ������%></div>

        <a class="step6 button button-click click-next-window"><%iif::language,UA,���� �����,����� ������%></a>

    </div><!-- END main content page (password)-->


    <!-- main content page (confirmation) -->
    <div class="main-wrap main-registration-confirmation">

        <div class="int_b_content">

            <select class="inputTxt" name="know_about_" id="selector_street"
                    onchange="display_hidden_fields();displayOther(this);"
                    title="������������� ������� 'I���� ���i���' ��� ������ ����� ������i���">
                <option value="" selected>����� �� ��� ��� ��������</option>
                <option value="1">ĳ������ � ���������� �������</option>
                <option value="2">�������� ��������</option>
                <option value="3">�������� ���������� ������� TNS</option>
                <option value="4">������� � ��������</option>
                <option value="5">��������� ������� ����</option>
                <option value="-">���� (��������)</option>
            </select>

        </div>

        <div class="int_b_content entry-password-img">
            <%setValueOf:captcha_name,respondent_fields_captcha_code%>

            <div>
                <script type="text/javascript" language="JavaScript" src="<%:EE_HTTP%>js/captcha.js"></script>

                <img alt="<%getValueOf:respondent_fields_captcha_code%>" title="" class="captcha_img" id="img_<%iif::captcha_name,,captcha_code,:captcha_name%>" src="<%:EE_HTTP%>action.php?action=show_captcha&rndmz=<%:rndmz_for_captcha%>" />

                <p class="cap_redraw">
                    <a class="pointer" onclick="imgRefresh('img_<%iif::captcha_name,,captcha_code,:captcha_name%>');"><%cms_cons:Redraw%></a>
                </p>
            </div>




            <input
                    placeholder="<%iif::language,UA,������ �����,������� �������%>"
                    type="text"
                    name="respondent_fields_captcha_code"
                    autocomplete="off"
                    class="inputTxt set-img-password cap_inp"
            />

        </div>


        <div class="int_b_content input-checkbox">
            <input type="checkbox" id="checkboxConfirm" class="check-in" name="checkboxConfirm">
            <label for="checkboxConfirm" class="label-input-hidden"></label>
            <%iif::language,UA,<span class="page-caption">� ���������� ������������ � <a href="/UA/Pravyla-uchasti.html" target="_blank" class="familiariz">��������� �����</a> �� <a href="/UA/Vidpovidalnist.html" target="_blank" class="familiariz">��������� ������������ ����������</a> �� �� ��� ���������� ���� �� �����.</span>, <span class="page-caption">� ����������� ������������ � <a href="/UA/Pravyla-uchasti.html" target="_blank" class="familiariz">��������� �������</a> � <a href="/UA/Vidpovidalnist.html" target="_blank" class="familiariz">��������� ������������� ����������</a> � �� ���� ���������� ���������� �� ����������.</span>%>
        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* �������� ������ ���,* ��������� ��������� ������%></div>

        <a class="step7 button button-click click-next-window subm" ><%iif::language,UA,³����!,�����������!%></a>

    </div><!-- END main content page (confirmation)-->

</form><!-- END registration form -->
<%longtext_edit_page_cms:email_subject%>
<%longtext_edit_page_cms:email_body%>