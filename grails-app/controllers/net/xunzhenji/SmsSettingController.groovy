package net.xunzhenji

import grails.transaction.Transactional
import net.xunzhenji.mall.UserInfo

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.OK

@Transactional(readOnly = true)
class SmsSettingController {
    def mobileMsgService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def sendMessage(){
        log.info("To number: ${params.mobile}")
        log.info("Content: ${params.content}")

        if ((!params.mobile && !params.toAll) || !params.content) {
            redirect(action: "show")
            return
        }
        def mobiles

        if (params.toAll) {
            mobiles = UserInfo.findAllByMobileIsNotNull().collect { it.mobile }
        } else {
            mobiles = params.mobile.split(",")
        }

        mobiles.each { mobile ->
            try {
                mobileMsgService.sendSms(mobile, params.content)
            } catch (e) {
                log.error("Fail to send to ${mobile}")
            }
        }
        redirect(action: "show")
    }

    def show() {
        respond SmsSetting.first()
    }

    def edit(SmsSetting smsSettingInstance) {
        respond smsSettingInstance
    }

    @Transactional
    def update(SmsSetting smsSettingInstance) {
        if (smsSettingInstance == null) {
            notFound()
            return
        }

        if (smsSettingInstance.hasErrors()) {
            respond smsSettingInstance.errors, view: 'edit'
            return
        }

        smsSettingInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SmsSetting.label', default: 'SmsSetting'), smsSettingInstance.id])
                redirect smsSettingInstance
            }
            '*' { respond smsSettingInstance, [status: OK] }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'smsSetting.label', default: 'SmsSetting'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
