/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

/**
 * Created by Irene on 2015/12/24.
 */
class WeChatCoupon {
    enum CouponType {
        NoThreshold(1, "代金券无门槛"),
        ThresholdConflict(2, "代金券有门槛互斥"),
        ThresholdOverlap(3, "代金券有门槛叠加")

        int id
        String description

        public CouponType(id, description) {
            this.id = id
            this.description = description
        }

        def static findByDescription(desc) {
            return CouponType.values().find { it.description == desc }
        }

        def static findById(id) {
            return CouponType.values().find { it.id == id }
        }
    }

    enum CouponStockStatus {
        Inactivated(1, "未激活"),
        InReview(2, "审批中"),
        Activated(4, "已激活"),
        Repeal(8, "已作废"),
        Stopped(16, "中止发放")

        int id
        String description

        public CouponStockStatus(id, description) {
            this.id = id
            this.description = description
        }

        def static findByDescription(desc) {
            return CouponStockStatus.values().find { it.description == desc }
        }

        def static findById(id) {
            return CouponStockStatus.values().find { it.id == id }
        }
    }

    String stockId
    String name
    BigDecimal value
    BigDecimal couponMininumn
    CouponType couponType
    CouponStockStatus couponStockStatus
    int couponTotal
    int maxQuota
    int lockNum
    int usedNum
    int isSendNum
    Date beginTime
    Date endTime
    Date createTime
    BigDecimal couponBudget


    def static allValidCoupon() {
        def now = new Date()
        return WeChatCoupon.findAllByBeginTimeLessThanAndEndTimeGreaterThanAndCouponStockStatus(now, now, WeChatCoupon.CouponStockStatus.Activated)
    }
}
