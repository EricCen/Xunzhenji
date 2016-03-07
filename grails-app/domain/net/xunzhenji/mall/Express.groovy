/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

/**
 * Created by Irene on 2015/8/29.
 */
class Express {
    String name
    String phone
    String displayName
    String deliverRange
    BigDecimal firstWeightPrice
    BigDecimal continuedWeightPrice
    String queryName
    int firstWeightTo

    static constraints = {
        displayName nullable: true
        queryName nullable: true
    }

    def calcSavedExpressFee(quantity, unitWeight){
        def onePieceExpressFee
        def totalExpressFee
        def savedExpressFee

        totalExpressFee = calcTotalExpressFee(unitWeight, quantity)
        onePieceExpressFee = calcTotalExpressFee(unitWeight, 1)
        savedExpressFee = onePieceExpressFee * quantity - totalExpressFee
        return savedExpressFee.setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    private BigDecimal calcTotalExpressFee(unitWeight, quantity) {
        def totalExpressFee
        if (firstWeightTo > unitWeight * quantity) { //首重以内
            totalExpressFee = firstWeightPrice
        } else {
            def countedWeight = quantity * unitWeight - firstWeightTo
            countedWeight = new BigDecimal(countedWeight).setScale(0, BigDecimal.ROUND_UP)
            totalExpressFee = firstWeightPrice + countedWeight * continuedWeightPrice
        }
        totalExpressFee
    }
    /*
     * @unitWeight - 单位商品重量
     * @unitCost - 单位商品成本
     * @unitPrice - 单位商品价格
     * @unitAllowance - 每单补贴给群主或消费者的金额
     */

    def calcPriceLadder(total, unitWeight, unitCost, unitPrice, unitAllowance) {
        def priceLadder = []
        def onePieceExpressFee

        [1,8,12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100].each { i ->
            def totalExpressFee
            def savedExpressFee
            def unitSavedExpressFee
            def unitAllowanceForOrganizer
            def unitDiscountForProduct
            def organizerEarn
            def totalPrice
            def totalCost
            def totalProfit
            def profitRate

            totalExpressFee = calcTotalExpressFee(unitWeight, i)

            if (i == 1) {
                onePieceExpressFee = totalExpressFee
            }

            savedExpressFee = onePieceExpressFee * i - totalExpressFee
            unitSavedExpressFee = savedExpressFee / i
            unitAllowanceForOrganizer = unitSavedExpressFee + unitAllowance
//            unitDiscountForProduct = unitSavedExpressFee / 2
            unitDiscountForProduct = 0.0
            organizerEarn = unitAllowanceForOrganizer * i
            totalPrice = (unitPrice - unitAllowance ) * i
            totalCost = totalExpressFee + unitAllowance * i + unitCost * i
            totalProfit = totalPrice - totalCost
            profitRate = totalProfit / totalCost * 100

            priceLadder << [quantity                 : i,
                            totalExpressFee          : totalExpressFee.setScale(2, BigDecimal.ROUND_HALF_UP),
                            savedExpressFee          : savedExpressFee.setScale(2, BigDecimal.ROUND_HALF_UP),
                            unitSavedExpressFee      : unitSavedExpressFee.setScale(2, BigDecimal.ROUND_HALF_UP),
                            unitAllowance            : unitAllowance.setScale(2, BigDecimal.ROUND_HALF_UP),
                            unitAllowanceForOrganizer: unitAllowanceForOrganizer.setScale(2, BigDecimal.ROUND_HALF_UP),
                            unitDiscountForProduct   : unitDiscountForProduct.setScale(2, BigDecimal.ROUND_HALF_UP),
                            organizerEarn            : organizerEarn.setScale(2, BigDecimal.ROUND_HALF_UP),
                            totalPrice               : (totalPrice as BigDecimal).setScale(2, BigDecimal.ROUND_HALF_UP),
                            totalCost                : (totalCost as BigDecimal).setScale(2, BigDecimal.ROUND_HALF_UP),
                            totalProfit              : (totalProfit as BigDecimal).setScale(2, BigDecimal.ROUND_HALF_UP),
                            profitRate               : (profitRate as BigDecimal).setScale(0, BigDecimal.ROUND_HALF_UP)
            ]
        }

        priceLadder
    }

    String toString(){
        "${displayName ? displayName : name}"
    }
}
