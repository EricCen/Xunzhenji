
<%@ page import="net.xunzhenji.mall.Producer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'producer.label', default: 'Producer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-producer" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'default.name.label', default: 'Name')}" />
						<g:sortableColumn property="introduction" title="${message(code: 'default.introduction.label', default: 'Introduction')}" />
						<g:sortableColumn property="address" title="${message(code: 'default.address.label', default: 'Address')}" />
						<g:sortableColumn property="phone" title="${message(code: 'default.phone.label', default: 'Phone')}" />
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${producerInstanceList}" status="i" var="producerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${producerInstance.id}">${fieldValue(bean: producerInstance, field: "name")}</g:link></td>
						<td>${fieldValue(bean: producerInstance, field: "introduction")}</td>
						<td>${fieldValue(bean: producerInstance, field: "address")}</td>
						<td>${fieldValue(bean: producerInstance, field: "phone")}</td>
						<td><g:link action="edit" id="${producerInstance.id}">编辑</g:link>
						<g:link action="show" id="${producerInstance.id}">预览</g:link>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${producerInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
