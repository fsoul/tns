<%set_allowed_uri_params_list:page_error_flag%>
<%ap_authorized_only%>

<%ap_process_plugin_form2%>

<%include:header_internal_1%>

<div id="page_header">
    <%longtext_edit_page_cms:page_header%>
    <%iif:<%page_cms:page_header%>,,<%:page_description%>,<%page_cms:page_header%>%>
</div>

<div id="main_internal_content_center_block_info">
    <%html_edit_page_cms:plugin_error%>
    <%html_edit_page_cms:plugin_sucess%>
    <div id="plugin_error" style="display:none;"><div class="error"><%nl2br_page_cms:plugin_error%></div>
        <div class="form_row">
            <%html_edit_page_cms:agree%><%nl2br_page_cms:agree%>
            <br/><br/>
            <script type="text/javascript">function check_agree(){document.getElementById('download_plugin_block').style.display = document.getElementById('agree').checked?'block':'none'}</script>
            <input type="checkbox" name="agree" id="agree" value="agree" onclick="check_agree()"/>
            <%text_edit_page_cms:agree2%><%page_cms:agree2%><!--<br/><br/>
            <%html_edit_page_cms:agree3%><strong><%page_cms:agree3%></strong>-->
        </div>
    </div>
    <div id="plugin_success" style="display:none;"><div class="success"><%nl2br_page_cms:plugin_sucess%></div>
    </div>
    <div id="download_plugin_block" style="display:none;">
        <%include:<%iif:<%ap_is_plugin_authorized%>,1,ap_plugin_form3_top%>%>
    </div>
    <%html_edit_page_cms:page_comment_black00%>
    <%html_edit_page_cms:page_comment_black10%>
    <%html_edit_page_cms:page_comment_black11%>
    <div id="page_comment_black">
        <%nl2br_page_cms:page_comment_black<%ap_is_plugin_authorized%>%>
    </div>
    <%longtext_edit_page_cms:undefined_browser%>
    <%longtext_edit_page_cms:undefined_os%>
    <div id="page_comment">
        <!-- iff: a,b,c,d,e,f   - if(a==b)c elseif(a==d)e else f ?-->
        <%nl2br_page_cms:<%iif:<%ap_get_browser_for_plugin%>,Android,undefined_browser, unknown,undefined_browser,unknown_os,undefined_os,page_comment<%ap_is_plugin_authorized%>%>%>

    </div>
<%include:<%iif:<%ap_get_browser_for_plugin%>,Android,,unknown,,unknown_os,,<%iif:<%ap_is_plugin_authorized%>,1,ap_plugin_form3_inc,ap_plugin_form1_inc%>%>%>
<%include:footer_internal%>
