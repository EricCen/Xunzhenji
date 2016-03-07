%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.Manufacture" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'manufacture.label', default: 'Manufacture')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-manufacture" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="manufactureTime"
                              title="${message(code: 'manufacture.manufactureTime.label', default: 'Manufacture Time')}"/>
            <th><g:message code="manufacture.inputProduct.label" default="Input Product"/></th>
            <th><g:message code="manufacture.outputProduct.label" default="Output Product"/></th>
            <g:sortableColumn property="inputQuantity"
                              title="${message(code: 'manufacture.inputQuantity.label', default: 'Input Quantity')}"/>
            <g:sortableColumn property="inputWeight"
                              title="${message(code: 'manufacture.inputWeight.label', default: 'Input Weight')}"/>
            <g:sortableColumn property="outputQuantity"
                              title="${message(code: 'manufacture.outputQuantity.label', default: 'Output Quantity')}"/>
            <g:sortableColumn property="outputWeight"
                              title="${message(code: 'manufacture.outputWeight.label', default: 'Output Weight')}"/>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${manufactureInstanceList}" status="i" var="manufactureInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${manufactureInstance.id}"><g:formatDate date="${manufactureInstance.manufactureTime}" format="yyyy-MM-dd"/></g:link></td>

                <td>${fieldValue(bean: manufactureInstance, field: "inputProduct")}</td>
                <td>${fieldValue(bean: manufactureInstance, field: "outputProduct")}</td>
                <td>${fieldValue(bean: manufactureInstance, field: "inputQuantity")}</td>
                <td>${fieldValue(bean: manufactureInstance, field: "inputWeight")}</td>
                <td>${fieldValue(bean: manufactureInstance, field: "outputQuantity")}</td>
                <td>${fieldValue(bean: manufactureInstance, field: "outputWeight")}</td>
                <td><g:link action="edit" id="${manufactureInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${manufactureInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
