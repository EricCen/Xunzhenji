%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.ShopDelivery" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'shopDelivery.label', default: 'ShopDelivery')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-shopDelivery" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>

            <g:sortableColumn property="shop"
                              title="${message(code: 'shopDelivery.shop.label', default: 'Shop')}"/>

            <g:sortableColumn property="product"
                              title="${message(code: 'shopDelivery.product.label', default: 'Product')}"/>

            <g:sortableColumn property="deliveryTime"
                              title="${message(code: 'shopDelivery.deliveryTime.label', default: 'Delivery Time')}"/>

            <g:sortableColumn property="quantity"
                              title="${message(code: 'shopDelivery.quantity.label', default: 'Quantity')}"/>

            <g:sortableColumn property="weight"
                              title="${message(code: 'shopDelivery.weight.label', default: 'Weight')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${shopDeliveryInstanceList}" status="i" var="shopDeliveryInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${shopDeliveryInstance.id}">${fieldValue(bean: shopDeliveryInstance, field: "shop")}</g:link></td>

                <td>${fieldValue(bean: shopDeliveryInstance, field: "product")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${shopDeliveryInstance.deliveryTime}"/></td>

                <td>${fieldValue(bean: shopDeliveryInstance, field: "quantity")}</td>

                <td>${fieldValue(bean: shopDeliveryInstance, field: "weight")}</td>

                <td><g:link action="edit" id="${shopDeliveryInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${shopDeliveryInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
