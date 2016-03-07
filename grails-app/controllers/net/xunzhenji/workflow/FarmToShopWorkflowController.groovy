package net.xunzhenji.workflow

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class FarmToShopWorkflowController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MiaoXinProcess.list(params), model: [farmToShopWorkFlowInstanceCount: MiaoXinProcess.count()]
    }

    def show(MiaoXinProcess farmToShopWorkFlowInstance) {
        respond farmToShopWorkFlowInstance
    }

    def create() {
        respond new MiaoXinProcess(params)
    }

    @Transactional
    def save(MiaoXinProcess farmToShopWorkFlowInstance) {
        if (farmToShopWorkFlowInstance == null) {
            notFound()
            return
        }

        if (farmToShopWorkFlowInstance.hasErrors()) {
            respond farmToShopWorkFlowInstance.errors, view: 'create'
            return
        }

        farmToShopWorkFlowInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'farmToShopWorkFlow.label', default: 'FarmToShopWorkFlow'), farmToShopWorkFlowInstance.id])
                redirect farmToShopWorkFlowInstance
            }
            '*' { respond farmToShopWorkFlowInstance, [status: CREATED] }
        }
    }

    def edit(MiaoXinProcess farmToShopWorkFlowInstance) {
        respond farmToShopWorkFlowInstance
    }

    @Transactional
    def update(MiaoXinProcess farmToShopWorkFlowInstance) {
        if (farmToShopWorkFlowInstance == null) {
            notFound()
            return
        }

        if (farmToShopWorkFlowInstance.hasErrors()) {
            respond farmToShopWorkFlowInstance.errors, view: 'edit'
            return
        }

        farmToShopWorkFlowInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FarmToShopWorkFlow.label', default: 'FarmToShopWorkFlow'), farmToShopWorkFlowInstance.id])
                redirect farmToShopWorkFlowInstance
            }
            '*' { respond farmToShopWorkFlowInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MiaoXinProcess farmToShopWorkFlowInstance) {

        if (farmToShopWorkFlowInstance == null) {
            notFound()
            return
        }

        farmToShopWorkFlowInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FarmToShopWorkFlow.label', default: 'FarmToShopWorkFlow'), farmToShopWorkFlowInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'farmToShopWorkFlow.label', default: 'FarmToShopWorkFlow'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
