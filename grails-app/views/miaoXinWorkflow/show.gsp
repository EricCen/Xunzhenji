%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.workflow.MiaoXinWorkflow" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'miaoXinWorkflow.label', default: 'MiaoXinWorkflow')}"/>
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

<div id="show-miaoXinWorkflow" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list miaoXinWorkflow">
        <table class="userinfoArea miaoXinWorkflow" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${miaoXinWorkflowInstance?.deliveryProduct}">
                <tr>
                    <th><span id="deliveryProduct-label" class="property-label"><g:message
                            code="miaoXinWorkflow.deliveryProduct.label" default="Delivery Product"/></span></th>

                    <td><span class="property-value" aria-labelledby="deliveryProduct-label"><g:link
                            controller="shopProduct" action="show"
                            id="${miaoXinWorkflowInstance?.deliveryProduct?.id}">${miaoXinWorkflowInstance?.deliveryProduct?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${miaoXinWorkflowInstance?.deliveryWarehouse}">
                <tr>
                    <th><span id="deliveryWarehouse-label" class="property-label"><g:message
                            code="miaoXinWorkflow.deliveryWarehouse.label" default="Delivery Warehouse"/></span></th>

                    <td><span class="property-value" aria-labelledby="deliveryWarehouse-label"><g:link
                            controller="warehouse" action="show"
                            id="${miaoXinWorkflowInstance?.deliveryWarehouse?.id}">${miaoXinWorkflowInstance?.deliveryWarehouse?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${miaoXinWorkflowInstance?.manufactureProduct}">
                <tr>
                    <th><span id="manufactureProduct-label" class="property-label"><g:message
                            code="miaoXinWorkflow.manufactureProduct.label" default="Manufacture Input Product"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="manufactureProduct-label"><g:link
                            controller="shopProduct" action="show"
                            id="${miaoXinWorkflowInstance?.manufactureProduct?.id}">${miaoXinWorkflowInstance?.manufactureProduct?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${miaoXinWorkflowInstance?.manufactureWarehouse}">
                <tr>
                    <th><span id="manufactureWarehouse-label" class="property-label"><g:message
                            code="miaoXinWorkflow.manufactureWarehouse.label" default="Manufacture Warehouse"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="manufactureWarehouse-label"><g:link
                            controller="warehouse" action="show"
                            id="${miaoXinWorkflowInstance?.manufactureWarehouse?.id}">${miaoXinWorkflowInstance?.manufactureWarehouse?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: miaoXinWorkflowInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${miaoXinWorkflowInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
