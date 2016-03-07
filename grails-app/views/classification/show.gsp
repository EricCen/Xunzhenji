
<%@ page import="net.xunzhenji.Classification" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'classification.label', default: 'Classification')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-classification" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
				<g:if test="${classificationInstance?.name}">
					<tr>
						<th><span id="name-label" class="property-label"><g:message code="default.name.label" default="Name" /></span></th>
						<td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${classificationInstance}" field="name"/></span></td>
					</tr>
				</g:if>
				<g:if test="${classificationInstance?.name}">
					<tr>
						<th><span id="introduction-label" class="property-label"><g:message code="default.introduction.label" default="Introduction" /></span></th>
						<td><span class="property-value" aria-labelledby="introduction-label"><g:fieldValue bean="${classificationInstance}" field="introduction"/></span></td>
					</tr>
				</g:if>
				</tbody>
			</table>
			<g:form url="[resource:classificationInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${classificationInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
