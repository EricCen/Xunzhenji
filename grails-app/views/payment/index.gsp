
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Payment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'payment.label', default: 'Payment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-payment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<g:sortableColumn property="prepayId" title="${message(code: 'payment.prepayId.label', default: 'Prepay Id')}" />

						<g:sortableColumn property="amount" title="${message(code: 'default.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'default.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'payment.type.label', default: 'Type')}" />
						<g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label', default: 'Date Created')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${paymentInstanceList}" status="i" var="paymentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: paymentInstance, field: "prepayId")}</td>
					
						<td>${fieldValue(bean: paymentInstance, field: "amount")}</td>
					
						<td>${fieldValue(bean: paymentInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: paymentInstance, field: "type")}</td>

						<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${paymentInstance.dateCreated}" /></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${paymentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
