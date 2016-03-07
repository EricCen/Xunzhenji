/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.delivery

import net.xunzhenji.mall.Express
import net.xunzhenji.model.RouteInfoItem
import net.xunzhenji.model.RouteInfoState

/**
 * Created by Irene on 2015/12/5.
 */
class RouteInfo {
    Express express
    Date timestamp
    String description
    RouteInfoState routeInfoState
    String courier
    String mobile

    static constraints = {
        courier nullable: true
        mobile nullable: true
    }

    static RouteInfo parse(String str, Express _express) {
        def routeInfoState = RouteInfoState.DELIVERING
        def courier, mobile
        RouteInfoState.values().each{state->
            if (state.matchPatterns && state.matchPatterns.find { it.matcher(str).matches() }) {
                routeInfoState = state
                if(RouteInfoState.CONFIRM_COURIER == state){
                    courier = extractCourier(str, _express)
                    mobile = extractMobile(str, _express)
                }
            }
        }
        new RouteInfo(description: str, routeInfoState: routeInfoState, courier: courier, mobile: mobile, express: _express)
    }

    def static extractCourier(String str, Express _express) {
        def routeInfoItem = RouteInfoItem.findByQueryName(_express.queryName)
        def start = str.indexOf(routeInfoItem.courierStart) + routeInfoItem.courierStart.length()
        def end = str.indexOf(routeInfoItem.courierEnd)
        str.substring(start, end)
    }

    def static extractMobile(String str, Express _express) {
        def routeInfoItem = RouteInfoItem.findByQueryName(_express.queryName)
        def start = str.indexOf(routeInfoItem.phoneStart) + routeInfoItem.phoneStart.length()
        def end = routeInfoItem.phoneEnd ? str.lastIndexOf(routeInfoItem.phoneEnd) : str.length()
        end = end < 0 ? str.length() : end
        str.substring(start, end)
    }

    public String toString(){
        "${timestamp.format("yyyy年MM月dd日 HH:mm:ss")} ${routeInfoState.description} ${description} ${courier?' 派件员:'+courier:""} ${courier?' 电话:'+mobile:""}"
    }
}
