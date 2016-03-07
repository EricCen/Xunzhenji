
/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var shoppingCartModel = new Object();
var orderIdList = new Array();

function goodsReduce(obj) {
    var goodsNumInput = $(obj).parent().find("input.input-num");
    var quantity = parseInt(goodsNumInput.val());
    var price = parseFloat(goodsNumInput.attr("price"));
    if (quantity >= 1) {
        goodsNumInput.val(--quantity);
    }
    var batchId = $(obj).parent().attr('batch-id');
    updateShoppingCart(batchId, price, quantity);
}

function goodsAdd(obj) {
    var goodsNumInput = $(obj).parent().find("input.input-num");
    var quantity = parseInt(goodsNumInput.val());
    var price = parseFloat(goodsNumInput.attr("price"));
    goodsNumInput.val(++quantity);
    var batchId = $(obj).parent().attr('batch-id');
    updateShoppingCart(batchId, price, quantity);
}

function updateNumber(obj){
    var goodsNumInput = $(obj);
    var quantity = parseInt(goodsNumInput.val());
    var price = parseFloat(goodsNumInput.attr("price"));
    if(!quantity || quantity < 0) quantity = 0;
    goodsNumInput.val(quantity);
    var batchId = $(obj).parent().attr('batch-id');
    updateShoppingCart(batchId, price, quantity);
}

function updateSpinners(batchId, quantity) {
    jQuery('#shoppingcart [batch-id=' + batchId + '].xzj-spinner input.input-num').each(function () {
        var price = jQuery(this).attr('price');
        var totalPrice = quantity * parseFloat(price);
        totalPrice = totalPrice ? totalPrice : 0;
        quantity = quantity ? quantity : 0;
        jQuery(this).parents('.order-item').find('span.price.total').text(totalPrice);
        jQuery(this).val(quantity);
    });
}

function updateShoppingCart(batchId, price, quantity) {
    updateSpinners(batchId, quantity);
    updateShoppingCartTotalPriceAndCount(batchId, price, quantity);

    jQuery.ajax({
        url: updateShoppingCartLink, async: true, type: 'post',
        data: {batchId: batchId, quantity: quantity},
        cache: false,
        dataType: 'json',
        success: function (data) {
            if (data.errorcode == 0 && data.model.shoppingCartCount) {
                $.afui.updateBadge("#shoppingcart-badge", data.model.shoppingCartCount);
                jQuery('[role=order-amount]').text(data.model.shoppingCartPrice);
                if(data.model.orderIds){
                    orderIdList = new Array();
                    $(data.model.orderIds).each(function(){
                        if(this != null){
                            orderIdList.push(this);
                        }
                    });
                }
            }
        },
        error: function (err) {
            error(JSON.stringify(err));
        }
    });
}

function initShoppingCart() {
    jQuery('#full-shoppingcart>ul.batch-list').html('');
    jQuery.ajax({
        url: queryShoppingCartLink, async: true, type: 'get',
        cache: false,
        dataType: 'json',
        success: function (data) {
            if (data && data.errorcode == 0) {
                jQuery('#empty-shoppingcart').hide();
                var shoppingCartDiv = jQuery('#full-shoppingcart');
                var ul = shoppingCartDiv.find('.batch-list');

                render($('#tpl-order-items'), ul, data.model);

                orderIdList = new Array();
                $(data.model.orders).each(function(){
                    if(this.showSpinner){ // don't update spinner if the order is paid
                        updateSpinners(this.batchId, this.quantity);
                    }
                    updateShoppingCartTotalPriceAndCount(this.batchId, this.unitPrice, this.quantity);
                    orderIdList.push(this.orderId);
                });

                $.afui.updateBadge("#shoppingcart-badge", data.model.shoppingCartCount);
                $('[role=order-amount]').text(data.model.shoppingCartPrice);
                shoppingCartDiv.show();
            } else if (data && data.errorcode == -8) {
                jQuery('#full-shoppingcart').hide();
                jQuery('#empty-shoppingcart').show();
                $.afui.updateBadge("#shoppingcart-badge", 0);
                $('[role=order-amount]').text(0);
            }
        },
        error: function (err) {
            error(JSON.stringify(err));
        }
    });
}

function updateShoppingCartTotalPriceAndCount(batchId, price, count){
    var priceAndCount = shoppingCartModel[batchId];
    if(!priceAndCount){
        shoppingCartModel[batchId] = {price:price, count:count};
    }else{
        shoppingCartModel[batchId].count = count;
    }
    //calc total price and count
    var totalPrice = 0;
    var totalCount = 0;
    for(id in shoppingCartModel){
        totalPrice += shoppingCartModel[id].price * shoppingCartModel[id].count;
        totalCount += shoppingCartModel[id].count;
    }
    $.afui.updateBadge("#shoppingcart-badge", totalCount);
    $('[role=order-amount]').text(totalPrice);
    if (totalCount > 0) {
        $("[role=order]").removeClass("invalid");
    }else{
        $("[role=order]").addClass("invalid");
    }

}