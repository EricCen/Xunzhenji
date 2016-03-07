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

<div id="show-manufacture" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list manufacture">
        <table class="userinfoArea manufacture" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${manufactureInstance?.inputProduct}">
                <tr>
                    <th><span id="inputProduct-label" class="property-label"><g:message
                            code="manufacture.inputProduct.label" default="Input Product"/></span></th>

                    <td><span class="property-value" aria-labelledby="inputProduct-label"><g:link
                            controller="shopProduct" action="show"
                            id="${manufactureInstance?.inputProduct?.id}">${manufactureInstance?.inputProduct?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.inputQuantity}">
                <tr>
                    <th><span id="inputQuantity-label" class="property-label"><g:message
                            code="manufacture.inputQuantity.label" default="Input Quantity"/></span></th>

                    <td><span class="property-value" aria-labelledby="inputQuantity-label"><g:fieldValue
                            bean="${manufactureInstance}" field="inputQuantity"/></span></td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.inputWeight}">
                <tr>
                    <th><span id="inputWeight-label" class="property-label"><g:message
                            code="manufacture.inputWeight.label" default="Input Weight"/></span></th>

                    <td><span class="property-value" aria-labelledby="inputWeight-label"><g:fieldValue
                            bean="${manufactureInstance}" field="inputWeight"/></span></td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.manufactureTime}">
                <tr>
                    <th><span id="manufactureTime-label" class="property-label"><g:message
                            code="manufacture.manufactureTime.label" default="Manufacture Time"/></span></th>

                    <td><span class="property-value" aria-labelledby="manufactureTime-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${manufactureInstance?.manufactureTime}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.outputProduct}">
                <tr>
                    <th><span id="outputProduct-label" class="property-label"><g:message
                            code="manufacture.outputProduct.label" default="Output Product"/></span></th>

                    <td><span class="property-value" aria-labelledby="outputProduct-label"><g:link
                            controller="shopProduct" action="show"
                            id="${manufactureInstance?.outputProduct?.id}">${manufactureInstance?.outputProduct?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.outputQuantity}">
                <tr>
                    <th><span id="outputQuantity-label" class="property-label"><g:message
                            code="manufacture.outputQuantity.label" default="Output Quantity"/></span></th>

                    <td><span class="property-value" aria-labelledby="outputQuantity-label"><g:fieldValue
                            bean="${manufactureInstance}" field="outputQuantity"/></span></td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.outputWeight}">
                <tr>
                    <th><span id="outputWeight-label" class="property-label"><g:message
                            code="manufacture.outputWeight.label" default="Output Weight"/></span></th>

                    <td><span class="property-value" aria-labelledby="outputWeight-label"><g:fieldValue
                            bean="${manufactureInstance}" field="outputWeight"/></span></td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.productionRate}">
                <tr>
                    <th><span id="productionRate-label" class="property-label"><g:message
                            code="manufacture.productionRate.label" default="Production Rate"/></span></th>

                    <td><span class="property-value" aria-labelledby="productionRate-label"><g:fieldValue
                            bean="${manufactureInstance}" field="productionRate"/></span></td>

                </tr>
            </g:if>
            <g:if test="${manufactureInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message
                            code="default.dateCreated.label" default="Date Created"/></span></th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${manufactureInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${manufactureInstance?.lastUpdated}">
                <tr>
                    <th><span id="lastUpdated-label" class="property-label"><g:message
                            code="default.lastUpdated.label" default="Last Updated"/></span></th>

                    <td><span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${manufactureInstance?.lastUpdated}"/></span></td>

                </tr>
            </g:if>
            </tbody>
        </table>
    </ol>
    <g:form url="[resource: manufactureInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${manufactureInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
