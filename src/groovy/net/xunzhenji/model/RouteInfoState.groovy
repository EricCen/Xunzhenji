/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.model

import java.util.regex.Pattern

/**
 * Created by Irene on 2015/12/5.
 */
enum RouteInfoState {
    PACKAGE_RECEIVED(0, "已收件", RouteInfoItem.packageReceivePatterns()),
    DELIVERING(10, "转运中",null),
    CONFIRM_COURIER(15, "派送中", RouteInfoItem.confirmCourierPatterns()),
    DELIVERED(20, "已签收", RouteInfoItem.deliveredPatterns())

    int id
    String description
    Set<Pattern> matchPatterns

    public RouteInfoState(id, description, matchPatterns) {
        this.id = id
        this.description = description
        this.matchPatterns = matchPatterns
    }
}
