<%@ page import="net.xunzhenji.mall.Express" %>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="express.name.label" default="快递名称"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required=""
                         value="${expressInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="displayName"><g:message code="express.displayName.label" default="显示名称"/></label>
        </th>
        <td><g:textField class="px" name="displayName"
                         value="${expressInstance?.displayName}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="queryName"><g:message code="express.queryName.label" default="查询名称"/></label>
        </th>
        <td><g:textField class="px" name="queryName"
                         value="${expressInstance?.queryName}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="firstWeightPrice"><g:message code="express.firstWeightPrice.label" default="首重价格"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="firstWeightPrice" class="px" value="${fieldValue(bean: expressInstance, field: 'firstWeightPrice')}"
                     required=""/>元
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="continuedWeightPrice"><g:message code="express.continuedWeightPrice.label" default="续重价格"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="continuedWeightPrice" class="px"
                     value="${fieldValue(bean: expressInstance, field: 'continuedWeightPrice')}" required=""/>元
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="firstWeightTo"><g:message code="express.firstWeightTo.label" default="首重重量"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="firstWeightTo" type="number" class="px" value="${expressInstance.firstWeightTo}" required=""/>kg
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="phone"><g:message code="express.phone.label" default="Phone"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="phone" required="" value="${expressInstance?.phone}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliverRange"><g:message code="express.range.label" default="Range"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="deliverRange" required="" value="${expressInstance?.deliverRange}"/>
        </td>
    </tr>
    </tbody>
</table>

