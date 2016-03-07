/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

/**
 * Created by Irene on 2015/8/31.
 */
class DepositRecord {
    enum Channel {
        WECHAT_DEPOSIT(id: 10, description: "微信充值"),
        LXGROUP_DEPOSIT(id: 20, description: "领鲜群充值"),
        CARD_DEPOSIT(id: 30, description: "卡券充值")

        int id
        String description
    }

    BigDecimal amount
    Channel channel
    Date dateCreated
    String remark

    static belongsTo = [userInfo: UserInfo]

    static constraints = {
        remark nullable: true
    }
}
