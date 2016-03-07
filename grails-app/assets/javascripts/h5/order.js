/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var ignoreOrderLoad = false;

function initOrderList() {
    queryOrders($('#tabAllStatus>a')[0]);
}

function queryOrders(elem) {
    $("li[role='presentation']").removeClass('active');

    var status = $(elem).parent().attr('query-status');
    $(elem).parent().addClass('active');

    $.ajax({
        url: queryOrdersLink + "?status=" + status, async: true, type: 'get',
        cache: false,
        dataType: 'json',
        success: function (data) {
            if (data && data.errorcode == 0) {
                addOrderRows(data.model);
                addNavTab(data.model);

                $("#tab-"+status).addClass("active");
            } else {
            }
        },
        error: function () {
        }
    });
}

function addOrderRows(data) {
    var template = $('#tpl-order-list').html();
    var rendered = Mustache.render(template,data);
    $('#ul-list-order').html(rendered);
    $('#ul-list-order').find("img.lazy").lazyload({
        effect: "fadeIn",
        effectspeed: 500,
        event: "sporty"
    }).trigger("sporty");
}

function addNavTab(data) {
    var template = $('#tpl-order-status-list').html();
    var rendered = Mustache.render(template,data);
    $('#ul-order-status_list').html(rendered);
}

function refundOrder(orderId) {
    $.ajax({
        url: refundLink + "?orderId=" + orderId, async: true, type: 'get',
        cache: false,
        dataType: 'json',
        success: function (data) {
            if (data && data.errorcode == 0) {
                refundSuccess(orderId, data.model.displayStatus);
            } else {
                refundFailure();
            }
        },
        error: function () {
            refundFailure();
        }
    });
}

function convertDiscountStr(discount){
    var discountStr = Math.round((1 - discount)* 1000) / 100;
    discountStr = discountStr == 10 ? "" : discountStr + "折";
    return discountStr;
}

function confirmRefund(orderId, discount) {
    var discountStr = convertDiscountStr(discount);
    $.afui.popup({
        title: "退款",
        message: "真要退掉您的" + discountStr + "订单吗?",
        cancelText: "返回",
        cancelCallback: function () {},
        doneText: "我要退款",
        doneCallback: function () {
            refundOrder(orderId);
        },
        cancelOnly: false
    });
}

function refundFailure() {
    $.afui.popup({
        title: "退款不成功",
        message: "真抱歉,退款未能正常完成,请稍后再试.",
        cancelText: "知道了",
        cancelOnly: true
    });
}

function refundSuccess(orderId, displayStatus) {
    $.afui.popup({
        title: "退款成功",
        message: "感谢您的耐心等待!",
        cancelText: "知道了",
        cancelOnly: true,
        cancelCallback: function () {
            $(".order-"+ orderId).css("position", "inherit").animate({
                left: "+=600"
            }, 500, function() {
                $(".order-"+ orderId).css("position", "inherit").animate({
                    left: "-=600"
                }).find('.refund-btn').remove();
                $(".order-"+ orderId).find('.display-status').removeClass().addClass(displayStatus).addClass("display-status");
            });
        },
    });
}

function convertWeekDayStr(deliverDaysInWeekArr) {
    var deliverDaysInWeek = "";
    $(deliverDaysInWeekArr).each(function () {
        deliverDaysInWeek += week[this - 1] + ",";
    });
    deliverDaysInWeek = deliverDaysInWeek.substring(0, deliverDaysInWeek.length - 1);
    return deliverDaysInWeek;
}

function queryOrderDetail(orderId){

    ajaxGet(queryOrderDetailLink, {orderId: orderId}, function(data){
        var displayStatus = data.model.displayStatus;
        data.model[displayStatus] = "highlighted";
        $(data.model.deliverDateList).each(function(){
            this.dayInWeek = week[this.dayInWeek - 1];
        });
        data.model.groupDeliverDaysInWeek = "周" + convertWeekDayStr(data.model.groupDeliverDaysInWeek);
        data.model.deliverDaysInWeek = "周" + convertWeekDayStr(data.model.deliverDaysInWeek);

        $(data.model.deliverDateList2).each(function(){
            this.dayInWeek = week[this.dayInWeek - 1];
        });

        render($("#tpl-order-detail-panel"), $("#order-detail-panel"), data.model);

        if(data.model.deliverDate){
            $("#lx_day_" + data.model.deliverDate).attr("checked", "checked");
            $("#conf-deliver-time .confirm-time-group").hide();
            $("#conf-deliver-time .deliverDate").show();
            $(".action-group .conf-time-button").hide();
        }

    });
}

