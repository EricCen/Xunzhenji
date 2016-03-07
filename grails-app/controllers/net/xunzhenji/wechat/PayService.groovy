/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

/**
 * Created by Irene on 2015/11/24.
 */
interface PayService {
    def genPrepayOrder(String body, String detail, totalFee, String outTradeNo, String openId, String clientIp)
}