/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SuggestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Suggestion.list(params), model: [suggestionInstanceCount: Suggestion.count()]
    }

    def show(Suggestion suggestionInstance) {
        respond suggestionInstance
    }

    def create() {
        respond new Suggestion(params)
    }

    @Transactional
    def save(Suggestion suggestionInstance) {
        if (suggestionInstance == null) {
            notFound()
            return
        }

        if (suggestionInstance.hasErrors()) {
            respond suggestionInstance.errors, view: 'create'
            return
        }

        suggestionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'suggestion.label', default: '建议'), suggestionInstance.id])
                redirect suggestionInstance
            }
            '*' { respond suggestionInstance, [status: CREATED] }
        }
    }

    def edit(Suggestion suggestionInstance) {
        respond suggestionInstance
    }

    @Transactional
    def update(Suggestion suggestionInstance) {
        if (suggestionInstance == null) {
            notFound()
            return
        }

        if(suggestionInstance.reply) suggestionInstance.replyDate = new Date()

        if (suggestionInstance.hasErrors()) {
            respond suggestionInstance.errors, view: 'edit'
            return
        }

        suggestionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Suggestion.label', default: 'Suggestion'), suggestionInstance.id])
                redirect suggestionInstance
            }
            '*' { respond suggestionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Suggestion suggestionInstance) {

        if (suggestionInstance == null) {
            notFound()
            return
        }

        suggestionInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Suggestion.label', default: 'Suggestion'), suggestionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'suggestion.label', default: 'Suggestion'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
