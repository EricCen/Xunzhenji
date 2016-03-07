%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.ShopOrder" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'shopOrder.label', default: 'ShopOrder')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm"/><g:message
                code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-shopOrder" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list shopOrder">
        <table class="userinfoArea shopOrder" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${shopOrderInstance?.deliveryMan}">
                <tr>
                    <th><span id="deliveryMan-label" class="property-label"><g:message
                            code="shopOrder.deliveryMan.label" default="Delivery Man"/></span></th>

                    <td><span class="property-value" aria-labelledby="deliveryMan-label"><g:link
                            controller="deliveryMan" action="show"
                            id="${shopOrderInstance?.deliveryMan?.id}">${shopOrderInstance?.deliveryMan?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${shopOrderInstance?.quantity}">
                <tr>
                    <th><span id="quantity-label" class="property-label"><g:message code="shopOrder.quantity.label"
                                                                                    default="Quantity"/></span></th>

                    <td><span class="property-value" aria-labelledby="quantity-label"><g:fieldValue
                            bean="${shopOrderInstance}" field="quantity"/></span></td>

                </tr>
            </g:if>

            <g:if test="${shopOrderInstance?.quote}">
                <tr>
                    <th><span id="quote-label" class="property-label"><g:message code="shopOrder.quote.label"
                                                                                 default="Quote"/></span></th>

                    <td><span class="property-value" aria-labelledby="quote-label"><g:link controller="quote"
                                                                                           action="show"
                                                                                           id="${shopOrderInstance?.quote?.id}">${shopOrderInstance?.quote?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${shopOrderInstance?.shopOrderStatus}">
                <tr>
                    <th><span id="shopOrderStatus-label" class="property-label"><g:message
                            code="shopOrder.shopOrderStatus.label" default="Shop Order Status"/></span></th>

                    <td><span class="property-value" aria-labelledby="shopOrderStatus-label"><g:fieldValue
                            bean="${shopOrderInstance}" field="shopOrderStatus"/></span></td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: shopOrderInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${shopOrderInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
