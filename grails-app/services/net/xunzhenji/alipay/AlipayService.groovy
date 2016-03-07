/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.alipay

import net.xunzhenji.util.SignUtil
import net.xunzhenji.wechat.PayService

/**
 * Created by Irene on 2015/11/15.
 */
class AlipayService implements PayService{

    def genPrepayOrder(String body, String detail, totalFee, String outTradeNo, String openId, String clientIp) {
        log.info("Generate alipay prepay order")
        AlipayContext context = AlipayContext.first()
        def bodyParams = [service       : AlipayContext.SERVICE_WAP_DIRECT_PAY,
                          partner       : context.partner,
                          _input_charset: context.inputCharset,
                          payment_type  : context.paymentType,
                          notify_url    : context.notifyUrl,
                          return_url    : context.returnUrl,
                          out_trade_no  : outTradeNo,
                          total_fee     : totalFee,
                          subject       : body,
                          seller_id     : context.partner
        ]

        def signParams = SignUtil.signAlipayPayInfo(bodyParams, context.key, context.signType)
        signParams
    }
}
