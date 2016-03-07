/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import net.xunzhenji.wechat.WeChatFans

class Suggestion {

    def String content
    def String reply
    def Date replyDate
    def Date dateCreated
    def WeChatFans weChatFans

    static constraints = {
        reply nullable: true
        replyDate nullable: true
    }
}
