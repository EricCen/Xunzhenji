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

<div id="show-shop" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list shop">
        <table class="userinfoArea shop" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${shopInstance?.name}">
                <tr>
                    <th><span id="name-label" class="property-label"><g:message code="shop.name.label"
                                                                                default="Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${shopInstance}"
                                                                                                field="name"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${shopInstance?.parentName}">
                <tr>
                    <th><span id="parentName-label" class="property-label"><g:message code="shop.parentName.label"
                                                                                      default="Parent Name"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="parentName-label"><g:fieldValue
                            bean="${shopInstance}" field="parentName"/></span></td>

                </tr>
            </g:if>

            <g:if test="${shopInstance?.lastOrderTime}">
                <tr>
                    <th><span id="lastOrderTime-label" class="property-label"><g:message code="shop.lastOrderTime.label"
                                                                                         default="Last Order Time"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="lastOrderTime-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${shopInstance?.lastOrderTime}"/></span></td>

                </tr>
            </g:if>



            <g:if test="${shopInstance?.displayForSelect}">
                <tr>
                    <th><span id="displayForSelect-label" class="property-label"><g:message
                            code="shop.displayForSelect.label" default="Display For Select"/></span></th>

                    <td><span class="property-value" aria-labelledby="displayForSelect-label">
                        <g:formatBoolean true="可选" false="不可选" boolean="${shopInstance?.displayForSelect}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${shopInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message code="default.dateCreated.label"
                                                                                       default="Date Created"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${shopInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>
            </tbody>
        </table>
    </ol>
    <g:form url="[resource: shopInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${shopInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
