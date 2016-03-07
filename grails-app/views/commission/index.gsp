%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.Commission" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'commission.label', default: 'Commission')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-commission" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<th><g:message code="productOrder.label" default="Product Order" /></th>

						<th><g:message code="product.label" default="Product" /></th>

						<th><g:message code="commission.organizer.label" default="Organizer" /></th>

						<g:sortableColumn property="amount" title="${message(code: 'default.amount.label', default: 'Amount')}" />

						<g:sortableColumn property="state" title="${message(code: 'default.state.label', default: 'State')}" />

						<g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'default.lastUpdated.label', default: 'Last Updated')}" />
					
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${commissionInstanceList}" status="i" var="commissionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${commissionInstance.id}">${fieldValue(bean: commissionInstance, field: "productName")}</g:link></td>

						<td>${fieldValue(bean: commissionInstance, field: "productOrder")}</td>

						<td>${fieldValue(bean: commissionInstance, field: "organizer")}</td>

						<td>${fieldValue(bean: commissionInstance, field: "amount")}</td>

						<td>${Commission.CommissionState.valueOf(commissionInstance.state).description}</td>

						<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${commissionInstance.dateCreated}" /></td>
					
						<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${commissionInstance.lastUpdated}" /></td>

						<td><g:link action="edit" id="${commissionInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${commissionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
