%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.WeChatFansActivity" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'weChatFansActivity.label', default: 'WeChatFansActivity')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link controller="weChatFans" action="activeFans" class='btnGrayS vm bigbtn'>
        <asset:image src="text.png" class="vm"/>返回互动粉丝
    </g:link>
</div>

<div id="list-weChatFansActivity" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <th><g:message code="weChatFans.label" default="Fans"/></th>

            <g:sortableColumn property="dateCreated" title="互动时间"/>

            <g:sortableColumn property="actionType"
                              title="${message(code: 'weChatFansActivity.actionType.label', default: 'Action Type')}"/>

            <g:sortableColumn property="actionContent"
                              title="${message(code: 'weChatFansActivity.actionContent.label', default: 'Action Content')}"/>

            <th><g:message code="product.label" default="Product"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${weChatFansActivityInstanceList}" status="i" var="weChatFansActivityInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="show" controller="weChatFans"
                            id="${weChatFansActivityInstance?.fans?.id}">${weChatFansActivityInstance?.fans?.nickName}<br>
                    <g:if test="${weChatFansActivityInstance?.fans?.userInfo}">${weChatFansActivityInstance?.fans?.userInfo.name}</g:if></g:link>
                </td>
                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${weChatFansActivityInstance.dateCreated}"/></td>

                <td>${fieldValue(bean: weChatFansActivityInstance, field: "actionType")}</td>

                <td>${fieldValue(bean: weChatFansActivityInstance, field: "actionContent")}</td>

                <td>${fieldValue(bean: weChatFansActivityInstance, field: "product")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${weChatFansActivityInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
