<%@ page import="net.xunzhenji.workflow.MiaoXinWorkflow" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="default.name.label" default="Name"/></label>
        </th>
        <td><g:field name="name" type="text" class="px" step="0.1" value="${fieldValue(bean: miaoXinWorkflowInstance, field: 'name')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="manufactureProduct"><g:message code="miaoXinWorkflow.manufactureProduct.label"
                                                       default="Manufacture Input Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="manufactureProduct" name="manufactureProduct.id"
                      from="${net.xunzhenji.shop.ShopProduct.list()}" optionKey="id" required=""
                      value="${miaoXinWorkflowInstance?.manufactureProduct?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveryProduct"><g:message code="miaoXinWorkflow.deliveryProduct.label"
                                                    default="Delivery Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="deliveryProduct" name="deliveryProduct.id" from="${net.xunzhenji.shop.ShopProduct.list()}"
                      optionKey="id" required="" value="${miaoXinWorkflowInstance?.deliveryProduct?.id}"
                      class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="manufactureWarehouse"><g:message code="miaoXinWorkflow.manufactureWarehouse.label"
                                                         default="Manufacture Warehouse"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="manufactureWarehouse" name="manufactureWarehouse.id"
                      from="${net.xunzhenji.shop.Warehouse.list()}" optionKey="id" required=""
                      value="${miaoXinWorkflowInstance?.manufactureWarehouse?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveryWarehouse"><g:message code="miaoXinWorkflow.deliveryWarehouse.label"
                                                      default="Delivery Warehouse"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="deliveryWarehouse" name="deliveryWarehouse.id" from="${net.xunzhenji.shop.Warehouse.list()}"
                      optionKey="id" required="" value="${miaoXinWorkflowInstance?.deliveryWarehouse?.id}"
                      class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>