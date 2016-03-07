%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.DeliveryProductOrders" contentType="text/html;charset=UTF-8" %>
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
    <g:link action="listDelivered" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/>已签收发货</g:link>
</div>

<div id="list-productOrder" class="content scaffold-list" role="main">
    <g:each in="${dateMap.keySet()}" var="key">
        <div id="delivery-tbl" class="table list-table">
            <div style="width: 100%; display: table-caption">
                <span><strong>${key}</strong></span>
                <span><strong>(${dateMap.get(key)?.sum { it.quantity }})</strong></span>
            </div>
            <div class="tr">
                <div class="th">联系人</div>

                <div class="th">联系电话</div>

                <div class="th">手机号码</div>

                <div class="th">地址</div>

                <div class="th">商品</div>

                <div class="th">数量</div>

                <div class="th">快递单号</div>

                <div class="th">手机已验证</div>

                <div class="th">派送状态</div>
                <div class="th">操作</div>
            </div>
            <g:each in="${dateMap.get(key)}" var="delivery">
                <div class="tr">
                    <div class="td">${delivery.name}</div>

                    <div class="td">${delivery.phone}</div>

                    <div class="td">${delivery.phone}</div>

                    <div class="td">${delivery.address}</div>

                    <div class="td">${delivery.product}</div>

                    <div class="td">${delivery.quantity}</div>

                    <div class="td">${delivery.deliveryCode}</div>

                    <div class="td">
                        <g:formatBoolean boolean="${delivery.phoneVerified}"
                                         true="是" false="否"/>
                    </div>

                    <div class="td">${delivery.deliveryStatus}</div>

                    <div class="td">
                        <g:link action="edit" id="${delivery.id}">编辑</g:link><br>
                    </div>
                </div>
            </g:each>
        </div>
        </g:each>
    </div>
</body>
</html>