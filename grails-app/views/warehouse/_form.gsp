<%@ page import="net.xunzhenji.shop.Warehouse" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="warehouse.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required="" value="${warehouseInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="location"><g:message code="warehouse.location.label" default="Location"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="location" required=""
                         value="${warehouseInstance?.location}"/>
        </td>
    </tr>
    </tbody>
</table>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="stockItems"><g:message code="warehouse.stockItems.label" default="Stock Items"/></label>
        </th>
        <td><g:select name="stockItems" from="${net.xunzhenji.shop.StockItem.list()}" multiple="multiple" optionKey="id"
                      size="5" value="${warehouseInstance?.stockItems*.id}" class="many-to-many"/>
        </td>
    </tr>
    </tbody>
</table>

