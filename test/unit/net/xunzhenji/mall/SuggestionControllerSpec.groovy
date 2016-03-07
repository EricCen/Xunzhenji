/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall


import grails.test.mixin.*
import spock.lang.*

@TestFor(SuggestionController)
@Mock(Suggestion)
class SuggestionControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.suggestionInstanceList
        model.suggestionInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.suggestionInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def suggestion = new Suggestion()
        suggestion.validate()
        controller.save(suggestion)

        then: "The create view is rendered again with the correct model"
        model.suggestionInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        suggestion = new Suggestion(params)

        controller.save(suggestion)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/suggestion/show/1'
        controller.flash.message != null
        Suggestion.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def suggestion = new Suggestion(params)
        controller.show(suggestion)

        then: "A model is populated containing the domain instance"
        model.suggestionInstance == suggestion
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def suggestion = new Suggestion(params)
        controller.edit(suggestion)

        then: "A model is populated containing the domain instance"
        model.suggestionInstance == suggestion
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/suggestion/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def suggestion = new Suggestion()
        suggestion.validate()
        controller.update(suggestion)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.suggestionInstance == suggestion

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        suggestion = new Suggestion(params).save(flush: true)
        controller.update(suggestion)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/suggestion/show/$suggestion.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/suggestion/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def suggestion = new Suggestion(params).save(flush: true)

        then: "It exists"
        Suggestion.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(suggestion)

        then: "The instance is deleted"
        Suggestion.count() == 0
        response.redirectedUrl == '/suggestion/index'
        flash.message != null
    }
}
