package net.xunzhenji.mall


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CouponTemplateController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CouponTemplate.list(params), model: [couponInstanceCount: CouponTemplate.count()]
    }

    def show(CouponTemplate couponInstance) {
        respond couponInstance
    }

    def create() {
        respond new CouponTemplate(params)
    }

    @Transactional
    def save(CouponTemplate couponInstance) {
        if (couponInstance == null) {
            notFound()
            return
        }

        if (couponInstance.hasErrors()) {
            respond couponInstance.errors, view: 'create'
            return
        }

        couponInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'coupon.label', default: 'Coupon'), couponInstance.id])
                redirect couponInstance
            }
            '*' { respond couponInstance, [status: CREATED] }
        }
    }

    def edit(CouponTemplate couponInstance) {
        respond couponInstance
    }

    @Transactional
    def update(CouponTemplate couponInstance) {
        if (couponInstance == null) {
            notFound()
            return
        }

        if (couponInstance.hasErrors()) {
            respond couponInstance.errors, view: 'edit'
            return
        }

        couponInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'coupon.label', default: 'Coupon'), couponInstance.id])
                redirect couponInstance
            }
            '*' { respond couponInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CouponTemplate couponInstance) {

        if (couponInstance == null) {
            notFound()
            return
        }

        couponInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'coupon.label', default: 'Coupon'), couponInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
