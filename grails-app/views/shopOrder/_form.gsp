<%@ page import="net.xunzhenji.shop.ShopOrder" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveryMan"><g:message code="shopOrder.deliveryMan.label" default="Delivery Man"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="deliveryMan" name="deliveryMan.id" from="${net.xunzhenji.shop.DeliveryMan.list()}"
                      optionKey="id" required="" value="${shopOrderInstance?.deliveryMan?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantity"><g:message code="shopOrder.quantity.label" default="Quantity"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="quantity" value="${fieldValue(bean: shopOrderInstance, field: 'quantity')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quote"><g:message code="shopOrder.quote.label" default="Quote"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="quote" name="quote.id" from="${net.xunzhenji.shop.Quote.list()}" optionKey="id" required=""
                      value="${shopOrderInstance?.quote?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="shopOrderStatus"><g:message code="shopOrder.shopOrderStatus.label"
                                                    default="Shop Order Status"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="shopOrderStatus" from="${net.xunzhenji.shop.ShopOrderStatus?.values()}"
                      keys="${net.xunzhenji.shop.ShopOrderStatus.values()*.name()}" required=""
                      value="${shopOrderInstance?.shopOrderStatus?.name()}"/>
        </td>
    </tr>
    </tbody>
</table>

