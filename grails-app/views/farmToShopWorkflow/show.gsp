%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.workflow.MiaoXinProcess" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'farmToShopWorkFlow.label', default: 'FarmToShopWorkFlow')}"/>
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

<div id="show-farmToShopWorkFlow" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list farmToShopWorkFlow">
        <table class="userinfoArea farmToShopWorkFlow" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${farmToShopWorkFlowInstance?.procurement}">
                <tr>
                    <th><span id="procurement-label" class="property-label"><g:message
                            code="farmToShopWorkFlow.procurement.label" default="Procurement"/></span></th>

                    <td><span class="property-value" aria-labelledby="procurement-label"><g:link
                            controller="procurement" action="show"
                            id="${farmToShopWorkFlowInstance?.procurement?.id}">${farmToShopWorkFlowInstance?.procurement?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${farmToShopWorkFlowInstance?.materialStockMove}">
                <tr>
                    <th><span id="materialStockMove-label" class="property-label"><g:message
                            code="farmToShopWorkFlow.materialStockMove.label" default="Material Stock Move"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="materialStockMove-label"><g:link
                            controller="stockMove" action="show"
                            id="${farmToShopWorkFlowInstance?.materialStockMove?.id}">${farmToShopWorkFlowInstance?.materialStockMove?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${farmToShopWorkFlowInstance?.manufacture}">
                <tr>
                    <th><span id="manufacture-label" class="property-label"><g:message
                            code="farmToShopWorkFlow.manufacture.label" default="Manufacture"/></span></th>

                    <td><span class="property-value" aria-labelledby="manufacture-label"><g:link
                            controller="manufacture" action="show"
                            id="${farmToShopWorkFlowInstance?.manufacture?.id}">${farmToShopWorkFlowInstance?.manufacture?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${farmToShopWorkFlowInstance?.transit}">
                <tr>
                    <th><span id="transit-label" class="property-label"><g:message
                            code="farmToShopWorkFlow.transit.label" default="Transit"/></span></th>

                    <td><span class="property-value" aria-labelledby="transit-label"><g:link controller="transit"
                                                                                             action="show"
                                                                                             id="${farmToShopWorkFlowInstance?.transit?.id}">${farmToShopWorkFlowInstance?.transit?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${farmToShopWorkFlowInstance?.shopDelivery}">
                <tr>
                    <th><span id="shopDelivery-label" class="property-label"><g:message
                            code="farmToShopWorkFlow.shopDelivery.label" default="Shop Delivery"/></span></th>

                    <td><span class="property-value" aria-labelledby="shopDelivery-label"><g:link
                            controller="shopDelivery" action="show"
                            id="${farmToShopWorkFlowInstance?.shopDelivery?.id}">${farmToShopWorkFlowInstance?.shopDelivery?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${farmToShopWorkFlowInstance?.productStockMove}">
                <tr>
                    <th><span id="productStockMove-label" class="property-label"><g:message
                            code="farmToShopWorkFlow.productStockMove.label" default="Product Stock Move"/></span></th>

                    <td><span class="property-value" aria-labelledby="productStockMove-label"><g:link
                            controller="stockMove" action="show"
                            id="${farmToShopWorkFlowInstance?.productStockMove?.id}">${farmToShopWorkFlowInstance?.productStockMove?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: farmToShopWorkFlowInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${farmToShopWorkFlowInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
