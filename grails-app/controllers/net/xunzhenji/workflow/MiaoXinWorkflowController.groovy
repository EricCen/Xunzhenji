package net.xunzhenji.workflow

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class MiaoXinWorkflowController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MiaoXinWorkflow.list(params), model: [miaoXinWorkflowInstanceCount: MiaoXinWorkflow.count()]
    }

    def show(MiaoXinWorkflow miaoXinWorkflowInstance) {
        respond miaoXinWorkflowInstance
    }

    def create() {
        respond new MiaoXinWorkflow(params)
    }

    @Transactional
    def save(MiaoXinWorkflow miaoXinWorkflowInstance) {
        if (miaoXinWorkflowInstance == null) {
            notFound()
            return
        }

        if (miaoXinWorkflowInstance.hasErrors()) {
            respond miaoXinWorkflowInstance.errors, view: 'create'
            return
        }

        miaoXinWorkflowInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'miaoXinWorkflow.label', default: 'MiaoXinWorkflow'), miaoXinWorkflowInstance.id])
                redirect miaoXinWorkflowInstance
            }
            '*' { respond miaoXinWorkflowInstance, [status: CREATED] }
        }
    }

    def edit(MiaoXinWorkflow miaoXinWorkflowInstance) {
        respond miaoXinWorkflowInstance
    }

    @Transactional
    def update(MiaoXinWorkflow miaoXinWorkflowInstance) {
        if (miaoXinWorkflowInstance == null) {
            notFound()
            return
        }

        if (miaoXinWorkflowInstance.hasErrors()) {
            respond miaoXinWorkflowInstance.errors, view: 'edit'
            return
        }

        miaoXinWorkflowInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'miaoXinWorkflow.label', default: 'MiaoXinWorkflow'), miaoXinWorkflowInstance.id])
                redirect miaoXinWorkflowInstance
            }
            '*' { respond miaoXinWorkflowInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MiaoXinWorkflow miaoXinWorkflowInstance) {

        if (miaoXinWorkflowInstance == null) {
            notFound()
            return
        }

        miaoXinWorkflowInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'miaoXinWorkflow.label', default: 'MiaoXinWorkflow'), miaoXinWorkflowInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'miaoXinWorkflow.label', default: 'MiaoXinWorkflow'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
