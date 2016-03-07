/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.workflow

import grails.converters.JSON
import grails.transaction.Transactional
import net.xunzhenji.shop.*
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.FormatUtil
import net.xunzhenji.util.SignUtil
import net.xunzhenji.wechat.WeChatContext
import org.apache.commons.lang.time.DateUtils

/**
 * Created by Irene on 2016-02-03.
 */
class WorkflowController {
    def weChatBasicService

    def miaoxin() {
        def weChatContext = WeChatContext.defaultContext()
        def ticket = weChatBasicService.getJsApiTicket()
        def url = "${params.requestUrl}${request.queryString ? "?" + request.queryString : ""}"
        log.info("Sign for url: ${url}")
        def signature = SignUtil.sign(ticket, url)
        signature.appId = weChatContext.appId

        def workflow = MiaoXinWorkflow.first()
        def products = ShopProduct.findAllByProcurable(Boolean.TRUE)
        def sources = Source.list()
        def processes = MiaoXinProcess.list([sort: "dateCreated", order: "desc"])
        def shops = Shop.findAllByDisplayForSelect(Boolean.TRUE)
        def hasTodayRecord = processes.find { it.date == new Date().clearTime() }
        def manufactureProduct = workflow.manufactureProduct
        def deliveryProduct = workflow.deliveryProduct
        def data = []
        if (!hasTodayRecord) {
            data << [
                            today                         : new Date()?.clearTime().format("yy/MM/dd"),
                            manufactoryProductName        : manufactureProduct?.name,
                            manufactoryProductQuantityUnit: manufactureProduct?.quantityUnit?.name,
                            manufactoryProductWeightUnit  : manufactureProduct?.weightUnit?.name,
                            deliveryProductName           : deliveryProduct?.name,
                            deliveryProductQuantityUnit   : deliveryProduct?.quantityUnit?.name,
                            deliveryProductWeightUnit     : deliveryProduct?.weightUnit?.name,
                            initialManufactureQuantity   : FormatUtil.formatPainStringNumber(workflow.currentManufactureWarehouseQuantity()),
                            initialDeliveryWeight: FormatUtil.formatPainStringNumber(workflow.currentDeliveryWarehouseWeight()),
                            hideProcurementBtn   : false,
                            hideManufactureBtn   : false,
                            hideDeliveryBtn      : true
            ]
        }
        data.addAll(processes.collect { process ->
                def procurements = process?.procurements
                def firstProcurement = procurements && procurements.size()>0 ? procurements[0] : null
                def manufacture = process?.manufacture
                def deliveries = process.deliveries
                def firstDelivery = deliveries && deliveries.size()>0 ? deliveries[0] : null
                def today = new Date().clearTime()
                [
                        id                            : process.id,
                        today                         : today.format("yy/MM/dd"),
                        date                          : process.date?.clearTime().format("yy/MM/dd"),
                        manufactoryProductName        : manufactureProduct?.name,
                        manufactoryProductQuantityUnit: manufactureProduct?.quantityUnit?.name,
                        manufactoryProductWeightUnit  : manufactureProduct?.weightUnit?.name,
                        deliveryProductName           : deliveryProduct?.name,
                        deliveryProductQuantityUnit   : deliveryProduct?.quantityUnit?.name,
                        deliveryProductWeightUnit     : deliveryProduct?.weightUnit?.name,
                        procurementTime               : firstProcurement?.procurementTime?.clearTime()?.format("yy/MM/dd"),
                        manufactureTime               : process.manufacture?.manufactureTime?.clearTime()?.format("yy/MM/dd"),
                        deliveryTime                  : firstDelivery?.deliveryTime?.clearTime()?.format("yy/MM/dd"),
                        initialManufactureQuantity    : FormatUtil.formatPainStringNumber(process.initialManufactureQuantity()),
                        initialDeliveryWeight         : FormatUtil.formatPainStringNumber(process.initialDeliveryStockWeight),
                        procuredQuantity              : FormatUtil.formatPainStringNumber(process.procuredQuantity() + process.initialManufactureStockQuantity),
                        manufactureStockWeight        : FormatUtil.formatPainStringNumber(process?.manufactureStockWeight()),
                        manufactureQuantity           : process?.manufactureQuantity(),
                        hideProcurementBtn: process ? process.date.clearTime()+2 <= today : true,
                        hideManufactureBtn: process ? process.date.clearTime()+2 <= today : true,
                        hideDeliveryBtn   : process ? process.date.clearTime()+2 <= today : true,
                        procurements                  : procurements.collect { procurement ->
                            [
                                    quantity: procurement.quantity.setScale(0, BigDecimal.ROUND_HALF_UP),
                                    weight  : FormatUtil.formatPainStringNumber(procurement.weight),
                            ]
                        }
                        ,
                        manufacture                   : [
                                quantity      : FormatUtil.formatPainStringNumber(manufacture?.inputQuantity),
                                inputWeight   : FormatUtil.formatPainStringNumber(process.manufactureInputWeight()),
                                outputWeight  : FormatUtil.formatPainStringNumber(manufacture?.outputWeight),
                                productionRate: manufacture && manufacture?.productionRate ? FormatUtil.formatPainStringNumber(manufacture?.productionRate * 100) : BigDecimal.ZERO

                        ],
                        delivery                      : [
                                totalWeight    : FormatUtil.formatPainStringNumber(process.deliveryWeight()),
                                stockWeight    : FormatUtil.formatPainStringNumber(process.deliveredStockWeight),
                                stockMoveWeight: FormatUtil.formatPainStringNumber(process.stockMoveWeight()),
                                productionRate : FormatUtil.formatPainStringNumber(process.deliveryProductionRate ? process.deliveryProductionRate * 100 : BigDecimal.ZERO)
                        ]
                ]
        })

        [
                signature     : signature,
                products      : products,
                sources       : sources,
                processes     : processes,
                shops         : shops,
                hasTodayRecord: hasTodayRecord,
                workflow    : workflow,
                currentStock: [
                        manufactureStockQuantity: workflow.manufactureWarehouse.getQuantityByProduct(workflow.manufactureProduct),
                        deliveryStockWeight     : workflow.deliveryWarehouse.getWeightByProduct(workflow.deliveryProduct)
                ] as JSON,
                data        : data as JSON
        ]
    }

