/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import grails.transaction.Transactional
import groovyx.net.http.ContentType
import net.xunzhenji.mall.UserInfo

class WeChatUserService extends WeChatService{
    def weChatBasicService

    def retrieveAllGroups(){
        log.info("Retrieve all groups...")

        def query  = [access_token: weChatBasicService.getAccessToken()]

        withHttp(WECHAT_API_URL, { api ->
            api.get(path: '/cgi-bin/groups/get',
                    query: query) { resp, json ->
                json.groups
            }
        });
    }

    def createGroup(name){
        log.info("Create group")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def postBody = ["group":[ "name": name]]
        def ret
        withHttp(WECHAT_API_URL, { api ->
            api.post(path: '/cgi-bin/groups/create', query: query, body: postBody,
                    requestContentType: ContentType.JSON) { resp, reader ->
                if (reader.errcode) {
                    ret = reader
                } else {
                    def wechatGroupId = reader.group.id
                    ret = [wechatGroupId: wechatGroupId, name: name]
                }
            }
        });
        ret
    }

    def updateGroup(weChatGroupId, name){
        log.info("Update group, wechat id:${weChatGroupId}")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def postBody = ["group":[ "id": weChatGroupId, name:name]]
        def ret

        withHttp(WECHAT_API_URL, { api ->
            api.post(path: '/cgi-bin/groups/update', query: query, body: postBody,
                    requestContentType: ContentType.JSON) { resp, reader ->
                if (reader.errcode) {
                    log.error("Wechat return error:${reader}")
                }
                ret = reader
            }
        });
        ret
    }

    def deleteGroup(weChatGroupId){
        log.info("Delete group, wechat group id:${weChatGroupId}")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def postBody = ["group":[ "id": weChatGroupId]]
        def ret
        withHttp(WECHAT_API_URL, { api ->
            api.post(path: '/cgi-bin/groups/delete', query: query, body: postBody,
                    requestContentType: ContentType.JSON) { resp, reader ->
                if (reader.errcode) {
                    log.error("Wechat return error:${reader}")
                }
                ret = reader
            }
        });
        ret
    }

    def updateFansGroup(openId, toGroupId){
        log.info("Update group, wechat open id:${openId}, to group id:${toGroupId}")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def postBody = ["openid":openId, to_groupid:toGroupId]
        def ret
        withHttp(WECHAT_API_URL, { api ->
            api.post(path: '/cgi-bin/groups/members/update', query: query, body: postBody,
                    requestContentType: ContentType.JSON) { resp, reader ->
                if (reader.errcode) {
                    log.error("Wechat return error:${reader}")
                }
                ret = reader
            }
        });
        ret
    }

    def batchUpdateFansGroup(openIds, toGroupId){
        log.info("Update group, wechat open id:${openIds}, to group id:${toGroupId}")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def postBody = ["openid_list":openIds, to_groupid:toGroupId]
        def ret
        withHttp(WECHAT_API_URL, { api ->
            api.post(path: '/cgi-bin/groups/members/batchupdate', query: query, body: postBody,
                    requestContentType: ContentType.JSON) { resp, reader ->
                if (reader.errcode) {
                    log.error("Wechat return error:${reader}")
                }
                ret = reader
            }
        });
        ret
    }

    def syncFans(openId){
        def fans = getFansInfo(openId)
        def weChatFans = WeChatFans.findByOpenId(openId)
        if(fans && weChatFans){
            weChatFans.updateFansInfo(fans)
        }else if(fans && !weChatFans){
            weChatFans = new WeChatFans(weChatContext: WeChatContext.defaultContext())
            weChatFans.updateFansInfo(fans)
        }
        if(weChatFans){
            weChatFans.save(flush:true)
        }
        return weChatFans
    }

    def listFans(){
        log.info("list fans")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def usersOpenIds = []
        def nextOpenId
        def total = 0
        withHttp(WECHAT_API_URL, {api->
            api.get( path: '/cgi-bin/user/get', query :query) { resp, json ->
                json.data.openid.each{
                    usersOpenIds << it
                }
                nextOpenId = json.next_openid
                total = json.total
            }
        })

        while(!nextOpenId && !usersOpenIds.contains(nextOpenId)){
            query  = [access_token: weChatBasicService.getAccessToken(), next_openid:nextOpenId]
            withHttp(WECHAT_API_URL, { api ->
                api.get(path: '/cgi-bin/user/get', query: query) { resp, json ->
                    json.data.openid.each {
                        usersOpenIds << it
                    }
                    nextOpenId = json.next_openid
                }
            });
        }

        log.info("Total get ${total} users, [${usersOpenIds}]")
        [total:total, usersOpenIds:usersOpenIds]
    }

    def getFansInfo(openId){
        log.info("get fans info:${openId}")

        def query  = [access_token: weChatBasicService.getAccessToken(), openId:openId, lang:"zh_CN"]
        def fansInfo = [:]
        withHttp(WECHAT_API_URL, { api ->
            api.get(path: '/cgi-bin/user/info', query: query) { resp, json ->
                if(json.errcode){
                    log.error("Hit error during get fans info: ${json}");
                    if(json.errcode == 40001){
                        WeChatContext.reloadDefaultContext()
                        return getFansInfo(openId)
                    }
                }else{
                    log.error("Got fans info: ${json}");
                    fansInfo.putAll(json)
                }
            }
        });
        fansInfo
    }

    def getSnsFansInfo(accessToken, openId){
        log.info("get sns fans info:${openId}")

        def query  = [access_token: accessToken, openId:openId, lang:"zh_CN"]
        def fansInfo = [:]
        withHttp(WECHAT_API_URL, { api ->
            api.get(path: '/sns/userinfo', query: query, contentType: ContentType.JSON) { resp, json ->
                fansInfo.city = json.city
                fansInfo.country = json.country
                fansInfo.headImgUrl = json.headimgurl
                fansInfo.language = json.language
                fansInfo.nickName = json.nickname
                fansInfo.openId = json.openid
                fansInfo.province = json.province
                fansInfo.sex = json.sex
            }
        });
        fansInfo
    }

    @Transactional
    def userUnsubscribe(openId, unsubscribeTime) {
        log.info("Process user unsubscribe, openId: ${openId}")
        WeChatFans fans = WeChatFans.findByOpenId(openId)
        fans.unsubscribeTime = unsubscribeTime
        fans.save()
    }

    @Transactional
    def userSubscribe(openId) {
        log.info("Process user subscribe, openId: ${openId}")
        def fans = WeChatFans.findByOpenId(openId)
        if (fans) {
            fans.updateFansInfo(getFansInfo(openId))
            fans.save(flush: true)
        } else {
            createUser(getFansInfo(openId))
        }
    }

    @Transactional
    def createUser(fansInfo) {
        log.info("Create user, fansInfo: ${fansInfo}")
        if (!fansInfo.subscribe) {
            log.info("User not subscribe our public account")
            // user not yet subscribe wechat account, need to redirect to get snsapi_userinfo
            // need user to accept the get user info
        }
        def weChatContext = WeChatContext.first()
        def fans = new WeChatFans(weChatContext: weChatContext)
        fans.updateFansInfo(fansInfo)
        def userInfo = new UserInfo()
        UserInfo.withTransaction {
            fans.save()
            userInfo.weChatFans = fans
            userInfo.save()
            fans.userInfo = userInfo
            fans.save()
        }
        return fans
    }
}
