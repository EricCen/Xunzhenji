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
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-stockItem" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>

            <g:sortableColumn property="weight" title="${message(code: 'stockItem.weight.label', default: 'Weight')}"/>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'stockItem.dateCreated.label', default: 'Date Created')}"/>

            <g:sortableColumn property="lastUpdated"
                              title="${message(code: 'stockItem.lastUpdated.label', default: 'Last Updated')}"/>

            <th><g:message code="stockItem.product.label" default="Product"/></th>

            <g:sortableColumn property="quantity"
                              title="${message(code: 'stockItem.quantity.label', default: 'Quantity')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${stockItemInstanceList}" status="i" var="stockItemInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${stockItemInstance.id}">${fieldValue(bean: stockItemInstance, field: "weight")}</g:link></td>

                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${stockItemInstance.dateCreated}"/></td>

                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${stockItemInstance.lastUpdated}"/></td>

                <td>${fieldValue(bean: stockItemInstance, field: "product")}</td>

                <td>${fieldValue(bean: stockItemInstance, field: "quantity")}</td>

                <td><g:link action="edit" id="${stockItemInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${stockItemInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
