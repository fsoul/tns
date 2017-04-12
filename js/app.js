var App;

App = (function () {
    var registerBlocks = document.getElementsByClassName('main-wrap');
    var positionWrap = 0;

    /* function show/hide window registration */
    var visibleNextWindow = function visibleNextWindow(event) {
        var target = event.target;

        if (!target.classList.contains('click-next-window')) {
            return false;
        }

        validate(registerBlocks[positionWrap]);

        if (validate(registerBlocks[positionWrap])) {
            return visibleNextWindow;
        } else {
            if (positionWrap >= registerBlocks.length-1) {
                console.log('Реестрацію завершено');
                $('#mob_reg').submit();
                return visibleNextWindow;
            }

            registerBlocks[positionWrap].classList.remove('active-main-wrap');
            positionWrap = positionWrap + 1;
            registerBlocks[positionWrap].classList.add('active-main-wrap');
        }

        event.preventDefault();
        event.stopPropagation();
    };
    /* END function show/hide window registration */

    /* Reset error */
    var resetError = function resetError(resetElem) {
        resetElem.classList.remove('error-input');

        var a = resetElem.getAttribute('placeholder');
        resetElem.setAttribute('placeholder', a);
    };
    /* END Reset error */

    /* validate form */
    var validate = function validate(validateParentElem) {
        var massageError = validateParentElem.querySelector('.massage-error');
        var inputElem = validateParentElem.querySelectorAll('input, select');
        var hasError = false;

        for (var i = 0; i < inputElem.length; i++) {
            var check = inputElem[i];

            resetError(inputElem[i]);

            if (validateParentElem.classList.contains('main-registration-confirmation')) {
                var inputConfirmation = validateParentElem.querySelector('#checkboxConfirm').checked;
                var labelConfirmation = validateParentElem.querySelector('.label-input-hidden');

                if(!inputConfirmation) {
                    labelConfirmation.classList.add('error-input');
                    massageError.style.visibility = 'visible';
                    hasError = true;
                } else {
                    labelConfirmation.classList.remove('error-input');
                    massageError.style.visibility = 'visible';
                }
            }

            if(check.type === 'checkbox') {
                if (!check.checked) hasError = true;
            }

            if (!inputElem[i].value || inputElem[i].value == '') {
                console.log(inputElem[i].value);
                inputElem[i].classList.add('error-input');
                massageError.style.visibility = 'visible';
                hasError = true;
            }

        }

        return hasError;
    };
    /* END validate form */

    /*  event add elements */
    if (window.addEventListener){
        window.addEventListener('click', visibleNextWindow);
    } else if (window.attachEvent){
        window.attachEvent('click', visibleNextWindow);
    } else {
        window.onclick = visibleNextWindow;
    }
    /*  END event add elements */

})();

$(document).ready(function(){
    $('.lang-item').click(function () {
        $('.lang-drop').toggle(500);
    });

    $('.img-woman').click(function () {
       $('input[name="sex_"]').val(0);
    });

    $('.step5').click(function(e){
        var $email = $('input[name="email_"]');
        var $phone = $('input[name="cell_phone_number_"]');
        var isValidEmail = validateEmail($email.val());
        var isValidPhone = $phone.val().length === 10;

        if(!isValidEmail){
            $email.addClass('error-input');
            e.preventDefault();
            e.stopPropagation();
        }else{
            $email.removeClass('error-input');
        }
        if(!isValidPhone){
            $phone.addClass('error-input');
            e.preventDefault();
            e.stopPropagation();
        }else{
            $phone.removeClass('error-input');
        }

    });

    $('.step6').click(function(e){
        var $pass = $('input[name="password"]');
        var $passConfirm = $('input[name="password_confirm"]');
        var lang = ($('.lang-item').text()).trim();
        var msg;

        $('.massage-error').css('visibility', 'hidden');

        if(!($pass.val().length >= 6 ))
        {
            if(lang == 'UA'){
                msg = '* Мінімальний пароль 6 символів';
            }else {
               msg = '* Минимальный пароль 6 символов';
            }
            $('.massage-error').text(msg).css('visibility', 'visible');
            $pass.addClass('error-input');
            //console.log('little pass');
            e.preventDefault();
            e.stopPropagation();
        }

        if(!($pass.val() == $passConfirm.val())){
            if(lang == 'UA'){
                msg = '* Паролі не збігаються';
            }else {
                msg = '* Пароли не совпадают';
            }
            $('.massage-error').text(msg).css('visibility', 'visible');
            $pass.addClass('error-input');
            $passConfirm.addClass('error-input');
            //console.log('not equal');
            e.preventDefault();
            e.stopPropagation();
        }
    });

    $('.step7').click(function(e) {

        e.preventDefault();
        e.stopPropagation();
        var $code = $('input[name="respondent_fields_captcha_code"]');
        var sel_str = $('#selector_street').prop('selectedIndex');
        var chek = $('#checkboxConfirm').prop("checked");

        $.ajax({
            type: "GET",
            url: "http://devopros.macc.com.ua/action.php?action=ajax_check_captcha",
            data: "code=" + $code.val()
        }).done(function (response) {
            res = JSON.parse(response);
            //console.log('json: ' + res.code);
            //console.log('json: ' + res.captcha);
            if(sel_str == 0){
                //console.log('err select');
                $('#selector_street').addClass('error-input');
            }else if(!res.captcha){
                $code.addClass('error-input');
                $('#cap_redraw').trigger('click');
            }else if(!chek){
                $('.label-input-hidden').addClass('error-input');
                //console.log('err chek');
            } else{
                if($('#tns_id').val() == '') $('#tns_id').val(window["IDCore"].getId());
                $('#mob_reg').submit();
            }
        });

    });

    $('.inputTxt, .checkboxConfirm').on('change keypress', function () {
        $(this).removeClass('error-input');
        $('.label-input-hidden').removeClass('error-input');
        $('.massage-error').css('visibility', 'hidden');
    });

    $('#phone_number').mask("zo00000000", {
        translation: {
            'z': {
                pattern: /0/,
                fallback: '0'
            },
            'o': {
                pattern: /5|6|7|9/
            }
        },
        clearIfNotMatch: true
    });
    
    $('.click-next-window').click(function () {
        $('#page_error').hide();
    });
});

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}