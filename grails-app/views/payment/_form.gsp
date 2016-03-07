<%@ page import="net.xunzhenji.mall.Payment" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="prepayId"><g:message code="payment.prepayId.label" default="Prepay Id"/></label>
        </th>
        <td><g:textField class="px" name="prepayId" value="${paymentInstance?.prepayId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="timeEnd"><g:message code="payment.timeEnd.label" default="Time End"/></label>
        </th>
        <td><g:datePicker name="timeEnd" precision="day" value="${paymentInstance?.timeEnd}" default="none"
                          noSelection="['': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="transactionId"><g:message code="payment.transactionId.label" default="Transaction Id"/></label>
        </th>
        <td><g:textField class="px" name="transactionId"
                         value="${paymentInstance?.transactionId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="cashFee"><g:message code="payment.cashFee.label" default="Cash Fee"/></label>
        </th>
        <td><g:field name="cashFee" value="${fieldValue(bean: paymentInstance, field: 'cashFee')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="balanceAmount"><g:message code="payment.balanceAmount.label" default="Balance Amount"/></label>
        </th>
        <td><g:field name="balanceAmount" value="${fieldValue(bean: paymentInstance, field: 'balanceAmount')}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="errCode"><g:message code="payment.errCode.label" default="Err Code"/></label>
        </th>
        <td><g:textField class="px" name="errCode" value="${paymentInstance?.errCode}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="errCodeDes"><g:message code="payment.errCodeDes.label" default="Err Code Des"/></label>
        </th>
        <td><g:textField class="px" name="errCodeDes" value="${paymentInstance?.errCodeDes}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="resultCode"><g:message code="payment.resultCode.label" default="Result Code"/></label>
        </th>
        <td><g:textField class="px" name="resultCode" value="${paymentInstance?.resultCode}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="isSubscribe"><g:message code="payment.isSubscribe.label" default="Is Subscribe"/></label>
        </th>
        <td><g:textField class="px" name="isSubscribe" value="${paymentInstance?.isSubscribe}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="tradeType"><g:message code="payment.tradeType.label" default="Trade Type"/></label>
        </th>
        <td><g:textField class="px" name="tradeType" value="${paymentInstance?.tradeType}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="bankType"><g:message code="payment.bankType.label" default="Bank Type"/></label>
        </th>
        <td><g:textField class="px" name="bankType" value="${paymentInstance?.bankType}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="openid"><g:message code="payment.openid.label" default="Openid"/></label>
        </th>
        <td><g:textField class="px" name="openid" value="${paymentInstance?.openid}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="amount"><g:message code="payment.amount.label" default="Amount"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="amount" value="${fieldValue(bean: paymentInstance, field: 'amount')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="cashFlowDirection"><g:message code="payment.cashFlowDirection.label"
                                                      default="Cash Flow Direction"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="cashFlowDirection" required=""
                         value="${paymentInstance?.cashFlowDirection}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="outTradeNo"><g:message code="payment.outTradeNo.label" default="Out Trade No"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="outTradeNo" required=""
                         value="${paymentInstance?.outTradeNo}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="status"><g:message code="payment.status.label" default="Status"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="status" required="" value="${paymentInstance?.status}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="type"><g:message code="payment.type.label" default="Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="type" required="" value="${paymentInstance?.type}"/>
        </td>
    </tr>
    </tbody>
</table>

