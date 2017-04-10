
<script type="text/javascript">
    window.onload = function(){
        //var tid = new TnsId();
        window["IDCore"].addOnReadyListener(function(id) {
            var i=3;
            function setPLID(){
                try{
                    if (document.getElementById('login_cookie')) {
                        //document.getElementById('tns_id').value = id;
                        document.getElementById('login_cookie').value = id;
                        get_plugin_id(function(plid){document.getElementById('login_plid').value = plid || 0});
                    }
                    if (document.getElementById('login_cookie2')) {
                        document.getElementById('login_cookie2').value = id;
                        console.log('login_cookie set '+id);
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