function loadOrderDetail(){
    var orderId = $.urlParam('orderId');
    if(orderId && !ignoreOrderLoad){
        queryOrderDetail(orderId);
        ignoreOrderLoad = true;
    }
}

function confirmDeliveryDate(elem){
    var deliveryDate = $("#conf-deliver-time").serialize();

    ajaxGet(confirmDeliveryDateLink, deliveryDate, function(data){
        showToast(elem, "确认收货时间成功.");
        $("#conf-deliver-time .confirm-time-group").hide();
        $("#conf-deliver-time .deliverDate").show();
        $(".action-group .conf-time-button").hide();
        if(data.hasOwnProperty("model") && data.model.deliverDate){
            $("#conf-deliver-time .deliverDate span").text(data.model.deliverDate);
        }
    }, function(data){
        showToast(elem, "<span style='color: red;font-weight: bold'>确认收货时间不成功!</span>");
    });
}

function confirmDelivery(elem){
    var orderId = $(elem).attr("orderId");
    ajaxGet(confirmDeliveryLink, {orderId:orderId}, function(data){
        showToast(elem, "确认收货成功.");
        var status = data.model.status;
        $("#order-detail-panel .order-status .display-status").removeClass("delivering").addClass(status);
        $("#order-detail-panel .conf-delivery-button").hide();
    });
}

function changeDeliveryDate(){
    $("#conf-deliver-time .confirm-time-group").show();
    $("#conf-deliver-time .deliverDate").hide();
    $(".action-group .conf-time-button").show();
}

function recalcAmount(){
    var balance =  parseFloat($("#order-payment-form .account-balance").attr("balance"));
    var totalCurrentPrice = parseFloat($("#order-payment-form .current-price").attr("total-current-price"));
    var useBalanceIndicator = $("#order-payment-form input#useBalance:checked").size() == 2; //this is a hack, as afui cannot directly provide the value
    if(useBalanceIndicator){
        $("#order-payment-form .used-balance").text((totalCurrentPrice >= balance ? balance : totalCurrentPrice).toFixed(2));
        $("#order-payment-form .wx-pay-amount").text((totalCurrentPrice >= balance ? totalCurrentPrice - balance : 0).toFixed(2));
    }else{
        $("#order-payment-form .used-balance").text("0.00");
        $("#order-payment-form .wx-pay-amount").text(totalCurrentPrice.toFixed(2));
    }
}

function updateOrderAddress(orderId, addressId){
    ajaxPost(updateOrderAddressLink, {orderId: orderId, addressId: addressId}, function(data){
        if(data.model.address){
            $("#order-detail-panel .address-receiver").text(data.model.name);
            $("#order-detail-panel .address-mobile").text(data.model.mobile);
            $("#order-detail-panel .address-detail").text(data.model.address);
        }
        $.afui.loadContent("#order-detail-panel", false, true, "slide");
    });
}

function onSelectFurtherDay(){
    $("#order-detail-panel .confirm-time-group input[type=radio]," +
        "#confirm-order-panel .confirm-time-group input[type=radio]").each(function(){
        $(this).removeAttr("on");
        $(this).removeAttr("checked");
    });
    $("#order-detail-panel .confirm-time-group select," +
        "#confirm-order-panel .confirm-time-group select").addClass("bold");
    $("#confirm-order-panel .confirm-time-group").parent().find(".item-title").css("background-color", "white");
}

function onSelectNearDay(){
    $("#order-detail-panel .confirm-time-group select," +
        "#confirm-order-panel .confirm-time-group select").each(function(){
        $(this).find(".default").prop('selected', true);
    });
    $("#order-detail-panel .confirm-time-group select," +
        "#confirm-order-panel .confirm-time-group select").removeClass("bold");
    $("#confirm-order-panel .confirm-time-group").parent().find(".item-title").css("background-color", "white");
}

function initConfirmOrderPanel(){
    $('[role="pay"]').text("支付订单").removeClass("btn-orange").removeClass("btn-green").addClass("btn-red");
}

