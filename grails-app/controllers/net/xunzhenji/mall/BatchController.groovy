package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.ObjectUtils

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class BatchController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = params.sort ? params.sort : 'product'
        respond Batch.list(params), model: [batchInstanceCount: Batch.count()]
    }

    def show(Batch batchInstance) {
        respond batchInstance
    }

    def create() {
        respond new Batch(params)
    }

    @Transactional
    def save(Batch batchInstance) {
        if (batchInstance == null) {
            notFound()
            return
        }

        ObjectUtils.updateImage(batchInstance, params['image.id'])
        batchInstance.discount = (batchInstance.discount as BigDecimal).movePointLeft(2)
        if (batchInstance.hasErrors()) {
            respond batchInstance.errors, view: 'create'
            return
        }

        batchInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'batch.label', default: 'Batch'), batchInstance.id])
                redirect batchInstance
            }
            '*' { respond batchInstance, [status: CREATED] }
        }
    }

    def edit(Batch batchInstance) {
        respond batchInstance
    }

    @Transactional
    def update(Batch batchInstance) {
        if (batchInstance == null) {
            notFound()
            return
        }

        ObjectUtils.updateImage(batchInstance, params['image.id'])
        batchInstance.discount = (batchInstance.discount as BigDecimal).movePointLeft(2)
        if (batchInstance.hasErrors()) {
            respond batchInstance.errors, view: 'edit'
            return
        }

        batchInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'batch.label', default: 'Batch'), batchInstance.id])
                redirect batchInstance
            }
            '*' { respond batchInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Batch batchInstance) {

        if (batchInstance == null) {
            notFound()
            return
        }

        batchInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'batch.label', default: 'Batch'), batchInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'batch.label', default: 'Batch'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def updateBatchPrice(){
        log.info("Update batch price, id: ${params.id}")
        def batch = Batch.get(params.id)
        batch?.updateDiscountPrice()
        batch?.updateBatchState()
        batch?.updateUnpaidOrdersPrice()
        batch?.save(flush:true)
        redirect(action: "index")
    }

    def calcPriceLadder(){
        log.info("Receive calc price ladder request")
        def total = params.total ? params.total as int: 30
        def batch = Batch.get(params.batchId)
        def product = batch.product
        def unitWeight = product.grossWeight / 1000
        def unitCost = batch.cost
        def unitPrice = batch.price
        def unitAllowance = batch.unitAllowance
        if(product?.express){
            def priceLadder = product.express.calcPriceLadder(total, unitWeight, unitCost, unitPrice, unitAllowance)

            render ErrorCodeUtil.noError(priceLadder)
            return
        }
    }

    @Transactional
    def updateProductPageWeight() {
        log.info("Update product page weight, id: ${params.id}, weight: ${params.productPageWeight}")
        def batch = Batch.get(params.id)
        if (batch) {
            batch.productPageWeight = params.productPageWeight as int
        }
        redirect(action: "index")
    }
}
