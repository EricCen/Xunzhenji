%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.promotion.RandomLink" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'randomLink.label', default: 'RandomLink')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-randomLink" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<th><g:message code="randomLink.linkCode.label" default="LinkCode" /></th>

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${randomLinkInstanceList}" status="i" var="randomLinkInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${randomLinkInstance.id}">${fieldValue(bean: randomLinkInstance, field: "linkCode")}</g:link></td>
					
						<td><g:link action="edit" id="${randomLinkInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${randomLinkInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
