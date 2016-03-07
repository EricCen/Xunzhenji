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
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm"/><g:message
                code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-weChatFansActivity" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list weChatFansActivity">
        <table class="userinfoArea weChatFansActivity" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${weChatFansActivityInstance?.actionContent}">
                <tr>
                    <th><span id="actionContent-label" class="property-label"><g:message
                            code="weChatFansActivity.actionContent.label" default="Action Content"/></span></th>

                    <td><span class="property-value" aria-labelledby="actionContent-label"><g:fieldValue
                            bean="${weChatFansActivityInstance}" field="actionContent"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansActivityInstance?.product}">
                <tr>
                    <th><span id="product-label" class="property-label"><g:message
                            code="weChatFansActivity.product.label" default="Product"/></span></th>

                    <td><span class="property-value" aria-labelledby="product-label"><g:link controller="product"
                                                                                             action="show"
                                                                                             id="${weChatFansActivityInstance?.product?.id}">${weChatFansActivityInstance?.product?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${weChatFansActivityInstance?.actionType}">
                <tr>
                    <th><span id="actionType-label" class="property-label"><g:message
                            code="weChatFansActivity.actionType.label" default="Action Type"/></span></th>

                    <td><span class="property-value" aria-labelledby="actionType-label"><g:fieldValue
                            bean="${weChatFansActivityInstance}" field="actionType"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansActivityInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message
                            code="weChatFansActivity.dateCreated.label" default="Date Created"/></span></th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatFansActivityInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansActivityInstance?.fans}">
                <tr>
                    <th><span id="fans-label" class="property-label"><g:message code="weChatFansActivity.fans.label"
                                                                                default="Fans"/></span></th>

                    <td><span class="property-value" aria-labelledby="fans-label"><g:link controller="weChatFans"
                                                                                          action="show"
                                                                                          id="${weChatFansActivityInstance?.fans?.id}">${weChatFansActivityInstance?.fans?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: weChatFansActivityInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${weChatFansActivityInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
