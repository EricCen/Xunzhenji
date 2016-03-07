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

    <title>源穑农业</title>
    <asset:stylesheet href="mobile-manifest.css"/>
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
            if ("${redirectUrl}") {
                info("Redirect to " + "${redirectUrl}");
                window.location.href = "${redirectUrl}";
                return;
            }
            try {
                var hash;
                if (window.location.hash) {
                    hash = window.location.hash.substring(1, window.location.hash.length);
                    hash = hash.indexOf("?") > 0 ? hash.substring(0, hash.indexOf("?")) : hash;
                } else {
                    hash = $.urlParam('hash');
                }
                if (hash) {
                    $("#" + hash).attr("data-selected", "true");
                    var met = $("#" + hash).attr('panelload');
                    if (met) {
                        try {
                            eval(met);
                        } catch (e) {
                            error(JSON.stringify(err), "panelload");
                        }
                    }
                }
                $.afui.launch();

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

<div class="view" id="mainview">
    <header>
        <h1>每日食材报单表</h1>
    </header>

    <div class="pages">
        <div data-title='每日食材报单表' id="main" class="panel" data-left-drawer="left"
             thumb-url="${assetPath(src: 'logo-whitebg.png', absolute: true)}">

            <div id="createOrder">
                <g:form action="create">
                    <div style="color: white; font-weight: bold;">门店</div>

                    <div id="shops_selection">

                    </div>

                    <div style="color: white; font-weight: bold;">送货时间</div>

                    <div>
                        <select id="date" name="deliverDate" onchange="onSelectFurtherDay();">
                            <option value="" class="default">选择时间</option>
                            <g:each in="${dateList}" var="date">
                                <option value="${date.date}" ${date.default ? 'selected' : ''}>${date.date} ${date.dayOfWeek}</option>
                            </g:each>
                        </select>
                    </div>

                    <div id="product-list">
                    </div>

                    <div style="text-align: center;"><a class="button orange" onclick="submit()">提交</a></div>
                </g:form>
            </div>
        </div>
    </div>

    <div id="tpl-product-list" class="hidden">
        {{#products}}
        <div style="color: white; font-weight: bold;">{{productName}}需求</div>

        <div>
            <input type="number" name="quantity.{{productId}}" placeholder="要多少{{productUnit}}{{productName}}">
        </div>
        {{/products}}
    </div>

<g:render template="../h5/links"/>
<g:render template="../h5/wechatConfig"/>
<script>
    //    weChatReady(init);
    init();

    function init() {
        ajaxPost(queryShopsLink, {}, function (data) {
            if (data.model.shops && data.model.shops.length > 0) {
                var shops = data.model.shops;

                if (shops.length > 1) {
                    $("#shops_selection").html("<select name='shopId' onchange='updateProducts();'></select>");
                    $.each(shops, function () {
                        $("#shops_selection select").append("<option value=" + this.id + ">" + this.name + "</option>");
                    });
                } else {
                    $("#shops_selection").html("<span style='color: white'>" +
                            (shops[0].parentName ? shops[0].parentName : "") + " " + shops[0].name + "</span>");
                    $("#shops_selection").append("<input type='hidden' name='shopId' value='" + shops[0].id + "'>");
                    queryProducts(shops[0].id);
                }
            }
        });
    }

    function updateProducts() {
        console.log("Update products");
    }

    function queryProducts(shopId) {
        ajaxPost(queryShopProductsLink, {shopId: shopId}, function (data) {
            render($("#tpl-product-list"), $("#product-list"), data.model);
        });
    }

    function submit() {
        var form = $("div#createOrder form").serialize();
        ajaxPost(submitOrderLink, form, function (data) {
            console.log(data);
        });
    }
</script>
</body>
</html>