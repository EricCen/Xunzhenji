/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import groovy.net.xmlrpc.XMLRPCServerProxy

/**
 * Created by Irene on 2015-12-30.
 */
class OdooService {
    def static URL_COMMON = "http://erp.xunzhenji.net:8069/xmlrpc/2/common"
    def static URL_OBJECT = "http://erp.xunzhenji.net:8069/xmlrpc/2/object"
    def db = "odoo"
    def username = ''
    def password = ''
    def uid

    def authenticate() {
        def common = new XMLRPCServerProxy(URL_COMMON)
        uid = common.authenticate(db, username, password, [:])
    }

    def executeKw(model, method, listParams, mapParams) {
        def models = new XMLRPCServerProxy(URL_OBJECT)
        if (mapParams) {
            return models.execute_kw(db, uid, password, model, method,
                    listParams, mapParams)
        } else {
            return models.execute_kw(db, uid, password, model, method,
                    listParams)
        }
    }

    def listRecord(model, criteria) {
        executeKw(model, "search", [criteria], null)
    }

    def readRecord(model, ids) {
        executeKw(model, "read", [ids], null)
    }

    def listRecordFields(model, attributes) {
        executeKw(model, "fields_get", [], [attributes: attributes])
    }

    def searchRead(model, criteria, fields) {
        executeKw(model, "search_read", [criteria], fields)
    }

    def createRecord(model, record) {
        executeKw(model, "create", [record], null)
    }


}
