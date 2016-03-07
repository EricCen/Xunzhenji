<%@ page import="net.xunzhenji.wechat.WeChatCoupon" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="stockId"><g:message code="weChatCoupon.stockId.label" default="Stock Id"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="stockId" required=""
                         value="${weChatCouponInstance?.stockId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="default.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required="" value="${weChatCouponInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="couponBudget"><g:message code="weChatCoupon.couponBudget.label" default="Coupon Budget"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="couponBudget" value="${fieldValue(bean: weChatCouponInstance, field: 'couponBudget')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="couponMininumn"><g:message code="weChatCoupon.couponMininumn.label"
                                                   default="Coupon Mininumn"/><span class="required-indicator">*</span>
            </label>
        </th>
        <td><g:field name="couponMininumn" value="${fieldValue(bean: weChatCouponInstance, field: 'couponMininumn')}"
                     required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="couponStockStatus"><g:message code="weChatCoupon.couponStockStatus.label"
                                                      default="Coupon Stock Status"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="couponStockStatus" from="${net.xunzhenji.wechat.WeChatCoupon$CouponStockStatus?.values()}"
                      keys="${net.xunzhenji.wechat.WeChatCoupon$CouponStockStatus.values()*.name()}" required=""
                      value="${weChatCouponInstance?.couponStockStatus?.name()}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="couponTotal"><g:message code="weChatCoupon.couponTotal.label" default="Coupon Total"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="couponTotal" type="number" value="${weChatCouponInstance.couponTotal}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="couponType"><g:message code="weChatCoupon.couponType.label" default="Coupon Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="couponType" from="${net.xunzhenji.wechat.WeChatCoupon$CouponType?.values()}"
                      keys="${net.xunzhenji.wechat.WeChatCoupon$CouponType.values()*.name()}" required=""
                      value="${weChatCouponInstance?.couponType?.name()}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="beginTime"><g:message code="weChatCoupon.beginTime.label" default="Begin Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="beginTime" precision="day" value="${weChatCouponInstance?.beginTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="createTime"><g:message code="weChatCoupon.createTime.label" default="Create Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="createTime" precision="day" value="${weChatCouponInstance?.createTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="endTime"><g:message code="weChatCoupon.endTime.label" default="End Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="endTime" precision="day" value="${weChatCouponInstance?.endTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="isSendNum"><g:message code="weChatCoupon.isSendNum.label" default="Is Send Num"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="isSendNum" type="number" value="${weChatCouponInstance.isSendNum}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="lockNum"><g:message code="weChatCoupon.lockNum.label" default="Lock Num"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="lockNum" type="number" value="${weChatCouponInstance.lockNum}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="maxQuota"><g:message code="weChatCoupon.maxQuota.label" default="Max Quota"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="maxQuota" type="number" value="${weChatCouponInstance.maxQuota}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="usedNum"><g:message code="weChatCoupon.usedNum.label" default="Used Num"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="usedNum" type="number" value="${weChatCouponInstance.usedNum}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="value"><g:message code="weChatCoupon.value.label" default="Value"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="value" value="${fieldValue(bean: weChatCouponInstance, field: 'value')}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