    @Transactional
    def addSource(){
        log.info("Add source, ${params}")
        def sourceInstance = new Source()
        sourceInstance.properties = params

        if (sourceInstance.hasErrors()) {
            respond sourceInstance.errors, view: 'create'
            return
        }

        sourceInstance.save flush: true

        render ErrorCodeUtil.noError([id: sourceInstance.id, name: sourceInstance.name])
    }

    def createProcess(date, workflow){
        def process = MiaoXinProcess.findByDate(date)
        if (!process) {
            process = new MiaoXinProcess(date: date,
                    initialManufactureStockQuantity: workflow.manufactureWarehouseInputQuantity(),
                    initialManufactureStockWeight: workflow.manufactureWarehouseInputWeight(),
                    initialDeliveryStockWeight: workflow.deliveryWarehouseWeight(),
                    workflow: workflow
            )
        }
        return process
    }
    def addProcurement() {
        log.info("Create procurement, ${params}")
        def workflow = MiaoXinWorkflow.first()

        def product = workflow.manufactureProduct
        def procurement = new Procurement(params)
        procurement.procurementTime = DateUtils.parseDate(params.date, 'yyyy-MM-dd')
        procurement.product = product

        def date = procurement.procurementTime ?: new Date().clearTime()
        def process = MiaoXinProcess.findByDate(date)
        if (!process) {
            process = createProcess(date, workflow)
        }
        process.addToProcurements(procurement)

        def wareHouse = product.defaultWareHouse
        def stockMove = wareHouse.moveIn(product, procurement.quantity, procurement.weight)
        process.addToStockMoves(stockMove)
        process.save()
        procurement.save()

        render ErrorCodeUtil.noError([procurement: [
                id             : procurement.id,
                quantity       : procurement.quantity,
                price          : procurement.price,
                weight         : procurement.weight,
                source         : procurement.source,
                procurementTime: procurement.procurementTime
        ],
                                      process    : processObject(process)
        ])
    }

    def listProducts() {

    }

    def listSources() {

    }

    def addManufacture() {
        log.info("Create manufacture, ${params}")

        def workflow = MiaoXinWorkflow.first()
        def manufacture = new Manufacture(params)
        manufacture.manufactureTime = DateUtils.parseDate(params.date, 'yyyy-MM-dd')

        def date = manufacture.manufactureTime ?: new Date().clearTime()

        def process = MiaoXinProcess.findByDate(date)
        if (!process) {
            process = createProcess(date, workflow)
        }
        def inputProduct = workflow.manufactureProduct
        def outputProduct = workflow.deliveryProduct

        process.manufacture = manufacture
        manufacture.manufactureTime = new Date()
        manufacture.inputProduct = inputProduct
        manufacture.outputProduct = outputProduct
        manufacture.inputQuantity = manufacture.outputQuantity
        manufacture.inputWeight = process.manufactureInputWeight()
        manufacture.save()

        def inputWarehouse = inputProduct.defaultWareHouse
        def outputWarehouse = outputProduct.defaultWareHouse
        def stockMove1 = inputWarehouse.moveOut(inputProduct, manufacture.inputQuantity, manufacture.inputWeight)
        def stockMove2 = outputWarehouse.moveIn(outputProduct, 0, manufacture.outputWeight)
        process.addToStockMoves(stockMove1).addToStockMoves(stockMove2)

        process.calcProductionRate()
        process.save()

        render ErrorCodeUtil.noError([manufacture: [
                id             : manufacture.id,
                inputQuantity  : manufacture.inputQuantity,
                outputQuantity : manufacture.outputQuantity,
                inputWeight    : manufacture.inputWeight,
                outputWeight   : manufacture.outputWeight,
                manufactureTime: manufacture.manufactureTime,
                productionRate : manufacture.productionRate,
        ],
                                      process    : processObject(process)
        ])
    }

