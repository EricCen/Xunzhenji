%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.Procurement" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'procurement.label', default: 'Procurement')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-procurement" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="procurementTime"
                              title="${message(code: 'procurement.procurementTime.label', default: 'Procurement Time')}"/>

            <th><g:message code="procurement.product.label" default="Product"/></th>

            <g:sortableColumn property="quantity"
                              title="${message(code: 'procurement.quantity.label', default: 'Quantity')}"/>

            <g:sortableColumn property="weight"
                              title="${message(code: 'procurement.weight.label', default: 'Weight')}"/>

            <g:sortableColumn property="source"
                              title="${message(code: 'procurement.source.label', default: 'Source')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${procurementInstanceList}" status="i" var="procurementInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${procurementInstance.id}"><g:formatDate format="yyyy-MM-dd" date="${procurementInstance.procurementTime}"/></g:link></td>
                <td>${fieldValue(bean: procurementInstance, field: "product")}</td>
                <td>${fieldValue(bean: procurementInstance, field: "quantity")}</td>
                <td>${fieldValue(bean: procurementInstance, field: "weight")}</td>
                <td>${fieldValue(bean: procurementInstance, field: "source")}</td>

                <td><g:link action="edit" id="${procurementInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${procurementInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
