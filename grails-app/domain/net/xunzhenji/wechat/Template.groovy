package net.xunzhenji.wechat

import groovy.json.JsonSlurper

class Template {
    String name
    String templateIdShort
    String templateId
    String templateContent // 从公众号copy过来
    String topColor = "#FF0000"
    String textColor = "#173177"
    String templateJson

    static constraints = {
        templateId nullable: true
        templateJson nullable: true
    }

    static mapping = {
        templateContent type: "text"
        templateJson type: "text"
    }

    def buildMsg(openId, url, data){
        def message = [touser     : openId,
                       template_id: templateId,
                       url        : url as String,
                       topcolor   : topColor,
                       data       : [:]
                        ]
        data.each{ key, value->
            message.data[key] = [value: value as String, color: textColor]
        }
        message
    }

    def templateData(){
        if (templateJson){
            return new JsonSlurper().parseText(templateJson.replace("\r","").replace("\n",""))
        }
        [:]
    }

    def renderTemplate(){
        templateData().each{ key, value->
            templateContent = templateContent.replace("{{${key}.DATA}}", "<span style=\"color:${textColor}\">${value}</span>")
        }
    }
}
