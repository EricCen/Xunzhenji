package net.xunzhenji.vendor



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SfSettingController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SfSetting.list(params), model:[sfSettingInstanceCount: SfSetting.count()]
    }

    def show(SfSetting sfSettingInstance) {
        respond sfSettingInstance
    }

    def create() {
        respond new SfSetting(params)
    }

    @Transactional
    def save(SfSetting sfSettingInstance) {
        if (sfSettingInstance == null) {
            notFound()
            return
        }

        if (sfSettingInstance.hasErrors()) {
            respond sfSettingInstance.errors, view:'create'
            return
        }

        sfSettingInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sfSetting.label', default: 'SfSetting'), sfSettingInstance.id])
                redirect sfSettingInstance
            }
            '*' { respond sfSettingInstance, [status: CREATED] }
        }
    }

    def edit(SfSetting sfSettingInstance) {
        respond sfSettingInstance
    }

    @Transactional
    def update(SfSetting sfSettingInstance) {
        if (sfSettingInstance == null) {
            notFound()
            return
        }

        if (sfSettingInstance.hasErrors()) {
            respond sfSettingInstance.errors, view:'edit'
            return
        }

        sfSettingInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sfSetting.label', default: 'sfSetting'), sfSettingInstance.id])
                redirect sfSettingInstance
            }
            '*'{ respond sfSettingInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SfSetting sfSettingInstance) {

        if (sfSettingInstance == null) {
            notFound()
            return
        }

        sfSettingInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sfSetting.label', default: 'SfSetting'), sfSettingInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sfSetting.label', default: 'SfSetting'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
