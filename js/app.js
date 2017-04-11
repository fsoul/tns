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
       $('input[name="sex_"').val(0);
    });

    $('.step5').click(function(e){
        var $email = $('input[name="email_"]');
        var $phone = $('input[name="cell_phone_number_"]');
        var isValidEmail = validateEmail($email.val());
        var isValidPhone = $phone.val().length === 10;
        console.log('valPhone--> '+isValidPhone);

        if(!isValidEmail){
            $email.addClass('error-input');
        }else{
            $email.removeClass('error-input');
        }
        if(!isValidPhone){
            $phone.addClass('error-input');
        }else{
            $phone.removeClass('error-input');
        }

        if(isValidEmail && isValidPhone)
        {
            return visibleNextWindow;
        }else{
            e.preventDefault();
            e.stopPropagation();
        }
    });

    $('.step6').click(function(e){
        var $pass = $('input[name="password"]');
        var $passConfirm = $('input[name="password_confirm"]');
        var lang = ($('.lang-item').text()).trim();
        var msg;
        console.log(lang);

        if($pass.val() == $passConfirm.val() && $pass.val().length >= 6 ){
            return visibleNextWindow;
        }else{
            if(!($pass.val().length >= 6 ))
            {
               if(lang == 'UA'){
                    msg = '* Мінімальний пароль 6 символів';
               }else {
                   msg = '* Минимальный пароль 6 символов';
               }
               $('.massage-error').text(msg).css('visibility', 'visible');
                console.log('little pass');

            }

            if(!($pass.val() == $passConfirm.val())){
                if(lang == 'UA'){
                    msg = '* Паролі не збігаються';
                }else {
                    msg = '* Пароли не совпадают';
                }
                $('.massage-error').text(msg).css('visibility', 'visible');
                console.log('not equal');
            }

            e.preventDefault();
            e.stopPropagation();
        }



    });

    $('#selector_street').change(function(){
        console.log($(this).prop('selectedIndex'));
    });

    $('.step7').click(function(e) {
        var $code = $('input[name="respondent_fields_captcha_code"]');
        var sel_str = $('#selector_street').prop('selectedIndex');
        var chek = $('#checkboxConfirm').prop("checked");

        $.ajax({
            type: "GET",
            url: "http://devopros.macc.com.ua/action.php?action=ajax_check_captcha",
            data: "code=" + $code.val()
        }).done(function (response) {
            res = JSON.parse(response);
            console.log('json: ' + res.code);
            console.log('json: ' + res.captcha);
            if(!res.captcha){
                $code.addClass('error-input');
                e.preventDefault();
                e.stopPropagation();
            }else if(sel_str == 0){
                console.log('err select');
            }else if(!chek){
                console.log('err chek');
            } else{
                $('#mob_reg').submit();
            }
        });

    });

    $('#phone_number').mask("0000000000", {
        onKeyPress: function(cep, event, currentField, options){
            console.log('An key was pressed!:', cep, ' event: ', event,
                'currentField: ', currentField, ' options: ', options);
            console.log(currentField[0].value[0]);
            if(currentField[0].value[0] != 0 ) {
                console.log('not null');
            }
        },
        onComplete: function(cep) {
            console.log('CEP Completed!:' + cep);
        },
    });
    if($('#tns_id').val() == '') $('#tns_id').val(window["IDCore"].getId());
});

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}