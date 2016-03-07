%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: Irene
  Date: 2015/10/10
  Time: 22:25
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <g:if test="${title}">
        <title>${title}</title>
    </g:if>
    <g:else>
        <title>寻真记二维码溯源系统</title>
    </g:else>
    <asset:stylesheet href="qrcode-manifest.css"/>
    <asset:javascript src="qrcode-manifest.js" />
<style>
    p {
        padding: 0 5px;
    }
</style>
</head>

<body style="margin: 0; line-height: 2em; background-color:white">

<g:if test="${content}">
    <div id="content"></div>
</g:if>
<g:else>
    <div style="text-align: center;margin: 100px auto 20px auto;">
        <asset:image src="logo.png"/>
    </div>
    <div style="text-align: center; color: red; font-size:2em;">产品信息不存在</div>
</g:else>
<div id="shareDiv" style="position: fixed; z-index: 999; width: 100%; top: 0; opacity: 0.8; background: black; display: none;"
     onclick="$(this).hide();">
    <asset:image style="width: 100%;" src="share.png"/>
</div>

<div id="tpl-content" style="display: none">
    ${content}
</div>
<script>
    var variable = ${variable ? variable : "{}"};
    $(document).ready(function(){
        if("${redirectUrl}"){
            window.location.href = "${redirectUrl}";
            return;
        }

        if($("#content").size()){
            render($("#tpl-content"), $("#content"), variable);
        }
    });
</script>
</body>

</html>