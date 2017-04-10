<%set_allowed_uri_params_list:jstest%>
<%ap_authorized_only%>
<%set_allowed_uri_params_list:debug%>

<%include:header_internal%>
<script type="text/javascript">window["in_cppage"] = 1;</script>
<%include:link_plugin%>
<%ap_current_projects_list%>
<div>

</div>
<noscript>
    <img src="//pa.tns-ua.com/bug/pic.gif?tnsb=jf2hymdsg1z2&tnskb=s&tnsv=1.0.1" alt="" />
</noscript>
<script language="javascript" type="text/javascript">
    (new Image()).src = (location.protocol == "https:" ? "https:" : "http:") + "//pa.tns-ua.com/bug/pic.gif?tnsb=jf2hymdsg1z2&tnskb=s&tnsv=1.0.1&r=" + Math.random();
</script>
<script>
    function check_ads_block(plid) {
        var is_counter_block = 0;
        var is_adv_block = 0;
        var testAd = document.createElement('div');

        plid = plid || '';
        testAd.innerHTML = '&nbsp;';
        testAd.className = 'adsbox';
        document.body.appendChild(testAd);
        window.setTimeout(function() {
            if (testAd.offsetHeight === 0) {
                is_adv_block = 1;
            }
            testAd.remove();
            if (window['__cm'] == undefined) {
                is_counter_block = 1;
            }
            // TODO: send requset to backend;
            console.log(is_counter_block, is_adv_block);
            ajax_get_json('<%:EE_HTTP%>action.php?action=check_adblock&' +
                    'is_counter_block=' + is_counter_block + '&' +
                    'is_adv_block=' + is_adv_block + '&' +
                    'plid=' + plid + '&' +
                    'cookie=' + window['IDCore'].getId(),
                function(resp){
                    console.log(resp);
                })
        }, 100);
    }
    get_plugin_id(check_ads_block, check_ads_block);

</script>
<%include:footer_internal%>
