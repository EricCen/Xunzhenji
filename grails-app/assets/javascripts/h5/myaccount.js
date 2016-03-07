/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

function initMyAccount(){
    var queryMyAccount = function(){
        ajaxGet(queryMyAccountLink, {}, function(data){
            render($("#tpl-my-account"), $("#my-account-panel"), data.model);
            if(data.model.addressId){
                $("#my-account-panel .show-address").show();
                $("#my-account-panel .add-address-text").hide();
            }else{
                $("#my-account-panel .show-address").hide();
                $("#my-account-panel .add-address-text").show();
            }
        });
    }
    if(userInfoCheck()){
        queryMyAccount.call();
    }else{
        postUserInfoCheckAction.push(queryMyAccount);
    }
}

function deposit(){
    $.afui.popup({
        title: "向账户充值",
        message: "金额: <input type='number' id='deposit-amount' class='af-ui-forms'>不能少于100元<br>",
        cancelText: "取消",
        cancelCallback: function () {},
        doneText: "确定",
        doneCallback: function () {
            var depositAmt = parseFloat($("#deposit-amount").val());
            if(depositAmt >= 100){
                processDeposit(depositAmt)
            }
        },
        cancelOnly: false
    });
}

function processDeposit(amount){
    bindWeChatJsApi(function () {
        ajaxPost(depositLink,{amount: amount}, function (data) {
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
                            $.afui.clearHistory();
                            var backlen = history.length - 1;
                            history.go(-backlen);
                            redirect(paymentSuccessLink, {prepayId: data.model.prepayId});
                        } else if ("get_brand_wcpay_request:cancel" == res.err_msg) {
                            info("Payment cancel, res:" + JSON.stringify(res));
                        } else {
                            error("Payment error, res:" + JSON.stringify(res));
                        }
                    }
                );
            }
        );
    });
}

function queryDepositRecords(){
    ajaxGet(queryDepositRecordsLink, {}, function(data){
       render($("#tpl-deposit-record-ul"), $("#deposit-record-ul"), data.model);
    });
}