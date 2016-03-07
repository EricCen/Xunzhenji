<%@ page import="net.xunzhenji.shop.Source" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="source.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required="" value="${sourceInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="phone"><g:message code="source.phone.label" default="Phone"/></label>
        </th>
        <td><g:textField class="px" name="phone" value="${sourceInstance?.phone}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="address"><g:message code="source.address.label" default="Address"/></label>
        </th>
        <td><g:textField class="px" name="address" value="${sourceInstance?.address}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="remark"><g:message code="source.remark.label" default="Remark"/></label>
        </th>
        <td><g:textField class="px" name="remark" value="${sourceInstance?.remark}"/>
        </td>
    </tr>
    </tbody>
</table>

