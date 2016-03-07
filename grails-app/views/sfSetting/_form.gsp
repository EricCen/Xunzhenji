<%@ page import="net.xunzhenji.vendor.SfSetting" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="serverAddress"><g:message code="sfSetting.serverAddress.label" default="服务地址"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="serverAddress" required=""
                         value="${sfSettingInstance?.serverAddress}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="clientCode"><g:message code="sfSetting.clientCode.label" default="接入编码"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="clientCode" required=""
                         value="${sfSettingInstance?.clientCode}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="checkword"><g:message code="sfSetting.checkword.label" default="Checkword"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="checkword" required=""
                         value="${sfSettingInstance?.checkword}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="custId"><g:message code="sfSetting.custId.label" default="Cust Id"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="custId" required=""
                         value="${sfSettingInstance?.custId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="expressType"><g:message code="sfSetting.expressType.label" default="快件类型"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="expressType" required=""
                         value="${sfSettingInstance?.expressType}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fromAddress"><g:message code="sfSetting.fromAddress.label" default="寄件地址"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="fromAddress" required=""
                         value="${sfSettingInstance?.fromAddress}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fromCompany"><g:message code="sfSetting.fromCompany.label" default="寄件公司"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="fromCompany" required=""
                         value="${sfSettingInstance?.fromCompany}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fromContact"><g:message code="sfSetting.fromContact.label" default="寄件方联系人"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="fromContact" required=""
                         value="${sfSettingInstance?.fromContact}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fromTel"><g:message code="sfSetting.fromTel.label" default="寄件联系电话"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="fromTel" required=""
                         value="${sfSettingInstance?.fromTel}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="payMethod"><g:message code="sfSetting.payMethod.label" default="Pay Method"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="payMethod" required=""
                         value="${sfSettingInstance?.payMethod}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="shipperCode"><g:message code="sfSetting.shipperCode.label" default="Shipper Code"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="shipperCode" required=""
                         value="${sfSettingInstance?.shipperCode}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="addedServiceCode"><g:message code="sfSetting.addedServiceCode.label"
                                                     default="Added Service Code"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="addedServiceCode" required=""
                         value="${sfSettingInstance?.addedServiceCode}"/>
        </td>
    </tr>
    </tbody>
</table>