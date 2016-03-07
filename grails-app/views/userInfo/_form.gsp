<%@ page import="net.xunzhenji.mall.ProductOrderPayments; net.xunzhenji.security.PersonAuthority; net.xunzhenji.mall.UserInfo" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="userInfo.headImage.label" default="头像"/></label>
        </th>
        <td>
            <g:if test="${userInfoInstance?.weChatFans?.headImgUrl}">
                <img style="max-width: 100px" src="${userInfoInstance?.weChatFans?.headImgUrl}" />
            </g:if>
            <g:else>
                <asset:image style="max-width: 100px"  src="profile.png" />
            </g:else>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="userInfo.name.label" default="Name"/></label>
        </th>
        <td><g:textField class="px" name="name" value="${userInfoInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="mobile"><g:message code="default.mobile.label" default="Mobile"/></label>
        </th>
        <td><g:textField class="px" name="mobile" value="${userInfoInstance?.mobile}"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label>微信呢称</label>
        </th>
        <td>${userInfoInstance?.weChatFans?.nickName}
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label>用户分组</label>
        </th>
        <td><g:each in="${net.xunzhenji.security.PersonAuthority.getAuthorities(userInfoInstance?.person?.id)}" var="a">
            ${a.authority.authority}<br>
        </g:each>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="balance"><g:message code="userInfo.balance.label" default="账号余额"/></label>
        </th>
        <td><g:textField class="px" name="balance" value="${userInfoInstance?.balance}"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="default.address.label" default="Address"/></label>
        </th>
        <td>
            <ul class="one-to-many">
                <g:each in="${userInfoInstance?.address ?}" var="a">
                    <li><g:link controller="address" action="show"
                                id="${a.id}">${a.name} ${a?.phone} ${a?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                    <g:link controller="address" action="create"
                            params="['userInfo.id': userInfoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'default.address.label', default: 'Address')])}</g:link>
                </li>
            </ul>

        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="productOrder.label" default="Orders"/></label>
        </th>
        <td>
            <table class="list-table">
                <tr>
                    <th>单号</th>
                    <th>商品名称</th>
                    <th>批次</th>
                    <th>数量</th>
                    <th>预订价</th>
                    <th>总价</th>
                    <th>支付状态</th>
                    <th>物流状态</th>
                    <th>操作</th>
                </tr>
                <g:each in="${userInfoInstance?.orders ?}" var="order">
                    <tr>
                        <td><g:link controller="productOrder" action="show" id="${order.id}">${order?.id}</g:link></td>
                        <td>${order?.product?.title}</td>
                        <td>${order?.batch?.title}</td>
                        <td>${order?.quantity}</td>
                        <td>${order?.orderPrice}</td>
                        <td>${order?.fullPrice()}</td>
                        <td>${order?.getPaymentStatusName()}</td>
                        <td>${order?.getDeliveryStatusName()}</td>
                        <td><a href="#" order-id="${order?.id}" onclick="addToShoppingCart(this);">加入购物车</a></td>
                    </tr>
                </g:each>
            </table>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="shoppingCart.label" default="Shopping Cart"/></label>
        </th>
        <td>
            <input type="hidden" id="shopping-cart-id" value="${userInfoInstance?.shoppingCart?.id}">
            <table class="list-table">
                <tr>
                    <th>单号</th>
                    <th>商品名称</th>
                    <th>批次</th>
                    <th>数量</th>
                    <th>预订价</th>
                    <th>总价</th>
                    <th>支付状态</th>
                    <th>物流状态</th>
                    <th>操作</th>
                </tr>
                <g:each in="${userInfoInstance?.shoppingCart?.productOrders ?}" var="order">
                    <tr>
                        <td><g:link controller="productOrder" action="show" id="${order.id}">${order?.id}</g:link></td>
                        <td>${order?.product?.title}</td>
                        <td>${order?.batch?.title}</td>
                        <td>${order?.quantity}</td>
                        <td>${order?.orderPrice}</td>
                        <td>${order?.fullPrice()}</td>
                        <td>${order?.getPaymentStatusName()}</td>
                        <td>${order?.getDeliveryStatusName()}</td>
                        <td><a href="#" order-id="${order?.id}" onclick="removeFromShoppingCart(this);">从购物车移除</a></td>
                    </tr>
                </g:each>
            </table>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="payment.label" default="Payments"/></label>
        </th>
        <td>
            <table class="list-table">
                <tr>
                    <th>流水号</th>
                    <th>支付时间</th>
                    <th>相关订单</th>
                    <th>支付金额</th>
                    <th>出金入金</th>
                    <th>状态</th>
                </tr>
                <g:each in="${userInfoInstance?.payments?.sort{it.dateCreated} ?}" var="payment">
                    <tr>
                        <td><g:link controller="payment" action="show" id="${payment.id}">${payment?.outTradeNo}</g:link></td>
                        <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${payment?.dateCreated}"/></td>
                        <td>${net.xunzhenji.mall.ProductOrderPayments.findByPayment(payment)?.collect{
                            "<a href='${createLink(controller: "productOrder", action: "edit", id:it.productOrder.id)}'>${it.productOrder.id}</a>"
                        }}</td>
                        <td>${payment?.amount}</td>
                        <td>${payment?.cashFlowDirection == "IN" ? "入金" : "出金"}</td>
                        <td>${payment?.status}</td>
                    </tr>
                </g:each>
            </table>
        </td>
    </tr>
    </tbody>
</table>

<script>
    function addToShoppingCart(elem){
        var orderId = $(elem).attr("order-id");
        $.ajax({
            url: "${createLink(controller: "productOrder", action: "addToShoppingCart")}",
            data:{orderId:orderId},
            success: function(data){
                if(data.errorcode == 0){
                    location.reload();
                }
            }
        })
    }
    function removeFromShoppingCart(elem){
        var orderId = $(elem).attr("order-id");
        var shoppingCartId = $("#shopping-cart-id").val();
        $.ajax({
            url: "${createLink(controller: "productOrder", action: "removeFromShoppingCart")}",
            data:{orderId:orderId, shoppingCartId: shoppingCartId},
            success: function(data){
                if(data.errorcode == 0){
                    location.reload();
                }
            }
        })
    }
</script>