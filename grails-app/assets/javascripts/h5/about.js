/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

/**
 * Created by jackeyjian on 15/9/4.
 */

function initAbout(){

    $.ajax({
        url: queryAboutLink, async: true, type: 'get',
        cache: false,
        dataType: 'json',
        success: function (data) {
            console.debug('about data : ');
            console.debug(data);

            $('#content').html(data.model.content);
        },
        error: function (err) {
            error(JSON.stringify(err));
        }
    });

}