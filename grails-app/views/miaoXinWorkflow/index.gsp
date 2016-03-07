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
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-miaoXinWorkflow" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <th><g:message code="default.name.label" default="Name"/></th>

            <th><g:message code="miaoXinWorkflow.deliveryProduct.label" default="Delivery Product"/></th>

            <th><g:message code="miaoXinWorkflow.deliveryWarehouse.label" default="Delivery Warehouse"/></th>

            <th><g:message code="miaoXinWorkflow.manufactureProduct.label" default="Manufacture Input Product"/></th>

            <th><g:message code="miaoXinWorkflow.manufactureWarehouse.label" default="Manufacture Warehouse"/></th>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${miaoXinWorkflowInstanceList}" status="i" var="miaoXinWorkflowInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${miaoXinWorkflowInstance.id}">${fieldValue(bean: miaoXinWorkflowInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: miaoXinWorkflowInstance, field: "deliveryProduct")}</td>
                <td>${fieldValue(bean: miaoXinWorkflowInstance, field: "deliveryWarehouse")}</td>

                <td>${fieldValue(bean: miaoXinWorkflowInstance, field: "manufactureProduct")}</td>

                <td>${fieldValue(bean: miaoXinWorkflowInstance, field: "manufactureWarehouse")}</td>

                <td><g:link action="edit" id="${miaoXinWorkflowInstance.id}">编辑</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${miaoXinWorkflowInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
