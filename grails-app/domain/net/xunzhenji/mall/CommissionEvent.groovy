/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

/**
 * Created by Irene on 2015/8/31.
 */
class CommissionEvent {
    public static int EVENT_CREATE = 0
    public static int EVENT_REALISE = 10
    public static int EVENT_CANCEL = 20
    public static int EVENT_UNREALISE = 30 //有人退群导致群解散

    int event
    BigDecimal amount
    int state
    UserInfo organizer
    Date dateCreated

    static belongsTo = [commission: Commission]
}
