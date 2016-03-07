/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

class WapLinkTagLib {
    def waplink = { attrs, body->
        def controller = attrs.controller
        def id = attrs.id
        def host = createLink(action: "index", controller:"home", absolute: true) as String
        host = host.substring(0, host.indexOf("/", 8))  // skip http;//
        def clz = attrs['class']?"class=\"${attrs['class']}\"":""
        out << "<a href=\"${host}/h5/${controller}/${id}\" ${clz}>${body()}</a>"
    }

    def qrcode = { attrs, body->
        def action = attrs.action
        def id = attrs.id
        def fragment = "${action}_${id}"
        def host = createLink(action: "index", controller:"home", absolute: true) as String
        host = host.substring(0, host.indexOf("/", 8))  // skip http;//
        out << "<img src=\"${host}/qrCode?link=http://xunzhenji.net/h5/home?hash=${fragment}\"></img>"
    }

    def spinner = { attrs, body->
        def tag = attrs.tag
        def value = attrs.value ? attrs.value : 0
        def batchId = attrs.batchId
        out << "<div class=\"xzj-spinner\" batch-id=\"${batchId}\">"
        out << '<a class="btn-reduce" onclick="goodsReduce(this);">-</a>'
        out << "<input type=\"tel\" class=\"input-num\" role=\"preorder-count\" onchange=\"updateNumber(this);\" ${tag} value=\"${value}\"/>"
        out << '<a class="btn-add" onclick="goodsAdd(this);">+</a>'
        out << '</div>'
    }
}
