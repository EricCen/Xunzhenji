%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>测试微信支付</title>
    <asset:stylesheet src="mobile-manifest.css"/>
    <asset:javascript src="mobile-manifest.js"/>

    <script>
        $.afui.useOSThemes = false;
        $.afui.autoLaunch = false;
        $.afui.loadingText = "努力加载中...";

        //check search
        var search = document.location.search.toLowerCase().replace("?", "");
        if (search.length > 0) {
            $.afui.useOSThemes = true;
            if (search == "win8")
                $.os.ie = true;
            else if (search == "firefox")
                $.os.fennec = "true"
            $.afui.ready(function () {
                $(document.body).get(0).className = (search);
            });
        }

        $(document).ready(function () {
            try {
                $.afui.launch();
                try {
                    if (navigator.userAgent.indexOf('MicroMessenger') > -1) {
                        bindWeChatJsApi();
                    }
                } catch (err) {
                    error(JSON.stringify(err), "bindWeChatJsApi");
                }
                initSession();
            } catch (err) {
                error(JSON.stringify(err), "ready");
            }
        });

        $.afui.ready(function () {
            afuiReady();
        });
    </script>
</head>

<body class="payment-inprogress">
<div class="view" id="mainview">
    <header>
        <h1>吃货平台</h1>
        <a id='menubadge' data-left-menu="main-left-menu" data-transition="push">
            <img style="display:none;" src="${fans?.headImgUrl}" class="img-circle small-circle">
            <i id="getMenu" class="fa fa-bars"></i>
        </a>
    </header>
    <div class="pages">
        <div data-title='寻真记' id="main" class="panel" data-left-drawer="left"
             style="background-color: white;"
             desc="寻真记是一个为您搜罗全国各地最真实，最天然，最安全，最健康食材的互联网平台">
            <div><a href="#shoppingcart">!!!</a></div>
            <div><a href="#" onclick="pay()">支付</a></div>
            </div>
        </div>

    <div title="购物车" id="shoppingcart" class="panel" data-load="initShoppingCart">
        <section class="row first-row">
            <div id="empty-shoppingcart" style="display: none;">购物车还是空的,快去购物吧!</div>
            <div id="full-shoppingcart" style="display: none;">
                <ul class="batch-list"></ul>
            </div>
        </section>
    </div>
    </div>

<g:render template="links" />
<script>

    $(document).ready(function(){
        bindWeChatJsApi();
        initSession();
    });

    function pay(){
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
    };

    function onBridgeReady(){
        ajaxGet("${createLink(action: "processTestpay")}",{}, function(data){
            invoke(data);
        })
    }

    function invoke(data){
        info(JSON.stringify(data));
        var payInfo = {
            "appId": data.model.appId,
            "timeStamp": data.model.timeStamp,
            "timestamp": data.model.timeStamp,
            "nonceStr": data.model.nonceStr,
            "package": data.model.pkg,
            "signType": data.model.signType,
            "paySign": data.model.paySign
        };
        payInfo.success = function (res) {
            if ("get_brand_wcpay_request:ok" == res.err_msg) {
                info("Payment success!");
            } else if ("get_brand_wcpay_request:cancel" == res.err_msg) {
                info("Payment cancel, res:" + JSON.stringify(res));
            } else {
                error("Payment error, res:" + JSON.stringify(res));
            }
        }
//        wx.chooseWXPay(payInfo);
        WeixinJSBridge.invoke(
                'getBrandWCPayRequest', payInfo,
                function (res) {
                    if ("get_brand_wcpay_request:ok" == res.err_msg) {
                        info("Payment success!");
                    } else if ("get_brand_wcpay_request:cancel" == res.err_msg) {
                        info("Payment cancel, res:" + JSON.stringify(res));
                    } else {
                        error("Payment error, res:" + JSON.stringify(res));
                    }
                }
        );
    }
</script>
</body>
</html>