<%@ page import="net.xunzhenji.workflow.MiaoXinProcess" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="date"><g:message code="miaoXinProcess.date.label" default="Date"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="date" precision="day" value="${miaoXinProcessInstance?.date}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="workflow"><g:message code="miaoXinProcess.workflow.label" default="Workflow"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="workflow" name="workflow.id" from="${net.xunzhenji.workflow.MiaoXinWorkflow.list()}"
                      optionKey="id" required="" value="${miaoXinProcessInstance?.workflow?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="miaoXinProcess.procurements.label"
                              default="Procurements"/></label>
        </th>
        <td>
            <ul class="one-to-many">
                <g:each in="${miaoXinProcessInstance?.procurements ?}" var="p">
                    <li><g:link controller="procurement" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                    <g:link controller="procurement" action="create"
                            params="['miaoXinProcess.id': miaoXinProcessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'procurement.label', default: 'Procurement')])}</g:link>
                </li>
            </ul>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="manufacture"><g:message code="miaoXinProcess.manufacture.label" default="Manufacture"/></label>
        </th>
        <td><g:select id="manufacture" name="manufacture.id" from="${net.xunzhenji.shop.Manufacture.list()}"
                      optionKey="id" value="${miaoXinProcessInstance?.manufacture?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveries"><g:message code="miaoXinProcess.deliveries.label" default="Deliveries"/></label>
        </th>
        <td><g:select name="deliveries" from="${net.xunzhenji.shop.ShopDelivery.list()}" multiple="multiple"
                      optionKey="id" size="5" value="${miaoXinProcessInstance?.deliveries*.id}" class="many-to-many"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveryProductionRate"><g:message code="miaoXinProcess.deliveryProductionRate.label"
                                                           default="Delivery Production Rate"/></label>
        </th>
        <td><g:field type="number" step="0.01" class="px" name="deliveryProductionRate"
                     value="${fieldValue(bean: miaoXinProcessInstance, field: 'deliveryProductionRate')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="initialManufactureStockQuantity"><g:message
                    code="miaoXinProcess.initialManufactureStockQuantity.label"
                    default="Initial Manufacture Stock Quantity"/><span class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" name="initialManufactureStockQuantity"
                     value="${fieldValue(bean: miaoXinProcessInstance, field: 'initialManufactureStockQuantity')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="initialManufactureStockWeight"><g:message
                    code="miaoXinProcess.initialManufactureStockWeight.label"
                    default="Initial Manufacture Stock Weight"/><span class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" step="0.01" class="px" name="initialManufactureStockWeight"
                     value="${fieldValue(bean: miaoXinProcessInstance, field: 'initialManufactureStockWeight')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="initialDeliveryStockWeight"><g:message code="miaoXinProcess.initialDeliveryStockWeight.label"
                                                               default="Initial Delivery Stock Weight"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" step="0.01" class="px" name="initialDeliveryStockWeight"
                     value="${fieldValue(bean: miaoXinProcessInstance, field: 'initialDeliveryStockWeight')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveredStockWeight"><g:message code="miaoXinProcess.deliveredStockWeight.label"
                                                         default="Delivered Stock Weight"/></label>
        </th>
        <td><g:field type="number" step="0.01" class="px" name="deliveredStockWeight"
                     value="${fieldValue(bean: miaoXinProcessInstance, field: 'deliveredStockWeight')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="stockMoves"><g:message code="miaoXinProcess.stockMoves.label" default="Stock Moves"/></label>
        </th>
        <td><g:select name="stockMoves" from="${net.xunzhenji.shop.StockMove.list()}" multiple="multiple" optionKey="id"
                      size="5" value="${miaoXinProcessInstance?.stockMoves*.id}" class="many-to-many"/>
        </td>
    </tr>
    </tbody>
</table>

