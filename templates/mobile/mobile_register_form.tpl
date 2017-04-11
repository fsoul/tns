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

        <div class="massage-error page-caption"><%iif::language,UA,* Перевірте вказані дані,* Проверьте указанные данные%></div>

        <a class="button button-click click-next-window"><%iif::language,UA,Далі,Далее%></a>

    </div><!-- END main content page (name and last name) -->



    <!-- main content page (floor) -->
    <div class="main-wrap floor-wrap">

        <div class="int_b_content">

            <div class="page-caption floor-block-caption"><%iif::language,UA,Вкажіть стать,Укажите пол%></div>
            <input type="hidden" name="sex_" value="1">
            <div class="mens-floor">
                <img src="/css/images/man.png" class="img-man click-next-window" alt="Чоловік">
                <div class="borfer-floor"></div>
                <img src="/css/images/women.png" class="img-woman click-next-window" alt="Жінка">
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
                <option value="" selected><%iif::language,UA,Місяць народження, Месяц рождения%></option>
                <%ap_numbers_to_options:1,12,<%:birth_date_m%>,ap_month_name%>
                <!--<option value="1">Січень</option>
                <option value="2">Лютий</option>
                <option value="3">Березень</option>
                <option value="4">Квітень</option>
                <option value="5">Травень</option>
                <option value="6">Червень</option>
                <option value="7">Липень</option>
                <option value="8">Серпень</option>
                <option value="9">Вересень</option>
                <option value="10">Жовтень</option>
                <option value="11">Листопад</option>
                <option value="12">Грудень</option>-->
            </select>

        </div>

        <div class="int_b_content">

            <select class="inputTxt" name="birth_date_y" id="birth_date_y"
                    onchange="display_hidden_fields();setBirthDate();">
                <option value="" selected><%iif::language,UA,Рік народження,Год рождения%></option>

                <%ap_numbers_to_options:<%tpl_sub:<%date:Y%>,75%>,<%tpl_sub:<%date:Y%>,12%>, <%:birth_date_y%>,,1%>
            </select>

        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* Перевірте вказані дані,* Проверьте указанные данные%></div>

        <a class="button button-click click-next-window"><%iif::language,UA,Далі,Далее%></a>

    </div><!-- END main content page (birthday)-->




    <!-- main content page (habitation) -->
    <div class="main-wrap">

        <div class="int_b_content">

            <select class="inputTxt " name="district_id_" id="selector_district_id"
                    onchange="display_hidden_fields();getOptions('region', this);"
                    title="<%cms_cons:KYIV_&_SEVASTOPOL%>">

                <option value="" selected><%e_cms_cons:District%></option>
                <option value="3">Івано-Франківська</option>
                <option value="47">АР Крим</option>
                <option value="21">Вінницька</option>
                <option value="31">Волинська</option>
                <option value="30">Дніпропетровська</option>
                <option value="29">Донецька</option>
                <option value="28">Житомирська</option>
                <option value="27">Закарпатська</option>
                <option value="26">Запорізька</option>
                <option value="25">Кіровоградська</option>
                <option value="2">Київ</option>
                <option value="24">Київська</option>
                <option value="23">Луганська</option>
                <option value="22">Львівська</option>
                <option value="45">Миколаївська</option>
                <option value="44">Одеська</option>
                <option value="43">Полтавська</option>
                <option value="63">Рівненська</option>
                <option value="62">Сумська</option>
                <option value="61">Тернопільська</option>
                <option value="86">Харківська</option>
                <option value="85">Херсонська</option>
                <option value="84">Хмельницька</option>
                <option value="83">Черкаська</option>
                <option value="82">Чернівецька</option>
                <option value="81">Чернігівська</option>
            </select>

        </div>

        <div class="int_b_content">

            <select class="inputTxt " name="region_" id="selector_region"
                    onchange="display_hidden_fields();getOptions('city', this);"
                    title="Скористайтесь пунктом 'Iнший варiант' щоб ввести назву самостiйно">
                <option value="...">...</option>
            </select>

        </div>

        <div class="int_b_content">

            <select class="inputTxt " name="city_" id="selector_city" onchange="display_hidden_fields();"
                    title="Скористайтесь пунктом 'Iнший варiант' щоб ввести назву самостiйно">
                <option value="...">...</option>
            </select>

        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* Перевірте вказані дані,* Проверьте указанные данные%></div>

        <a class="button button-click click-next-window"><%iif::language,UA,От й познайомилися,Вот и познакомились%></a>

    </div><!-- END main content page (habitation)-->



    <!-- main content page (contact-data) -->
    <div class="main-wrap">

        <div class="int_b_content">
            <input type="text" class="inputTxt" name="email_" value="" placeholder="Email"
                   title="Введiть e-mail у загальноприйнятому форматi (з “@” - собачкою та “.”- крапочкою)">
        </div>

        <div class="int_b_content">
            <input id="phone_number" type="text" class="inputTxt" name="cell_phone_number_" value="" placeholder="<%iif::language,UA,Мобільний ,Мобильный  %> телефон"
                   title="Введiть номер телефону з кодом (10 цифр) без нецифрових символів (дужок, крапок, тире, пробілів)." >
        </div>

        <div class="page-caption number-description"><%iif::language,UA,Номер у форматі,Номер в формате%> 0675258236</div>

        <div class="massage-error page-caption"><%iif::language,UA,* Перевірте вказані дані,* Проверьте указанные данные%></div>

        <a class="step5 button button-click click-next-window"><%iif::language,UA,Ще трохи,Еще немного%></a>

    </div><!-- END main content page (contact-data)-->



    <!-- main content page (password) -->
    <div class="main-wrap">

        <div class="int_b_content">
            <input type="password" class="inputTxt" name="password" placeholder="Пароль"
                   title="Пароль має бути завдовжки не менше, ніж 6 символів.">
        </div>

        <div class="int_b_content">
            <input type="password" class="inputTxt" name="password_confirm" placeholder="<%iif::language,UA,Підтвердити,Подтвердить%> пароль"
                   title="Пароль має бути завдовжки не менше, ніж 6 символів.">
        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* Перевірте вказані дані,* Проверьте указанные данные%></div>

        <a class="step6 button button-click click-next-window"><%iif::language,UA,Дуже добре,Очень хорошо%></a>

    </div><!-- END main content page (password)-->


    <!-- main content page (confirmation) -->
    <div class="main-wrap main-registration-confirmation">

        <div class="int_b_content">

            <select class="inputTxt" name="know_about_" id="selector_street"
                    onchange="display_hidden_fields();displayOther(this);"
                    title="Скористайтесь пунктом 'Iнший варiант' щоб ввести назву самостiйно">
                <option value="" selected>Звідки Ви про нас дізнались</option>
                <option value="1">Дізнався в соціальних мережах</option>
                <option value="2">Запросив знайомий</option>
                <option value="3">Запросив співробітник коммпанії TNS</option>
                <option value="4">Реклама в Інтернеті</option>
                <option value="5">Самостійно знайшов сайт</option>
                <option value="-">Інше (запишіть)</option>
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
                    placeholder="<%iif::language,UA,Введіть напис,Введите надпись%>"
                    type="text"
                    name="respondent_fields_captcha_code"
                    autocomplete="off"
                    class="inputTxt set-img-password cap_inp"
            />

        </div>


        <div class="int_b_content input-checkbox">
            <input type="checkbox" id="checkboxConfirm" class="check-in" name="checkboxConfirm">
            <label for="checkboxConfirm" class="label-input-hidden"></label>
            <%iif::language,UA,<span class="page-caption">Я підтверджую ознайомлення з <a href="/UA/Pravyla-uchasti.html" target="_blank" class="familiariz">правилами участі</a> та <a href="/UA/Vidpovidalnist.html" target="_blank" class="familiariz">правилами використання інформації</a> та не маю заперечень щодо їх змісту.</span>, <span class="page-caption">Я подтверждаю ознакомление с <a href="/UA/Pravyla-uchasti.html" target="_blank" class="familiariz">правилами участия</a> и <a href="/UA/Vidpovidalnist.html" target="_blank" class="familiariz">правилами использования информации</a> и не имею возражений касательно их содержания.</span>%>
        </div>

        <div class="massage-error page-caption"><%iif::language,UA,* Перевірте вказані дані,* Проверьте указанные данные%></div>

        <a class="step7 button button-click click-next-window subm" ><%iif::language,UA,Вітаємо!,Поздравляем!%></a>

    </div><!-- END main content page (confirmation)-->

</form><!-- END registration form -->
<%longtext_edit_page_cms:email_subject%>
<%longtext_edit_page_cms:email_body%>