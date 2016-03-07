/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.filter

import net.xunzhenji.util.SessionUtil

class WeChatSecurityFilters {
    def weChatBasicService
    def weChatUserService
    def sessionService

    def filters = {
        //add path to all url
        checkSession() {
            before = {
                params.host = 'http://' + request.getServerName() + (request.serverPort == 80 ? "" : (":" + request.serverPort))
                params.requestUrl = params.host + request.forwardURI
            }
        }
        checkSession(controller: 'h5') {
            before = {
                log.info("Check session... ${params}")

                params.host = 'http://' + request.getServerName() + (request.serverPort == 80 ? "" : (":" + request.serverPort))
                params.requestUrl = params.host + request.forwardURI
                log.info("request.forwardURI=" + request.forwardURI)
                def hash = params.hash
                def redirectUrl = params.host + "/session/initSession" + (hash ? "?hash=${hash}" : "")

                if(params.action != "home") return   //Only home page need to check session

                def ret = sessionService.init(params, redirectUrl)
                if (ret?.snsapiBaseUrl) {
                    params.redirectUrl = ret.snsapiBaseUrl
                }
            }

            after = { Map model ->
                if (model) {
                    model.fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
                    model.userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
                    model.shoppingCart = SessionUtil.getSessionValue(SessionUtil.SESSION_SHOPPING_CART)
                    model.latitude = SessionUtil.getSessionValue(SessionUtil.SESSION_LATITUDE)
                    model.longitude = SessionUtil.getSessionValue(SessionUtil.SESSION_LONGITUDE)
                }
            }
            afterView = { Exception e ->

            }
        }

        checkSession(controller: 'shopOrder') {
            before = {
                log.info("Check session... ${params}")

                params.host = 'http://' + request.getServerName() + (request.serverPort == 80 ? "" : (":" + request.serverPort))
                params.requestUrl = params.host + request.forwardURI
                log.info("request.forwardURI=" + request.forwardURI)
                def hash = params.hash
                def redirectUrl = params.host + "/session/initErpSession?c=shopOrder&a=${params.action}" + (hash ? "&hash=${hash}" : "")

                def ret = sessionService.init(params, redirectUrl)
                if (ret?.snsapiBaseUrl) {
                    redirect(url: ret.snsapiBaseUrl)
                }
            }

            after = { Map model ->
                if (model) {
                    model.fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
                }
            }
            afterView = { Exception e ->

            }
        }

        checkSession(controller: 'workflow') {
            before = {
                log.info("Check session... ${params}")

                params.host = 'http://' + request.getServerName() + (request.serverPort == 80 ? "" : (":" + request.serverPort))
                params.requestUrl = params.host + request.forwardURI
                log.info("request.forwardURI=" + request.forwardURI)
                def hash = params.hash
                def redirectUrl = params.host + "/session/initErpSession?c=workflow&a=${params.action}" + (hash ? "&hash=${hash}" : "")

                def ret = sessionService.init(params, redirectUrl)
                if (ret?.snsapiBaseUrl) {
                    redirect(url: ret.snsapiBaseUrl)
                }
            }

            after = { Map model ->
                if (model) {
                    model.fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
                }
            }
            afterView = { Exception e ->

            }
        }
    }
}
