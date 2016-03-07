<%@ page import="net.xunzhenji.shop.Manufacture" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="manufactureTime"><g:message code="manufacture.manufactureTime.label"
                                                    default="Manufacture Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="manufactureTime" precision="day" value="${manufactureInstance?.manufactureTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="inputProduct"><g:message code="manufacture.inputProduct.label" default="Input Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="inputProduct" name="inputProduct.id" from="${net.xunzhenji.shop.ShopProduct.list()}"
                      optionKey="id" required="" value="${manufactureInstance?.inputProduct?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="outputProduct"><g:message code="manufacture.outputProduct.label" default="Output Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="outputProduct" name="outputProduct.id" from="${net.xunzhenji.shop.ShopProduct.list()}"
                      optionKey="id" required="" value="${manufactureInstance?.outputProduct?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="inputQuantity"><g:message code="manufacture.inputQuantity.label" default="Input Quantity"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" name="inputQuantity" value="${fieldValue(bean: manufactureInstance, field: 'inputQuantity')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="inputWeight"><g:message code="manufacture.inputWeight.label" default="Input Weight"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" step="0.01" name="inputWeight" value="${fieldValue(bean: manufactureInstance, field: 'inputWeight')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="outputQuantity"><g:message code="manufacture.outputQuantity.label"
                                                   default="Output Quantity"/><span class="required-indicator">*</span>
            </label>
        </th>
        <td><g:field type="number" class="px" name="outputQuantity" value="${fieldValue(bean: manufactureInstance, field: 'outputQuantity')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="outputWeight"><g:message code="manufacture.outputWeight.label" default="Output Weight"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" step="0.01" name="outputWeight" value="${fieldValue(bean: manufactureInstance, field: 'outputWeight')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="productionRate"><g:message code="manufacture.productionRate.label"
                                                   default="Production Rate"/><span class="required-indicator">*</span>
            </label>
        </th>
        <td><g:field type="number" class="px" step="0.01" name="productionRate" value="${fieldValue(bean: manufactureInstance, field: 'productionRate')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

