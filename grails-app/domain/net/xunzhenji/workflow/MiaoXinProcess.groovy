/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.workflow

import grails.transaction.Transactional
import net.xunzhenji.shop.Manufacture
import net.xunzhenji.shop.Procurement
import net.xunzhenji.shop.ShopDelivery
import net.xunzhenji.shop.StockMove

/**
 * Created by Irene on 2016-02-03.
 */
class MiaoXinProcess {
    Date date
    MiaoXinWorkflow workflow
    Manufacture manufacture
    BigDecimal initialManufactureStockQuantity
    BigDecimal initialManufactureStockWeight
    BigDecimal initialDeliveryStockWeight
    BigDecimal deliveredStockWeight

    BigDecimal deliveryProductionRate

    Date dateCreated
    Date lastUpdated

    static hasMany = [procurements: Procurement, stockMoves: StockMove, deliveries: ShopDelivery]

    static constraints = {
        manufacture nullable: true
        deliveryProductionRate nullable: true
        deliveredStockWeight nullable: true
    }

    static mapping = {
        date type: "date"
    }

    String toString(){
        "${date?.format("MM月dd日")}工作流"
    }

    def initialManufactureQuantity() {
        def qty = initialManufactureStockQuantity.setScale(0, BigDecimal.ROUND_HALF_UP)
        qty ? qty : BigDecimal.ZERO
    }

    def procuredQuantity() {
        if(!procurements) return BigDecimal.ZERO
        def qty = procurements.sum { it.quantity }?.setScale(0, BigDecimal.ROUND_HALF_UP)
        return qty ? qty : BigDecimal.ZERO
    }

    def manufactureQuantity() {
        def ret
        if (manufacture) {
            ret = initialManufactureStockQuantity + procuredQuantity() - manufacture.inputQuantity
        } else {
            ret = initialManufactureStockQuantity
        }
        ret.setScale(0, BigDecimal.ROUND_HALF_UP)
    }

    def manufactureStockWeight() {
        def stockMoveWeight = stockMoves.findAll {
            it.product == workflow.manufactureProduct && it.direction == StockMove.MoveDirection.In
        }.sum { it.weight }
        stockMoveWeight = stockMoveWeight ? stockMoveWeight : 0
        initialManufactureStockWeight + stockMoveWeight
    }

    def manufactureStockQuantity() {
        def stockMoveQuantity = stockMoves.findAll {
            it.product == workflow.manufactureProduct && it.direction == StockMove.MoveDirection.In
        }.sum { it.quantity }
        stockMoveQuantity = stockMoveQuantity ? stockMoveQuantity : 0
        initialManufactureStockQuantity + stockMoveQuantity
    }

    def deliveryStockWeight() {
        def stockMoveWeight = stockMoves.findAll {
            it.product == workflow.deliveryProduct && it.direction == StockMove.MoveDirection.In
        }.sum { it.weight }
        stockMoveWeight = stockMoveWeight ? stockMoveWeight : 0
        initialDeliveryStockWeight + stockMoveWeight - deliveryWeight()
    }
    /*
     * 毛鸡重量 = 库存毛重 * ( 屠宰数量/ 库存总数)
     */

    def manufactureInputWeight() {
        def manufactureStockQuantity = manufactureStockQuantity()
        def inputWeight = manufactureStockQuantity && manufacture ? manufactureStockWeight() * (manufacture.inputQuantity / manufactureStockQuantity) : BigDecimal.ZERO
        inputWeight.setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    def deliveryWeight() {
        def weight = deliveries.sum { it.weight }
        weight ? weight : BigDecimal.ZERO
    }

    @Transactional
    def calcProductionRate() {
        def inputWeight = manufactureInputWeight()
        if (manufacture && inputWeight) {
            def outputWeight = manufacture.outputWeight
            def manufactureProductionRate = outputWeight / inputWeight
            manufacture.productionRate = manufactureProductionRate.setScale(4, BigDecimal.ROUND_HALF_DOWN);
            log.info("Recalculate manufacture prduction rate, inputWeight:${inputWeight}, outputWeight: ${outputWeight}, productionRate: ${manufacture.productionRate}")
            manufacture.save()
        }
        if (deliveries && inputWeight) {
            def totalDeliveryWeight = deliveryWeight() - initialDeliveryStockWeight + deliveredStockWeight
            deliveryProductionRate = (totalDeliveryWeight / inputWeight).setScale(4, BigDecimal.ROUND_HALF_DOWN);
            log.info("Recalculate delivery prduction rate, inputWeight:${inputWeight}, outputWeight: ${totalDeliveryWeight}, productionRate: ${deliveryProductionRate}")
            save()
        }
    }

    def stockMoveWeight() {
        stockMoves.findAll {
            it.product == workflow.deliveryProduct &&
                    it.direction == StockMove.MoveDirection.Reset
        }.sum { it.weight }

    }
}