function refreshPrice(elem){
    var promotionInput = $(elem).parent().find("#promotionCode1");
    var promotionCode = promotionInput.val();
    var orderIds = promotionInput.attr("order-ids");
    doRefreshPromtionCode(promotionCode, orderIds);
}

function doRefreshPromtionCode(promotionCode, orderIds){
    ajaxPost(refreshOrderPrice, {orderIds: orderIds, promotionCode: promotionCode}, function(data){
        var orders = data.model.newPriceList;
        $(orders).each(function(){
            var orderId = this.orderId;
            var orderItem = $("#order-payment .order-list .order-" + orderId);
            orderItem.find(".price.order-price").text(this.price);
            orderItem.find(".quantity").text("x " + this.quantity);
            //quantity
            var detailItem = $("#order-payment .price-detail-box.order-" + orderId);
            detailItem.find(".price.discount").text(this.discount);
            detailItem.find(".price.order-price").text(this.price);
            detailItem.find(".price.unit").text(this.price);
        });
        var totalPrice = parseFloat(data.model.totalPrice).toFixed(2);
        var balance =  parseFloat($("#order-payment-form .account-balance").attr("balance"));
        var useBalanceIndicator = $("#order-payment-form input#useBalance:checked").size() == 2; //this is a hack, as afui cannot directly provide the value
        if(useBalanceIndicator){
            $("#order-payment .payment-info .wx-pay-amount").text((data.model.totalPrice >= balance ? data.model.totalPrice - balance : 0).toFixed(2));
            $("#order-payment .payment-info .used-balance").text((data.model.totalPrice >= balance ? balance : data.model.totalPrice).toFixed(2));
        }else{
            $("#order-payment .payment-info .wx-pay-amount").text(totalPrice);
            $("#order-payment .payment-info .used-balance").text((0).toFixed(2));
        }
        $("#order-payment .current-price .price").text(totalPrice);
        $("#order-payment .current-price").attr("total-current-price", totalPrice);
        $("#order-payment .price-detail-box .total-price").text(totalPrice);
        if (data.model.desc) {
            if (data.model.isValid) {
                $("#order-payment .promotion-desc").text("(" + data.model.desc + ", 有效期至:" + data.model.expireDate + ")");
            } else {
                $("#order-payment .promotion-desc").text("(" + data.model.desc + ", 已经失效)");
            }
        } else {
            $("#order-payment .promotion-desc").text("");
        }
        if (data.model.address) {
            var address = data.model.address;
            $("#order-payment .show-address").show();
            $("#order-payment .show-address").attr("address-id", data.model.address.id);
            $("#order-payment .add-address-text").hide();
            if (data.model.isLxGroup) {
                $("#order-payment .show-address span.lxgroup-name").show();
                $("#order-payment .show-address span.receiver-name").hide();
            } else {
                $("#order-payment .show-address span.lxgroup-name").hide();
                $("#order-payment .show-address span.receiver-name").show();
            }
            $("#order-payment .show-address span.address-name").text(address.name);
            $("#order-payment .show-address span.address-phone").text(address.phone);
            $("#order-payment .show-address span.address-address").text(address.address);
            $("#order-payment .show-address .add-address-text").hide();
            if (address.headImage) {
                $("#order-payment .show-address .head-image img").attr("src", address.headImage);
            }
            $("#order-payment .show-address .show-address").show();

        } else {
            $("#order-payment .show-address").hide();
            var addText = $("#order-payment .add-address-text");
            addText.show();
        }
        if (data.model.fixAddress) {
            unwrapShowAddress();
        } else {
            wrapShowAddress();
        }
    });
}

function wrapShowAddress() {
    if (!$("#order-payment .show-address").parent().attr("href")) {
        var addText = $("#order-payment .add-address-text");
        var link = $("<a href='#address-panel' data-transition='slide-reveal' style='margin-right: 0px;' onclick='loadOrderAddress();'></a>");
        $("#order-payment .show-address").wrap(link);
        addText.appendTo($("#order-payment .show-address").parent());
    }
}

function unwrapShowAddress() {
    $("#order-payment .show-address").unwrap();
}

function autoRefresh(elem){
    var promotionInput = $(elem);
    var promotionCode = promotionInput.val();
    var orderIds = promotionInput.attr("order-ids");
    doRefreshPromtionCode(promotionCode, orderIds);
}