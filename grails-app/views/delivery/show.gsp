%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Delivery" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'delivery.label', default: 'Delivery')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link action="list" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/>未签收发货</g:link></li>
        <li><g:link action="listDelivered" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/>已签收发货</g:link></li>
    </ul>
</div>

<div id="show-delivery" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="userinfoArea delivery" border="0" cellspacing="0" cellpadding="0" width="100%">
        <tbody>

        <g:if test="${deliveryInstance?.deliveryCode}">
            <tr>
                <th><span id="deliveryCode-label" class="property-label"><g:message code="delivery.deliveryCode.label"
                                                                                    default="Delivery Code"/></span>
                </th>

                <td><span class="property-value" aria-labelledby="deliveryCode-label"><g:fieldValue
                        bean="${deliveryInstance}" field="deliveryCode"/></span></td>

            </tr>
        </g:if>

        <g:if test="${deliveryInstance?.targetDeliveryDate}">
            <tr>
                <th><span id="targetDeliveryDate-label" class="property-label"><g:message
                        code="delivery.targetDeliveryDate.label" default="Delivery Date"/></span></th>

                <td><span class="property-value" aria-labelledby="targetDeliveryDate-label"><g:formatDate
                        format="yyyy-MM-dd" date="${deliveryInstance?.targetDeliveryDate}"/></span></td>

            </tr>
        </g:if>

        <g:if test="${deliveryInstance?.receiver}">
            <tr>
                <th><span id="receiver-label" class="property-label"><g:message code="delivery.receiver.label"
                                                                                default="Organizer"/></span></th>

                <td><span class="property-value" aria-labelledby="receiver-label">
                    ${deliveryInstance?.address?.name} (${deliveryInstance?.address?.phone})</span>
                </td>

            </tr>
        </g:if>

        <g:if test="${deliveryInstance?.startDateTime}">
            <tr>
                <th><span id="completionDateTime-label" class="property-label"><g:message
                        code="delivery.startDateTime.label" default="Start Date Time"/></span></th>

                <td><span class="property-value" aria-labelledby="startDateTime-label"><g:formatDate
                        format="yyyy-MM-dd HH:mm:ss" date="${deliveryInstance?.startDateTime}"/></span></td>

            </tr>
        </g:if>

        <g:if test="${deliveryInstance?.completionDateTime}">
            <tr>
                <th><span id="completionDateTime-label" class="property-label"><g:message
                        code="delivery.completionDateTime.label" default="Completion DateTime"/></span></th>

                <td><span class="property-value" aria-labelledby="completionDateTime-label"><g:formatDate
                        format="yyyy-MM-dd HH:mm:ss" date="${deliveryInstance?.completionDateTime}"/></span></td>

            </tr>
        </g:if>

        <g:if test="${deliveryInstance?.deliveryStatus}">
            <tr>
                <th><span id="deliveryStatus-label" class="property-label"><g:message
                        code="delivery.deliveryStatus.label" default="Delivery Status"/></span></th>

                <td>${deliveryInstance.deliveryStatus.name}</td>
            </tr>
        </g:if>

        <g:if test="${deliveryInstance?.address}">
            <tr>
                <th><span id="address-label" class="property-label"><g:message code="default.address.label"
                                                                                default="地址"/></span></th>

                <td><span class="property-value" aria-labelledby="receiver-label">${deliveryInstance?.address}</span>
                </td>
            </tr>
        </g:if>
        </tbody>
    </table>
    <g:form url="[resource: deliveryInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${deliveryInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>

            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
    <div id="orders-tbl-body" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <h1>订单列表</h1>

        <div class="tr">
            <div class="th">单号</div>

            <div class="th">商品名称</div>

            <div class="th">批次</div>

            <div class="th">数量</div>

            <div class="th">预订价</div>

            <div class="th">总价</div>
            <div class="th">显示状态</div>
            <div class="th">支付状态</div>
            <div class="th">物流状态</div>
        </div>

        <g:each in="${deliveryInstance.orders()}" var="order">
            <div class="tr">
                <div class="td"><g:link controller="productOrder" action="show" id="${order.id}">${order?.id}</g:link></div>

                <div class="td">${order?.product?.title}</div>

                <div class="td">${order?.batch?.title}</div>

                <div class="td">${order?.quantity}</div>

                <div class="td">${order?.orderPrice}</div>

                <div class="td">${order?.fullPrice()}</div>
                <div class="td">${order?.displayStatusDesc()}</div>
                <div class="td">${order?.getPaymentStatusName()}</div>
                <div class="td">${order?.getDeliveryStatusName()}</div>
            </div>
        </g:each>
    </div>

    %{--<div id="route-detail">--}%
        %{--<h1>快递订单信息</h1>--}%
        %{--<table class="userinfoArea delivery" border="0" cellspacing="0" cellpadding="0" width="100%">--}%
            %{--<tbody>--}%
            %{--<g:if test="${searchResult?.orderId}">--}%
                %{--<tr>--}%
                    %{--<th>订单号</th>--}%
                    %{--<td>${searchResult.orderId}</td>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
            %{--<g:if test="${searchResult?.mailNo}">--}%
                %{--<tr>--}%
                    %{--<th>返回结果</th>--}%
                    %{--<td>${searchResult.mailNo}</td>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
            %{--<g:if test="${searchResult?.originCode}">--}%
                %{--<tr>--}%
                    %{--<th>原寄地代码</th>--}%
                    %{--<td>${searchResult.originCode}</td>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
            %{--<g:if test="${searchResult?.destCode}">--}%
                %{--<tr>--}%
                    %{--<th>目的地代码</th>--}%
                    %{--<td>${searchResult.destCode}</td>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
            %{--<g:if test="${searchResult?.filterResult}">--}%
                %{--<tr>--}%
                    %{--<th>筛单结果</th>--}%
                    %{--<td>${searchResult.filterResult==1 ? "人工确认": searchResult.filterResult==2 ? "可收派": "不可以收派"}</td>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
            %{--<g:if test="${searchResult?.response}">--}%
                %{--<tr>--}%
                    %{--<th>备注</th>--}%
                    %{--<td>${searchResult ? searchResult.filterResult==1 ? "收方超范围": searchResult.filterResult==2 ? "派方超范围": "其他原因" :""}</td>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
            %{--</tbody>--}%
        %{--</table>--}%
    %{--</div>--}%

    <div id="route-detail">
        <h1>路由信息</h1>
        <g:each in="${routeInfo}" var="item">
            <div>${item}</div>
        </g:each>
    </div>
</div>
</body>
</html>
