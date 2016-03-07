%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.Source" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'source.label', default: 'Source')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-source" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'source.name.label', default: 'Name')}"/>

            <g:sortableColumn property="phone" title="${message(code: 'source.phone.label', default: 'Phone')}"/>

            <g:sortableColumn property="address" title="${message(code: 'source.address.label', default: 'Address')}"/>

            <g:sortableColumn property="remark" title="${message(code: 'source.remark.label', default: 'Remark')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${sourceInstanceList}" status="i" var="sourceInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${sourceInstance.id}">${fieldValue(bean: sourceInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: sourceInstance, field: "phone")}</td>

                <td>${fieldValue(bean: sourceInstance, field: "address")}</td>

                <td>${fieldValue(bean: sourceInstance, field: "remark")}</td>

                <td><g:link action="edit" id="${sourceInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${sourceInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
