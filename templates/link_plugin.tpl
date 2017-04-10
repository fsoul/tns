<script>
    $(function(){
        get_plugin_id(function(plid){
            console.log('fire standart');
            var tnsid = null;
            window["IDCore"].addOnReadyListener(function(id) {
                tnsid = id;
                $.get(
                    "<%:EE_HTTP%>action.php",
                    {action:"link_plugin_id",id_resp:"<%ap_get_respondent_id%>",id_pl:plid,tns_id:tnsid},
                    function(){}
                );
            });
            window["IDCore"].init();
            $("#confirm_button").removeClass("disabled").bind("click",function(){
                document.forms["internal_login_form"].submit();
            });
        },function(){
            $("#plugin_success").hide();
            $("#plugin_error").show();
            clearCheckAddon();
        });
    });
    (function (success, error) {
        var timeout, i=0 ;
        function checkAddon() {
            if ("addonCMeter" in window || sessionStorage.getItem('AddonCMeterMain') != undefined) {
                $("#plugin_error").hide();
                $("#plugin_success").show();
                clearInterval(timeout);
                setTimeout(function () {
                    sessionStorage.removeItem('AddonCMeterMain');
                }, 2000)
            }
        }
        window.clearCheckAddon =  function () { clearInterval(timeout); };
        timeout = setInterval(checkAddon, 100); })('#plugin_succes', '#plugin_error');
</script>