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
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-farmToShopWorkFlow" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>

            <th><g:message code="farmToShopWorkFlow.procurement.label" default="Procurement"/></th>

            <th><g:message code="farmToShopWorkFlow.materialStockMove.label" default="Material Stock Move"/></th>

            <th><g:message code="farmToShopWorkFlow.manufacture.label" default="Manufacture"/></th>

            <th><g:message code="farmToShopWorkFlow.transit.label" default="Transit"/></th>

            <th><g:message code="farmToShopWorkFlow.shopDelivery.label" default="Shop Delivery"/></th>

            <th><g:message code="farmToShopWorkFlow.productStockMove.label" default="Product Stock Move"/></th>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${farmToShopWorkFlowInstanceList}" status="i" var="farmToShopWorkFlowInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${farmToShopWorkFlowInstance.id}">${fieldValue(bean: farmToShopWorkFlowInstance, field: "procurement")}</g:link></td>

                <td>${fieldValue(bean: farmToShopWorkFlowInstance, field: "materialStockMove")}</td>

                <td>${fieldValue(bean: farmToShopWorkFlowInstance, field: "manufacture")}</td>

                <td>${fieldValue(bean: farmToShopWorkFlowInstance, field: "transit")}</td>

                <td>${fieldValue(bean: farmToShopWorkFlowInstance, field: "shopDelivery")}</td>

                <td>${fieldValue(bean: farmToShopWorkFlowInstance, field: "productStockMove")}</td>

                <td><g:link action="edit" id="${farmToShopWorkFlowInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${farmToShopWorkFlowInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
