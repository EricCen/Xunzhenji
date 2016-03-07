/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

/**
 * Created by Irene on 2016-02-03.
 */
class Warehouse {
    String name
    String location

    static hasMany = [stockItems: StockItem]

    def moveIn(product, quantity, weight) {
        def stockItem = stockItems.find { it.product == product }
        if (stockItem) {
            stockItem.quantity += quantity
            stockItem.weight += weight
        } else {
            stockItem = new StockItem(product: product, quantity: quantity, weight: weight)
            addToStockItems(stockItem)
        }

        def stockMove = new StockMove(direction: StockMove.MoveDirection.In,
                product: stockItem.product, quantity: quantity, weight: weight, warehouse: this)
        stockMove.save()
    }

    def moveOut(product, quantity, weight) {
        def stockItem = stockItems.find { it.product == product }
        if (stockItem) {
            stockItem.quantity -= quantity
            stockItem.weight -= weight
        } else {
            stockItem = new StockItem(product: product, quantity: -1 * quantity, weight: -1 * weight)
            addToStockItems(stockItem)
        }
        def stockMove = new StockMove(direction: StockMove.MoveDirection.Out,
                product: stockItem.product, quantity: quantity, weight: weight, warehouse: this)
        stockMove.save()
    }

    def reset(product, quantity, weight) {
        def stockItem = stockItems.find { it.product == product }
        def oldQuantity = stockItem.quantity
        def oldWeight = stockItem.weight
        stockItem.quantity = quantity
        stockItem.weight = weight

        def stockMove = new StockMove(direction: StockMove.MoveDirection.Reset,
                product: stockItem.product, quantity: (quantity - oldQuantity),
                weight: (weight - oldWeight), warehouse: this)
        stockMove.save()
    }

    def getQuantityByProduct(product) {
        def stockItem = stockItems.find { it.product == product }
        stockItem ? stockItem.quantity : BigDecimal.ZERO
    }

    def getWeightByProduct(product) {
        def stockItem = stockItems.find { it.product == product }
        stockItem ? stockItem.weight : BigDecimal.ZERO
    }

    String toString() {
        name
    }
}
