package net.xunzhenji.workflow

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class MiaoXinProcessController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MiaoXinProcess.list(params), model: [miaoXinProcessInstanceCount: MiaoXinProcess.count()]
    }

    def show(MiaoXinProcess miaoXinProcessInstance) {
        respond miaoXinProcessInstance
    }

    def create() {
        respond new MiaoXinProcess(params)
    }

    @Transactional
    def save(MiaoXinProcess miaoXinProcessInstance) {
        if (miaoXinProcessInstance == null) {
            notFound()
            return
        }

        if (miaoXinProcessInstance.hasErrors()) {
            respond miaoXinProcessInstance.errors, view: 'create'
            return
        }

        miaoXinProcessInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'miaoXinProcess.label', default: 'MiaoXinProcess'), miaoXinProcessInstance.id])
                redirect miaoXinProcessInstance
            }
            '*' { respond miaoXinProcessInstance, [status: CREATED] }
        }
    }

    def edit(MiaoXinProcess miaoXinProcessInstance) {
        respond miaoXinProcessInstance
    }

    @Transactional
    def update(MiaoXinProcess miaoXinProcessInstance) {
        if (miaoXinProcessInstance == null) {
            notFound()
            return
        }

        if (miaoXinProcessInstance.hasErrors()) {
            respond miaoXinProcessInstance.errors, view: 'edit'
            return
        }

        miaoXinProcessInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'miaoXinProcess.label', default: 'MiaoXinProcess'), miaoXinProcessInstance.id])
                redirect miaoXinProcessInstance
            }
            '*' { respond miaoXinProcessInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MiaoXinProcess miaoXinProcessInstance) {

        if (miaoXinProcessInstance == null) {
            notFound()
            return
        }

        miaoXinProcessInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'miaoXinProcess.label', default: 'MiaoXinProcess'), miaoXinProcessInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'miaoXinProcess.label', default: 'MiaoXinProcess'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def calculate(){
        log.info("Recalculate production rate, id: ${params.id}")
        def process = MiaoXinProcess.get(params.id)

        if(process){
            process.calcProductionRate()
        }
        redirect(action: "index")
    }
}
