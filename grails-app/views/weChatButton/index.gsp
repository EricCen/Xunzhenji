%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.WeChatButton" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'weChatButton.label', default: 'WeChatButton')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-weChatButton" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="name" title="${message(code: 'weChatButton.name.label', default: 'Name')}"/>
            <g:sortableColumn property="key" title="${message(code: 'weChatButton.key.label', default: 'Key')}"/>

            <g:sortableColumn property="url" title="${message(code: 'weChatButton.url.label', default: 'Url')}"/>

            <g:sortableColumn property="mediaId"
                              title="${message(code: 'weChatButton.mediaId.label', default: 'Media Id')}"/>

            <g:sortableColumn property="buttonType"
                              title="${message(code: 'weChatButton.buttonType.label', default: 'Button Type')}"/>
            <g:sortableColumn property="buttonEventType"
                              title="${message(code: 'weChatButton.buttonEventType.label', default: 'Type')}"/>
            <th>操作</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${weChatButtonInstanceList}" status="i" var="weChatButtonInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${weChatButtonInstance.id}">${fieldValue(bean: weChatButtonInstance, field: "name")}</g:link></td>
                <td>${fieldValue(bean: weChatButtonInstance, field: "key")}</td>

                <td>${fieldValue(bean: weChatButtonInstance, field: "url")}</td>

                <td>${fieldValue(bean: weChatButtonInstance, field: "mediaId")}</td>

                <td>${fieldValue(bean: weChatButtonInstance, field: "buttonType")}</td>

                <td>${fieldValue(bean: weChatButtonInstance, field: "buttonEventType")}</td>

                <td><g:link action="edit" id="${weChatButtonInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${weChatButtonInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
