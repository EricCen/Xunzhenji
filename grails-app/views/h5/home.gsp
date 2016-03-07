%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page contentType="text/html;charset=UTF-8" %>
<html style="overflow: auto; overflow-y:hidden">
<head>
    <script>
        (function() {
            if ("-ms-user-select" in document.documentElement.style && navigator.userAgent.match(/IEMobile\/10\.0/)) {
                var msViewportStyle = document.createElement("style");
                msViewportStyle.appendChild(
                        document.createTextNode("@-ms-viewport{width:auto!important}")
                );
                document.getElementsByTagName("head")[0].appendChild(msViewportStyle);
            }
        })();
    </script>
    <title>我们只有最新鲜滴</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <asset:stylesheet href="mobile-manifest.css"/>
    <asset:javascript src="mobile-manifest.js" />


    <script>
        $.afui.useOSThemes = false;
        $.afui.autoLaunch = false;
        $.afui.loadingText = "努力加载中...";

        if (!((window.DocumentTouch && document instanceof DocumentTouch) || 'ontouchstart' in window)) {
            var script = document.createElement("script");
            script.src = "plugins/af.desktopBrowsers.js";
            var tag = $("head").append(script);
        }

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
            if("${redirectUrl}"){
                info("Redirect to " + "${redirectUrl}");
                window.location.href = "${redirectUrl}";
                return;
            }
            try {
                var hash;
                if(window.location.hash){
                    hash = window.location.hash.substring(1, window.location.hash.length);
                    hash = hash.indexOf("?") > 0 ? hash.substring(0, hash.indexOf("?")) : hash;
                }else{
                    hash = $.urlParam('hash');
                }
                if(hash){
                    $("#"+hash).attr("data-selected", "true");
                    var met = $("#"+hash).attr('panelload');
                    if(met){
                        try{
                            eval(met);
                        }catch(e){
                            error(JSON.stringify(err), "panelload");
                        }
                    }
                }
                $.afui.launch();
                try {
                    if (navigator.userAgent.indexOf('MicroMessenger') > -1) {
                        weChatReady(function () {
                            getLocation();
                        });
                    }
                } catch (err) {
                    error(JSON.stringify(err), "bindWeChatJsApi");
                }
            } catch (err) {
                error(JSON.stringify(err), "ready");
            }
        });

        $.afui.ready(function () {
            afuiReady();
        });
</script>
</head>

<body>
<div id="splashscreen" class='ui-loader heavy'>
    寻真记吃货之家
    <br>
    <br>    <span class='ui-icon ui-icon-loading spin'></span>
    <h1>努力载入中</h1>
</div>
<g:if test="${!redirectUrl}">
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
             thumb-url="${assetPath(src: 'logo-whitebg.png', absolute: true)}"
             desc="寻真记是一个为您搜罗全国各地最真实，最天然，最安全，最健康食材的互联网平台">

            <p id='main_info'>寻真记是一个为您搜罗全国各地最真实，最天然，最安全，最健康食材的互联网平台</p>
            <ul class="product-item-container">
                <g:each in="${products}" var="product">
                    <li ${product.homePageWeight >= 0? "" : 'style="display: none"'} class="product-item">
                        <a href="#product_${product.id}" onclick="queryGroupsNearBy(${product.id});">
                            <div class="product-image">
                                <img data-original="${product.banner?.mobileUrl}" class="lazy">
                            </div>
                            <div class="title-backgroud"></div>
                            <div class="product-title">${product.title}>></div>
                        </a>
                    </li>
                </g:each>
            </ul>
        </div>

        <g:each in="${products}" var="product">
            <!---------------------------------------------->
            <g:render template="product" model="[product : product]"/>
            <!-- ------------------------------------------ -->
        </g:each>

        <g:each in="${categories}" var="category">
            <!---------------------------------------------->
            <g:render template="category" model="[category : category]"/>
            <!-- ------------------------------------------ -->
        </g:each>

        <g:render template="shoppingCart"/>

        <g:render template="suggestion" />

        <g:render template="confirmOrder" />

        <g:render template="about" />

    </div>
    <!-- navbar -->

    <nav id="main-left-menu">
        <div class="my-account">
            <g:if test="${fans?.headImgUrl}">
                <img src="${fans?.headImgUrl}" class="img-circle">
            </g:if>
            <g:else>
                <asset:image class="img-circle" src="profile.png" onclick="getHeadImage();"/>
            </g:else>
            <div class="user-info">
                <div class="user-login-btn" style="display: none">
                    <button class="btn btn-green" onclick="showLoginPanel();">登录</button>
                    <button class="btn btn-green" onclick="showRegisterPanel();">注册</button>
                </div>
                <div class="user-name-mobile" ${userInfo?.name ? 'style="display: none;"': ""}>
                    <div class="user-name">
                        <h4>${userInfo?.name ? userInfo?.name : fans?.nickName}</h4>
                    </div>
                    <div class="user-mobile">${userInfo?.mobile}</div>
                </div>
            </div>
        </div>
        <ul class="list">
            <li>
                <a class="menu-item" href="#main">首页</a>
            </li>
            <li>
                <a class="menu-item" href="#shoppingcart">购物车</a>
            </li>
            <li>
                <a class="menu-item" href="#listOrder" data-transition="pop-reveal">我的订单</a>
            </li>
            <li>
                <a class="menu-item" href="#my-account-panel" data-transition="pop-reveal">我的帐户</a>
            </li>
            <li>
                <g:link class="menu-item" controller="help" action="h5Help" data-title="新手入门" data-persist-ajax="true">新手入门</g:link>
            </li>
            <li>
                <a class="menu-item" href="#group-home-panel"  data-transition="pop-reveal">领鲜群</a>
            </li>
            <li>
                <a class="menu-item" href="#about" onclick="initAbout();">关于我们</a>
            </li>
            <li>
                <a class="menu-item" href="#suggestion" onclick="initSuggestion();">建议</a>
            </li>
        </ul>
    </nav>

    <footer id="home_footer">
        <a href="#shoppingcart" onclick='initShoppingCart();'>
            <div style="float: left;">
                <div class="shopping-cart" role="shopping-cart">
                    <i class="fa fa-shopping-cart"></i>
                    <span id='shoppingcart-badge' style="margin-top: 5px;">
                        <span class="af-badge" data-ignore-pressed="true"
                              style="background: red; position: relative; left:-14px; top:-18px;">0</span>
                    </span>
                    <span role="order-amount" class="price"
                          style="font-size: 1.5em;">0</span>
                </div>
            </div>
        </a>
        <a href="#" role="order" class="place-order invalid" onclick="placeOrder();"><i class="fa fa-hand-pointer-o"></i> 去结账</a>
    </footer>
</div>

<g:render template="listOrder" />

<g:render template="userInfo"/>

<g:render template="address"/>

<g:render template="myAccount" />

<g:render template="lxgroup"/>

<g:render template="templates" />

<iframe id="sessionDiv" style="display: none;"></iframe>

<iframe id="payDiv" style="display: none;"></iframe>
<g:render template="links" />
<script>
    var userMobile = '${userInfo?.mobile}';
    var userName = '${userInfo?.name}';
    var latitude = ${latitude?latitude:0};
    var longitude = ${longitude?longitude:0};
</script>
</g:if>
<g:else>
    <div id="empty-view" class="view"></div>
</g:else>
<g:render template="wechatConfig"/>
</body>
</html>