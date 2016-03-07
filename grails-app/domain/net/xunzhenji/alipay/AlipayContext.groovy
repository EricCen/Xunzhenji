/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.alipay

/**
 * Created by Irene on 2015/11/16.
 */
class AlipayContext {
    public static final String SERVICE_WAP_DIRECT_PAY = "alipay.wap.create.direct.pay.by.user"
    public static final String ALIPAY_GATEWAY_URL = "https://mapi.alipay.com/gateway.do"
    String partner
    String key
    String inputCharset
    String signType
    String notifyUrl
    String returnUrl
    Integer paymentType

    static mapping = {
        key column: "mch_key"
    }
}
