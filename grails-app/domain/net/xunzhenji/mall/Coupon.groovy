/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

class Coupon {
    def CouponTemplate coupon
    def UserInfo referee
    def UserInfo consumer
    def Date dateCreated
    def Boolean valid               //半年内有效
    def ProductOrder order

    static constraints = {
        consumer unique: true
        order nullable: true
    }
}
