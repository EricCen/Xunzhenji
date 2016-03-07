/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

/**
 * Created by Irene on 2015/11/30.
 */
class PromotionCode {
    def String title
    def String description
    def String code
    def Date expiredDate
    def BigDecimal discount
    def BigDecimal price
    def Boolean includeExpress = Boolean.FALSE

    def int minimumOrder = 0
    def int maximumUsed = 1
    def int usedCount = 0

    def Address address
    static hasMany = [products: Product]

    static constraints = {
        address nullable: true
        discount nullable: true
        price nullable: true
    }

    def boolean isPromotionOrder(ProductOrder order) {
        if (products) {
            return products.collect { it.id }.contains(order.product.id)
        }
        return true
    }

    def boolean isValid(orders) {
        if (expiredDate < new Date()) {
            return false
        }

        if (usedCount >= maximumUsed) {
            return false
        }

        if (minimumOrder > orders.size()) {
            return false
        }
        return true
    }

    def addUsedCount() {
        usedCount++
    }
}
