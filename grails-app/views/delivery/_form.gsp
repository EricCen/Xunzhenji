%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="org.apache.commons.lang.time.DateFormatUtils; net.xunzhenji.mall.Delivery" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deliveryCode"><g:message code="delivery.deliveryCode.label" default="Delivery Code"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="deliveryCode" class="px" value="${deliveryInstance?.deliveryCode}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label>下单用户<span class="required-indicator">*</span></label>
        </th>
        <td><g:link controller="userInfo" action="show" id="${userInfo.id}">${userInfo.name}</g:link></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="address.name.label" default="联系人"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td>${deliveryInstance?.address?.name}</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="address.phone.label" default="电话"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td>${deliveryInstance?.address?.phone}</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="address.address.label" default="地址"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td>${deliveryInstance?.address?.toFullAddress()}</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="targetDeliveryDate"><g:message code="delivery.targetDeliveryDate.label" default="Delivery Date"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="targetDeliveryDate" precision="day" value="${deliveryInstance?.targetDeliveryDate}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="completionDateTimeStr"><g:message code="delivery.completionDateTime.label" default="Complete Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="completionDateTimeStr" class="px"
                         value="${deliveryInstance?.completionDateTime?deliveryInstance?.completionDateTime?.format("yyyy-MM-dd HH:mm:ss"):""}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="productOrder.label" default="Product Orders"/></label>
        </th>
        <td>
            <ul class="one-to-many">
                <g:each in="${deliveryInstance?.orders() ?}" var="p">
                    <li><g:link controller="productOrder" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                </g:each>
            </ul>

        </td>
    </tr>
    </tbody>
</table>

