%{--
  - Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
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

    <title>正在进入支付</title>
    %{--<asset:stylesheet href="wechatpay-manifest.css"/>--}%
    <asset:javascript src="wechatpay-manifest.js"/>
    <g:render template="links"/>
</head>

<body>
<g:render template="wechatConfig"/>
<script>
    weChatReady(sendPayRequest);

    function sendPayRequest() {
        info("Send pay request");
        var openId = $.urlParam("openId");
        var batchId = $.urlParam("batchId");
        var quantity = $.urlParam("quantity");
        ajaxPost(wechatpayLink, {openId: openId, batchId: batchId, quantity: quantity}, function (data) {
                    info("Receive payinfo" + JSON.stringify(data));
                    var payInfo = {
                        "appId": data.model.appId,
                        "timeStamp": data.model.timeStamp,
                        "nonceStr": data.model.nonceStr,
                        "package": data.model.pkg,
                        "signType": data.model.signType,
                        "paySign": data.model.paySign
                    };

                    WeixinJSBridge.invoke(
                            'getBrandWCPayRequest', payInfo,
                            function (res) {
                                if ("get_brand_wcpay_request:ok" == res.err_msg) {
                                    redirect(paymentSuccessLink, {prepayId: data.model.prepayId});
                                } else if ("get_brand_wcpay_request:cancel" == res.err_msg) {
                                    info("Payment cancel, res:" + JSON.stringify(res));
                                    WeixinJSBridge.call('closeWindow');
                                } else {
                                    error("Payment error, res:" + JSON.stringify(res));
                                    redirect(homeLink, {});
                                }
                            }
                    );
                },
                function (data) {
                    error("Hit error " + JSON.stringify(data));
                    if (data.errorcode == -23) {
                        alert("用户还没有注册，对话框【回复】“注册,姓名,电话”即可注册。");
                    }
                }
        );
    }
</script>
</body>
</html>