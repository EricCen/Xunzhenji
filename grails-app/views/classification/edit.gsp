<%@ page import="net.xunzhenji.Classification" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'classification.label', default: 'Classification')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-classification" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${classificationInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${classificationInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:classificationInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${classificationInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="btnGreen left" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
