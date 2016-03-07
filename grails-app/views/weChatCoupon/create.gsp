<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    %{--
- Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
- GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
--}%

    <g:set var="entityName" value="${message(code: 'weChatCoupon.label', default: 'WeChatCoupon')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-weChatCoupon" class="content scaffold-create" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${weChatCouponInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${weChatCouponInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource: weChatCouponInstance, action: 'save']">
        <fieldset class="form">
            <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tbody>
                <tr>
                    <th>
                        <label for="stockId"><g:message code="weChatCoupon.stockId.label" default="Stock Id"/><span
                                class="required-indicator">*</span></label>
                    </th>
                    <td><g:textField class="px" name="stockId" required=""
                                     value="${weChatCouponInstance?.stockId}"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="btnGreen left"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
