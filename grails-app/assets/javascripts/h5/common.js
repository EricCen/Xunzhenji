/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */
var postUserInfoCheckAction = new Array();
var postLocationCheckAction = new Array();
var hideFooterPanelSelectors = [
    "#main",
    "#confirm-order-panel",
    "#edit-group-panel",
    "#group-home-panel",
    "#lxgroup-order-management",
    "#my-commission-panel",
    "#order-detail-panel",
    "#listOrder",
    "#my-account-panel",
    "[id^=category_].panel",
    "#group-home-panel"
];
var showFooterPanelSelectors = [
    "[id^=product_].panel",
    "[id^=batch_].panel",
    "#manage-group-panel"
];

var week = ['日','一','二','三','四','五','六'];

$.urlParam = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
}

$.removeParam = function removeVariableFromURL(url_string, variable_name) {
    var URL = String(url_string);
    var regex = new RegExp( "\\?" + variable_name + "=[^&]*&?", "gi");
    URL = URL.replace(regex,'?');
    regex = new RegExp( "\\&" + variable_name + "=[^&]*&?", "gi");
    URL = URL.replace(regex,'&');
    URL = URL.replace(/(\?|&)$/,'');
    regex = null;
    return URL;
}

$.addParam = function addVariableToURL(url_string, variable_name, variable_value) {
    var hashs = url_string.split("#")
    var beforeHash = hashs[0];
    var hash = hashs.length > 1 ? hashs[1] : null;
    if (beforeHash.indexOf("?") > 0) {
        beforeHash += "&" + variable_name + "=" + variable_value;
    } else {
        beforeHash += "?" + variable_name + "=" + variable_value;
    }
    return beforeHash + (hash ? "#" + hash : "");
}

Date.prototype.format = function(fmt)
{
    var o = {
        "y+": this.getYear(),                 //年份
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}

$.fn.scrollTo = function( target, options, callback ){
    if(typeof options == 'function' && arguments.length == 2){ callback = options; options = target; }
    var settings = $.extend({
        scrollTarget  : target,
        offsetTop     : 50,
        duration      : 500,
        easing        : 'swing'
    }, options);
    return this.each(function(){
        var scrollPane = $(this);
        var scrollTarget = (typeof settings.scrollTarget == "number") ? settings.scrollTarget : $(settings.scrollTarget);
        var scrollY = (typeof scrollTarget == "number") ? scrollTarget : scrollTarget.offset().top + scrollPane.scrollTop() - parseInt(settings.offsetTop);
        scrollY = scrollY < 0 ? 0 : scrollY;
        scrollPane.animate({scrollTop : scrollY }, parseInt(settings.duration), settings.easing, function(){
            if (typeof callback == 'function') { callback.call(this); }
        });
    });
}

function afuiReady(){
    $(".panel").on('panelload', function (what) {
        loadedMyPanel(what.target);
        var panel = what.target.id;
        var met = $("#"+panel).attr('panelload');
        try{
            info("Load #" + panel, "CA");
            eval(met);
        }catch(e){
            error(JSON.stringify(e), "Load " + panel + " panel error");
        }
    });

    $(".panel").on('panelunload', function (what) {
        var panel = what.target.id;
        var met = $("#"+panel).attr('panelunload');
        try{
            eval(met);
        }catch(e){
            error(JSON.stringify(e), "Load " + panel + " panel error");
        }
    });

    for(var i in hideFooterPanelSelectors){
        $(hideFooterPanelSelectors[i]).on('panelload', function (what) {
            toggleFooter($(what.target));
        });
    }
    for(var i in showFooterPanelSelectors){
        $(showFooterPanelSelectors[i]).on('panelload', function (what) {
            toggleFooter($(what.target));
        });
    }

    $("nav li a").click(function () {
        $.afui.drawer.hide("#main-left-menu", 'left');
    });

    $("[id=suggestion]").on('panelload', function (what) {
        $("footer").hide();
    });

    info("Load " + window.location.hash, "CA");
    loadedMyPanel(window.location.hash);
    toggleFooter(window.location.hash);

    //if($.os.ios)
    $.afui.animateHeader(true);
}

function initSlider(elem) {
    jQuery(elem).find(".slide:not([src])").owlCarousel({
        navigation: false, // Show next and prev buttons
        slideSpeed: 300,
        lazyLoad: true,
        lazyFollow: false,
        paginationSpeed: 400,
        singleItem: true,
        pagination: true,
        autoHeight: true
    }).trigger('owl.play', 5000);
}

function initLazyLoad(elem) {
    var images = $(elem).find("img.lazy:not([src])");
    images.lazyload({
        container: $(elem),
        threshold : 200,
        effect: "fadeIn",
        effectspeed: 500,
    });
}

function redirect(link, params){
    var paramsStr = "?"
    $.each(params, function(key, value){
        paramsStr += key + "=" + value + "&";
    });
    if(this.hasOwnProperty("code") && code){
        paramsStr+="code="+ code;
    }
    window.location.href = link + paramsStr
}

function loadedMyPanel(what) {
    initSlider(what);
    initLazyLoad(what);
    initShareInfo(what);
}

function toggleFooter(selector){
    var hideFooter = false;
    for(var i in hideFooterPanelSelectors){
        if($(hideFooterPanelSelectors[i])[0] == $(selector)[0]) hideFooter = true;
    }
    if(hideFooter){
        $("footer").hide();
    }else{
        $("footer").show();
    }
}

function setCookie(c_name, value, expirehours) {
    var exdate = new Date()
    exdate.setHours(exdate.getHours() + expirehours)
    document.cookie = c_name + "=" + encodeURI(value) +
        (";expires=" + exdate.toGMTString())
}

function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=")
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1
            c_end = document.cookie.indexOf(";", c_start)
            if (c_end == -1) c_end = document.cookie.length
            return decodeURI(document.cookie.substring(c_start, c_end))
        }
    }
    return ""
}

