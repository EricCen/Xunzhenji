%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>正在进入微信支付</title>
    <asset:javascript src="wechatpay-manifest.js"/>
</head>

<body class="payment-inprogress">
<g:if test="${subscribe == 0}">
    <asset:image src="subscribeRemind.jpg" style="width: 100%; height: 100%"/>
</g:if>

<g:render template="links" />
<script>
    $(document).ready(function(){
        if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
                document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
            }
        }else{
            onBridgeReady();
        }
    });

    function onBridgeReady(){
        WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId": "${appId}",
                    "timeStamp": "${timeStamp ? timeStamp : 0}",
                    "nonceStr": "${nonceStr}",
                    "package": "${pkg}",
                    "signType": "${signType}",
                    "paySign": "${paySign}"
                },
                function (res) {
                    if ("get_brand_wcpay_request:ok" == res.err_msg) {
                        redirect(paymentSuccessLink, {prepayId:"${prepayId}"});
                    } else if ("get_brand_wcpay_request:cancel" == res.err_msg) {
                        info("Payment cancel, res:" + JSON.stringify(res));
                        redirect("${createLink(controller: "h5", action: "home")}", {});
                    } else {
                        error("Payment error, res:" + JSON.stringify(res));
                        redirect("${createLink(controller: "h5", action: "home")}", {});
                    }
                }
        );
    }
</script>
</body>
</html>