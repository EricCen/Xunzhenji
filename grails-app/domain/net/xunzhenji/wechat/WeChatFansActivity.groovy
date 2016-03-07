/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import net.xunzhenji.mall.Product

/**
 * Created by Irene on 2016-01-16.
 */
class WeChatFansActivity {
    enum ActionType {
        SUBSCRIBE, CLICK_MENU, TEXT_MSG, PAYMENT,
    }
    Date dateCreated
    ActionType actionType
    String actionContent
    Product product

    static belongsTo = [fans: WeChatFans]

    static constraints = {
        actionContent nullable: true
        product nullable: true
    }
}
