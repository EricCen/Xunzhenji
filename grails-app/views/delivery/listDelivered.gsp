%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="groovy.time.TimeCategory; net.xunzhenji.mall.DeliveryProductOrders" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="发货"/>
    <title>批次列表</title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="index" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.list.label" args="[entityName]"/></g:link>
    <g:link action="list" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/>未签收发货</g:link>
</div>

<div id="list-productOrder" class="content scaffold-list" role="main">
    <div id="delivery-tbl" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <div class="tr">
            <div class="th" style="width: 6em;">日期</div>

            <div class="th">商品</div>

            <div class="th">数量</div>

            <div class="th">快递单号</div>

            <div class="th">手机已验证</div>

            <div class="th" style="width: 300px">地址</div>

            <div class="th">时间</div>

            <div class="th">操作</div>
        </div>
        <g:each in="${dateMap.entrySet()}" var="entry">
            <g:each in="${entry.value}" var="delivery">
            <div class="tr">
                <div class="td"><g:formatDate format="yyyy-MM-dd" date="${entry.key}"/></div>

                <div class="td">${delivery.product}</div>

                <div class="td">${delivery.quantity}</div>

                <div class="td">${delivery.deliveryCode}</div>

                <div class="td">
                    <g:formatBoolean boolean="${delivery.phoneVerified}"
                        true="是" false="否"/></div>
                
                <div class="td">${delivery.address}</div>

                <div class="td">
                    <g:if test="${delivery?.startDateTime && delivery?.completionDateTime}">
                        收货:<g:formatDate format="yy-MM-dd HH:mm" date="${delivery?.startDateTime}"/><br>
                        签收:<g:formatDate format="yy-MM-dd HH:mm" date="${delivery?.completionDateTime}"/><br>
                        历时:${groovy.time.TimeCategory.minus(delivery?.completionDateTime, delivery?.startDateTime).days}天${groovy.time.TimeCategory.minus(delivery?.completionDateTime, delivery?.startDateTime).hours}小时
                    </g:if>
                </div>

                <div class="td">
                    <g:link action="updateProcessing" id="${delivery.id}">更新物流状态</g:link><br>
                    <g:link action="show" id="${delivery.id}">物流详情</g:link><br>
                    <g:link action="deliveryCompleted" id="${delivery.id}">货物已签收</g:link>
                </div>
            </div>
            </g:each>
        </g:each>
    </div>
</div>
</body>
</html>