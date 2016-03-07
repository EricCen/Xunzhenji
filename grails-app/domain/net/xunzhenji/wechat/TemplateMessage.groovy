/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

class TemplateMessage {

    WeChatFans toUser
    Template template
    String url
    String topColor
    String data

    static constraints = {
    }
}
