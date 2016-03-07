%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.promotion.Link" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'link.label', default: 'Link')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-link" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>

						<g:sortableColumn property="title" title="${message(code: 'default.title.label', default: 'Title')}" />

						<g:sortableColumn property="tinyCode" title="${message(code: 'link.tinyCode.label', default: 'Tiny Code')}" />
					
						<g:sortableColumn property="url" title="${message(code: 'link.url.label', default: 'Url')}" />
					
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${linkInstanceList}" status="i" var="linkInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: linkInstance, field: "title")}</td>

						<td>${fieldValue(bean: linkInstance, field: "tinyCode")}</td>
					
						<td>${fieldValue(bean: linkInstance, field: "url")}</td>
					
						<td><g:link action="edit" id="${linkInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${linkInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
