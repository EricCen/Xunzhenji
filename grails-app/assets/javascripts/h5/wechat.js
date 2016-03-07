/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var appId;
var shareInfo;
var code;

function initSession() {
    code = $.urlParam('code');
    info("Start to init session, code=" + code)
    ajaxPost(initSessionLink, {code: code}, function (data) {
        if (data != null && data.model) {

            if(data.model.snsapiUserInfoUrl){
                window.location.href = data.model.snsapiUserInfoUrl;
            }

            if (data.model.name) {
                $('.user-name-mobile>.user-name>h4').text(data.model.name);
                userName = data.model.name;
            }
            if (data.model.mobile) {
                $('.user-name-mobile>.user-mobile').text(data.model.mobile);
                userMobile = data.model.mobile;
                $('nav#main-left-menu .my-account .user-name-mobile').show();
                $('nav#main-left-menu .my-account .user-login-btn').hide();
            } else {
                $('nav#main-left-menu .my-account .user-login-btn').show();
                $('nav#main-left-menu .my-account .user-name-mobile').hide();
            }

            if (data.model.headImgUrl) {
                $('nav#main-left-menu .my-account img').attr("src", data.model.headImgUrl);
                $('nav#main-left-menu .my-account .user-name-mobile').show();
                $('nav#main-left-menu .my-account .user-login-btn').hide();
            } else {
                $('nav#main-left-menu .my-account .user-login-btn').show();
                $('nav#main-left-menu .my-account .user-name-mobile').hide();
            }

            if(data.model.openId){
                openId = data.model.openId;
            }

            initShoppingCart();
            info("Init session completed.");
        }
    }, function (data) {
        error(JSON.stringify(data), "initSession issue");
    });
}

function weChatReady(callback, params) {
    wx.ready(function () {
        info("Wechat session ready.");
        if (callback) {
            callback.call(params);
        }
    });
}

function bindWeChatJsApi(callback, params) {
    var url = encodeURIComponent(location.href.split('#')[0]);
    info("Start to bind wechat js api, url:" + url);

    ajaxPost(jsApiLink, {url: url}, function (data) {
            var timestamp = data.model.timestamp;
            var nonceStr = data.model.nonceStr;
            var signature = data.model.signature;
            appId = data.model.appId;
            wx.config({
                debug: false,
                appId: appId,
                timestamp: timestamp,
                nonceStr: nonceStr,
                signature: signature,
                jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'getLocation', 'chooseWXPay']
            });

            weChatReady(callback, params);
        }, function () {
            error(JSON.stringify(e), "bindWeChatJsApi.error()");
        }
    );
}

function snsapiBaseUrl(appId, path) {
    return "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId +
        "&redirect_uri=" + encodeURI(path) +
        "&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect";
}

function initShareInfo(elem){
    var title = $(elem).attr('share-title');
    title = title ? title : $(elem).attr('data-title');
    var anchor = $(elem).attr('id');
    var desc = $(elem).attr('desc');
    var imgUrl = $(elem).attr('thumb-url');
    var updateShareInfo = function () {
        var shareInfo = {
            title: title,
            link: $.removeParam(location.href, 'code'),
            imgUrl: imgUrl,
            desc: desc,
            success : function(){
                ajaxGet(shareToTimelineLink, {});
            },
            cancel : function() {
                ajaxGet(cancelShareToTimelineLink, {});
            }
        };

        //info("Init share time line, " + JSON.stringify(shareInfo));
        wx.onMenuShareTimeline(shareInfo);

        //info("Init share app message.");
        wx.onMenuShareAppMessage(shareInfo);
    }

    try{
        if (this.hasOwnProperty('wx')) {
            updateShareInfo();
        }
        wx.ready(function () {
            updateShareInfo();
        });
    }catch(e){}
}

function retrieveWechatUserInfo(){
    window.location.href = snsUserInfoLink;
}