function render(template, target, data){
    var rendered = Mustache.render(template.html(),data);
    target.html(rendered);
    var images = target.find("img.lazy");
    images.lazyload({
        container: target,
        threshold : 200,
        effect: "fadeIn",
        effectspeed: 500,
    });
}

function renderPrepend(template, target, data){
    var rendered = Mustache.render(template.html(),data);
    target.prepend(rendered);
    target.find("img.lazy").lazyload({
        container: target,
        threshold : 200,
        effect: "fadeIn",
        effectspeed: 500,
    });
}

function getHeadImage(){
    $.afui.popup({
        title: "获取头像",
        message: "允许寻真记获取您的微信头像和呢称,让你的好友更容易认出你.",
        cancelText: "不获取",
        cancelCallback: function () {},
        doneText: "获取",
        doneCallback: function () {
            retrieveWechatUserInfo();
        },
        cancelOnly: false
    });
}

function info(log, method){
    jQuery.ajax({
        url: clientLogInfoLink, async: true, type: 'get',
        data: {info: method? method + "-" + log : log},
        cache: false,
        dataType: 'json'
    });
}


function error(log, method){
    log = String(log);
    log = log.length > 200 ? log.substr(0, 200) : log;
    $.ajax({
        url: clientLogInfoLink, async: true, type: 'get',
        data: {error: method? method + "-" + log : log},
        cache: false,
        dataType: 'json'
    });
}

function popup(title, message, callback){
    $.afui.popup({
        title: title,
        message: message,
        cancelText: "知道了",
        cancelCallback: callback,
        cancelOnly: true
    });
}

function clearHistory(filter){ // remove all panel in filter
    var keep = [];
    var view = $.afui.findViewTarget($.afui.activeDiv);
    $($.afui.views[view.prop("id")]).each(function(){
        if(!filter.call(this.target)){
            keep.push(this);
        }
    });
    $.afui.views[view.prop("id")] = keep;
}

function cleanAllHistoryUntilTop(){
    var keep = [];
    $($.afui.views[view.prop("id")]).each(function(){
        if($(this).attr("id") == "main"){
            keep.push(this);
        }
    });
    $.afui.views[view.prop("id")] = keep;
}

function getPosition(element) {
    var xPosition = 0;
    var yPosition = 0;

    while(element) {
        xPosition += (element.offsetLeft - element.scrollLeft + element.clientLeft);
        yPosition += (element.offsetTop - element.scrollTop + element.clientTop);
        element = element.offsetParent;
    }
    return { x: xPosition, y: yPosition };
}

function showToast(elem, message, headImageUrl, delay){
    showToastWithHideToggle(elem, message, true, headImageUrl, delay)
}

function showToastWithHideToggle(elem, message, hide, headImageUrl, delay){
    var centerHeight = window.screen.height / 2;
    var y = event.pageY ? event.pageY : getPosition(elem).y;
    var pos = y > centerHeight  ? "tc" : "bc";
    if(hide){
        $("div.afToastContainer").find(".afToast").css("background-color", "#ECECEC").hide();
    }
    $.afui.toast({
        message: message,
        position: pos,
        type:"bubble",
        imageUrl: headImageUrl,
        delay: delay ? delay : 8000
    });
}

function goto(anchor){
    $.afui.loadContent(anchor, true, true, "slide");
}

function ajaxGet(link, data, successHandler, errorHandler) {
    addParamData(data);

    $.ajax({
        method: "GET",
        url: link,
        data: data,
        async: true,
        success: function (data) {
            if (data.errorcode == 0) {
                successHandler.call(this, data)
            }else{
                if(errorHandler) errorHandler.call(this, data);
            }
        }, error: function(e){
            error(JSON.stringify(e), "get " + link + ", error()");
        }
    });
}

function addParamData(data){
    if(openId){
        if (data instanceof String) {
            data+="&openId="+openId;
        } else if (data instanceof Object) {
            data.openId = openId;
        }
    }
}

function ajaxPost(link, data, successHandler, errorHandler){
    addParamData(data);

    $.ajax({
        method: "POST",
        url: link,
        data: data,
        async: true,
        success: function (data) {
            if (data.errorcode == 0) {
                successHandler.call(this, data);
            }else{
                if(errorHandler) errorHandler.call(this, data);
            }
        },
        error: function(e){
            unblockUI();
            error(JSON.stringify(e), "post " + link + ", error()");
        }
    });
}

function backToHome(elem) {
    var view = $(elem).parent().closest(".view");
    view.removeClass("active");
    view.find(".panel").removeClass("active");

    $.afui.clearHistory();
    $.afui.loadContent("#main", false, false, "pop-reveal:dismiss");
}

function blockUI() {
    if ($.afui) {
        $.afui.blockUI();
    }

}

function unblockUI() {
    if ($.afui) {
        $.afui.unblockUI();
    }
}