    def processObject(process) {
        [id                        : process.id,
         initialManufactureQuantity: FormatUtil.formatPainStringNumber(process.initialManufactureQuantity()),
         procuredQuantity          : FormatUtil.formatPainStringNumber(process.procuredQuantity() + process.initialManufactureQuantity()),
         manufactureStockWeight    : FormatUtil.formatPainStringNumber(process?.manufactureStockWeight()),
         manufactureQuantity       : FormatUtil.formatPainStringNumber(process?.manufactureQuantity()),
         deliveredStockWeight      : FormatUtil.formatPainStringNumber(process?.deliveredStockWeight)
        ]
    }

    def addDelivery() {
        log.info("Create delivery, ${params}")

        def workflow = MiaoXinWorkflow.first()
        def product = workflow.deliveryProduct
        def process = MiaoXinProcess.get(params.processId as long)
        def deliveryTime = new Date()
        params.each {
            if (it.key.startsWith("shopWeight")) {
                def shopId = it.key.split("_")[1] as long
                def shop = Shop.get(shopId)
                if(!params[it.key]) return
                def weight = params[it.key] as BigDecimal
                if(!weight) return

                def shopDelivery = new ShopDelivery(params)
                shopDelivery.deliveryTime = deliveryTime
                shopDelivery.product = product
                shopDelivery.weight = weight
                shopDelivery.shop = shop
                process.addToDeliveries(shopDelivery)
            }
        }
        process.deliveredStockWeight = params.stockWeight as BigDecimal
        def totalDeliveredWeight = process.deliveryWeight()
        def wareHouse = product.defaultWareHouse
        def stockMove = wareHouse.moveOut(product, 0, totalDeliveredWeight)
        def resetMove = wareHouse.reset(product, 0, process.deliveredStockWeight)
        process.addToStockMoves(stockMove).addToStockMoves(resetMove)
        process.calcProductionRate()
        process.save()

        render ErrorCodeUtil.noError([delivery: [
                deliveryTime   : deliveryTime,
                totalWeight    : totalDeliveredWeight,
                stockWeight    : process.deliveryStockWeight()?.stripTrailingZeros().toPlainString(),
                stockMoveWeight: process.stockMoveWeight(),
                productionRate : process.deliveryProductionRate ? (process.deliveryProductionRate * 100).stripTrailingZeros().toPlainString() : BigDecimal.ZERO
        ],
                                      process : processObject(process)
        ])
    }

    def getManufactureList(){
        log.info("Request manufacture list")

        def manufactures = Manufacture.list(sort: "manufactureTime", order: "desc")

        render ErrorCodeUtil.noError([manufactures:manufactures.collect{
            [
                    date: it.manufactureTime.format("yyyy年MM月dd日"),
                    quantity: it.outputQuantity,
                    weight: it.outputWeight,
                    productionRate: it.productionRate ? it.productionRate*100 : BigDecimal.ZERO,
                    quantityUnit: it.outputProduct?.quantityUnit.name,
                    weightUnit: it.outputProduct?.weightUnit.name
            ]
        }])
    }

    def getProcurementList(){
        log.info("Request procurement list")

        def procurements = Procurement.list(sort: "procurementTime", order: "desc")

        render ErrorCodeUtil.noError(procurements.collect{
            [
                    date: it.procurementTime.format("yyyy年MM月dd日"),
                    product: it.product.name,
                    quantity: it.quantity,
                    weight: it.weight,
                    price: it.price,
                    totalPrice: (it.price * it.weight).setScale(2, BigDecimal.ROUND_HALF_DOWN),
                    source: it.source?.name,
                    weightUnit: it.product.weightUnit.name,
                    quantityUnit: it.product.quantityUnit.name,
                    avgWeight: it.quantity ? (it.weight / it.quantity).setScale(2, BigDecimal.ROUND_HALF_DOWN) : 0
            ]
        }.groupBy {it.date})
    }

    def getShopDeliveryList(){
        log.info("Request shop delivery list")

        def deliveries = ShopDelivery.list(sort: "deliveryTime", order: "desc")

        render ErrorCodeUtil.noError(deliveries.collect {
            def date = it.deliveryTime
            def cal = Calendar.getInstance()
            cal.setTime(date)
            [
                    date: date.format("yy年MM月dd日") + " (周${FormatUtil.formatDayInWeek(cal.get(Calendar.DAY_OF_WEEK))})",
                    shop      : it.shop.name,
                    product   : it.product.name,
                    quantity: it.quantity,
                    weight    : it.weight,
                    weightUnit: it.product.weightUnit.name
            ]
        }.groupBy { it.date })
    }
}
