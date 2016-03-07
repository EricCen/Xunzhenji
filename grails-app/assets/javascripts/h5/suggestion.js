/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

//init suggestion page
var counter = 1;
function initSuggestion(){

    ajaxGet(querySuggestionLink, {}, function(data){
        render($('#tpl-suggestion'), $('#suggList'), data);
        var template = $('#tpl-suggestion').html();
        var rendered = Mustache.render(template,data);
        $('#suggList').html(rendered);
    }, function(err){
        error(JSON.stringify(err));
    });

    $('#showMore').text('显示更多');
    counter = 1;
    $('#showMore').click(showMore);

}

//register submit event
$(document).ready(function() {

    //submit a suggestion:
    $('#suggBtn').click(function () {
        var content = $('#suggTxt').val();
        var code = $('#captchaTxt').val();

        //非空检查
        if (content.trim() === "") {
            showToast(this, '请输入建议');
            return false;
        }

        if (code.trim() === "") {
            showToast(this, '请输入验证码');
            return false;
        }

        $.ajax({
            url: submitSuggestionLink, async: true, type: 'post',
            cache: false,
            data: {
                code: code,
                content: content
            },
            dataType: 'json',
            success: function (data) {
                if (data.errorcode == '-2') {//验证失败
                    showToast(this, '验证码错误,请重新输入');
                    return false;
                } else {//保存成功
                    showToast(this, '谢谢您的建议！');
                    //重置页面
                    $('#captchaImg').click();
                    $('#suggTxt').val('');
                    $('#captchaTxt').val('');

                    initSuggestion();
                }
            },
            error: function (err) {
                error(JSON.stringify(err));
            }
        });
    })

    //click to change captcha:
    $('#captchaImg').click(function () {
        var self = this;
        console.log(self);
        this.src = '/captcha/genRandomCode?t=' + new Date();
    })
});

function showMore(){

    var total = 0;

    //获取总条数：
    $.ajax({
        url: querySuggestionLink, async: false, type: 'get',
        cache: false,
        dataType: 'json',
        success: function (data) {
            total = data.model[0].total;
        },
        error: function (err) {
        }
    });

    console.log('total = ' + total)

    //请求更多数据：
    $.ajax({
        url: querySuggestionLink + '?offset=' + counter * 10, async: true, type: 'get',

        cache: false,
        dataType: 'json',
        success: function (data) {
            console.debug('loading more suggestion data : ');
            console.debug(data);

            var template = $('#tpl-suggestion').html();
            var rendered = Mustache.render(template, data);
            $('#suggList').append(rendered);
        },
        error: function (err) {
            error(err.statusText)
        }
    });

    if (total - counter * 10 < 10) {
        $('#showMore').text('已显示全部' + total + '条建议');
        $('#showMore').unbind();
        counter = 1;
    } else {
        counter += 1;
    }
}
