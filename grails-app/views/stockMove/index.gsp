%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.StockMove" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'stockMove.label', default: 'StockMove')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-stockMove" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>

            <th><g:message code="stockMove.product.label" default="Product"/></th>

            <g:sortableColumn property="direction"
                              title="${message(code: 'stockMove.direction.label', default: 'Direction')}"/>

            <g:sortableColumn property="warehouse"
                              title="${message(code: 'stockMove.warehouse.label', default: 'Warehouse')}"/>

            <g:sortableColumn property="weight" title="${message(code: 'stockMove.weight.label', default: 'Weight')}"/>

            <g:sortableColumn property="quantity"
                              title="${message(code: 'stockMove.quantity.label', default: 'Quantity')}"/>

            <g:sortableColumn property="lastUpdated"
                              title="${message(code: 'default.lastUpdated.label', default: 'Last Updated')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${stockMoveInstanceList}" status="i" var="stockMoveInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${stockMoveInstance.id}">${fieldValue(bean: stockMoveInstance, field: "product")}</g:link></td>
                <td>${fieldValue(bean: stockMoveInstance, field: "direction")}</td>
                <td>${fieldValue(bean: stockMoveInstance, field: "warehouse")}</td>
                <td>${fieldValue(bean: stockMoveInstance, field: "weight")}</td>
                <td>${fieldValue(bean: stockMoveInstance, field: "quantity")}</td>
                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${stockMoveInstance.lastUpdated}"/></td>
                <td><g:link action="edit" id="${stockMoveInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${stockMoveInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
