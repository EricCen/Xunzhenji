/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.model

import java.util.regex.Pattern

/**
 * Created by Irene on 2015/12/5.
 */
enum RouteInfoItem {
    SfExpress("shunfeng",
            "派件人:",
            ",电话:",
            ",电话:",
            ")",
            Pattern.compile(".*已收取快件.*"),
            Pattern.compile(".*派件人:.*,电话:.*"),
            Pattern.compile(".*已签收.*")),
    YouShu("youshuwuliu",
            "的【",
            "】正在派件",
            "电话：",
            " 寄件电话：",
            Pattern.compile(".*快件已由\\[广州天河八部.*"),
            Pattern.compile(".*正在派件.*"),
            Pattern.compile(".*已签收.*")),
    YunDa("yunda",
            "派送业务员：",
            "；联系电话：",
            "；联系电话：",
            null,
            Pattern.compile(".*到件扫描.*"),
            Pattern.compile(".*派送业务员.*联系电话：.*"),
            Pattern.compile(".*已签收.*"))

    String expressQueryName
    String courierStart
    String courierEnd
    String phoneStart
    String phoneEnd
    Pattern packageReceivePattern
    Pattern confirmCourier
    Pattern delivered

    public RouteInfoItem(String expressQueryName, String courierStart, String courierEnd, String phoneStart, String phoneEnd,
                         Pattern packageReceivePattern, Pattern confirmCourier, Pattern delivered) {
        this.expressQueryName = expressQueryName
        this.courierStart = courierStart
        this.courierEnd = courierEnd
        this.phoneStart = phoneStart
        this.phoneEnd = phoneEnd
        this.packageReceivePattern = packageReceivePattern
        this.confirmCourier = confirmCourier
        this.delivered = delivered
    }

    public static RouteInfoItem findByQueryName(queryName) {
        return values().find { it.expressQueryName == queryName }
    }

    def static Set<RouteInfoItem> packageReceivePatterns() {
        return values().collect { it.packageReceivePattern }
    }

    def static Set<RouteInfoItem> confirmCourierPatterns() {
        return values().collect { it.confirmCourier }
    }

    def static Set<RouteInfoItem> deliveredPatterns() {
        return values().collect { it.delivered }
    }
}
