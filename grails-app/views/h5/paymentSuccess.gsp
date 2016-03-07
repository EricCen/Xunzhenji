%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <title>支付成功</title>
    <asset:stylesheet href="wechatpay-manifest.css"/>
    <asset:javascript src="wechatpay-manifest.js"/>
    <g:render template="links"/>
</head>

<body class="payment-success">
<div class="pay-container">
    <div class="payment-success-icon">
        <i class="fa fa-check-circle payment-success"></i>

        <h2>付款成功</h2>
        <span class="price">${payment?.amount}</span>

        <div style="font-weight: bold"><span class="counter">10</span>秒后返回购物页面</div>

        <div>
            <g:if test="${payment.productOrders().size() == 1}">
                <g:link controller="h5" action="home" params="[orderId: payment.productOrders()[0].id]"
                        fragment="order-detail-panel" class="return-home">马上返回</g:link>
            </g:if>
            <g:else>
                <g:link controller="h5" action="home"
                        fragment="listOrder" class="return-home">马上返回</g:link>
            </g:else>
        </div>
    </div>

    <div style="margin: 0 10px !important;"><strong>订单号码</strong></div>

    <div style="margin: 0 10px !important; border-top: 1px solid lightgrey;">
        <table class="orderNumTbl">
            <g:if test="${payment?.transactionId}">
                <tr>
                    <td>交易单号</td>
                    <td>${payment?.transactionId}</td>
                </tr>
            </g:if>
            <tr>
                <td>商户单号</td>
                <td>${payment?.outTradeNo}</td>
            </tr>
        </table>
    </div>

    <div style="margin: 10px 0 0 10px !important;"><strong>产品清单</strong></div>

    <div style="margin: 0 10px !important; border-top: 1px solid lightgrey;">
        <table class="priceTbl">
            <g:each in="${payment?.productOrders()}" var="order">
                <tr>
                    <td>${order.toPayBody()}</td>
                    <td><span class="price" style="font-size: medium">${order.currentPrice()}</span></td>
                </tr>
            </g:each>
        </table>
    </div>
</div>

<script>
    $(document).ready(function () {
        countDown();
    });
    function countDown() {
        var counter = 10;
        var refreshTimer = function () {
            if (counter > 0) {
                counter--;
                $('.counter').html(counter);
                timerId = setTimeout(refreshTimer, 1000);
            } else {
                redirect("${createLink(controller: "h5", action: "home")}", {});
                clearTimeout(timerId);
            }
        };
        $('.counter').html(counter);
        timerId = setTimeout(refreshTimer, 1000);
    }
</script>
</body>
</html>