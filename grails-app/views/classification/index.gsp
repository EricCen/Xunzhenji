
<%@ page import="net.xunzhenji.Classification" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'classification.label', default: 'Classification')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-classification" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<g:sortableColumn property="id" title="${message(code: 'default.id.label', default: 'ID')}" />
						<g:sortableColumn property="name" title="${message(code: 'default.name.label', default: 'Name')}" />
						<g:sortableColumn property="introduction" title="${message(code: 'default.introduction.label', default: 'Introduction')}" />
						<th>${message(code: 'default.operation.label', default: 'Ops')}</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${classificationInstanceList}" status="i" var="classificationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>${fieldValue(bean: classificationInstance, field: "id")}</td>
						<td>${fieldValue(bean: classificationInstance, field: "name")}</td>
						<td>${fieldValue(bean: classificationInstance, field: "introduction")}</td>
						<td><g:link action="edit" id="${classificationInstance.id}">${message(code: 'default.operation.edit.label', default: 'Edit')}</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${classificationInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
