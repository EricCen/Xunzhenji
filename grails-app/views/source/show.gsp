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

<div id="show-source" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list source">
        <table class="userinfoArea source" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${sourceInstance?.name}">
                <tr>
                    <th><span id="name-label" class="property-label"><g:message code="source.name.label"
                                                                                default="Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${sourceInstance}"
                                                                                                field="name"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${sourceInstance?.phone}">
                <tr>
                    <th><span id="phone-label" class="property-label"><g:message code="source.phone.label"
                                                                                 default="Phone"/></span></th>

                    <td><span class="property-value" aria-labelledby="phone-label"><g:fieldValue
                            bean="${sourceInstance}" field="phone"/></span></td>

                </tr>
            </g:if>

            <g:if test="${sourceInstance?.address}">
                <tr>
                    <th><span id="address-label" class="property-label"><g:message code="source.address.label"
                                                                                   default="Address"/></span></th>

                    <td><span class="property-value" aria-labelledby="address-label"><g:fieldValue
                            bean="${sourceInstance}" field="address"/></span></td>

                </tr>
            </g:if>

            <g:if test="${sourceInstance?.remark}">
                <tr>
                    <th><span id="remark-label" class="property-label"><g:message code="source.remark.label"
                                                                                  default="Remark"/></span></th>

                    <td><span class="property-value" aria-labelledby="remark-label"><g:fieldValue
                            bean="${sourceInstance}" field="remark"/></span></td>

                </tr>
            </g:if>
            </tbody>
        </table>
    </ol>
    <g:form url="[resource: sourceInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${sourceInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
