<%@ page import="net.xunzhenji.shop.ShopDelivery" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="shop"><g:message code="shopDelivery.shop.label" default="Shop"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="shop" name="shop.id" from="${net.xunzhenji.shop.Shop.list()}" optionKey="id" required=""
                      value="${shopDeliveryInstance?.shop?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="product"><g:message code="shopDelivery.product.label" default="Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="product" name="product.id" from="${net.xunzhenji.shop.ShopProduct.list()}" optionKey="id"
                      required="" value="${shopDeliveryInstance?.product?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveryTime"><g:message code="shopDelivery.deliveryTime.label" default="Delivery Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="deliveryTime" precision="day" value="${shopDeliveryInstance?.deliveryTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantity"><g:message code="shopDelivery.quantity.label" default="Quantity"/></label>
        </th>
        <td><g:field name="quantity" type="number" class="px" step="0.1" value="${fieldValue(bean: shopDeliveryInstance, field: 'quantity')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weight"><g:message code="shopDelivery.weight.label" default="Weight"/></label>
        </th>
        <td><g:field type="number" step="0.1" name="weight" class="px" value="${fieldValue(bean: shopDeliveryInstance, field: 'weight')}"/>
        </td>
    </tr>
    </tbody>
</table>
