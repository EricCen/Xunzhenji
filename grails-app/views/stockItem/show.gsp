%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.StockItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'stockItem.label', default: 'StockItem')}"/>
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

<div id="show-stockItem" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list stockItem">
        <table class="userinfoArea stockItem" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${stockItemInstance?.weight}">
                <tr>
                    <th><span id="weight-label" class="property-label"><g:message code="stockItem.weight.label"
                                                                                  default="Weight"/></span></th>

                    <td><span class="property-value" aria-labelledby="weight-label"><g:fieldValue
                            bean="${stockItemInstance}" field="weight"/></span></td>

                </tr>
            </g:if>

            <g:if test="${stockItemInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message
                            code="stockItem.dateCreated.label" default="Date Created"/></span></th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${stockItemInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${stockItemInstance?.lastUpdated}">
                <tr>
                    <th><span id="lastUpdated-label" class="property-label"><g:message
                            code="stockItem.lastUpdated.label" default="Last Updated"/></span></th>

                    <td><span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${stockItemInstance?.lastUpdated}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${stockItemInstance?.product}">
                <tr>
                    <th><span id="product-label" class="property-label"><g:message code="stockItem.product.label"
                                                                                   default="Product"/></span></th>

                    <td><span class="property-value" aria-labelledby="product-label"><g:link controller="shopProduct"
                                                                                             action="show"
                                                                                             id="${stockItemInstance?.product?.id}">${stockItemInstance?.product?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${stockItemInstance?.quantity}">
                <tr>
                    <th><span id="quantity-label" class="property-label"><g:message code="stockItem.quantity.label"
                                                                                    default="Quantity"/></span></th>

                    <td><span class="property-value" aria-labelledby="quantity-label"><g:fieldValue
                            bean="${stockItemInstance}" field="quantity"/></span></td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: stockItemInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${stockItemInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
