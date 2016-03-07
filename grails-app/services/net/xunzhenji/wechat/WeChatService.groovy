/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import groovyx.net.http.HTTPBuilder
import net.xunzhenji.HttpService
import org.apache.http.conn.scheme.Scheme
import org.apache.http.conn.ssl.SSLSocketFactory
import org.apache.log4j.LogManager

import javax.net.ssl.KeyManagerFactory
import javax.net.ssl.SSLContext
import java.security.KeyStore

abstract class WeChatService extends HttpService{

    def static HTTPBuilder api = new HTTPBuilder(WECHAT_API_URL)
    def static HTTPBuilder payApi = new HTTPBuilder(WECHAT_MCH_API_URL)
    def static HTTPBuilder secApi

    static {
        //HTTPBuilder has no direct methods to add timeouts.  We have to add them to the HttpParams of the underlying HttpClient
        setTimeout(api)
        setTimeout(payApi)
    }

    def static getSecApi() {
        if(secApi == null){
            secApi = new HTTPBuilder(WECHAT_MCH_API_URL)
            setTimeout(secApi)
            try{
                WeChatContext weChatContext = WeChatContext.defaultContext()
                SSLContext sslContext = SSLContext.getInstance("TLSV1");
                KeyStore ks = KeyStore.getInstance("PKCS12");
                new File("/opt/security/apiclient_cert.p12" ).withInputStream {
                    ks.load( it, weChatContext.merchantId.toCharArray() )
                }

                KeyManagerFactory keyManagerFactory = KeyManagerFactory.getInstance("SunX509");
                keyManagerFactory.init(ks, weChatContext.merchantId.toCharArray());

                sslContext.init(keyManagerFactory.getKeyManagers(), null, null);

                SSLSocketFactory sf = new SSLSocketFactory(sslContext, SSLSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);

                secApi.client.connectionManager.schemeRegistry.register(new Scheme("https", sf, 443) )
            }catch(e){
                LogManager.getLogger(WeChatService).error("Fail to import certificate", e)
            }
        }
        return secApi
    }

    def static String WECHAT_API_URL = "https://api.weixin.qq.com/"
    def static String WECHAT_FILE_API_URL = "https://file.api.weixin.qq.com/"
    def static String WECHAT_MCH_API_URL = "https://api.mch.weixin.qq.com/"

    def static URL_REFRESH_OAUTH_TOKEN = "/sns/oauth2/access_token"
    def static URL_GET_TICKET = "/cgi-bin/ticket/getticket"
    def static URL_REFRESH_TOKEN = "/cgi-bin/token"

    def static URL_SEND = "/cgi-bin/message/mass/send"
    def static URL_SENDALL = "/cgi-bin/message/mass/sendall"
    def static URL_PREVIEW = "/cgi-bin/message/mass/preview"

    def static URL_MEDIA_UPLOAD = "/cgi-bin/media/upload"
    def static URL_MATERIAL_UPLOAD = "/cgi-bin/material/add_material"
    def static URL_ADD_NEWS = "/cgi-bin/material/add_news"
    def static URL_UPLOAD_NEWS = "/cgi-bin/media/uploadnews"
    def static URL_BATCHGET_MATERIAL = "/cgi-bin/material/batchget_material"
    def static URL_MATERIAL_COUNT = "/cgi-bin/material/get_materialcount"
    def static URL_DEL_MATERIAL = "/cgi-bin/material/del_material"
    def static URL_GET_MATERIAL = "/cgi-bin/material/get_material"

    def static URL_PAY_UNIFIEDORDER = "/pay/unifiedorder"
    def static URL_PAY_REFUND = "/secapi/pay/refund"
    def static URL_PAY_TRANSFER = "/mmpaymkttransfers/promotion/transfers"
    def static URL_PAY_REDPACK = "/mmpaymkttransfers/sendredpack"
    def static URL_PAY_GROUPREDPACK = "/mmpaymkttransfers/sendgroupredpack"
    def static URL_PAY_SENDCOUPON = "/mmpaymkttransfers/send_coupon"
    def static URL_PAY_QUERYCOUPON = "/mmpaymkttransfers/query_coupon_stock"

    def static URL_ADD_TEMPLATE = "/cgi-bin/template/api_add_template"
    def static URL_TEMPLATE_SEND = "/cgi-bin/message/template/send"

    def static URL_GET_CURRENT_SELFMENU_INFO = "/cgi-bin/get_current_selfmenu_info"
    def static URL_MENU_CREATE = "/cgi-bin/menu/create"

    def static URL_CARD_CREATE = "/card/create"
    def static URL_CARD_QRCODE_CREATE = "/card/qrcode/create"
    def static URL_CARD_LANDINGPAGE_CREATE = "/card/landingpage/create"
    def static URL_CARD_CODE_DEPOSIT = "/card/code/deposit"
    def static URL_CARD_CODE_GETDEPOSITCOUNT = "/card/code/getdepositcount"
    def static URL_CARD_CODE_CHECKCODE = "/card/code/checkcode"

    def static URL_MESSAGE_CUSTOM_SEND = "/cgi-bin/message/custom/send"
}
