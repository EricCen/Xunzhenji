%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.ShopFans" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'shopFans.label', default: 'ShopFans')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-shopFans" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>

            <th><g:message code="shopFans.fans.label" default="Fans"/></th>

            <th><g:message code="shopFans.shop.label" default="Shop"/></th>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${shopFansInstanceList}" status="i" var="shopFansInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${shopFansInstance.id}">${fieldValue(bean: shopFansInstance, field: "fans")}</g:link></td>

                <td>${fieldValue(bean: shopFansInstance, field: "shop")}</td>

                <td><g:link action="edit" id="${shopFansInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${shopFansInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
