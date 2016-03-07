<%@ page import="net.xunzhenji.workflow.MiaoXinProcess" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="procurement"><g:message code="farmToShopWorkFlow.procurement.label"
                                                default="Procurement"/></label>
        </th>
        <td><g:select id="procurement" name="procurement.id" from="${net.xunzhenji.shop.Procurement.list()}"
                      optionKey="id" value="${farmToShopWorkFlowInstance?.procurement?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="materialStockMove"><g:message code="farmToShopWorkFlow.materialStockMove.label"
                                                      default="Material Stock Move"/></label>
        </th>
        <td><g:select id="materialStockMove" name="materialStockMove.id" from="${net.xunzhenji.shop.StockMove.list()}"
                      optionKey="id" value="${farmToShopWorkFlowInstance?.materialStockMove?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="manufacture"><g:message code="farmToShopWorkFlow.manufacture.label"
                                                default="Manufacture"/></label>
        </th>
        <td><g:select id="manufacture" name="manufacture.id" from="${net.xunzhenji.shop.Manufacture.list()}"
                      optionKey="id" value="${farmToShopWorkFlowInstance?.manufacture?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="transit"><g:message code="farmToShopWorkFlow.transit.label" default="Transit"/></label>
        </th>
        <td><g:select id="transit" name="transit.id" from="${net.xunzhenji.shop.Transit.list()}" optionKey="id"
                      value="${farmToShopWorkFlowInstance?.transit?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="shopDelivery"><g:message code="farmToShopWorkFlow.shopDelivery.label"
                                                 default="Shop Delivery"/></label>
        </th>
        <td><g:select id="shopDelivery" name="shopDelivery.id" from="${net.xunzhenji.shop.ShopDelivery.list()}"
                      optionKey="id" value="${farmToShopWorkFlowInstance?.shopDelivery?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="productStockMove"><g:message code="farmToShopWorkFlow.productStockMove.label"
                                                     default="Product Stock Move"/></label>
        </th>
        <td><g:select id="productStockMove" name="productStockMove.id" from="${net.xunzhenji.shop.StockMove.list()}"
                      optionKey="id" value="${farmToShopWorkFlowInstance?.productStockMove?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

