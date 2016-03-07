%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.workflow.MiaoXinProcess" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'miaoXinProcess.label', default: 'MiaoXinProcess')}"/>
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

<div id="show-miaoXinProcess" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list miaoXinProcess">
        <table class="userinfoArea miaoXinProcess" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <g:if test="${miaoXinProcessInstance?.date}">
                <tr>
                    <th><span id="date-label" class="property-label"><g:message code="miaoXinProcess.date.label"
                                                                                default="Date"/></span></th>

                    <td><span class="property-value" aria-labelledby="date-label"><g:formatDate
                            format="yyyy-MM-dd" date="${miaoXinProcessInstance?.date}"/></span></td>

                </tr>
            </g:if>
            <g:if test="${miaoXinProcessInstance?.procurements}">
                <tr>
                    <th><span id="procurements-label" class="property-label"><g:message
                            code="miaoXinProcess.procurements.label" default="Procurements"/></span></th>
                    <td>
                        <g:each in="${miaoXinProcessInstance.procurements}" var="p">
                            <span class="property-value" aria-labelledby="procurements-label"><g:link
                                    controller="procurement" action="show"
                                    id="${p.id}">${p?.encodeAsHTML()}</g:link></span><br>
                        </g:each>
                    </td>
                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.manufacture}">
                <tr>
                    <th><span id="manufacture-label" class="property-label"><g:message
                            code="miaoXinProcess.manufacture.label" default="Manufacture"/></span></th>

                    <td><span class="property-value" aria-labelledby="manufacture-label"><g:link
                            controller="manufacture" action="show"
                            id="${miaoXinProcessInstance?.manufacture?.id}">${miaoXinProcessInstance?.manufacture?.encodeAsHTML()}</g:link></span>
                    </td>
                </tr>
            </g:if>
            <g:if test="${miaoXinProcessInstance?.deliveries}">
                <tr>
                    <th><span id="deliveries-label" class="property-label"><g:message
                            code="miaoXinProcess.deliveries.label" default="Deliveries"/></span></th>
                    <td>
                        <g:each in="${miaoXinProcessInstance.deliveries}" var="d">
                            <span class="property-value" aria-labelledby="deliveries-label"><g:link
                                    controller="shopDelivery" action="show"
                                    id="${d.id}">${d?.encodeAsHTML()}</g:link></span><br>
                        </g:each>
                    </td>
                </tr>
            </g:if>
            <g:if test="${miaoXinProcessInstance?.deliveryProductionRate}">
                <tr>
                    <th><span id="deliveryProductionRate-label" class="property-label"><g:message
                            code="miaoXinProcess.deliveryProductionRate.label"
                            default="Delivery Production Rate"/></span></th>

                    <td><span class="property-value" aria-labelledby="deliveryProductionRate-label"><g:fieldValue
                            bean="${miaoXinProcessInstance}" field="deliveryProductionRate"/></span></td>

                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.deliveredStockWeight}">
                <tr>
                    <th><span id="deliveredStockWeight-label" class="property-label"><g:message
                            code="miaoXinProcess.deliveredStockWeight.label" default="Delivered Stock Weight"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="deliveredStockWeight-label"><g:fieldValue
                            bean="${miaoXinProcessInstance}" field="deliveredStockWeight"/></span></td>

                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.initialDeliveryStockWeight}">
                <tr>
                    <th><span id="initialDeliveryStockWeight-label" class="property-label"><g:message
                            code="miaoXinProcess.initialDeliveryStockWeight.label"
                            default="Initial Delivery Stock Weight"/></span></th>

                    <td><span class="property-value" aria-labelledby="initialDeliveryStockWeight-label"><g:fieldValue
                            bean="${miaoXinProcessInstance}" field="initialDeliveryStockWeight"/></span></td>

                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.initialManufactureStockQuantity}">
                <tr>
                    <th><span id="initialManufactureStockQuantity-label" class="property-label"><g:message
                            code="miaoXinProcess.initialManufactureStockQuantity.label"
                            default="Initial Manufacture Stock Quantity"/></span></th>

                    <td><span class="property-value"
                              aria-labelledby="initialManufactureStockQuantity-label"><g:fieldValue
                                bean="${miaoXinProcessInstance}" field="initialManufactureStockQuantity"/></span></td>

                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.initialManufactureStockWeight}">
                <tr>
                    <th><span id="initialManufactureStockWeight-label" class="property-label"><g:message
                            code="miaoXinProcess.initialManufactureStockWeight.label"
                            default="Initial Manufacture Stock Weight"/></span></th>

                    <td><span class="property-value" aria-labelledby="initialManufactureStockWeight-label"><g:fieldValue
                            bean="${miaoXinProcessInstance}" field="initialManufactureStockWeight"/></span></td>

                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.stockMoves}">
                <tr>
                    <th><span id="stockMoves-label" class="property-label"><g:message
                            code="miaoXinProcess.stockMoves.label" default="Stock Moves"/></span></th>
                <td>
                    <g:each in="${miaoXinProcessInstance.stockMoves.sort{a,b->a.dateCreated<=>b.dateCreated}}" var="s">
                        <span class="property-value" aria-labelledby="stockMoves-label"><g:link
                                controller="stockMove" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span><br>

                    </g:each>
                </td>
                </tr>
            </g:if>

            <g:if test="${miaoXinProcessInstance?.workflow}">
                <tr>
                    <th><span id="workflow-label" class="property-label"><g:message code="miaoXinProcess.workflow.label"
                                                                                    default="Workflow"/></span></th>

                    <td><span class="property-value" aria-labelledby="workflow-label"><g:link
                            controller="miaoXinWorkflow" action="show"
                            id="${miaoXinProcessInstance?.workflow?.id}">${miaoXinProcessInstance?.workflow?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>
            <g:if test="${miaoXinProcessInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message
                            code="default.dateCreated.label" default="Date Created"/></span></th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${miaoXinProcessInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>
            <g:if test="${miaoXinProcessInstance?.lastUpdated}">
                <tr>
                    <th><span id="lastUpdated-label" class="property-label"><g:message
                            code="default.lastUpdated.label" default="Last Updated"/></span></th>

                    <td><span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${miaoXinProcessInstance?.lastUpdated}"/></span></td>

                </tr>
            </g:if>
            </tbody>
        </table>
    </ol>
    <g:form url="[resource: miaoXinProcessInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${miaoXinProcessInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
