%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.Shop" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'shop.label', default: 'Shop')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-shop" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="name" title="${message(code: 'shop.name.label', default: 'Name')}"/>
            <g:sortableColumn property="parentName"
                              title="${message(code: 'shop.parentName.label', default: 'Parent Name')}"/>


            <g:sortableColumn property="displayForSelect"
                              title="${message(code: 'shop.displayForSelect.label', default: 'Display For Select')}"/>

            <g:sortableColumn property="lastOrderTime"
                              title="${message(code: 'shop.lastOrderTime.label', default: 'Last Order Time')}"/>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'default.dateCreated.label', default: 'Date Created')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${shopInstanceList}" status="i" var="shopInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="show"
                            id="${shopInstance.id}">${fieldValue(bean: shopInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: shopInstance, field: "parentName")}</td>

                <td><g:formatBoolean true="可选" false="不可选" boolean="${shopInstance.displayForSelect}"/></td>

                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${shopInstance.lastOrderTime}"/></td>

                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${shopInstance.dateCreated}"/></td>

                <td><g:link action="edit" id="${shopInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${shopInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
