<%@ page import="net.xunzhenji.shop.Procurement" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="procurementTime"><g:message code="procurement.procurementTime.label"
                                                    default="Procurement Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="procurementTime" precision="day" value="${procurementInstance?.procurementTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="product"><g:message code="procurement.product.label" default="Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="product" name="product.id" from="${net.xunzhenji.shop.ShopProduct.list()}"
                      optionKey="id" required="" value="${procurementInstance?.product?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantity"><g:message code="procurement.quantity.label" default="Quantity"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" name="quantity" value="${fieldValue(bean: procurementInstance, field: 'quantity')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weight"><g:message code="procurement.weight.label" default="Weight"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" step="0.01" class="px" name="weight" value="${fieldValue(bean: procurementInstance, field: 'weight')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="price"><g:message code="procurement.price.label" default="Price"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" name="price" step="0.1" value="${fieldValue(bean: procurementInstance, field: 'price')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="source"><g:message code="procurement.source.label" default="Source"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td>
            <g:select id="source" name="source.id" from="${net.xunzhenji.shop.Source.list()}"
                      optionKey="id" required="" value="${procurementInstance?.source?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="workflow"><g:message code="procurement.workflow.label" default="Process"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="workflow" name="workflow.id" from="${net.xunzhenji.workflow.MiaoXinProcess.list()}"
                      optionKey="id" required="" value="${procurementInstance?.workflow?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>