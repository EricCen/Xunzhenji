%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.Address" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'address.label', default: 'Address')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-address" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <th><g:message code="address.name.label" default="姓名"/></th>
            <th><g:message code="address.phone.label" default="电话"/></th>
            <th><g:message code="address.city.label" default="城市"/></th>
            <th><g:message code="address.district.label" default="区县"/></th>
            <g:sortableColumn property="street" title="${message(code: 'address.street.label', default: '道路街道')}"/>
            <g:sortableColumn property="address" title="${message(code: 'address.address.label', default: '详细地址')}"/>
            <g:sortableColumn property="disable" title="${message(code: 'address.disable.label', default: 'Disable')}"/>
            <g:sortableColumn property="isDefault"
                              title="${message(code: 'address.isDefault.label', default: 'Is Default')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${addressInstanceList}" status="i" var="addressInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show"
                        id="${addressInstance.id}">${fieldValue(bean: addressInstance, field: "name")}</td>
                <td>${fieldValue(bean: addressInstance, field: "phone")}</td>

                <td>${fieldValue(bean: addressInstance, field: "city")}</td>
                <td>${fieldValue(bean: addressInstance, field: "district")}</td>
                <td>${fieldValue(bean: addressInstance, field: "street")}</g:link></td>
                <td>${fieldValue(bean: addressInstance, field: "address")}</td>
                <td><g:formatBoolean boolean="${addressInstance.disable}"/></td>
                <td><g:formatBoolean boolean="${addressInstance.isDefault}"/></td>
                <td><g:link action="edit" id="${addressInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${addressInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
