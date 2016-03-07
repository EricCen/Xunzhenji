<%@ page import="net.xunzhenji.shop.ShopPrice; net.xunzhenji.shop.Shop" %>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="shop.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required="" value="${shopInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="parentName"><g:message code="shop.parentName.label" default="Parent Name"/></label>
        </th>
        <td><g:textField class="px" name="parentName" value="${shopInstance?.parentName}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="lastOrderTime"><g:message code="shop.lastOrderTime.label" default="Last Order Time"/></label>
        </th>
        <td><g:datePicker name="lastOrderTime" precision="day" value="${shopInstance?.lastOrderTime}" default="none"
                          noSelection="['': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="displayForSelect"><g:message code="shop.displayForSelect.label"
                                                     default="Display For Select"/></label>
        </th>
        <td><g:checkBox name="displayForSelect" value="${shopInstance?.displayForSelect}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="shop.products.label"
                              default="产品"/></label>
        </th>
        <td>
            <g:each in="${net.xunzhenji.shop.ShopProduct.list()}" var="product">
                <div>
                    <span style="padding-right: 10px">${product.name}</span>
                    <g:checkBox name="product_${product.id}" checked="${shopInstance?.products?.find{it.id == product?.id} != null}"/>
                    <g:textField class="px" style="width:80px;" name="price_${product.id}"
                                 value="15"/>元
                </div>
            </g:each>
        </td>
    </tr>
    </tbody>
</table>
