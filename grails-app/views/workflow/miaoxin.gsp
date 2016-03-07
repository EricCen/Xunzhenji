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

</head>

<body ontouchstart="">

<div class="container js_container">

</div>

<g:render template="/workflow/home"/>
<g:render template="/workflow/procurement"/>
<g:render template="/workflow/manufacture"/>
<g:render template="/workflow/delivery"/>
<g:render template="/workflow/source"/>
<g:render template="/workflow/manufactureList"/>
<g:render template="/workflow/deliveryList"/>
<g:render template="/workflow/procurementList"/>

<g:render template="../h5/links"/>
<g:render template="../h5/wechatConfig"/>

<asset:stylesheet href="/workflow/workflow-manifest.css"/>
<asset:javascript src="/workflow/workflow-manifest.js"/>
    <script>
        //    weChatReady(init);
        init();

        function init() {
            $(window).ready(function () {
                render($('#tpl_main_table'), $('#main_table'), pageData);
            });

//            ajaxPost(queryShopsLink, {}, function(data){
//                if(data.model.shops && data.model.shops.length>0){
//                    var shops = data.model.shops;
//
//                    if(shops.length>1){
//                        $("#shops_selection").html("<select name='shopId' onchange='updateProducts();'></select>");
//                        $.each(shops, function(){
//                            $("#shops_selection select").append("<option value=" + this.id + ">"+ this.name+"</option>");
//                        });
//                    }else{
//                        $("#shops_selection").html("<span style='color: white'>" +
//                                (shops[0].parentName?shops[0].parentName:"") + " " + shops[0].name + "</span>");
//                        $("#shops_selection").append("<input type='hidden' name='shopId' value='" + shops[0].id + "'>");
//                        queryProducts(shops[0].id);
//                    }
//                }
//            });
        }

        function initAddProcurement(date) {
            $("#add_procurement_date").text(date);
            ajaxGet(getProductListLink, {}, function (data) {
                var products = data.model.products;
                $.each(products, function () {
                    $("#ap_product").append("<option value='" + this.id + "'>" + this.name + "</option>");
                })
            });
        }

        function showAddProcurement(elem) {
            initAddProcurement($(elem).attr("date"));
            $.afui.loadContent("#addProcurement", false, false);
        }


        function showAddShopDelivery(elem) {
//            initAddProcurement($(elem).attr("date"));
            $.afui.loadContent("#addShopDelivery", false, false);
        }

        function resetAddProcurement() {
            $("#ap_source").val("");
            $("#ap_quantity").val("");
            $("#ap_price").val("");
            $("#ap_weight").val("");
            $("#ap_quantityLeft").val("");
        }

    </script>
</body>
</html>