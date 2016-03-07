%{--
- Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
- GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
--}%

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'qrCodeSetting.label', default: 'QrCodeSetting')}"/>
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<asset:stylesheet href="upload.css"/>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link  class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-qrCodeSetting" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${qrCodeSettingInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${qrCodeSettingInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:qrCodeSettingInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="btnGreen left" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>