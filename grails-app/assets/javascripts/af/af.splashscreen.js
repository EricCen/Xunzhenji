
/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

/**
 * af.splashscreen 
 * @copyright Intel 2014 
 * 
 */
(function($){
    "use strict";
    $.afui.ready(function(){
        //delay to hide the splashscreen
        setTimeout(function(){
            $("#splashscreen").remove();
        },250);
    });
})(jQuery);