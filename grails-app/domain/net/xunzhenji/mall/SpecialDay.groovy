/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

/**
 * Created by Irene on 2016-01-21.
 */
class SpecialDay {
    public static int TYPE_INCLUDE_DAY = 1
    public static int TYPE_EXCLUDE_DAY = 2
    public static int TYPE_HOLIDAY = 3

    int type
    Date date
    String remark

    static belongsTo = [category: Category]

    static constraints = {
        remark nullable: true
    }

    static mapping = {
        date type: 'date'
    }
}
