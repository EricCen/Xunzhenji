/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import net.xunzhenji.Classification
import net.xunzhenji.security.Person

class WeChatContext {
    def String name
    def String weChatId
    def String username
    def String headerPic
    def String appId
    def String appSecret
    def String merchantId
    def String merchantKey
    def String accessToken
    def String aesKey
    def int encode = 0
    def Date expiresIn
    def Date dateCreated
    def int fansCount = 0
    def String email
    def int accountType = 1

    def String ticket
    def Date ticketExpiresIn

    static WeChatContext instance

    static belongsTo = [person: Person]

    static hasMany = [WeChatGroup, WeChatImage, Classification, Media,
                       MultiImage, SendMessage,  SubscribeReply, WeChatText]

    static constraints = {
        appId nullable: false
        appSecret nullable: false
        accessToken nullable: true
        aesKey nullable: true
        expiresIn nullable: true
        headerPic nullable: true
        email nullable: true

        ticket nullable: true
        ticketExpiresIn nullable: true
    }

    def static defaultContext(){
        if(!instance){
            instance = WeChatContext.first()
        }
        instance
    }

    def static reloadDefaultContext(){
        instance = WeChatContext.first()
    }
}
