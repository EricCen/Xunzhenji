package net.xunzhenji

import net.xunzhenji.util.ObjectUtils
import net.xunzhenji.wechat.WeChatFans

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class QrCodeSettingController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond QrCodeSetting.list(params), model:[qrCodeSettingInstanceCount: QrCodeSetting.count()]
    }

    def show(QrCodeSetting qrCodeSettingInstance) {
        def weChatFans = QrCodeSettingWeChatFans.findAllByQrCodeSetting(qrCodeSettingInstance)*.weChatFans
        [qrCodeSettingInstance: qrCodeSettingInstance, fans: weChatFans]
    }

    def create() {
        respond new QrCodeSetting(params)
    }

    @Transactional
    def save(QrCodeSetting qrCodeSettingInstance) {
        if (qrCodeSettingInstance == null) {
            notFound()
            return
        }

        ObjectUtils.updateImage(qrCodeSettingInstance, params['image.id'])
        qrCodeSettingInstance.content = qrCodeSettingInstance.content?.replace("src=","data-original=")
        qrCodeSettingInstance.save flush:true
        qrCodeSettingInstance.images?.each{
            it.ownerClass = qrCodeSettingInstance.class.getName()
            it.ownerId = qrCodeSettingInstance.id;
            it.order = params["image_order_${it.id}"] ? params["image_order_${it.id}"] as int : 0
            it.save()
        }

        if (qrCodeSettingInstance.hasErrors()) {
            respond qrCodeSettingInstance.errors, view:'create'
            return
        }

        qrCodeSettingInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'qrCodeSetting.label', default: 'QrCodeSetting'), qrCodeSettingInstance.id])
                redirect qrCodeSettingInstance
            }
            '*' { respond qrCodeSettingInstance, [status: CREATED] }
        }
    }

    def edit(QrCodeSetting qrCodeSettingInstance) {
        def openIds = QrCodeSettingWeChatFans.findAllByQrCodeSetting(qrCodeSettingInstance)*.weChatFans?.openId
        [qrCodeSettingInstance: qrCodeSettingInstance, openIds:openIds?.join(",")]
    }

    @Transactional
    def update(QrCodeSetting qrCodeSettingInstance) {
        if (qrCodeSettingInstance == null) {
            notFound()
            return
        }

        ObjectUtils.updateImage(qrCodeSettingInstance, params['image.id'])
        qrCodeSettingInstance.content = qrCodeSettingInstance.content?.replace("src=","data-original=")
        qrCodeSettingInstance.save flush:true
        qrCodeSettingInstance.images?.each{
            it.ownerClass = qrCodeSettingInstance.class.getName()
            it.ownerId = qrCodeSettingInstance.id;
            it.order = params["image_order_${it.id}"] ? params["image_order_${it.id}"] as int : 0
            it.save()
        }

        def openIds = params.openIds.split(",")
        def fans = WeChatFans.withCriteria {
            'in'("openId", openIds)
        }
        def qrCodeFansInDb = QrCodeSettingWeChatFans.findAllByQrCodeSetting(qrCodeSettingInstance)
        def fansInDb = qrCodeFansInDb*.weChatFans
        def intersect = fansInDb.intersect(fans)
        fans.minus(intersect).each{ // to add
            new QrCodeSettingWeChatFans(qrCodeSetting: qrCodeSettingInstance, weChatFans: it).save()
        }
        def openIdsToRemove = fansInDb.minus(intersect)*.openId
        QrCodeSettingWeChatFans.deleteAll(qrCodeFansInDb.findAll {openIdsToRemove.contains(it.weChatFans.openId)})

        if (qrCodeSettingInstance.hasErrors()) {
            respond qrCodeSettingInstance.errors, view:'edit'
            return
        }

        qrCodeSettingInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'qrCodeSetting.label', default: 'QrCodeSetting'), qrCodeSettingInstance.id])
                redirect qrCodeSettingInstance
            }
            '*'{ respond qrCodeSettingInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(QrCodeSetting qrCodeSettingInstance) {

        if (qrCodeSettingInstance == null) {
            notFound()
            return
        }

        qrCodeSettingInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'qrCodeSetting.label', default: 'QrCodeSetting'), qrCodeSettingInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrCodeSetting.label', default: 'QrCodeSetting'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Transactional
    def startRegister(){
        log.info("Start qrcode register, id:${params.id}")
        def setting = QrCodeSetting.get(params.id)
        setting.registerMode = true
        setting.save()
        redirect(action: "index")
    }

    @Transactional
    def stopRegister(){
        log.info("Stop qrcode register, id:${params.id}")
        def setting = QrCodeSetting.get(params.id)
        setting.registerMode = false
        setting.save()
        redirect(action: "index")
    }
}
