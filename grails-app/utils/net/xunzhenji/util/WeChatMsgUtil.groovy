/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

import groovy.xml.StreamingMarkupBuilder
import net.xunzhenji.wechat.MultiImage

class WeChatMsgUtil {

    def static textMessage(fromUserName, toUserName, content) {
        new StreamingMarkupBuilder().bind {
            xml {
                Content{ mkp.yieldUnescaped cdata(content) }
                MsgType{mkp.yieldUnescaped cdata("text") }
                CreateTime(System.currentTimeMillis())
                FromUserName{mkp.yieldUnescaped cdata(fromUserName)}
                ToUserName{mkp.yieldUnescaped cdata(toUserName)}
            }
        }
    }

    def static articleMessage(fromUserName, toUserName, title, description, picUrl, url) {
        new StreamingMarkupBuilder().bind {
            xml {
                MsgType{mkp.yieldUnescaped cdata("news") }
                CreateTime(System.currentTimeMillis()/1000)
                FromUserName{mkp.yieldUnescaped cdata(fromUserName)}
                ToUserName{mkp.yieldUnescaped cdata(toUserName)}

                ArticleCount(1)
                Articles{
                    item{
                        Title{mkp.yieldUnescaped cdata(title)}
                        Description{mkp.yieldUnescaped cdata(description)}
                        if (picUrl) PicUrl { mkp.yieldUnescaped cdata(picUrl) }
                        Url{mkp.yieldUnescaped cdata(url)}
                    }
                }
            }
        }
    }

    def static multiArticleMessage(fromUserName, toUserName, MultiImage multiImage) {
        new StreamingMarkupBuilder().bind {
            xml {
                MsgType { mkp.yieldUnescaped cdata("news") }
                CreateTime(System.currentTimeMillis() / 1000)
                FromUserName { mkp.yieldUnescaped cdata(fromUserName) }
                ToUserName { mkp.yieldUnescaped cdata(toUserName) }

                ArticleCount(multiImage.images.size())
                Articles {
                    multiImage.images.each { reply ->
                        def picUrl = reply.pic?.url ? reply.pic?.url : reply.thumbUrl
                        item {
                            Title { mkp.yieldUnescaped cdata(reply.title) }
                            Description { mkp.yieldUnescaped cdata(reply.digest) }
                            if (picUrl) PicUrl { mkp.yieldUnescaped cdata(picUrl) }
                            Url { mkp.yieldUnescaped cdata(reply.url) }
                        }
                    }
                }
            }
        }
    }


    def static cdata(content){
        "<![CDATA[${content}]]>"
    }

    def static unifiedOrderMessage(params){
        new StreamingMarkupBuilder().bind {
            xml  {
                appid(params.appid)
                attach(params.attach)
                body(new String(params.body.getBytes("UTF-8"), "ISO-8859-1"))
                detail(new String(params.detail.getBytes("UTF-8"), "ISO-8859-1"))
                mch_id(params.mch_id)
                nonce_str(params.nonce_str)
                notify_url(params.notify_url)
                openid(params.openid)
                out_trade_no(params.out_trade_no)
                spbill_create_ip(params.spbill_create_ip)
                total_fee(params.total_fee)
                trade_type(params.trade_type)
                sign(params.sign)
            }
        }
    }

    def static refundMessage(params){
        new StreamingMarkupBuilder().bind {
            xml  {
                appid(params.appid)
                mch_id(params.mch_id)
                nonce_str(params.nonce_str)
                op_user_id(params.op_user_id)
                out_refund_no(params.out_refund_no)
                out_trade_no(params.out_trade_no)
                refund_fee(params.refund_fee)
                total_fee(params.total_fee)
                transaction_id(params.transaction_id)
                sign(params.sign)
            }
        }
    }

    def static transferMessage(params){
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            xml  {
                mch_appid(params.mch_appid)
                mchid(params.mchid)
                nonce_str(params.nonce_str)
                partner_trade_no(params.partner_trade_no)
                openid(params.openid)
                check_name(params.check_name)
                re_user_name(params.re_user_name)
                amount(params.amount)
                desc(params.desc)
                spbill_create_ip(params.spbill_create_ip)
                sign(params.sign)
            }
        }
    }

    def static redPackMessage(params){
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            xml  {
                sign{ mkp.yieldUnescaped cdata(params.sign) }
                mch_billno{ mkp.yieldUnescaped cdata(params.mch_billno) }
                mch_id{ mkp.yieldUnescaped cdata(params.mch_id) }
                wxappid{ mkp.yieldUnescaped cdata(params.wxappid) }
                nick_name{ mkp.yieldUnescaped cdata(params.nick_name) }
                send_name{ mkp.yieldUnescaped cdata(params.send_name) }
                re_openid{ mkp.yieldUnescaped cdata(params.re_openid) }
                total_amount{ mkp.yieldUnescaped cdata(params.total_amount) }
                total_num{ mkp.yieldUnescaped cdata(params.total_num) }
                wishing{ mkp.yieldUnescaped cdata(params.wishing) }
                client_ip{ mkp.yieldUnescaped cdata(params.client_ip) }
                act_name{ mkp.yieldUnescaped cdata(params.act_name) }
                remark{ mkp.yieldUnescaped cdata(params.remark) }
                nonce_str{ mkp.yieldUnescaped cdata(params.nonce_str) }
            }
        }
    }

    def static couponMessage(params) {
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            xml {
                appid(params.appid)
                coupon_stock_id(params.coupon_stock_id)
                mch_id(params.mch_id)
                nonce_str(params.nonce_str)
                openid(params.openid)
                openid_count(params.openid_count)
                partner_trade_no(params.partner_trade_no)
                sign(params.sign)
            }
        }
    }

    def static queryCouponStockMessage(params) {
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            xml {
                appid(params.appid)
                coupon_stock_id(params.coupon_stock_id)
                mch_id(params.mch_id)
                nonce_str(params.nonce_str)
                sign(params.sign)
            }
        }
    }

    def static notificationAckMessage(params){
        new StreamingMarkupBuilder().bind {
            xml  {
                return_code { mkp.yieldUnescaped cdata(params.returnCcode)}
                return_msg {mkp.yieldUnescaped cdata(params.returnMsg)}
            }
        }
    }
}
