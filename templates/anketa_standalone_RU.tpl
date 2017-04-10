<script type="text/javascript">
    //jQuery(function($){
     //   $("#inputEnterPhone").mask("(999) 999-99-99");
    //});
    var resp_id,
    submit_form = function(findex){
        var error = false,
                fname = 'question'+findex,
                next = 'question'+(findex+1),
                curform = document.forms[fname],
                nextform = document.forms[next];
        if(findex>0 && findex<11) {
            if ((curform.answer == undefined || curform.answer.type == undefined) && $(curform).find('[name*=answer]:checked').length == 0) {
                error = 'Пожалуйста, выберите значение';
            } else if (curform.answer && curform.answer.type == 'text' && curform.answer.value == "") {
                error = 'Пожалуйста, введите значение';
            } else if (curform.answer && curform.answer.value == '...') {
                error = 'Пожалуйста, выберите значение';
            }
        }
        if (error) {
            alert(error);
            return false;
        }
        if(findex>0 && (typeof resp_id == undefined || !resp_id)) {
            return false;
        }
        if(findex ==0) {
            //var tid = new TnsId();
            window["IDCore"].addOnReadyListener(function(id) {
                if (curform['tns_id']) {
                    curform['tns_id'].value = id;
                }
            });
            window["IDCore"].init();
            if("addonCMeter" in window) {
                curform["pl_id"].value = addonCMeter.PLID;
            }
        }
        //document.forms[fname].submit();
        $.post("<%:EE_HTTP%>action.php", $(curform).serialize().replace('%5B%5D', '[]'),function(data){
            if(findex == 0) {
                resp_id = data.id;
                if(data.is_new==0)
                    nextform = document.forms['question12'];
            }
            if(findex == 3) {
                if(curform.answer.value == -1) {
                    nextform = document.forms['question13'];
                } else {
                    $.get("<%:EE_HTTP%>action.php?action=ap_select_city_options_from_region&filter_id="+curform.answer.value,
                        function(data){
                            $('#selector_city_id').html(data);
                        }
                    );
                }
            }
            if(findex == 4 && $(curform).find('[name=answer]:checked').val() > 1) {
                nextform = document.forms['question6'];
            }
            /*if(findex == 8 && $(curform).find('[name=answer]:checked').val() == 0) {
                nextform = document.forms['question10'];
            }
            if(findex == 9) {
                if($(curform).find('[name=answer]:checked').val() == 1)
                    nextform = document.forms['question11'];
                else
                    nextform = document.forms['question12'];
            }
            if(findex == 10) {
                nextform = document.forms['question12'];
            } */
            if(nextform) {
                if(nextform['resp_id']) nextform['resp_id'].value = resp_id;
                $(curform).hide();
                $(nextform).show();
            }
        },'json');
        return false;
    }
</script>
<div id="q_pages_wrapper">
<div id="q_pages">
    <div class="header"></div>
    <%include:anketa_standalone_ru/intro%>
    <%include:anketa_standalone_ru/question1%>
    <%include:anketa_standalone_ru/question2%>
    <%include:anketa_standalone_ru/question3%>
    <%include:anketa_standalone_ru/question4%>
    <%include:anketa_standalone_ru/question5%>
    <%include:anketa_standalone_ru/question6%>
    <%include:anketa_standalone_ru/question7%>
    <%include:anketa_standalone_ru/question8%>
    <%include:anketa_standalone_ru/question9%>
    <%include:anketa_standalone_ru/question10%>
    <%include:anketa_standalone_ru/question11%>
    <%include:anketa_standalone_ru/question12%>
    <%include:anketa_standalone_ru/question13%>
</div>
    </div>
