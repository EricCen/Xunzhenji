<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'producer.label', default: 'Producer')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<asset:stylesheet href="upload.css"/>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link  class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-producer" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${producerInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${producerInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:producerInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="btnGreen left" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>

	<asset:javascript src="jquery.iframe-transport.js" />
	<asset:javascript src="jquery.fileupload.js" />
	<asset:javascript src="utilities.js" />
	<script>
		$(document).ready(function(e) {
			initFileUpload('fileupload-container-image', 'image', 5);
			initFileUpload('fileupload-container-head', 'head', 1);
		});
	</script>
	</body>
</html>
