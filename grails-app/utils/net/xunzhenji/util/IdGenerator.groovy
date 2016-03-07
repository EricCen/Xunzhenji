/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

/**
 * Created by Irene on 2015/8/1.
 */
class IdGenerator {
    def static generateWxTradeId(){
        (String.valueOf(System.currentTimeMillis()) + Math.random()).replace('.', '')
    }
}
