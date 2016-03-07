/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var payable=true;

function placeOrder() {
    if($('[role=order]').hasClass("invalid")){ return;}

    //get all orderIds from shoppingcart
    var ids;
    if(orderIdList.length >0){
        ids = "";
        $(orderIdList).each(function(){
            ids += this + ",";
        });
        ids= ids.substr(0, ids.length -1);
    }

    if (userInfoCheck()) {
        buildConfirmOrderPage(ids, function(){
            $.afui.loadContent("#confirm-order-panel", false, false, "up-reveal:dismiss");
        });
    } else {
        postUserInfoCheckAction.push(function () {
            buildConfirmOrderPage(ids, function(){
                $.afui.loadContent("#confirm-order-panel", false, false, "up-reveal:dismiss");
            });
        });
    }
}

function buildConfirmOrderPage(orderIds, callback){
    $.ajax({
        url: confirmOrderLink, async: true, type: 'post',
        data: {orderIds: orderIds},
        cache: false,
        dataType: 'json',
        success: function (data) {
            if (data.errorcode == 0) {
                render($('#tpl-order-payment'), $('#order-payment'), data.model);
                if(data.model.address){
                    $("#confirm-order-panel .show-address").show();
                    $("#confirm-order-panel .add-address-text").hide();
                }else{
                    $("#confirm-order-panel .show-address").hide();
                    $("#confirm-order-panel .add-address-text").show();
                }
                if(data.model.useGroup){
                    $("#confirm-order-panel .receiver-name").hide();
                    $("#confirm-order-panel .lxgroup-name").show();
                }else{
                    $("#confirm-order-panel .receiver-name").show();
                    $("#confirm-order-panel .lxgroup-name").hide();
                }
                callback.call();

                // do promotion code refresh
                if(data.model.promotionCode){
                    doRefreshPromtionCode(data.model.promotionCode, data.model.orderIds);
                }
            }
        },
        error: function (data) {
            error("Fail to connect to url: " + confirmOrderLink + ", status: " + data.status + ", statusText: " + data.statusText);
        }
    });
}

function payForOrder(elem) {
    var orderId = $(elem).attr("orderId");
    var params = {rand:Math.random(), orderIds: orderId}
    if (userInfoCheck()) {
        buildConfirmOrderPage(orderId, function(){
            $("#confirm-order-panel").parents(".view").find(".active.panel").removeClass("active");
            $.afui.loadDiv("#confirm-order-panel", false, false, "up-reveal");
        });
    } else {
        postUserInfoCheckAction.push(function () {
            buildConfirmOrderPage(orderId, function(){
                $("#confirm-order-panel").parents(".view").find(".active.panel").removeClass("active");
                $.afui.loadDiv("#confirm-order-panel", false, false, "up-reveal");
            });
        });
    }
}

function wxPay() {
    if(!payable){
        return;
    }
    $.afui.blockUI(0.1);
    if(!$("#order-payment .show-address").attr("address-id")){
        showToast($("#order-payment .show-address"), "亲爱的顾客，您还没有填地址，请点击最顶<span style='background-color: #FF6161; color: white;'>红色</span>按钮。");
        $("#confirm-order-panel").scrollTo($("#confirm-order-panel #order-payment-form"));
        $.afui.unblockUI();
        return;
    }

    if($("#confirm-order-panel #order-payment-form .confirm-time-group").size() > 0 &&
        $("#confirm-order-panel #order-payment-form").serialize().replace(/deliverDate=&/g, "").indexOf("deliverDate=")<0){
        showToast($("#order-payment .show-address"), "亲爱的顾客，请选择<span style='background-color: #FF6161'>送货时间</span>后再提交订单。");
        $("#confirm-order-panel").scrollTo($("#confirm-order-panel #order-payment-form"));
        $("#confirm-order-panel .confirm-time-group").parent().find(".item-title").css("background-color", "#FF6161");
        $.afui.unblockUI();
        return;
    }

    $('[role="pay"]').text("正在支付中,请稍等...").removeClass("btn-green").addClass("btn-orange");
    payable = false;
    $.afui.unblockUI();
    if(openId){
        $("#order-payment-form").append("<input type='hidden' name='openId' value='" + openId +"'>")
    }

    bindWeChatJsApi(ajaxPay);
}

function ajaxPay() {
    info("Start to pay for order");
    ajaxPost(payLink, $("#order-payment-form").serialize(), function (data) {
            if(data.model.paymentType == "ACCOUNT" && data.model.payAmount == 0){
                redirect(paymentSuccessLink,
                    {prepayId: data.model.prepayId, outTradeNo: data.model.outTradeNo});
                return;
            }else if(data.model.paymentType == "ALIPAY"){
                    redirect(alipayLink,
                        {outTradeNo: data.model.outTradeNo});
                return;
            }

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
                    payable = true;
                    if ("get_brand_wcpay_request:ok" == res.err_msg) {
                        $('[role="pay"]').text("支付完成").removeClass("btn-orange").addClass("btn-green");
                        $.afui.clearHistory();
                        var backlen = history.length - 1;
                        history.go(-backlen);
                        redirect(paymentSuccessLink, {prepayId: data.model.prepayId});
                    } else if ("get_brand_wcpay_request:cancel" == res.err_msg) {
                        $('[role="pay"]').text("重新支付").removeClass("btn-orange").addClass("btn-red");
                        info("Payment cancel, res:" + JSON.stringify(res));
                    } else {
                        error("Payment error, res:" + JSON.stringify(res));
                        redirect(homeLink, {});
                    }
                }
            );
        }, function(data){ //failure handler
            payable = true;
            $.afui.popup({
                title: "差点就支付成功了",
                message: "再来一次吧?",
                cancelText: "返回",
                cancelCallback: function () {
                    $.afui.goBack();
                },
                doneText: "再来一次",
                doneCallback: function () {
                    $('[role="pay"]').text("重新支付").removeClass("btn-orange").addClass("btn-red");
                },
                cancelOnly: false
            });
        }
    );
}
