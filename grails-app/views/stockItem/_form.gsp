<%@ page import="net.xunzhenji.shop.StockItem" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weight"><g:message code="stockItem.weight.label" default="Weight"/></label>
        </th>
        <td><g:field name="weight" value="${fieldValue(bean: stockItemInstance, field: 'weight')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="product"><g:message code="stockItem.product.label" default="Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="product" name="product.id" from="${net.xunzhenji.shop.ShopProduct.list()}" optionKey="id"
                      required="" value="${stockItemInstance?.product?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantity"><g:message code="stockItem.quantity.label" default="Quantity"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="quantity" value="${fieldValue(bean: stockItemInstance, field: 'quantity')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

