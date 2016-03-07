/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var timerId;
var userMobile;
var userName;
var openId;

function userInfoCheck() {
    if (!userMobile || !userName) {
        showRegisterPanel();
        return false;
    }
    return true;
}

function executePostUserInfoCheckActions() {
    hidePanel();

    while (postUserInfoCheckAction.length > 0) {
        postUserInfoCheckAction.pop().call();
    }
}

function validateMobileNum(mobileNum){
    if(mobileNum.match(/^\d{11}$/)){
        $('.incorrect-mobile').hide();
        return true;
    }else{
        $(mobileNum).focus();
        $('.incorrect-mobile').show();
        return false;
    }
}

function validateMobile(){
    var phoneNumber = $('#login-mobile').val();
    if(!validateMobileNum(phoneNumber)){
        return;
    }
    var randomCode = $('#randomCode').val();
    var data = {mobile: phoneNumber};
    if(randomCode) data.randomCode = randomCode;

    ajaxPost(validateMobileLink, data, function (data) { // success handler
        var seq = data.model.seq;
        $('#seq').html(seq);
        $('#seqValue').val(seq);
        $('[role=userDetail]').show();
        $('[role=mobileCaptcha]').show();
        $('[role=confirmMobile]').hide();
        $('[role=confirmInfo]').show().css("display", "block");
        countDown();
    }, function (data) { // error handler
        if (data.errorcode == -2) {
            $('[role=randomCaptcha]').show();
            $('img.lazy').lazyload();
        } else if(data.errorcode == -20){

        }
    });
}

function countDown(){
    $('[role=reGetMobileCaptcha]').toggleClass('not-active');
    var counter = 60;
    var refreshTimer = function(){
        if(counter > 0) {
            counter--;
            $('[role=reGetMobileCaptcha]').html(counter+"秒后重发");
            clearTimeout(timerId);
            timerId = setTimeout(refreshTimer, 1000);
        } else {
            clearTimeout(timerId);
            $('[role=reGetMobileCaptcha]').html("重新发送");
            $('[role=reGetMobileCaptcha]').toggleClass('not-active');
        }
    };
    $('[role=reGetMobileCaptcha]').html(counter+"秒后重发");
    timerId = setTimeout(refreshTimer, 1000);
}
function refreshRandomCaptcha(){
    $('[role=reGetRandomCaptcha]').html('<img src="/captcha/genRandomCode?_r=' + Math.random() +'">');
}

function matchRandomCaptcha(evt){
    var randomCode = $(evt.target).val();
    if(randomCode.match(/^\w{4}$/)){
        $.ajax({
            url: checkRandomCodeLink, async: true, type: 'post',
            data: {code: randomCode},
            cache: false,
            dataType: 'json',
            success: function (data) {
                if(data.errorcode == 0){
                    $('[role=randomCaptcha]').hide();
                    $('.incorrect-code').hide();
                    validateMobile();
                } else if(data.errorcode == -2) {
                    $('[role=randomCaptcha]').show();
                    $('.incorrect-code').show();
                }
            },
            error: function () {}
        });
    }
}

function matchMobileCaptcha(){
    var seq = $('#seqValue').val();
    var mobileCode = $('#mobileCode').val();
    var data = {code: mobileCode, seq: seq};
    var randomCode = $('#randomCode').val();
    if(randomCode) data.randomCode = randomCode;

    if(mobileCode.match(/^\d{4}$/)){
        $.ajax({
            url: checkMobileCodeLink, async: true, type: 'post',
            data: data,
            cache: false,
            dataType: 'json',
            success: function (data) {
                if(data.errorcode == 0){
                    $('[role=mobileCaptcha]').hide();
                    $('.incorrect-code').hide();
                    $('#mobile').attr('readonly','').css('border-bottom','none');
                    $('i.verified').show();
                } else if(data.errorcode == -2) {
                    $('.incorrect-code').show();
                }
            },
            error: function () {}
        });
    }
}

function invalidCode(event){
    $('.incorrect-code').show();
    checkOtherValidity();
}

function invalidPassword(event){
    $('.incorrect-password').show();
    checkOtherValidity();
}

function invalidMobile(event){
    $('.incorrect-mobile').show();
    checkOtherValidity();
}

function invalidName(event){
    $('.incorrect-name').show();
    checkOtherValidity();
}

function checkOtherValidity(){
    if($('#mobileCode')[0].validity.valid){$('.incorrect-code').hide();}
    if($('#password')[0].validity.valid){$('.incorrect-password').hide();}
    if($('#login-mobile')[0].validity.valid){$('.incorrect-mobile').hide();}
    if($('[role=realName] input')[0].validity.valid){$('.incorrect-name').hide();}
    return  $('#password')[0].validity.valid && $('[role=realName] input')[0].validity.valid;
}

function userInfoSubmit(){
    $.afui.blockUI(0.1);
    if(!checkOtherValidity()){
        $.afui.unblockUI();
        return;
    }

    ajaxPost(addUserInfoLink, $("#user-info-form").serialize(), function (data) {
        handleSuccessUserLoginOrRegister(data.model.userName, data.model.mobile);
        $.afui.unblockUI();
        info("Handle success user login or register completed, user:" + data.model.userName);
    }, function(data){
        if(data.errorcode == -1){
            $('.incorrect-code').show();
        }else{
            error(JSON.stringify(data, "userInfoSubmit()"));
        }
        $.afui.unblockUI();
    });
    return false;
}

function handleSuccessUserLoginOrRegister(_userName, _userMobile){
    $(".user-info .user-login-btn").hide();
    $(".user-info .user-name h4").text(_userName);
    $(".user-info .user-mobile").text(_userMobile);
    $('.user-info .user-name-mobile').show();
    userName = _userName;
    userMobile = _userMobile;
    $.afui.drawer.hide("#main-left-menu","left");
    executePostUserInfoCheckActions();
}

function userLogin(){
    var mobile = $("[name=mobile]").val();
    var password = $("[name=loginPassword]").val();
    $.ajax({
            url:"/j_spring_security_check",
            async: true, type: 'post',
            data: {j_username:mobile, j_password:password},
            dataType: 'json',
            success: function (data) {
                if(data.success){
                    $.ajax({
                        url: userAuthLink, async: true, type: 'post',
                        success: function (data) {
                            if(data.errorcode == 0){
                                handleSuccessUserLoginOrRegister(data.model.userName, data.model.mobile);
                            }else {
                            }
                    }});
                }else {
                }
            },
            error: function () {
            }
        }
    );
    return false;
}

function showRegisterPanel() {
    $("[role=loginTip]").text("绑定手机号码");
    $("[role=loginPassword]").hide();
    $("[role=loginRemind]").show();
    $("[role=confirmMobile]").show();
    $("[role=login]").hide();
    $.afui.loadContent("#login", true, false, "up-reveal");
}

function hidePanel(){
    $.afui.loadContent("#main", true, false, "down", "#login-container");
}

function showLoginPanel() {
    $("[role=loginTip]").text("登录");
    $("[role=loginPassword]").show();
    $("[role=loginRemind]").hide();
    $("[role=confirmMobile]").hide();
    $("[role=login]").show();
    $.afui.loadContent("#login", true, false, "up-reveal");
}