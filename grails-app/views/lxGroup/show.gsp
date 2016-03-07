%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.LxGroup" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'lxGroup.label', default: 'LxGroup')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-lxGroup" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <table class="userinfoArea lxGroup" border="0" cellspacing="0" cellpadding="0" width="100%">
        <tbody>
        <g:if test="${lxGroupInstance?.organizer?.weChatFans?.headImgUrl}">
            <tr>
                <th>头像</th>
                <td><img src="${lxGroupInstance?.organizer?.weChatFans?.headImgUrl}" style="max-width: 50px;"></td>
            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.groupName}">
            <tr>
                <th><span id="groupName-label" class="property-label"><g:message code="lxGroup.groupName.label"
                                                                                 default="Group Name"/></span></th>

                <td><span class="property-value" aria-labelledby="groupName-label"><g:fieldValue
                        bean="${lxGroupInstance}" field="groupName"/></span></td>

            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.address}">
            <tr>
                <th><span id="address-label" class="property-label"><g:message code="lxGroup.address.label"
                                                                               default="Address"/></span></th>

                <td><span class="property-value" aria-labelledby="address-label"><g:link controller="address"
                                                                                         action="show"
                                                                                         id="${lxGroupInstance?.address?.id}">${lxGroupInstance?.address?.encodeAsHTML()}</g:link></span>
                </td>

            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.deliverable}">
            <tr>
                <th><span id="deliverable-label" class="property-label"><g:message code="lxGroup.deliverable.label"
                                                                                   default="Deliverable"/></span>
                </th>

                <td><span class="property-value" aria-labelledby="deliverable-label"><g:formatBoolean
                        boolean="${lxGroupInstance?.deliverable}"/></span></td>

            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.organizer}">
            <tr>
                <th><span id="organizer-label" class="property-label"><g:message code="lxGroup.organizer.label"
                                                                                 default="Organizer"/></span></th>

                <td><span class="property-value" aria-labelledby="organizer-label"><g:link controller="userInfo"
                                                                                           action="show"
                                                                                           id="${lxGroupInstance?.organizer?.id}">${lxGroupInstance?.organizer?.encodeAsHTML()}</g:link></span>
                </td>

            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.wechatAccount}">
            <tr>
                <th><span id="wechatAccount-label" class="property-label"><g:message
                        code="lxGroup.wechatAccount.label" default="Wechat Account"/></span></th>

                <td><span class="property-value" aria-labelledby="wechatAccount-label"><g:fieldValue
                        bean="${lxGroupInstance}" field="wechatAccount"/></span></td>

            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.phone}">
            <tr>
                <th><span id="phone-label" class="property-label"><g:message code="lxGroup.phone.label"
                                                                             default="Phone"/></span></th>

                <td><span class="property-value" aria-labelledby="phone-label"><g:fieldValue
                        bean="${lxGroupInstance}" field="phone"/></span></td>

            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.pickupTimes}">
            <tr>
                <th><span id="pickupTimes-label" class="property-label"><g:message code="lxGroup.pickupTimes.label"
                                                                                   default="Pickup Times"/></span>
                </th>
                <td><span class="property-value"
                          aria-labelledby="pickupTimes-label">周${lxGroupInstance.pickupTimes*.toDayStr().join(",")}</span>
                </td>
            </tr>
        </g:if>

        <g:if test="${lxGroupInstance?.dateCreated}">
            <tr>
                <th><span id="dateCreated-label" class="property-label"><g:message code="default.dateCreated.label"
                                                                                   default="Date Created"/></span>
                </th>

                <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                        format="yyyy-MM-dd HH:mm:ss" date="${lxGroupInstance?.dateCreated}"/></span></td>

            </tr>
        </g:if>
        </tbody>
    </table>

    <g:form url="[resource: lxGroupInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${lxGroupInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>


    <div id="member-tbl-body" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <h1>群成员</h1>
        <div class="tr">
            <div class="th">头像</div>
            <div class="th">姓名</div>
            <div class="th">电话</div>
            <div class="th">地址</div>
        </div>

        <g:each in="${members}" var="member">
            <div class="tr">
                <div class="td"><img src="${member?.weChatFans?.headImgUrl? member?.weChatFans?.headImgUrl: "/assets/profile.png"}" style="max-width: 50px"></div>
                <div class="td">${member.name}</div>
                <div class="td">${member.mobile}</div>
                <div class="td">${member.defaultAddress}</div>
            </div>
        </g:each>
    </div>

    <div id="order-tbl-body" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <h1>订单列表</h1>
        <div class="tr">
            <div class="th">商品</div>
            <div class="th">数量</div>
            <div class="th">群总订购</div>
            <div class="th">每件节省运费</div>
            <div class="th">补贴金额</div>
            <div class="th">订单价格</div>
            <div class="th">返还顾客金额</div>
            <div class="th">群主佣金</div>
            <div class="th">支付状态</div>
            <div class="th">发货状态</div>
            <div class="th">佣金状态</div>
            <div class="th">最后更新</div>
        </div>

        <g:each in="${orders}" var="order">
            <div class="tr">
                <div class="td"><g:link controller="productOrder" action="show" id="${order.id}">#${order.id} ${order.toPayBody()}(${order.product.category.toDeliverDaysInWeekStr()})</g:link></div>
                <div class="td">${order.quantity}</div>
                <div class="td">${lxGroupInstance.totalQuantity(order.batch)}</div>
                <div class="td">${lxGroupInstance.unitSavedExpressFee(order.batch)}</div>
                <div class="td">${order.batch.unitAllowance*100}%</div>
                <div class="td">${order.orderPrice}</div>
                <div class="td">${order.refundAmount}</div>
                <div class="td">${order.commission.amount}</div>
                <div class="td">${order.paymentStatusName}</div>
                <div class="td">${order.deliveryStatusName}</div>
                <div class="td">${order.commission.commissionStateName}</div>
                <div class="td"><g:formatDate format="yy-MM-dd HH:mm" date="${order.lastUpdated}" /></div>
            </div>
        </g:each>
    </div>

    <div id="delivery-tbl-body" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <h1>发货列表</h1>
        <div class="tr">
            <div class="th">运单号</div>
            <div class="th">货到日</div>
            <div class="th">商品批次</div>
            <div class="th">地址</div>
            <div class="th">收货人</div>
            <div class="th">订单数目</div>
            <div class="th">有效</div>
        </div>

        <g:each in="${deliveries}" var="delivery">
            <div class="tr">
                <div class="td"><g:link action="show" controller="delivery" id="${delivery.id}">${fieldValue(bean: delivery, field: "deliveryCode")}</g:link></div>
                <div class="td"><g:formatDate format="yyyy-MM-dd E" date="${delivery.targetDeliveryDate}" /></div>
                <div class="td">${delivery.batch}</div>
                <div class="td">${delivery.address}</div>
                <div class="td">${fieldValue(bean: delivery, field: "receiver")}</div>
                <div class="td">${delivery.orders()? delivery.orders()?.sum{it.quantity} : 0}</div>
                <div class="td"><g:formatBoolean true="有效" false="无效" boolean="${delivery.enable}"/></div>
            </div>
        </g:each>
    </div>
</div>
</body>
</html>
