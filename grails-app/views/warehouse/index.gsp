%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.Warehouse" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'warehouse.label', default: 'Warehouse')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-warehouse" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="name" title="${message(code: 'warehouse.name.label', default: 'Name')}"/>
            <g:sortableColumn property="location"
                              title="${message(code: 'warehouse.location.label', default: 'Location')}"/>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${warehouseInstanceList}" status="i" var="warehouseInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="show"
                            id="${warehouseInstance.id}">${fieldValue(bean: warehouseInstance, field: "name")}</g:link></td>
                <td>${fieldValue(bean: warehouseInstance, field: "location")}</td>
                <td><g:link action="edit" id="${warehouseInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${warehouseInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
