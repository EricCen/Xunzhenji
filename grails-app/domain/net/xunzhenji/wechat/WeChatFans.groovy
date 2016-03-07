/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import net.xunzhenji.datacollect.FansLocation
import net.xunzhenji.mall.UserInfo

class WeChatFans {
    def int subscribe = 0
    def String openId
    def String unionId
    def String nickName
    def int sex = 0
    def String city
    def String country
    def String province
    def String language
    def String headImgUrl
    def long subscribeTime = 0
    def Date unsubscribeTime
    def String remark

    //Oauth 2.0
    def String accessToken
    def String refreshToken
    def Date expiresIn
    def String scope

    def UserInfo userInfo
    def Date dateCreated

    def Integer shareToFriendsCount = 0
    def Integer shareToTimelineCount = 0
    def Integer visitCount = 1

    def Date lastActivityTime //记录用户主动发送信息、点击自定义菜单、订阅事件、扫描二维码事件、支付成功事件、用户维权的最新时间

    static belongsTo = [weChatContext:WeChatContext, weChatGroup: WeChatGroup]

    static hasMany = [fansLocation: FansLocation, weChatFansActivity: WeChatFansActivity]

    static constraints = {
        openId nullable: false, unique: true
        unionId nullable: true
        nickName nullable: true
        city nullable: true
        country nullable: true
        province nullable: true
        language nullable: true
        headImgUrl nullable: true
        remark nullable: true
        weChatGroup nullable: true
        accessToken nullable: true
        refreshToken nullable: true
        expiresIn nullable: true
        scope nullable: true
        userInfo nullable: true
        shareToFriendsCount nullable: true
        shareToTimelineCount nullable: true
        visitCount nullable: true
        unsubscribeTime nullable: true
        lastActivityTime nullable: true
    }

    static mapping = {
        userInfo lazy: false
    }

    def updateFansInfo(fansInfo){
        subscribe = fansInfo.subscribe ? 1 : 0
        if(fansInfo.openid){
            openId = fansInfo.openid
        }
        nickName = fansInfo.nickname ? fansInfo.nickname?.replaceAll("[^\\u0000-\\uFFFF]", "\uFFFD") : nickName
        sex = fansInfo.sex ? fansInfo.sex : 0
        language = fansInfo.language ? fansInfo.language : language
        city = fansInfo.city ? fansInfo.city : city
        province = fansInfo.province ? fansInfo.province : province
        country = fansInfo.country ? fansInfo.country : country
        headImgUrl = fansInfo.headimgurl ? fansInfo.headimgurl : headImgUrl
        subscribeTime = fansInfo.subscribe_time ? fansInfo.subscribe_time : subscribeTime
        unionId = fansInfo.unionid ? fansInfo.unionid : unionId
        remark = fansInfo.remark ? fansInfo.remark : remark
        weChatGroup = fansInfo.groupid ? WeChatGroup.findByWechatGroupId(fansInfo.groupid) : null
    }

    def String toString(){
        return "${nickName}:${id}"
    }
}
