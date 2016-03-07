<%@ page import="net.xunzhenji.mall.Address" %>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="address.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required="" value="${addressInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="phone"><g:message code="address.phone.label" default="Phone"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="phone" required="" value="${addressInstance?.phone}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="city"><g:message code="address.city.label" default="City"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="city" name="city.id" from="${net.xunzhenji.mall.City.list()}" optionKey="id" required=""
                      value="${addressInstance?.city?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="district"><g:message code="address.district.label" default="District"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="district" name="district.id" from="${net.xunzhenji.mall.District.list()}" optionKey="id"
                      required="" value="${addressInstance?.district?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="street"><g:message code="address.street.label" default="Street"/></label>
        </th>
        <td><g:textField class="px" name="street" value="${addressInstance?.street}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="address"><g:message code="address.address.label" default="Address"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="address" required=""
                         value="${addressInstance?.address}"/>
        </td>
    </tr>
    </tbody>
</table>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="disable"><g:message code="address.disable.label" default="Disable"/></label>
        </th>
        <td><g:checkBox name="disable" value="${addressInstance?.disable}"/>
        </td>
    </tr>
    </tbody>
</table>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="isDefault"><g:message code="address.isDefault.label" default="Is Default"/></label>
        </th>
        <td><g:checkBox name="isDefault" value="${addressInstance?.isDefault}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="latitude"><g:message code="address.latitude.label" default="Latitude"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="latitude" value="${fieldValue(bean: addressInstance, field: 'latitude')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="longitude"><g:message code="address.longitude.label" default="Longitude"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="longitude" value="${fieldValue(bean: addressInstance, field: 'longitude')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="userInfo"><g:message code="userInfo.label" default="User Info"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="userInfo" name="userInfo.id" from="${net.xunzhenji.mall.UserInfo.list()}" optionKey="id"
                      required="" value="${addressInstance?.userInfo?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

