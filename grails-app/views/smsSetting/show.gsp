%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.SmsSetting" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'smsSetting.label', default: 'SmsSetting')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div id="show-smsSetting" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list smsSetting">
        <table class="userinfoArea smsSetting" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${smsSettingInstance?.alarmBalance}">
                <tr>
                    <th><span id="alarmBalance-label" class="property-label"><g:message
                            code="smsSetting.alarmBalance.label" default="Alarm Balance"/></span></th>

                    <td><span class="property-value" aria-labelledby="alarmBalance-label"><g:fieldValue
                            bean="${smsSettingInstance}" field="alarmBalance"/></span></td>

                </tr>
            </g:if>

            <g:if test="${smsSettingInstance?.balance}">
                <tr>
                    <th><span id="balance-label" class="property-label"><g:message code="smsSetting.balance.label"
                                                                                   default="Balance"/></span></th>

                    <td><span class="property-value" aria-labelledby="balance-label"><g:fieldValue
                            bean="${smsSettingInstance}" field="balance"/></span></td>

                </tr>
            </g:if>

            <g:if test="${smsSettingInstance?.ipWhiteList}">
                <tr>
                    <th><span id="ipWhiteList-label" class="property-label"><g:message
                            code="smsSetting.ipWhiteList.label" default="Ip White List"/></span></th>

                    <td><span class="property-value" aria-labelledby="ipWhiteList-label"><g:fieldValue
                            bean="${smsSettingInstance}" field="ipWhiteList"/></span></td>

                </tr>
            </g:if>

            <g:if test="${smsSettingInstance?.apiKey}">
                <tr>
                    <th><span id="key-label" class="property-label"><g:message code="smsSetting.key.label"
                                                                               default="Key"/></span></th>

                    <td><span class="property-value" aria-labelledby="key-label"><g:fieldValue
                            bean="${smsSettingInstance}" field="apiKey"/></span></td>

                </tr>
            </g:if>

            </tbody>
        </table>
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${smsSettingInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
        </fieldset>

        <br>

        <h1>发送短信</h1>

        <form>

            <table class="userinfoArea smsSetting" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tbody>
                <tr>
                    <th>号码(以,分隔)</th>
                    <td>
                        <g:textField class="px" name="mobile" required=""/>
                    </td>
                </tr>
                <tr>
                    <th>全体用户</th>
                    <td><g:checkBox name="toAll"/></td>
                </tr>
                <tr>
                    <th>内容</th>
                    <td>
                        <textarea name="content" id="remark" rows="5" required=""
                                  style="width:580px;border: ridge;"></textarea>
                    </td>
                </tr>
                </tbody>
            </table>
            <fieldset class="buttons">
                <g:actionSubmit class="btnGreen left" action="sendMessage"
                                value="${message(code: 'smsSetting.send.label', default: 'Send')}"/>
            </fieldset>
        </form>
    </ol>
</div>

</body>
</html>
