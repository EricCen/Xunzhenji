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
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
    <g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
            code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-weChatCoupon" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <thead>
        <tr>
            <g:sortableColumn property="stockId"
                              title="${message(code: 'weChatCoupon.stockId.label', default: 'stockId')}"/>

            <g:sortableColumn property="name" title="${message(code: 'default.name.label', default: 'Begin Time')}"/>

            <g:sortableColumn property="beginTime"
                              title="${message(code: 'weChatCoupon.beginTime.label', default: 'Begin Time')}"/>

            <g:sortableColumn property="endTime"
                              title="${message(code: 'weChatCoupon.endTime.label', default: 'End Time')}"/>

            <g:sortableColumn property="couponBudget"
                              title="${message(code: 'weChatCoupon.couponBudget.label', default: 'Coupon Budget')}"/>

            <g:sortableColumn property="couponMininumn"
                              title="${message(code: 'weChatCoupon.couponMininumn.label', default: 'Coupon Mininumn')}"/>

            <g:sortableColumn property="couponStockStatus"
                              title="${message(code: 'weChatCoupon.couponStockStatus.label', default: 'Coupon Stock Status')}"/>

            <g:sortableColumn property="couponTotal"
                              title="${message(code: 'weChatCoupon.couponTotal.label', default: 'Coupon Total')}"/>

            <g:sortableColumn property="couponType"
                              title="${message(code: 'weChatCoupon.couponType.label', default: 'Coupon Type')}"/>

            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${weChatCouponInstanceList}" status="i" var="weChatCouponInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="show"
                            id="${weChatCouponInstance.id}">${fieldValue(bean: weChatCouponInstance, field: "stockId")}</g:link></td>

                <td>${fieldValue(bean: weChatCouponInstance, field: "name")}</td>

                <td><g:formatDate format="yyyy-MM-dd" date="${weChatCouponInstance?.beginTime}"/></td>

                <td><g:formatDate format="yyyy-MM-dd" date="${weChatCouponInstance?.endTime}"/></td>

                <td>${fieldValue(bean: weChatCouponInstance, field: "couponBudget")}</td>

                <td>${fieldValue(bean: weChatCouponInstance, field: "couponMininumn")}</td>

                <td>${fieldValue(bean: weChatCouponInstance, field: "couponStockStatus")}</td>

                <td>${fieldValue(bean: weChatCouponInstance, field: "couponTotal")}</td>

                <td>${fieldValue(bean: weChatCouponInstance, field: "couponType")}</td>

                <td><g:link action="edit" id="${weChatCouponInstance.id}">编辑</g:link>
                <g:link action="sendToAllUser" params="${[stockId: weChatCouponInstance.stockId]}">全员发送</g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${weChatCouponInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
