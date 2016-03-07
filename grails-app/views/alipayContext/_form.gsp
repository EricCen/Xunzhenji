<%@ page import="net.xunzhenji.alipay.AlipayContext" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="partner"><g:message code="alipayContext.partner.label" default="Partner"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="partner" required=""
                         value="${alipayContextInstance?.partner}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="key"><g:message code="alipayContext.key.label" default="Key"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="key" required="" value="${alipayContextInstance?.key}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="inputCharset"><g:message code="alipayContext.inputCharset.label" default="Input Charset"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="inputCharset" required=""
                         value="${alipayContextInstance?.inputCharset}"/>
        </td>
    </tr>
    </tbody>
</table>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="notifyUrl"><g:message code="alipayContext.notifyUrl.label" default="Notify Url"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="notifyUrl" required=""
                         value="${alipayContextInstance?.notifyUrl}"/>
        </td>
    </tr>
    </tbody>
</table>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="paymentType"><g:message code="alipayContext.paymentType.label" default="Payment Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="paymentType" type="number" value="${alipayContextInstance.paymentType}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="returnUrl"><g:message code="alipayContext.returnUrl.label" default="Return Url"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="returnUrl" required=""
                         value="${alipayContextInstance?.returnUrl}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="signType"><g:message code="alipayContext.signType.label" default="Sign Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="signType" required=""
                         value="${alipayContextInstance?.signType}"/>
        </td>
    </tr>
    </tbody>
</table>

