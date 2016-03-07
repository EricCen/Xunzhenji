%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.WeChatCoupon" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'weChatCoupon.label', default: 'WeChatCoupon')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm"/><g:message
                code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-weChatCoupon" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list weChatCoupon">
        <table class="userinfoArea weChatCoupon" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${weChatCouponInstance?.stockId}">
                <tr>
                    <th><span id="stockId-label" class="property-label"><g:message code="weChatCoupon.stockId.label"
                                                                                   default="Stock Id"/></span></th>

                    <td><span class="property-value" aria-labelledby="stockId-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="stockId"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.name}">
                <tr>
                    <th><span id="name-label" class="property-label"><g:message code="weChatCoupon.name.label"
                                                                                default="Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="name"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.beginTime}">
                <tr>
                    <th><span id="beginTime-label" class="property-label"><g:message code="weChatCoupon.beginTime.label"
                                                                                     default="Begin Time"/></span></th>

                    <td><span class="property-value" aria-labelledby="beginTime-label"><g:formatDate format="yyyy-MM-dd"
                                                                                                     date="${weChatCouponInstance?.beginTime}"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.couponBudget}">
                <tr>
                    <th><span id="couponBudget-label" class="property-label"><g:message
                            code="weChatCoupon.couponBudget.label" default="Coupon Budget"/></span></th>

                    <td><span class="property-value" aria-labelledby="couponBudget-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="couponBudget"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.couponMininumn}">
                <tr>
                    <th><span id="couponMininumn-label" class="property-label"><g:message
                            code="weChatCoupon.couponMininumn.label" default="Coupon Mininumn"/></span></th>

                    <td><span class="property-value" aria-labelledby="couponMininumn-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="couponMininumn"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.couponStockStatus}">
                <tr>
                    <th><span id="couponStockStatus-label" class="property-label"><g:message
                            code="weChatCoupon.couponStockStatus.label" default="Coupon Stock Status"/></span></th>

                    <td><span class="property-value" aria-labelledby="couponStockStatus-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="couponStockStatus"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.couponTotal}">
                <tr>
                    <th><span id="couponTotal-label" class="property-label"><g:message
                            code="weChatCoupon.couponTotal.label" default="Coupon Total"/></span></th>

                    <td><span class="property-value" aria-labelledby="couponTotal-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="couponTotal"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.couponType}">
                <tr>
                    <th><span id="couponType-label" class="property-label"><g:message
                            code="weChatCoupon.couponType.label" default="Coupon Type"/></span></th>

                    <td><span class="property-value" aria-labelledby="couponType-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="couponType"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.createTime}">
                <tr>
                    <th><span id="createTime-label" class="property-label"><g:message
                            code="weChatCoupon.createTime.label" default="Create Time"/></span></th>

                    <td><span class="property-value" aria-labelledby="createTime-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatCouponInstance?.createTime}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.endTime}">
                <tr>
                    <th><span id="endTime-label" class="property-label"><g:message code="weChatCoupon.endTime.label"
                                                                                   default="End Time"/></span></th>

                    <td><span class="property-value" aria-labelledby="endTime-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatCouponInstance?.endTime}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.isSendNum}">
                <tr>
                    <th><span id="isSendNum-label" class="property-label"><g:message code="weChatCoupon.isSendNum.label"
                                                                                     default="Is Send Num"/></span></th>

                    <td><span class="property-value" aria-labelledby="isSendNum-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="isSendNum"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.lockNum}">
                <tr>
                    <th><span id="lockNum-label" class="property-label"><g:message code="weChatCoupon.lockNum.label"
                                                                                   default="Lock Num"/></span></th>

                    <td><span class="property-value" aria-labelledby="lockNum-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="lockNum"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.maxQuota}">
                <tr>
                    <th><span id="maxQuota-label" class="property-label"><g:message code="weChatCoupon.maxQuota.label"
                                                                                    default="Max Quota"/></span></th>

                    <td><span class="property-value" aria-labelledby="maxQuota-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="maxQuota"/></span></td>

                </tr>
            </g:if>


            <g:if test="${weChatCouponInstance?.usedNum}">
                <tr>
                    <th><span id="usedNum-label" class="property-label"><g:message code="weChatCoupon.usedNum.label"
                                                                                   default="Used Num"/></span></th>

                    <td><span class="property-value" aria-labelledby="usedNum-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="usedNum"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatCouponInstance?.value}">
                <tr>
                    <th><span id="value-label" class="property-label"><g:message code="weChatCoupon.value.label"
                                                                                 default="Value"/></span></th>

                    <td><span class="property-value" aria-labelledby="value-label"><g:fieldValue
                            bean="${weChatCouponInstance}" field="value"/></span></td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: weChatCouponInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${weChatCouponInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
