
<script type="text/javascript">
window.onload = function(){
    window["IDCore"].addOnReadyListener(function(id) {
        document.cookie = 'cmeter_id='+id;
        try {
            if( typeof showMmiForm == 'function' ){
                showMmiForm(id); 
            }
            if ("" != "<%ap_get_respondent_id%>") {
                window["IDCore"].send("http://pagestat.mmi.bemobile.ua/pagestat/PageStatEntry", {
                    "param1": "<%ap_get_respondent_id%>",
                    "param2" : -1,
                    "param3": 2
                });
                get_plugin_id(function(plid){try_show_popup("<%ap_get_respondent_id%>",id,plid)},function(){try_show_popup("<%ap_get_respondent_id%>",id,0)});

            } else if ("ap_respondent_register_form" == "<%:page_file%>") {
            //} else if (document.getElementById('tns_id')) {
                document.getElementById('tns_id').value = id;
            }
            document.getElementById('login_cookie').value = id;
            console.log('login_cookie set_ '+id);
        } catch(e) {
            console.log(e);
        }

        var i=3;
        function setPLID(){
            try{
                get_plugin_id(function(plid){document.getElementById('login_plid').value = plid || 0});
                if (document.getElementById('login_cookie2')) {
                    document.getElementById('login_cookie2').value = id;
                    get_plugin_id(function(plid){document.getElementById('login_plid2').value = plid || 0});
                }
            }catch (e){
                if(i)
                    setTimeout(setPLID, 2000);
                i--;
                console.log('_ '+e);
            }
        }
        setPLID();
        //setTimeout(setPLID, 2000);

    });
    window["IDCore"].init();
}
</script>
