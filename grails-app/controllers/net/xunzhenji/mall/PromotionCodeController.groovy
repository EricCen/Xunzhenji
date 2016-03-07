package net.xunzhenji.mall


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PromotionCodeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PromotionCode.list(params), model: [promotionCodeInstanceCount: PromotionCode.count()]
    }

    def show(PromotionCode promotionCodeInstance) {
        respond promotionCodeInstance
    }

    def create() {
        respond new PromotionCode(params)
    }

    @Transactional
    def save(PromotionCode promotionCodeInstance) {
        if (promotionCodeInstance == null) {
            notFound()
            return
        }

        if (promotionCodeInstance.hasErrors()) {
            respond promotionCodeInstance.errors, view: 'create'
            return
        }

        promotionCodeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'promotionCode.label', default: 'PromotionCode'), promotionCodeInstance.id])
                redirect promotionCodeInstance
            }
            '*' { respond promotionCodeInstance, [status: CREATED] }
        }
    }

    def edit(PromotionCode promotionCodeInstance) {
        respond promotionCodeInstance
    }

    @Transactional
    def update(PromotionCode promotionCodeInstance) {
        if (promotionCodeInstance == null) {
            notFound()
            return
        }

        if (promotionCodeInstance.hasErrors()) {
            respond promotionCodeInstance.errors, view: 'edit'
            return
        }

        promotionCodeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'promotionCode.label', default: 'PromotionCode'), promotionCodeInstance.id])
                redirect promotionCodeInstance
            }
            '*' { respond promotionCodeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PromotionCode promotionCodeInstance) {

        if (promotionCodeInstance == null) {
            notFound()
            return
        }

        promotionCodeInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'promotionCode.label', default: 'PromotionCode'), promotionCodeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'promotionCode.label', default: 'PromotionCode'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
