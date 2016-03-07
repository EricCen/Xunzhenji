<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/8
  Time: 23:53
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>多图文回复</title>
    <asset:stylesheet href="cymain.css" />

    <style>
    html, body {
        /*position:relative;
        height:100%;*/
        color:#222;
        font-family:Microsoft YaHei, Helvitica, Verdana, Tohoma, Arial, san-serif;
        background-color:#ffffff;
        margin:0;
        padding: 0;
        text-decoration: none;
    }
    body >.tips {
        position:fixed;
        display:none;
        top:50%;
        left:50%;
        z-index:100;
        text-align:center;
        padding:20px;
        width:200px;
    }
    body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td {
        margin:0;
        padding:0;
    }
    table {
        border-collapse:collapse;
        border-spacing:0;
    }
    .text img {
        max-width: 100%;
    }
    fieldset, img {
        border:0;
    }
    address, caption, cite, code, dfn, em, th, var {
        font-style:normal;
        font-weight:normal;
    }
    ol, ul {
        list-style: none outside none;
        margin:0;
        padding: 0;
    }
    caption, th {
        text-align:left;
    }
    h1, h2, h3, h5, h6 {
        font-size:100%;
        font-weight:normal;
    }
    a {
        color:#000000;
        text-decoration: none;
    }
    #iphone #activity-detail {
        height: 414px;
        left: 33px;
        overflow: auto;
        padding: 0;
        position: absolute;
        top: 197px;
        width: 319px;
        background:#EFEFEF;
    }
    #iphone .nickname {
        color: #CCCCCC;
        display: block;
        font-weight: bold;
        line-height: 45px;
        position: absolute;
        text-align: center;
        text-shadow: 0 1px 3px #000000;
        top: 152px;
        left: 33px;
        width: 320px;
    }

    .keywordtext .me {
        margin-top:30px
    }

    .chatItem .avatar {
        width:38px;
        height:38px;
        border:1px solid #ccc\9;
        border: 1px solid #CCCCCC;
        box-shadow: 0 1px 3px #D3D4D5;
        border-radius:5px;
        -moz-border-radius:5px;
        -webkit-border-radius:5px;
    }
    .chatItem .cloud {
        max-width:240px; /*border-radius:11px; border-width:1px; border-style:solid; */
        cursor:default;
        position: static;
    }
    .chatItem .cloud {/*for ie*/
        /*position: relative;*/
        padding: 0px;
        margin: 0px;
    }
    .me .avatar {
        float:right;
    }
    .me .cloud { /*position:relative;*/
        float:right;
        min-width:50px;
        max-width:200px;
        margin:0 15px 0 0;
    }
    .chatItem .cloudContent { /* position:relative;for ie*/
        text-align:left; /*padding:2px; line-height:1.2; */
        font-weight:normal;
        font-size:16px;
        min-height:20px;
        word-wrap:break-word;
    }
    .me .cloudText .cloudBody {
        -moz-border-top-colors:none;
        -moz-border-right-colors:none;
        -moz-border-bottom-colors:none;
        -moz-border-left-colors:none;
        border-color:transparent;
        border:1px solid #AFAFAF;
        border-radius:5px;
        -moz-border-radius:5px;
        -webkit-border-radius:5px;
        box-shadow: 0px 1px 3px #D5D5D5;
        border:1px solid #9f9f9f\9;
        background:#ECECEC\9;
        border-radius:6px\9;
        margin-left:8px;
    }
    .me .cloudContent {
        border:1px solid #eee\9;
        border-top:1px solid #FFF;
        border-bottom:1px solid #F2F2F2;
        padding:13px\9;
        border-radius:13px\9;
        border-radius:4px;
        -moz-border-radius:4px;
        -webkit-border-radius:4px;
        overflow:hidden;
        color:#000;
        text-shadow:none;
        background-color:#ECECEC;
        background:-webkit-gradient(linear,  left top, left bottom,  from(#F4F4F4), to(#E5E5E5),  color-stop(0.1, #F3F3F3), color-stop(0.3, #F1F1F1), color-stop(0.5, #ECECEC), color-stop(0.7, #E9E9E9), color-stop(0.9, #E6E6E6), color-stop(1.0, #E5E5E5));
        background-image:-moz-linear-gradient(top, #F3F3F3 10%, #F1F1F1 30%, #ECECEC 50%, #E9E9E9 70%, #E6E6E6 90%, #E5E5E5 100%);
    }/*.cloudText*/
    .me .cloudText .cloudArrow {
        position: absolute;
        right: -10px;
        top: 11px;
        width: 13px;
        height: 24px;
        background: url(bubble_right.png) no-repeat;
    }
    .me .cloudText .cloudContent {
        background-color:#E5E5E5;
        vertical-align: top;
        padding:7px 10px;
        background-color:#ECECEC\9;
    }
    .you .avatar {
        float:left;
    }
    .you .cloud { /*position:relative;8.3*/
        float:left;
        min-width:50px;
        max-width:200px;
        margin:0 0 0 15px;
    }
    .you .cloudText .cloudBody {
        -moz-border-top-colors:none;
        -moz-border-right-colors:none;
        -moz-border-bottom-colors:none;
        -moz-border-left-colors:none;
        border-color:transparent;
        /*border-style:solid;
            border-width:1px;
            border-color:#7B9F45 #7B9F45 #7B9F45 #7B9F45;*/
        border: 1px solid #7AA23F;
        border-radius:5px;
        -moz-border-radius:5px;
        -webkit-border-radius:5px;
        box-shadow: 0px 1px 3px #8DA254;
        border:1px solid #73972a\9;
        border-radius:6px\9;
        background-color: #AEDC43;
    }
    .you .cloudText .cloudContent {
        padding:5px 13px\9;
        border-radius:13px\9;
        border-radius:5px;
        -moz-border-radius:5px;
        -webkit-border-radius:5px;
        padding:7px 10px;
        text-shadow:none;
        color:#030303;
        border-top: 1px solid #DCE6C8;
        border-bottom: 1px solid #B9CF8B;
        border-right: 1px solid #CCDEA3;
    }
    .you .cloudText .cloudArrow {
        position: absolute;
        left: -6px;
        top: 11px;
        width: 13px;
        height: 24px;
        background: url(bubble_left.png) no-repeat;
    }

    .mediaContent a:hover {
        background-color: #F6F6F6;
    }
    .mediaContent .last:hover {
        -webkit-border-radius:0px 0px 12px 12px;
        -moz-border-radius:0px 0px 12px 12px;
        border-radius:0px 0px 12px 12px;
        background-color: #F6F6F6;
    }
    .mediaFullText:hover {
        background-color: #F6F6F6;
        background:-webkit-gradient(linear,  left top, left bottom,  from(#F6F6F6), to(#F6F6F6));
        background-image:-moz-linear-gradient(top, #F6F6F6 0%, #F6F6F6 100%);
    }
    </style>

    <asset:stylesheet href="appmsg.css" />
</head>

<body>
<div class="content">

    <div class="cLineB">
        <h4 class="left">多图文回复</h4>
        <div class="clr"></div>
    </div>

    <div class="msgWrap form">
        <ul id="tags" style="width:100%">
            <li class="selectTag">
                <g:link action="index">添加多图文回复</g:link>
            </li>
            <li>
                <g:link action="list">多图文回复列表</g:link>
            </li>

            <div class="clr" style="height:1px;background:#eee;margin-bottom:20px;"></div>
        </ul>
    </div>

    <g:form method="post" action="save">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <tr>
                <th valign="top"><span class="red">*</span>关键词
                    <g:hasErrors bean="${multiimage}" field="keywords">
                        <g:eachError bean="${multiimage}" field="keywords">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors>
                </th>
                <td><input type="text" class="px" name="keywords" value="${multiimage?.keywords?.join(' ')}" /></td>
            </tr>


            <TR>
                <TH valign="top"><label for="multinews">图文消息</label>
                    <g:hasErrors bean="${multiimage}" field="images">
                        <g:eachError bean="${multiimage}" field="images">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors>
                </TH>
                <TD> <a onclick="addImgMessage()" class="a_choose">添加图文消息</a>&nbsp;&nbsp;
                    <a onclick="clearMessage()" class="a_clear">清空重选</a>

                    <div class="chatPanel" style="width:280px;" id="singlenews">
                        <div un="item_1741035" class="chatItem you">
                            　<a target="ddd">
                            <div class="media mediaFullText" id="titledom">
                                <div class="mediaPanel">
                                    <div class="mediaHead"><span class="title" id="zbt">图文消息标题</span><span class="time">${org.apache.commons.lang.time.DateFormatUtils.format(new Date(), 'yyyy-MM-dd')}</span>
                                        <div class="clr"></div>
                                    </div>
                                    <div class="mediaImg"><asset:image id="suicaipic1" src="message/oid.jpg"/></div>
                                    <div class="mediaContent mediaContentP">
                                        <p id="zinfo">消息简介</p>
                                    </div>
                                    <div class="mediaFooter">
                                        <span class="mesgIcon right"></span><span style="line-height:50px;" class="left">查看全文</span>
                                        <div class="clr"></div>
                                    </div>
                                </div>
                            </div>
                        </a>
                        </div>
                    </div>

                    <div style="clear:both"></div>

                    <input type="hidden" class="px" id="imgids" value="" name="imgids" style="width:300px" >  <br>

                    <div class="media_preview_area" id="multinews" style="display:none">
                        <div class="appmsg multi editing">
                            <div id="js_appmsg_preview" class="appmsg_content">
                                <div id="appmsgItem1" data-fileid="" data-id="1" class="js_appmsg_item ">
                                    <div class="appmsg_info">
                                        <em class="appmsg_date"></em>
                                    </div>
                                    <div class="cover_appmsg_item" id="multione"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </TD>
                <TD>&nbsp;</TD>
            </TR>

            <tr>
                <th></th>
                <td><button type="submit" class="btnGreen">保存</button>
                    <a href="javascript:history.go(-1);" class="btnGray vm">取消</a>
                </td>
            </tr>
            </tbody>
        </table>
    </g:form>

</div>

<div class="clr"></div>

<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>

<script>
    function addImgMessage(){
        art.dialog.data('titledom', 'titledom');
        art.dialog.data('imgids', 'imgids');
        art.dialog.data('multinews', 'multinews');
        art.dialog.data('singlenews', 'singlenews');

        art.dialog.data('js_appmsg_preview', 'js_appmsg_preview');
        art.dialog.data('multione', 'multione');
        art.dialog.open('${createLink(controller: "multiimage", action: "img")}',{lock:true,title:'选择图文消息',width:600,height:400,yesText:'关闭',background: '#000',opacity: 0.45});
    }
    function clearMessage(){
        document.getElementById('titledom').innerHTML='';
        document.getElementById('imgids').value='';
        document.getElementById('js_appmsg_preview').innerHTML='<div class="appmsg_info"><em class="appmsg_date"></em></div><div class="cover_appmsg_item" id="multione"></div>';
        document.getElementById('multinews').style.display='none';
        document.getElementById('singlenews').style.display='';
    }
</script>

</body>
</html>