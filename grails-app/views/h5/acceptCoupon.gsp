%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: Irene
  Date: 2015/11/4
  Time: 13:26
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
    <title>鸡票已经放进寻真记账户啦</title>

    <asset:stylesheet src="coupon-manifest.css" />
    <asset:javascript src="wechatpay-manifest.js"/>
</head>

<body style="background-color: #eeeeee;">
<div style="text-align: center;">
    <g:link class="btn btn-green btn-lg" style="margin: 10px; width: 90%" action="home" params="[hash:'product_'+ productId]">马上去买灵芝鸡</g:link>
</div>
<div style="text-align: center;">
    <g:link class="btn btn-green btn-lg" style="margin: 10px; width: 90%" action="home">到寻真记逛逛</g:link>
</div>
<div style="text-align: center;">
    <g:link class="btn btn-green btn-lg" style="margin: 10px; width: 90%" action="home" fragment="my-account-panel">看看我的寻真记账户</g:link>
</div>
</body>
</html>