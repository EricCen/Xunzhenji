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

<div id="show-shopFans" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list shopFans">
        <table class="userinfoArea shopFans" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${shopFansInstance?.fans}">
                <tr>
                    <th><span id="fans-label" class="property-label"><g:message code="shopFans.fans.label"
                                                                                default="Fans"/></span></th>

                    <td><span class="property-value" aria-labelledby="fans-label"><g:link controller="weChatFans"
                                                                                          action="show"
                                                                                          id="${shopFansInstance?.fans?.id}">${shopFansInstance?.fans?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${shopFansInstance?.shop}">
                <tr>
                    <th><span id="shop-label" class="property-label"><g:message code="shopFans.shop.label"
                                                                                default="Shop"/></span></th>

                    <td><span class="property-value" aria-labelledby="shop-label"><g:link controller="shop"
                                                                                          action="show"
                                                                                          id="${shopFansInstance?.shop?.id}">${shopFansInstance?.shop?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: shopFansInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${shopFansInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
