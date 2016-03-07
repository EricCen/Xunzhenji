%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.Express" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'express.label', default: 'Express')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-express" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<g:sortableColumn property="continuedWeightPrice" title="${message(code: 'express.continuedWeightPrice.label', default: 'Continued Weight Price')}" />
					
						<g:sortableColumn property="expressName" title="${message(code: 'express.name.label', default: 'Express Name')}" />

						<g:sortableColumn property="displayName" title="${message(code: 'express.displayName.label', default: '显示名称')}" />

						<g:sortableColumn property="firstWeightPrice" title="${message(code: 'express.firstWeightPrice.label', default: 'First Weight Price')}" />
					
						<g:sortableColumn property="firstWeightTo" title="${message(code: 'express.firstWeightTo.label', default: 'First Weight To')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'express.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="deliverRange" title="${message(code: 'express.range.label', default: 'Range')}" />
					
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${expressInstanceList}" status="i" var="expressInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${expressInstance.id}">${fieldValue(bean: expressInstance, field: "continuedWeightPrice")}</g:link></td>
					
						<td>${fieldValue(bean: expressInstance, field: "name")}</td>

						<td>${fieldValue(bean: expressInstance, field: "displayName")}</td>

						<td>${fieldValue(bean: expressInstance, field: "firstWeightPrice")}</td>
					
						<td>${fieldValue(bean: expressInstance, field: "firstWeightTo")}</td>
					
						<td>${fieldValue(bean: expressInstance, field: "phone")}</td>
					
						<td>${fieldValue(bean: expressInstance, field: "deliverRange")}</td>
					
						<td><g:link action="edit" id="${expressInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${expressInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
