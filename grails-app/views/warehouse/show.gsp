%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.Warehouse" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'warehouse.label', default: 'Warehouse')}"/>
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

<div id="show-warehouse" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list warehouse">
        <table class="userinfoArea warehouse" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <g:if test="${warehouseInstance?.name}">
                <tr>
                    <th><span id="name-label" class="property-label"><g:message code="warehouse.name.label"
                                                                                default="Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue
                            bean="${warehouseInstance}" field="name"/></span></td>

                </tr>
            </g:if>


            <g:if test="${warehouseInstance?.location}">
                <tr>
                    <th><span id="location-label" class="property-label"><g:message code="warehouse.location.label"
                                                                                    default="Location"/></span></th>

                    <td><span class="property-value" aria-labelledby="location-label"><g:fieldValue
                            bean="${warehouseInstance}" field="location"/></span></td>

                </tr>
            </g:if>


            <g:if test="${warehouseInstance?.stockItems}">
                <tr>
                    <th><span id="stockItems-label" class="property-label"><g:message code="warehouse.stockItems.label"
                                                                                      default="Stock Items"/></span>
                    </th>

                    <g:each in="${warehouseInstance.stockItems}" var="s">
                        <td><span class="property-value" aria-labelledby="stockItems-label"><g:link
                                controller="stockItem" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
                        </td>
                    </g:each>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: warehouseInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${warehouseInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
