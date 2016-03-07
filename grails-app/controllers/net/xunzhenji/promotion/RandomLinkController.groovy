package net.xunzhenji.promotion

import net.xunzhenji.util.RamdomNumUtil

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RandomLinkController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def get() {
        log.info("Request random link, code: ${params.code}")
        if(!params.code){
            redirect(controller: "home")
            return
        }
        def randomLink = RandomLink.findByLinkCode(params.code)
        def linksCount = randomLink?.links?.size()
        if(!randomLink || !linksCount){
            redirect(controller: "home")
            return
        }

        def index = ((linksCount - 1) * Math.random() as BigDecimal).setScale(0, BigDecimal.ROUND_HALF_UP)
        def link = randomLink.links[index as int]

        redirect(url: link.url)
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond RandomLink.list(params), model:[randomLinkInstanceCount: RandomLink.count()]
    }

    def show(RandomLink randomLinkInstance) {
        respond randomLinkInstance
    }

    def create() {
        def randomLink = new RandomLink(params)
        randomLink.linkCode = RamdomNumUtil.generateVerifyCode(6)
        respond randomLink
    }

    @Transactional
    def save(RandomLink randomLinkInstance) {
        if (randomLinkInstance == null) {
            notFound()
            return
        }

        if (randomLinkInstance.hasErrors()) {
            respond randomLinkInstance.errors, view:'create'
            return
        }

        randomLinkInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'randomLink.label', default: 'RandomLink'), randomLinkInstance.id])
                redirect randomLinkInstance
            }
            '*' { respond randomLinkInstance, [status: CREATED] }
        }
    }

    def edit(RandomLink randomLinkInstance) {
        respond randomLinkInstance
    }

    @Transactional
    def update(RandomLink randomLinkInstance) {
        if (randomLinkInstance == null) {
            notFound()
            return
        }

        if (randomLinkInstance.hasErrors()) {
            respond randomLinkInstance.errors, view:'edit'
            return
        }

        randomLinkInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RandomLink.label', default: 'RandomLink'), randomLinkInstance.id])
                redirect randomLinkInstance
            }
            '*'{ respond randomLinkInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(RandomLink randomLinkInstance) {

        if (randomLinkInstance == null) {
            notFound()
            return
        }

        randomLinkInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RandomLink.label', default: 'RandomLink'), randomLinkInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'randomLink.label', default: 'RandomLink'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
