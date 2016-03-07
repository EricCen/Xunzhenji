%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.workflow.MiaoXinProcess" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'miaoXinProcess.label', default: 'MiaoXinProcess')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-miaoXinProcess" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="date" title="${message(code: 'miaoXinProcess.date.label', default: 'Date')}"/>

            <th><g:message code="miaoXinProcess.manufacture.label" default="Manufacture"/></th>
            <th><g:message code="miaoXinProcess.procurements.label" default="Procurements"/></th>
            <th><g:message code="miaoXinProcess.deliveries.label" default="Deliveries"/></th>
            <g:sortableColumn property="deliveryProductionRate"
                              title="${message(code: 'miaoXinProcess.deliveryProductionRate.label', default: 'Delivery Production Rate')}"/>
            <g:sortableColumn property="initialManufactureStockQuantity"
                              title="${message(code: 'miaoXinProcess.initialManufactureStockQuantity.label', default: '宰前库存数量')}"/>

            <g:sortableColumn property="deliveredStockWeight"
                              title="${message(code: 'miaoXinProcess.deliveredStockWeight.label', default: '送后库存重量')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${miaoXinProcessInstanceList}" status="i" var="miaoXinProcessInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${miaoXinProcessInstance.id}"><g:formatDate format="yyyy-MM-dd" date="${miaoXinProcessInstance.date}"/></g:link></td>
                <td>${fieldValue(bean: miaoXinProcessInstance, field: "manufacture")}</td>
                <td>${fieldValue(bean: miaoXinProcessInstance, field: "procurements")}</td>
                <td><g:each in="${miaoXinProcessInstance?.deliveries}" var="delivery">${delivery}<br></g:each></td>
                <td>${fieldValue(bean: miaoXinProcessInstance, field: "deliveryProductionRate")}</td>
                <td>${fieldValue(bean: miaoXinProcessInstance, field: "initialManufactureStockQuantity")}</td>
                <td>${fieldValue(bean: miaoXinProcessInstance, field: "deliveredStockWeight")}</td>

                <td>
                    <g:link action="edit" id="${miaoXinProcessInstance.id}">编辑</g:link>
                    <g:link action="calculate" id="${miaoXinProcessInstance.id}">重新计算</g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${miaoXinProcessInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
