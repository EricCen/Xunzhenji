<%@ page import="net.xunzhenji.mall.LxGroup" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="address"><g:message code="lxGroup.address.label" default="Address"/></label>
        </th>
        <td><g:select id="address" name="address.id" from="${net.xunzhenji.mall.Address.list()}" optionKey="id"
                      value="${lxGroupInstance?.address?.id}" class="many-to-one" noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliverable"><g:message code="lxGroup.deliverable.label" default="Deliverable"/></label>
        </th>
        <td><g:checkBox name="deliverable" value="${lxGroupInstance?.deliverable}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="groupName"><g:message code="lxGroup.groupName.label" default="Group Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="groupName" required=""
                         value="${lxGroupInstance?.groupName}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="organizer"><g:message code="lxGroup.organizer.label" default="Organizer"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="organizer" name="organizer.id" from="${net.xunzhenji.mall.UserInfo.list()}" optionKey="id"
                      required="" value="${lxGroupInstance?.organizer?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="phone"><g:message code="lxGroup.phone.label" default="Phone"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="phone" required="" value="${lxGroupInstance?.phone}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="pickupTimes"><g:message code="lxGroup.pickupTimes.label" default="Pickup Times"/></label>
        </th>
        <td><g:select name="pickupTimes" from="${net.xunzhenji.mall.PickupTime.list()}" multiple="multiple"
                      optionKey="id" size="5" value="${lxGroupInstance?.pickupTimes*.id}" class="many-to-many"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="wechatAccount"><g:message code="lxGroup.wechatAccount.label" default="Wechat Account"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="wechatAccount" required=""
                         value="${lxGroupInstance?.wechatAccount}"/>
        </td>
    </tr>
    </tbody>
</table>

