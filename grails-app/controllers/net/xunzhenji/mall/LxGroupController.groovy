package net.xunzhenji.mall

import net.xunzhenji.util.ErrorCodeUtil

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LxGroupController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond LxGroup.list(params), model:[lxGroupInstanceCount: LxGroup.count()]
    }

    def show(LxGroup lxGroupInstance) {
        def lxGroupMembers = LxGroupMembers.findAllByLxGroup(lxGroupInstance)
        def members = lxGroupMembers.collect{it.userInfo}
        def organizer = lxGroupInstance.organizer
        def commissions = Commission.findAllByOrganizer(organizer)
        def orders = LxGroupProductOrder.findAllByLxGroup(lxGroupInstance).collect{it.productOrder}
        def deliveries = lxGroupInstance.delivery?.sort{it.targetDeliveryDate}
        [lxGroupInstance:lxGroupInstance, members: members, commissions: commissions, orders : orders, deliveries: deliveries]
    }

    def create() {
        respond new LxGroup(params)
    }

    @Transactional
    def save(LxGroup lxGroupInstance) {
        if (lxGroupInstance == null) {
            notFound()
            return
        }

        if (lxGroupInstance.hasErrors()) {
            respond lxGroupInstance.errors, view:'create'
            return
        }

        lxGroupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'lxGroup.label', default: 'LxGroup'), lxGroupInstance.id])
                redirect lxGroupInstance
            }
            '*' { respond lxGroupInstance, [status: CREATED] }
        }
    }

    def edit(LxGroup lxGroupInstance) {
        respond lxGroupInstance
    }

    @Transactional
    def update(LxGroup lxGroupInstance) {
        if (lxGroupInstance == null) {
            notFound()
            return
        }

        if (lxGroupInstance.hasErrors()) {
            respond lxGroupInstance.errors, view:'edit'
            return
        }

        lxGroupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LxGroup.label', default: 'LxGroup'), lxGroupInstance.id])
                redirect lxGroupInstance
            }
            '*'{ respond lxGroupInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(LxGroup lxGroupInstance) {

        if (lxGroupInstance == null) {
            notFound()
            return
        }

        lxGroupInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'LxGroup.label', default: 'LxGroup'), lxGroupInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'lxGroup.label', default: 'LxGroup'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Transactional
    def createOneMonthDelivery(){
        log.info("Generate one month delivery...")

        LxGroup lxGroup = LxGroup.get(params.id)
        lxGroup.createOneMonthDelivery()
        render ErrorCodeUtil.noError()
    }
}
