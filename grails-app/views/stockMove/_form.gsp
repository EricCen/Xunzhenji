<%@ page import="net.xunzhenji.shop.StockMove" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="product"><g:message code="stockMove.product.label" default="Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="product" name="product.id" from="${net.xunzhenji.shop.ShopProduct.list()}" optionKey="id"
                      required="" value="${stockMoveInstance?.product?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="direction"><g:message code="stockMove.direction.label" default="Direction"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="direction" from="${net.xunzhenji.shop.StockMove$MoveDirection?.values()}"
                      keys="${net.xunzhenji.shop.StockMove$MoveDirection.values()*.name()}" required=""
                      value="${stockMoveInstance?.direction?.name()}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="warehouse"><g:message code="stockMove.warehouse.label" default="Warehouse"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="warehouse" name="warehouse.id" from="${net.xunzhenji.shop.Warehouse.list()}" optionKey="id"
                      required="" value="${stockMoveInstance?.warehouse?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantity"><g:message code="stockMove.quantity.label" default="Quantity"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field type="number" class="px" name="quantity" value="${fieldValue(bean: stockMoveInstance, field: 'quantity')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weight"><g:message code="stockMove.weight.label" default="Weight"/></label>
        </th>
        <td><g:field type="number" step="0.01" class="px" name="weight" value="${fieldValue(bean: stockMoveInstance, field: 'weight')}"/>
        </td>
    </tr>
    </tbody>
</table>


